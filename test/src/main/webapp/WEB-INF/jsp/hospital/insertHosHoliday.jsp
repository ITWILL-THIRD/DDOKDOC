<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	//달력 띄우기
	document.addEventListener('DOMContentLoaded', function() {
	    var calendarEl = document.getElementById('calendar');
	    var selectedDate = null; 
	    var selectedDay = null;
	    var selectedDates = []; // 선택된 날짜들을 저장할 배열
    
    // 휴무일 목록을 받아옴
    var closedDates = [
	    <c:forEach var="date" items="${hosHolidayList}">
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
      	selectable: true,
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
	          if (confirm(info.dateStr + "휴무지정 취소하시겠습니까?")) {
	        	  //휴무 취소 함수 실행시키기
	        	  alert("휴무 취소하기");
	        	  deleteHoliday(info.dateStr);
	          } else {
		          return;
	          }
	        }
	        var dateIndex = selectedDates.indexOf(info.dateStr);
	        if (dateIndex > -1) {
	          // 이미 선택된 날짜일 경우 선택 해제
	          selectedDates.splice(dateIndex, 1);
	          info.dayEl.style.backgroundColor = ''; // 원래 색상으로 복원
	        } else {
	          // 선택되지 않은 날짜일 경우 선택
	          selectedDates.push(info.dateStr);
	          info.dayEl.style.backgroundColor = 'lightblue'; // 선택된 색상 설정
	        }
	        alert(selectedDates);
	        
	        // 숨겨진 필드 업데이트
	        document.getElementById('holidays').value = JSON.stringify(selectedDates);
	        alert("선택된 날짜들: " + selectedDates.join(', '));
	        
        },
      
     	// 과거 날짜, 휴무일 회색으로 설정
      	datesRender: function(info) {
	        var today = new Date();
	        today.setHours(0, 0, 0, 0);
	
	        var allDayEls = document.querySelectorAll('.fc-day');
	
	        allDayEls.forEach(function(dayEl) {
	        	var dateStr = dayEl.getAttribute('data-date');
	          	var date = new Date(dateStr);
	          
	          	if (date < today || closedDates.includes(dateStr)) {
	              	dayEl.style.backgroundColor = '#f0f1f1';
	          	}
        	});
      	} 

    });

    calendar.render();
  });

  
  function submitForm() {
    document.getElementById("holidayForm").submit();
  }
  
  function deleteHoliday(dateStr) {
	  document.getElementById('holiDateStr').value = dateStr;
	  document.getElementById('DelHolidayForm').submit();
  }
  
</script>
<title>병원 휴무일 등록 페이지</title>
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
  
</style>
</head>
<body>
\${hoUser} : ${hoUser }
\${hosHolidayList} : ${hosHolidayList }
	<h2>병원 휴무일 등록</h2>
	<div id="calendar" class="reserInfo"></div>
	<form id="holidayForm" action="insertHosHoliday.do" method="post">
		<input type="hidden" id="holidays" name="holidays" value="[]">
		<input type="hidden" id="hosIdx" name="hosIdx" value="${hoUser.hosIdx }">
		<button type="button" onclick="submitForm()">제출</button>
	</form>
	<form id="DelHolidayForm" action="deleteHosHoliday.do" method="post">
		<input type="hidden" id="holiDateStr" name="holiDateStr" >
		<input type="hidden" id="hosIdx" name="hosIdx" value="${hoUser.hosIdx }">
	</form>
</body>
</html>