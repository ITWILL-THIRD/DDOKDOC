<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
    var selectedDay = null;
    
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
        // 특정 날짜만 클릭 비활성화 (예: 2024-05-30)
        if (info.dateStr === '2024-06-01') {
          alert('2024-06-01은 병원 휴무입니다:)');
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
      }
    });

    calendar.render();
    
    
  });

  function getJsonTimeData(selectedDate, selectedDay) {
	    alert("예약 가능한 시간");
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
                for (let time of response.availableTimes) {
                    if (response.reservedTimes.includes(time)) {
                        dispHtml += `<button type="button" class="time-btn" data-time="${time}" disabled>`;
                    } else {
                        dispHtml += `<button type="button" class="time-btn" data-time="${time}">`;
                    }
                    dispHtml += time;
                    dispHtml += "</button><br>";
                }
                $("#listDisp").html(dispHtml);

             // 시간 선택 이벤트 리스너 설정
                $(document).on("click", ".time-btn", function() {
                  if ($(this).hasClass("selected")) {
                	  alert("선택된시간");
                    $(this).removeClass("selected");
                  } else {
                    clearSelectedTime();
                    $(this).addClass("selected");
                    let selectedTime = $(this).text();  // 선택된 시간 가져오기
                    alert(selectedTime);
                    $('#selectTime').val(selectedTime); // resertime에 선택된 시간 저장
                  }
                });


	        },
	        error: function() {
	            alert("실패~~");
	        }
	    });

	  }
  function insertReservation(frm) {
	frm.action = "insertReservation.do";
	let selectedDate = document.getElementById('reserDate').value;
    let selectedTime = document.getElementById('selectTime').value;
    alert("Selected Date: " + selectedDate);
    alert("Select Time: " + selectTime);
	frm.submit();
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
\${hospital } : ${hospital }<br>
\${reservationList } : ${reservationList }<br>
\${user } : ${user }<br>
\${session.getAttribute } : ${userIdx }<br>

	<div>
        <div id='calendar' class="reserInfo"></div>
        <div id="listDisp" class="reserInfo">
            <ul>
                <li>예약가능시간</li>
            </ul>
        </div>
        <!-- <form action="insertReservation.do" method="post" >
            <input  type="submit" value="예약하기">
            <input type="hidden" id="user" name="userIdx">
            <input type="hidden" id="dateStr" name="reserDate">
            <input type="hidden" id="selectedTime" name="resertime">
        </form> -->
        <form method="post">
            <input type="button" value="예약하기" onclick="insertReservation(this.form)">
            <input type="hidden" id="reserDate" name="reserDate">
            <input type="hidden" id="selectTime" name="selectTime">
        </form>
    </div>

    <script>
    	//선택된 시간을 form 시간값에 저장
        $('form').on('submit', function() {
            let selectedTime = $('.time-btn.selected').data('time');
            $('#selectTime').val(selectedTime);
        });
        function clearSelectedTime() {
            $(".time-btn").removeClass("selected");
        }
        
        

    </script>
  
</body>
</html>