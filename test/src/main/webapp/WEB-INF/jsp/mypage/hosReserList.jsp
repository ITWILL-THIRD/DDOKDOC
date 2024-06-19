<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/" ></script>
<link href="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/main.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@4.4.0/main.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@4.4.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@4.4.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@4.4.0/main.min.js"></script>
<script>
	//병원 일요일 휴무 체크
/* 	if (${hospital.sunDayOff == 'Y'}) {
		alert(${hospital.sunDayOff == 'Y'});
	} */

	//달력 띄우기
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var selectedDate = null; 
    var selectedDay = null;
    
    var hospitalSundayOff = ${hospital.sunDayOff == 'Y'};
    
 	// 예시 휴무일 데이터
    // 휴무일 목록을 받아옴
    var closedDates = [
	    <c:forEach var="date" items="${hosHoliday}">
	        '<fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/>',
	    </c:forEach>
	];
 	//alert(closedDates);
    // 마지막 쉼표 제거
    closedDates.pop();

    var calendar = new FullCalendar.Calendar(calendarEl, {
      googleCalendarApiKey:'AIzaSyCpdR-Qoefgl33LiyjqpiZglfgJogfB16Y',
      plugins: [ 'interaction', 'dayGrid', 'googleCalendar' ],
      header: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
      editable: false,
      eventLimit: true, // allow "more" link when too many events
      selectable: false,
      eventSources:[
        {
          googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
          className: 'ko_event',
          color: 'white',
          textColor: 'red'
        }
      ],
      eventRender: function(info) {
        // href 속성 제거
        if (info.el.tagName === 'A') {
          info.el.removeAttribute('href');
        }
        // 부모 노드로부터 링크 제거
        if (info.el.parentNode) {
          var parent = info.el.parentNode;
          if (parent.tagName === 'A') {
            parent.replaceWith(info.el);
          }
        }
      },
      dateClick: function(info) {
        //alert(info.dateStr);
        
        var today = new Date();
        today.setHours(0, 0, 0, 0); // 시간을 0으로 설정해야 오늘 날짜를 클릭 가능함.
        var clickedDate = new Date(info.dateStr);

        // 휴무일 클릭 비활성화
        if (closedDates.includes(info.dateStr)) {
          alert(info.dateStr + "은 휴무입니다:)");
          return;
        }
     	// 일요일 클릭 비활성화
        if (hospitalSundayOff && clickedDate.getDay() === 0) {
          alert("일요일은 휴무입니다.");
          return;
        }
        // 클릭한 날짜가 선택된 날짜인지 확인
        if (selectedDate === info.dateStr) {
          // 선택된 날짜 다시 클릭 시 해제
          info.dayEl.style.backgroundColor = ''; // 원래 색상으로 복원
          selectedDate = null; // 선택 해제
          document.getElementById('reserDate').value = ''; // 숨겨진 필드 비움
          // 시간 리스트 숨김
          $("#listDisp").html("");
          clearSelectedTime(); // 선택된 시간 초기화
        } else {
          // 다른 날짜를 클릭했을 때
          if (selectedDate) {
            // 이미 선택된 날짜가 있으면 원래 색상으로 복원
            var prevDayEl = document.querySelector('[data-date="' + selectedDate + '"]');
            if (prevDayEl) {
              prevDayEl.style.backgroundColor = '';
            }
          }
          // 클릭한 날짜를 새로운 선택 날짜로 설정
          info.dayEl.style.backgroundColor = '#B6E5FF'; // 선택된 색상 설정
          selectedDate = info.dateStr; // 선택된 날짜 업데이트
          selectedDay = info.date.getDay(); //선택된 날짜의 요일
          // 예약 가능한 시간 비동기처리
          getJsonTimeData(selectedDate, selectedDay);
          document.getElementById('reserDate').value = info.dateStr; // 숨겨진 필드 업데이트
        }
      },
      
   //휴무일 회색으로 설정
      datesRender: function(info) {
        var today = new Date();
        today.setHours(0, 0, 0, 0);

        var allDayEls = document.querySelectorAll('.fc-day');

        allDayEls.forEach(function(dayEl) {
          var dateStr = dayEl.getAttribute('data-date');
          var date = new Date(dateStr);
          
          if (closedDates.includes(dateStr) || (hospitalSundayOff && date.getDay() === 0)) {
              dayEl.style.backgroundColor = '#f0f1f1';
          }
        });
      } 
    });

    calendar.render();
  });

  function getJsonTimeData(selectedDate, selectedDay) {
	    let vo = {
	        reserDate: selectedDate,
	        dayStr: selectedDay
	    };

	    $.ajax("getReseredTimes.do", {
	        type: "post",
	        data: JSON.stringify(vo),
	        contentType: "application/json",
	        dataType: "json",
	        success: function(response) {
	            let dispHtml = "";
	            console.log(response); // response 객체 구조 확인

	            // 예약된 시간만 표시하는 부분
	            for (let time of response.reservedTimes) {
	                let timeComponents = time.split(":");
	                let hour = parseInt(timeComponents[0]);
	                let minute = parseInt(timeComponents[1]);
	                let isDisabled = false;

	                dispHtml = ''; // 여기서 초기화

	                for (let reservation of response.petReserList) {
	                    let reservationTime = reservation.reserTime.substring(0, 5); // 시간과 분까지만 추출 (14:30:00 -> 14:30)
	                    let reserGuardian = reservation.guardian;
	                    let reserGuardianPhone = reservation.guardianPhone;
	                    let reserPetName = reservation.petName;
	                    let reserAnimal = reservation.animal;
	                    let reserPetAge = reservation.petAge;
	                    let reserCondition = reservation.condition;
	                    let reserIdx = reservation.reserIdx;

	                    console.log("reserIdx : " + reserIdx);

	                    let completBtn = "";
	                    if (reservation.condition === "RESERVATION") {
	                        completBtn += '<button class="complete-btn" data-reserIdx="';
	                        completBtn += reservation.reserIdx;
	                        completBtn += '">진료 완료</button>';
	                    } else {
	                        completBtn = "";
	                    }

	                    dispHtml += '<div id="reserDate" style="display: flex; align-items: center;">';
	                    dispHtml += '<button type="button" class="complete-btn" data-reserIdx="';
	                    dispHtml += reserIdx;
	                    dispHtml += '" ';
	                    if (isDisabled) {
	                        dispHtml += 'disabled ';
	                    }
	                    dispHtml += 'style="background-color: skyblue;">';
	                    dispHtml += reservationTime;
	                    dispHtml += '</button>';
	                    dispHtml += '<span style="margin-left: 10px;">보호자 : ';
	                    dispHtml += reserGuardian;
	                    dispHtml += ' 연락처 : ';
	                    dispHtml += reserGuardianPhone;
	                    dispHtml += ' 이름 : ';
	                    dispHtml += reserPetName;
	                    dispHtml += ' 종류 : ';
	                    dispHtml += reserAnimal;
	                    dispHtml += ' 나이 : ';
	                    dispHtml += reserPetAge;
	                    dispHtml += '살 ';
	                    dispHtml += completBtn; // 여기서 버튼을 포함한 reserCondition을 추가
	                    dispHtml += '</span>';
	                    dispHtml += '</div><br>';
	                }

	                console.log(dispHtml);
	                $("#listDisp").html(dispHtml);
	            }

	            // '진료 완료' 버튼 클릭 이벤트 등록
	            $('#listDisp').on('click', '.complete-btn', function() {
	            	let reserIdx = $(this).attr('data-reserIdx');  // 문자열 타입
	            	reserIdx = parseInt(reserIdx, 10);  // 정수 타입으로 변환

	                console.log("reserIdx : " + reserIdx + " type : " + typeof reserIdx);

	                // reserIdx가 "정보 없음"인 경우를 처리
	                if (reserIdx === "정보 없음") {
	                    alert("예약 정보가 없습니다.");
	                    return;
	                }

	                $.ajax({
	                    url: '../mypage/updateComplete.do',
	                    method: 'POST',
	                    contentType: 'application/json',
	                    data: JSON.stringify({ reserIdx: reserIdx }),
	                    success: function(data) {
	                        console.log('updateComplete 완료:', data);

	                        // updateFinish가 완료된 후 getReseredTimes.do를 호출
	                        $.ajax({
	                            url: '../mypage/getReseredTimes.do',
	                            type: "post",
	                	        data: JSON.stringify(vo),
	                	        contentType: "application/json",
	                	        dataType: "json",
	                	        success: function(response) {
	                	            let dispHtml = "";
	                	            console.log(response); // response 객체 구조 확인

	                	            // 예약된 시간만 표시하는 부분
	                	            for (let time of response.reservedTimes) {
	                	                let timeComponents = time.split(":");
	                	                let hour = parseInt(timeComponents[0]);
	                	                let minute = parseInt(timeComponents[1]);
	                	                let isDisabled = false;

	                	                dispHtml = ''; // 여기서 초기화

	                	                for (let reservation of response.petReserList) {
	                	                    let reservationTime = reservation.reserTime.substring(0, 5); // 시간과 분까지만 추출 (14:30:00 -> 14:30)
	                	                    let reserGuardian = reservation.guardian;
	                	                    let reserGuardianPhone = reservation.guardianPhone;
	                	                    let reserPetName = reservation.petName;
	                	                    let reserAnimal = reservation.animal;
	                	                    let reserPetAge = reservation.petAge;
	                	                    let reserCondition = reservation.condition;
	                	                    let reserIdx = reservation.reserIdx;

	                	                    console.log("reserIdx : " + reserIdx);

	                	                    let completBtn = "";
	                	                    if (reservation.condition === "RESERVATION") {
	                	                        completBtn += '<button class="complete-btn" data-reserIdx="';
	                	                        completBtn += reservation.reserIdx;
	                	                        completBtn += '">진료 완료</button>';
	                	                    } else {
	                	                        completBtn = "";
	                	                    }

	                	                    dispHtml += '<div id="reserDate" style="display: flex; align-items: center;">';
	                	                    dispHtml += '<button type="button" class="complete-btn" data-reserIdx="';
	                	                    dispHtml += reserIdx;
	                	                    dispHtml += '" ';
	                	                    if (isDisabled) {
	                	                        dispHtml += 'disabled ';
	                	                    }
	                	                    dispHtml += 'style="background-color: skyblue;">';
	                	                    dispHtml += reservationTime;
	                	                    dispHtml += '</button>';
	                	                    dispHtml += '<span style="margin-left: 10px;">보호자 : ';
	                	                    dispHtml += reserGuardian;
	                	                    dispHtml += ' 연락처 : ';
	                	                    dispHtml += reserGuardianPhone;
	                	                    dispHtml += ' 이름 : ';
	                	                    dispHtml += reserPetName;
	                	                    dispHtml += ' 종류 : ';
	                	                    dispHtml += reserAnimal;
	                	                    dispHtml += ' 나이 : ';
	                	                    dispHtml += reserPetAge;
	                	                    dispHtml += '살 ';
	                	                    dispHtml += completBtn; // 여기서 버튼을 포함한 reserCondition을 추가
	                	                    dispHtml += '</span>';
	                	                    dispHtml += '</div><br>';
	                	                }

	                	                console.log(dispHtml);
	                	                $("#listDisp").html(dispHtml);
	                	            }
	                	        }
	                        });
	                    },
	                    error: function(jqXHR, textStatus, errorThrown) {
	                        console.error('updateComplete 호출 중 오류 발생:', textStatus, errorThrown);
	                    }
	                });
	            });
	        },
	        error: function() {
	            alert("실패~~");
	        }
	    });
	}

	function formatDate(date) {
	    let year = date.getFullYear();
	    let month = String(date.getMonth() + 1).padStart(2, '0');
	    let day = String(date.getDate()).padStart(2, '0');
	    return `${year}-${month}-${day}`;
	}

	function clearSelectedTime() {
	    $(".time-btn").removeClass("selected");
	    $("#selectTime").val("");
	}

	 //선택된 시간을 form 시간값에 저장
    $('form').on('submit', function() {
        let selectedTime = $('.time-btn.reserved').data('time');
        $('#selectTime').val(selectedTime);
    });
  
</script>
<style>
  #reserBody {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 700px;
    margin-left: 100px;
    display: inline-block;
  }
  
  .reserInfo {
    display: inline-block;
    vertical-align: top;
  }
  
  .time-btn {
       margin: 5px;
       padding: 10px;
       border: 1px solid #ccc;
       background-color: #f9f9f9;
       cursor: pointer;
   }

   .time-btn.selected {
       background-color: lightblue;
   }
   
   /* 예약된 시간 버튼 스타일 */
	.reserved {
	  background-color: #87CEEB; /* 하늘색 */
	  color: white;
	  cursor: not-allowed; /* 마우스 커서를 변경하여 클릭할 수 없음을 표시 */
	}
	
	.reserved:hover {
	  background-color: #6495ED; /* 버튼에 마우스를 올리면 약간 더 어두운 색으로 변경 */
	}
   
  
</style>
</head>
<body>
<%-- \${hospital } : ${hospital }<br>
\${reservationList } : ${reservationList }<br>
\${user } : ${user }<br>
\${myPetList } : ${myPetList }<br>
\${session.getAttribute } : ${userIdx }<br> --%>
<%-- \${hospital } : ${hospital }<br>
\${hosHoliday } : ${hosHoliday }<br> --%>

  <div id="reserBody">
    <%-- <div id="selectPetDiv">
      <select id="selectPet">
        <option value="null">진료볼 마이펫을 선택하세요</option>
        <c:forEach var="myPet" items="${myPetList }">
          <option value="${myPet.petIdx}">${myPet.petName}</option>
        </c:forEach>
      </select>
    </div> --%>
    <div id="calendar" class="reserInfo"></div>
      <ul>
        <li>예약 목록</li>
      </ul>
    <div id="listDisp" class="reserInfo">
    </div>
<!--     <form method="post">
      <textarea rows="4" cols="5" id="memo" name="memo">메모를 남겨주세요</textarea>
      <input type="button" value="예약하기" onclick="insertReservation(this.form)">
      <input type="hidden" id="reserDate" name="reserDate">
      <input type="hidden" id="selectTime" name="selectTime">
    </form> -->
  </div>


</body>
</html>
