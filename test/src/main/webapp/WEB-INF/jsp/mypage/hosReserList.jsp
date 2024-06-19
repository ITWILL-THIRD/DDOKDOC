<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/hosReserListCss.jsp"/>

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
	    var selectedDate = localStorage.getItem('selectedDate') || null;
	    var selectedDay = selectedDate ? new Date(selectedDate).getDay() : null;

	    var hospitalSundayOff = ${hospital.sunDayOff == 'Y'};

	    var closedDates = [
	        <c:forEach var="date" items="${hosHoliday}">
	            '<fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/>',
	        </c:forEach>
	    ];
	    closedDates.pop();

	    var calendar = new FullCalendar.Calendar(calendarEl, {
	        googleCalendarApiKey: 'AIzaSyCpdR-Qoefgl33LiyjqpiZglfgJogfB16Y',
	        plugins: ['interaction', 'dayGrid', 'googleCalendar'],
	        header: {
	            left: 'prevYear,prev,next,nextYear today',
	            center: 'title',
	            right: 'dayGridMonth,dayGridWeek,dayGridDay'
	        },
	        editable: false,
	        eventLimit: true,
	        selectable: false,
	        eventSources: [
	            {
	                googleCalendarId: 'ko.south_korea#holiday@group.v.calendar.google.com',
	                className: 'ko_event',
	                color: 'white',
	                textColor: 'red'
	            }
	        ],
	        eventRender: function(info) {
	            if (info.el.tagName === 'A') {
	                info.el.removeAttribute('href');
	            }
	            if (info.el.parentNode) {
	                var parent = info.el.parentNode;
	                if (parent.tagName === 'A') {
	                    parent.replaceWith(info.el);
	                }
	            }
	        },
	        dateClick: function(info) {
	            var today = new Date();
	            today.setHours(0, 0, 0, 0);
	            var clickedDate = new Date(info.dateStr);

	            if (closedDates.includes(info.dateStr)) {
	                alert(info.dateStr + "은 휴무입니다:)");
	                return;
	            }
	            if (hospitalSundayOff && clickedDate.getDay() === 0) {
	                alert("일요일은 휴무입니다.");
	                return;
	            }
	            if (selectedDate === info.dateStr) {
	                info.dayEl.style.backgroundColor = '';
	                selectedDate = null;
	                localStorage.removeItem('selectedDate');
	                $("#listDisp").html("");
	                clearSelectedTime();
	            } else {
	                if (selectedDate) {
	                    var prevDayEl = document.querySelector('[data-date="' + selectedDate + '"]');
	                    if (prevDayEl) {
	                        prevDayEl.style.backgroundColor = '';
	                    }
	                }
	                info.dayEl.style.backgroundColor = '#B6E5FF';
	                selectedDate = info.dateStr;
	                selectedDay = info.date.getDay();
	                localStorage.setItem('selectedDate', selectedDate);
	                getJsonTimeData(selectedDate, selectedDay);
	            }
	        },
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
	    
	    if (selectedDate) {
	    	getJsonTimeData(selectedDate, selectedDay);
	    }
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
 				getReservData(response);
	            	/* let currentTime = new Date();
	                let currentDateString = currentTime.toISOString().split('T')[0]; // YYYY-MM-DD 형식의 현재 날짜
	                let currentHours = currentTime.getHours().toString().padStart(2, '0');
	                let currentMinutes = currentTime.getMinutes().toString().padStart(2, '0');
	                let currentTimeStr = currentHours + ':' + currentMinutes;

	                let reservationTime = $(this).attr('data-reservationTime');
	                let reservationDateStr = $(this).attr('data-reserDate');    
	                let reservationDate = new Date(reservationDateStr); // 문자열을 Date 객체로 변환
	                let reservationDateString = reservationDate.toISOString().split('T')[0]; // YYYY-MM-DD 형식의 예약 날짜
	               
	                console.log("reservationDateString :" + reservationDateString + typeof reservationDateString);
	                //let reservationDateString = reservationDate.toISOString().split('T')[0]; // YYYY-MM-DD 형식의 예약 날짜
	                
	                console.log("reservationTime : " + reservationTime + typeof reservationTime);

	                if (reservationTime > currentTimeStr && reservationDateString > currentDateString) {
	                    alert("진료 시간이 아닙니다.");
	                } else {  */
 				
	            // 진료 완료 버튼 클릭 이벤트
	            $('#listDisp').on('click', '.complete-btn', function() {
	            	let reserIdx = $(this).attr('data-reserIdx');  // 문자열 타입
	            	reserIdx = parseInt(reserIdx, 10);  // 정수 타입으로 변환

		                $.ajax({
		                    url: '../mypage/updateComplete.do',
		                    method: 'POST',
		                    contentType: 'application/json',
		                    data: JSON.stringify({ reserIdx: reserIdx }),
		                    success: function(data) {
		                        console.log('updateComplete 완료:', data);
	
		                        // 진료 완료 처리가 완료된 후 데이터를 다시 호출
		                        $.ajax({
		                            url: '../mypage/getReseredTimes.do',
		                            type: "post",
		                	        data: JSON.stringify(vo),
		                	        contentType: "application/json",
		                	        dataType: "json",
		                	        success: function(response) {
		                	        	getReservData(response);
	                	            }
		                        });
		                    },
		                    error: function(jqXHR, textStatus, errorThrown) {
		                        console.error('updateComplete 호출 중 오류 발생:', textStatus, errorThrown);
		                    }
		                });	
	                //}
	                // reserIdx가 "정보 없음"인 경우를 처리
	                if (reserIdx === "정보 없음") {
	                    alert("예약 정보가 없습니다.");
	                    return;
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
	function getReservData(response) {
		let dispHtml = "";
        //console.log(response); // response 객체 구조 확인

        if (response.petReserList.length === 0) {
            dispHtml += '<tr><td colspan="6">진료 내역이 없습니다</td></tr>';
        } else {
       			// 예약된 시간만 표시하는 부분
            for (let time of response.reservedTimes) {
                let timeComponents = time.split(":");
                let hour = parseInt(timeComponents[0]);
                let minute = parseInt(timeComponents[1]);
                let isDisabled = false;

                dispHtml = ''; // 여기서 초기화

                for (let reservation of response.petReserList) {
                    let reservationTime = reservation.reserTime.substring(0, 5); // 시간과 분까지만 추출 (14:30:00 -> 14:30)
                    let reservationDate = new Date(parseInt(reservation.reserDate)); // 타임스탬프를 Date 객체로 변환
                    let reserGuardian = reservation.guardian;
                    let reserGuardianPhone = reservation.guardianPhone;
                    let reserPetName = reservation.petName;
                    let reserAnimal = reservation.animal;
                    let reserPetAge = reservation.petAge;
                    let reserCondition = reservation.condition;
                    let reserIdx = reservation.reserIdx;
				
					if (reserIdx == null) {
                		dispHtml += '<tr><td colspan="6">진료 내역이 없습니다</td></tr>';
                		console.log( );
            		}
                    let completBtn = "";
                    if (reservation.condition === "RESERVATION") {
                        completBtn += '<button class="complete-btn" data-reserIdx="';
                        completBtn += reservation.reserIdx;
                        completBtn += '" data- data-reservationTime="' + reservationTime + '" data-reserDate="' + reservationDate + '">진료 완료</button>';
                    } else {
                        completBtn = "";
                    }
                    if (isDisabled) {
                        dispHtml += 'disabled ';
                    }
                    dispHtml += '<tr>';
                    if (isDisabled) {
                        dispHtml += 'disabled ';
                    }
                    dispHtml += '<td class="reserTime">' + reservationTime + '</td>';
                    dispHtml += '<td>' + reserGuardian + '</td>';
                    dispHtml += '<td>' + reserGuardianPhone + '</td>';
                    dispHtml += '<td>' + reserPetName + '</td>';
                    dispHtml += '<td>' + reserAnimal + '</td>';
                    dispHtml += '<td>' + reserPetAge + '살</td>';
                    dispHtml += '<td>' + completBtn + '</td>';
                    dispHtml += '</tr>';
                }
            }
   		}
        $("#listDisp").html(dispHtml);
	}

/* 	 //선택된 시간을 form 시간값에 저장
    $('form').on('submit', function() {
        let selectedTime = $('.time-btn.reserved').data('time');
        $('#selectTime').val(selectedTime);
    }); */
  
</script>
</head>
<body>
	<div id="reserBody">
	    <div id="calendar" class="reserInfo"></div>
	    <div>    
			<ul>
				<li>예약 목록</li>
			</ul>
			   <table id="reserList">
					<thead>
				        <tr>
				            <th width="60px">예약시간</th>
				            <th width="80px">보호자</th>
				            <th width="150px">연락처</th>
				            <th width="60px">펫이름</th>
				            <th width="60px">종류</th>
				            <th width="60px">나이</th>
				            <th width="60px"></th>
				        </tr>
			    	</thead>
				    <tbody id="listDisp">
				    </tbody>
				</table>
	    </div>
	</div>
</body>
</html>
