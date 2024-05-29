<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/" ></script>
<link href="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/main.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@4.4.0/main.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/core@4.4.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/interaction@4.4.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/daygrid@4.4.0/main.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@4.4.0/main.min.js"></script>
<script>

  document.addEventListener('DOMContentLoaded', function() {
    var calendarEl = document.getElementById('calendar');
    var selectedDate = null; 
    
    var calendar = new FullCalendar.Calendar(calendarEl, {
      googleCalendarApiKey:'AIzaSyCpdR-Qoefgl33LiyjqpiZglfgJogfB16Y',
      plugins: [ 'interaction', 'dayGrid', 'googleCalendar' ],
      header: {
        left: 'prevYear,prev,next,nextYear today',
        center: 'title',
        right: 'dayGridMonth,dayGridWeek,dayGridDay'
      },
      navLinks: true, // can click day/week names to navigate views
      editable: false,
      eventLimit: true, // allow "more" link when too many events
      selectable: false,
      eventSources:[
    	{googleCalendarId:'ko.south_korea#holiday@group.v.calendar.google.com',
    		className:'ko_event',
    		color:'white',
    		textColor:'red'
    		}],
  		eventClick: function(info) {
  		      // 클릭한 이벤트가 구글 캘린더 이벤트인지 확인
  		      if (info.event.source.googleCalendarId) {
  		        return false; // 구글 캘린더 이벤트 클릭 무시
  		      } else {
  		        // 다른 이벤트 클릭 시 기본 동작 수행
  		        window.open(info.event.url, '_blank'); // 새 창으로 이벤트 URL 열기
  		        return false; // 기본 이벤트 처리 막기
  		      }
  		    },		
      dateClick: function(info) {
    	// 특정 날짜만 클릭 비활성화 (예: 2024-05-28)
    	// 휴무일 데이터 테이블 만들어서 처리(아마도....)
          if (info.dateStr === '2024-05-30') {
            alert('2024-05-30은 병원 휴무입니다:)');
            return;
          }
        // 클릭한 날짜가 선택된 날짜인지 확인
        if (selectedDate === info.dateStr) {
          // 선택된 날짜 다시 클릭 시 해제
          info.dayEl.style.backgroundColor = ''; // 원래 색상으로 복원
          selectedDate = null; // 선택 해제
          document.getElementById('dateStr').value = ''; // 숨겨진 필드 비움
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
          document.getElementById('dateStr').value = info.dateStr; // 숨겨진 필드 업데이트
		  
          // 선택된 날짜가 없으면 예약하기 안넘어가게 코드 추가
		  
        }
      }
    });

    calendar.render();
  });

  
  function selectTime(time) {
    document.getElementById('selectedTime').value = time;
  }

</script>
<style>

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }

  #calendar {
    max-width: 700px;
	margin-left: 100px;
  }

</style>
</head>
<body>
\${hospital } : ${hospital }<br>
  <div id='calendar'></div>
  <form action="insertReservation.do" method="post" > 
	  <input type="submit" value="예약하기">
	  <!-- 날짜, 시간 데이터 전송 -->
	  <input type="hidden" id="dateStr" name="dateStr">
  </form>

</body>
</html>
