<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    var initialDate = '${reservationVO.reserDate}'; // 기존 예약 날짜
    var initialTime = '${reservationVO.formattedTime}'; // 기존 예약 시간
    
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
      dayRender: function(date, cell) {
        var today = new Date();
        today.setHours(0, 0, 0, 0);
        if (date < today) {
          cell.style.backgroundColor = 'lightgray';
        }
      }
      
    });

    calendar.render();

 	// 초기 예약 날짜 및 시간 설정
    if (initialDate) {
      selectedDate = initialDate;
      document.getElementById('reserDate').value = initialDate; // 숨겨진 필드 업데이트
      var initialDayEl = document.querySelector('[data-date="' + initialDate + '"]');
      if (initialDayEl) {
        initialDayEl.style.backgroundColor = 'lightblue'; // 선택된 색상 설정
        selectedDay = new Date(initialDate).getDay(); //선택된 날짜의 요일
        getJsonTimeData(initialDate, selectedDay, initialTime);
      }
    }
 	
  });

  function getJsonTimeData(selectedDate, selectedDay, initialTime) {
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
        
        //초기시간값 저장
        $('#selectTime').val(initialTime);
        
        let dispHtml = "";
        for (let time of response.availableTimes) {
        	// 기존 예약 시간과 같을 때 선택 상태로 설정
            if (response.reservedTimes.includes(time)) {
            	if (time == initialTime) {
            		dispHtml += `<button type="button" class="time-btn selected" data-time="${time}">`;
            	} else {
	                dispHtml += `<button type="button" class="time-btn" data-time="${time}" disabled>`;
            	}
            } else {
                dispHtml += `<button type="button" class="time-btn ${selectedClass}" data-time="${time}">`;
            }
            dispHtml += time;
            dispHtml += "</button><br>";
        }
        $("#listDisp").html(dispHtml);

        // 시간 선택 이벤트 리스너 설정
        $(".time-btn").on("click", function() {
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
    $(".time-btn").removeClass("selected");
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
  
  function updateReservation(frm) {
    let selectedDate = document.getElementById('reserDate').value;
    let selectedTime = document.getElementById('selectTime').value;
    let selectedPet = document.getElementById('petIdxStr').value;
    
    // null 체크
    if (selectedPet === "null") {
        alert("진료볼 마이펫을 선택하세요");
        return false; 
    }
    
    alert("selectedPet: " + selectedPet);
    alert("Selected Date: " + selectedDate);
    alert("Select Time: " + selectedTime);
    
    frm.action = "updateReservation.do";
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
<%-- \${hospital } : ${hospital }<br>
\${reservationList } : ${reservationList }<br>
\${user } : ${user }<br>
\${myPetList } : ${myPetList }<br>
\${session.getAttribute } : ${userIdx }<br> --%>
\${reservationVO } : ${reservationVO }<br> 

	<h2>예약변경하기</h2>
  <div>
    <div id="selectPetDiv">
      <select id="selectPet">
        <option value="null">진료볼 마이펫을 선택하세요</option>
        <c:forEach var="myPet" items="${myPetList }">
          <option value="${myPet.petIdx}" <c:if test="${myPet.petIdx == reservationVO.petIdx}">selected</c:if>>${myPet.petName}</option>
        </c:forEach>
      </select>
    </div>
    <div id="calendar" class="reserInfo"></div>
    <div id="listDisp" class="reserInfo">
      <ul>
        <li>예약가능시간</li>
      </ul>
    </div>
    <form method="post">
      <textarea rows="4" cols="5" id="memo" name="memo">${reservation.memo}</textarea>
      <input type="button" value="예약 변경하기" onclick="updateReservation(this.form)">
      <input type="hidden" id="reserIdx" name="reserIdx" value="${reservationVO.reserIdx}">
      <input type="hidden" id="reserDate" name="reserDate">
      <input type="hidden" id="selectTime" name="selectTime">
      <input type="hidden" id="petIdxStr" name="petIdxStr" value="${reservationVO.petIdx}">
    </form>
  </div>

  <script>
    //선택된 시간을 form 시간값에 저장
    $('form').on('submit', function() {
        let selectedTime = $('.time-btn.selected').data('time');
        $('#selectTime').val(selectedTime);
    });
  </script>

</body>
</html>