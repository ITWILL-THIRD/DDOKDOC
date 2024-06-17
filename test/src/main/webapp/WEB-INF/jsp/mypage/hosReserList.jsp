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
	if (${hospital.sunDayOff == 'Y'}) {
		alert(${hospital.sunDayOff == 'Y'});
	}

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
 	alert(closedDates);
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
        alert(info.dateStr);
        
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
          $("#listDisp").html("예약가능시간");
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
          info.dayEl.style.backgroundColor = 'lightblue'; // 선택된 색상 설정
          selectedDate = info.dateStr; // 선택된 날짜 업데이트
          selectedDay = info.date.getDay(); //선택된 날짜의 요일
          // 예약 가능한 시간 비동기처리
          getJsonTimeData(selectedDate, selectedDay);
          document.getElementById('reserDate').value = info.dateStr; // 숨겨진 필드 업데이트
        }
      },
      
     // 과거 날짜, 휴무일 회색으로 설정
      datesRender: function(info) {
        var today = new Date();
        today.setHours(0, 0, 0, 0);

        var allDayEls = document.querySelectorAll('.fc-day');

        allDayEls.forEach(function(dayEl) {
          var dateStr = dayEl.getAttribute('data-date');
          var date = new Date(dateStr);
          
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
	            alert("성공~");

	            let dispHtml = "";
	            let currentTime = new Date();
	            let currentHour = currentTime.getHours();
	            let currentMinute = currentTime.getMinutes();
	            console.log(response); // response 객체 구조 확인
	            console.log("currentHour : " + currentHour);
	            console.log("currentMinute :" + currentMinute);

	            // 예약된 시간만 표시하는 부분
	            for (let time of response.reservedTimes) {
	                let timeComponents = time.split(":");
	                let hour = parseInt(timeComponents[0]);
	                let minute = parseInt(timeComponents[1]);
	                let isDisabled = false;
	                let reservedUserNames = [];

	                if (selectedDate === formatDate(currentTime)) {
	                    if (hour < currentHour || (hour === currentHour && minute < currentMinute)) {
	                        isDisabled = true;
	                    }
	                }

	                // 예약된 사용자 이름을 찾음
	                for (var reservation of response.reserList) {
	                    if (reservation.reserTime === time) {  // reservation.time -> reservation.reserTime
	                        reservedUserNames.push(reservation.guardian);
	                    }
	                }

	                dispHtml += `<div style="display: flex; align-items: center;">`;
	                dispHtml += `<button type="button" class="time-btn reserved" data-time="${time}" ${isDisabled ? 'disabled' : ''} style="background-color: skyblue;">`;
	                dispHtml += time;
	                dispHtml += "</button>";
	                dispHtml += `<span style="margin-left: 10px;">(${reservedUserNames.join(', ')})</span>`; // 예약자 이름 추가
	                dispHtml += "</div><br>";
	            }

	            $("#listDisp").html(dispHtml); // HTML 삽입 위치 확인

	            $(".reserved").on("click", function() {
	                console.log("reserved");
	                clearSelectedTime();
	                $(this).addClass("selected");

	                // 클릭한 버튼의 텍스트(시간)을 가져옴
	                var clickedTime = $(this).text();
	                console.log("reserved click " + clickedTime);
	                console.log("response.reserList : " + response.reserList);
	                // reservedTimes 배열에서 클릭한 시간에 해당하는 사용자 이름을 찾음
	                var reservedUserNames = [];
	                for (var reservation of response.reserList) {
	                    if (reservation.reserTime === clickedTime) {  // reservation.time -> reservation.reserTime
	                        reservedUserNames.push(reservation.guardian);
	                    }
	                }   
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
\${hospital } : ${hospital }<br>
\${hosHoliday } : ${hosHoliday }<br>

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
    <div id="listDisp" class="reserInfo">
      <ul>
        <li>예약 목록</li>
      </ul>
    </div>
    <form method="post">
      <!-- <textarea rows="4" cols="5" id="memo" name="memo">메모를 남겨주세요</textarea>
      <input type="button" value="예약하기" onclick="insertReservation(this.form)"> -->
      <input type="hidden" id="reserDate" name="reserDate">
      <input type="hidden" id="selectTime" name="selectTime">
    </form>
  </div>


</body>
</html>
