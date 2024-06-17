<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/header.jsp"/>
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

	//마이펫 등록 여부 체크
	if (${myPetList.size()} == 0) {
		  alert ("마이펫 등록 후 예약 가능합니다.");
		  location.href="../mypage/insertMyPetView.do";
	  }
	//달력 띄우기
  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var selectedDate = null; 
    var selectedDay = null;
    
    var hospitalSundayOff = ${hospital.sunDayOff == 'Y'};
    
    // 휴무일 목록을 받아옴
    var closedDates = [
	    <c:forEach var="date" items="${hosHoliday}">
	        '<fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/>',
	    </c:forEach>
	];
 	alert(closedDates);

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

        // 오늘 이전 날짜 클릭 비활성화
        if (clickedDate < today) {
          alert('지난 날짜는 선택할 수 없습니다.');
          return;
        }
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
          info.dayEl.style.backgroundColor = '#B6E5FF'; // 선택된 색상 설정
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
          
          if (date < today || closedDates.includes(dateStr) || (hospitalSundayOff && date.getDay() === 0)) {
              dayEl.style.backgroundColor = '#f0f1f1';
          }
        });
      } 
   

      
    });

    calendar.render();
  });

  
  function getJsonTimeData(selectedDate, selectedDay) {
    alert("예약 가능한 시간");
    alert("selectedDay : " + selectedDay)
    var selectedTime = null; 

    // 병원 ID 및 선택된 날짜를 포함하여 데이터 전송
    let vo = {
      hosIdx: ${hospital.hosIdx },
      reserDate: selectedDate,
      dayStr: selectedDay
    };
    console.log(vo);
    console.log(JSON.stringify(vo));

    $.ajax("getAvailableTimes.do", {
      type: "post",
      data: JSON.stringify(vo),
      contentType: "application/json",
      dataType: "json",
      success: function(response) {
        alert("성공~~");
        console.log(response);
        
        let dispHtml = "";
        
        var currentTime = new Date();
        var currentHour = currentTime.getHours();
        var currentMinute = currentTime.getMinutes();
        
        for (let time of response.availableTimes) {
          if (response.reservedTimes.includes(time)) {
            dispHtml += `<button type="button" class="btn btn-secondary" data-time="${time}" disabled>`;
          } else {
        	  var timeComponents = time.split(":");
              var hour = parseInt(timeComponents[0]);
              var minute = parseInt(timeComponents[1]);
              
              var todayDate = new Date();
              todayDate.setHours(0, 0, 0, 0); // 오늘 날짜와 시간 초기화
              
              var selectedDateObj = new Date(selectedDate + "T00:00:00"); // 문자열을 Date 객체로 변환
              
           	  console.log("비교 : " + (selectedDateObj.getTime() === todayDate.getTime()));
              console.log(selectedDateObj.getTime());
              console.log(todayDate.getTime());
              
              var today = new Date();
              
              if (selectedDateObj.getTime() === todayDate.getTime()) {// 날짜 비교
            	  console.log("if문 내부 true");
                  var currentHour = today.getHours();
                  var currentMinute = today.getMinutes();
                  
                  console.log(currentHour);
                  console.log(currentMinute);
                  
                  if (hour < currentHour || (hour === currentHour && minute < currentMinute)) {
                      dispHtml += `<button type="button" class="btn btn-secondary" data-time="${time}" disabled>`;
                  } else {
                      dispHtml += `<button type="button" class="btn btn-outline-primary" data-time="${time}">`;
                  }
              } else {
                  dispHtml += `<button type="button" class="btn btn-outline-primary" data-time="${time}">`;
              }
              
              
          }
          dispHtml += time;
          dispHtml += "</button><br>";
        }
        $("#listDisp").html(dispHtml); 

        // 시간 선택 이벤트 리스너 설정
        $(".btn").on("click", function() {
          if ($(this).hasClass("selected")) {
            $(this).removeClass("selected");
          } else {
            clearSelectedTime();
            $(this).addClass("selected");
            let selectedTime = $(this).text();  // 선택된 시간 가져오기
            $('#selectTime').val(selectedTime); // resertime에 선택된 시간 저장
          }
        });

      },
      error: function() {
        alert("실패~~");
      }
    });

  }

  function clearSelectedTime() {
    $(".btn").removeClass("selected");
    $("#selectTime").val("");
  }
  
  $(document).ready(function(){
    var initialPet = $("#selectPet :selected").val();
    $("#petIdxStr").val(initialPet);

    $("#selectPet").change(function(){
      // Value값 가져오기
      var selectedPet = $("#selectPet :selected").val();
      alert("selectPet: " + selectedPet);

      $("#petIdxStr").val(selectedPet);
    });
  });
  
  function insertReservation(frm) {
    let selectedDate = document.getElementById('reserDate').value;
    let selectedTime = document.getElementById('selectTime').value;
    let selectedPet = document.getElementById('petIdxStr').value;
    let strGuardian = document.getElementById('guardian').value;
    let strGuardianPhone = document.getElementById('guardianPhone').value;
    
    // null 체크
    if (selectedPet === "null") {
        alert("진료볼 마이펫을 선택하세요");
        return false; 
    }
    if (strGuardian == null || strGuardianPhone == null) {
    	alert("보호자 정보를 입력하세요");
    	return false;
    }
    
    
    alert("selectedPet: " + selectedPet);
    alert("Selected Date: " + selectedDate);
    alert("Select Time: " + selectedTime);
    
    frm.action = "insertReservation.do";
    frm.submit();
  }
  
</script>
<style>
  #reserBody {
    margin: auto;
    margin-top: 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
    text-align: center;
  }

   #selectPetDiv, #selectDateTimeDiv {
	float: left;
    vertical-align: top;
    margin-top: 20px;
  }

  #selectPetDiv {
    width: calc(30% - 5px); /* 50% width for two divs with 5px space in between */
  }

  #selectDateTimeDiv {
    width: calc(70% - 5px);
    margin-left: 10px; /* Adjust margin between the two divs */
    display: flex; /* Flexbox 레이아웃 설정 */
    align-items: flex-start; /* 위쪽 정렬 */

    /* 선택적으로 간격을 조정할 수 있습니다. */
    gap: 10px; /* 요소 사이의 간격 */
  }

  #calendar {
  	flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
    max-width: 700px; /* 최대 너비 설정 */
  }
  
  #listDisp {
  	width: 100px;
  	height: 600px;
  	margin-left: 10px;
  	display: inline-block;
  	overflow-y: auto;
  }
  
  .reserInfo {
    display: inline-block;
    vertical-align: top;
  }

   .btn {
     margin-bottom: 2px;
   }	
   	
   .btn.selected {
       background-color: #B6E5FF;
   }
   
   #guardianInfo {
	    margin-top: 10px;
	    font-size: 16px;
	    text-align: center;
	    width: 100%; /* 너비를 100%로 설정하여 부모 요소에 맞추기 */
	}
	
	#guardianInfoTitle, #timeListTitle {
		border-radius: 10px;
		background-color: #B6E5FF;
	}
	
	
	#guardianInfo p {
		 margin: 0;	
	}
   
   #guardian, #guardianPhone {
	    margin-bottom: 5px;
	    width: calc(100% - 20px); /* 입력 필드의 너비 설정 */
	    padding: 5px; /* 내부 여백 설정 */
	    box-sizing: border-box; /* 내부 여백과 테두리를 포함하여 요소의 크기 계산 */
	    text-align: left; /* 입력 필드 내용 왼쪽 정렬 */
	}
	
	#reserButton {
		border: none;
		border-radius: 10px;
		background-color: #f0f1f1;
		width: calc(100% - 20px);
	}
	#reserButton:hover {
	  box-shadow: 0 5px 20px rgba(0,0,0,0.25), 0 3px 5px rgba(0,0,0,0.22);
	}
  	
  	.btn-secondary {
  		background-color: #f0f1f1; opacity : 0.5;
  		border-color: #f0f1f1;
  	}
  	.btn-outline-primary {
		border-color: #B6E5FF;
		color: black;
  	}
  	
  	.btn-outline-primary:hover {
  		border-color: #B6E5FF;
		background-color: #B6E5FF;
		color: black;
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

  <div id="reserBody" class="container">
	<h1>진료 예약하기</h1>
    <div id="selectPetDiv">
      <select id="selectPet" class="custom-select">
        <option value="null">진료볼 마이펫을 선택하세요</option>
        <c:forEach var="myPet" items="${myPetList }">
          <option value="${myPet.petIdx}">${myPet.petName}</option>
        </c:forEach>
      </select>
      
      <div id="guardianInfo">
      	<p id="guardianInfoTitle">보호자 정보</p>
      	<form method="post">
      		<c:choose>
		    	<c:when test="${not empty user.name }">
		    		<p>이름 : <input type="text" id="guardian" name="guardian" value="${user.name }"></p>
		      		<p>연락처 : <input type="text" id="guardianPhone" name="guardianPhone" value="${user.phone }"></p>
		    	</c:when>
		    	<c:otherwise>
		    		<p>이름 : <input type="text" id="guardian" name="guardian" placeholder="보호자이름"></p>
		      		<p>연락처 : <input type="text" id="guardianPhone" name="guardianPhone" placeholder="보호자연락처"></p>
		    	</c:otherwise>
		    </c:choose>
		      <textarea rows="10" cols="30" id="memo" name="memo">메모를 남겨주세요</textarea>
		      <input type="button" value="예약하기" id="reserButton" onclick="insertReservation(this.form)">
		      <input type="hidden" id="reserDate" name="reserDate">
		      <input type="hidden" id="selectTime" name="selectTime">
		      <input type="hidden" id="petIdxStr" name="petIdxStr">
      	</form>
      	
   	  </div>  
    </div>
    
    
    
    <div id="selectDateTimeDiv" class="container">
    	<div id="calendar" class="reserInfo"></div>
    	<div id="listDisp" class="reserInfo">
    		<p id="timeListTitle">예약 가능 시간</p>
	    </div>
    </div>
    
    
    
  </div>

  <script>
    //선택된 시간을 form 시간값에 저장
    $('form').on('submit', function() {
        let selectedTime = $('.btn.selected').data('time');
        $('#selectTime').val(selectedTime);
    });
  </script>

</body>
</html>
