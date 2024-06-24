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
    /* alert(closedDates); */

   var calendar = new FullCalendar.Calendar(calendarEl, {
         googleCalendarApiKey:'AIzaSyCpdR-Qoefgl33LiyjqpiZglfgJogfB16Y',
         plugins: [ 'interaction', 'dayGrid', 'googleCalendar' ],
         header: {
            left: 'today',
           center: 'title',
            right: 'prevYear,prev,next,nextYear'
         },
         editable: false,
         eventLimit: true, 
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
                deleteHoliday(info.dateStr);
             } else {
                return;
             }
           } else {
              selectedDates.push(info.dateStr);
                info.dayEl.style.backgroundColor = '#E0EAF5'; // 선택된 색상 설정
              
               // 선택되지 않은 날짜일 경우 선택
                if (confirm(info.dateStr + " 휴무지정 하시겠습니까?")) {
                    selectedDates.push(info.dateStr);
                    info.dayEl.style.backgroundColor = '#E0EAF5'; // 선택된 색상 설정
                    // 휴무 지정 함수 실행시키기
                    insertHoliday(info.dateStr);
                } else {
                    // 선택 취소 시 선택된 색상 되돌리기
                    info.dayEl.style.backgroundColor = '';
                    var index = selectedDates.indexOf(info.dateStr);
                    if (index > -1) {
                        selectedDates.splice(index, 1);
                    }
                    return;
                }
              
           }
           
           
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
  
  function insertHoliday(dateStr) {
     document.getElementById('holiday').value = dateStr;
     document.getElementById('holidayForm').submit();
  }
  
  function deleteHoliday(dateStr) {
     document.getElementById('holiDateStr').value = dateStr;
     document.getElementById('DelHolidayForm').submit();
  }
  
</script>
<title>병원 휴무일 등록 페이지</title>
<style>
   #container { width: 800px; margin: auto; }

   #pageTitle{ 
      margin-top: 20px;
      text-align: center; 
      font-weight: bold;
   }
   
   .fc-day-header {
     background-color: #E0EAF5;
   }
   
   #selectPetDiv, #selectDateTimeDiv {
   float: left;
    vertical-align: top;
    margin-top: 20px;
  }

  #selectPetDiv {
    width: calc(30% - 5px);
    height: 530px;
    box-sizing: border-box; 
     border: 1px solid gray;
     border-radius: 5px;
     padding: 5px;
  }
  
  #selectPet {
     border: 1px solid #bbb;
     border-radius: 10px;
    width: 100%;
    height: 50px;
    font-size: 20x; 
    margin-top: 5px;
    margin-bottom: 5px;
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
     margin: auto;
     flex: 1; /* 남은 공간을 모두 차지하도록 설정 */
    max-width: 700px; /* 최대 너비 설정 */
  }
  
   .btn {
     margin-bottom: 0px;
     width: 70%;
     height: 200px;
     font-size: 16px;
   }   
      
   .btn.selected {
       background-color: #E0EAF5;
   }
   
   <%-- 제목 링크 --%>
   #linkTag {   
      font-weight: bold;
      color: #2C307D;
      text-decoration: none;   
      margin-bottom: 20px;
   }
   
   #linkTag:hover {
      color:#FFA217;
   }
   

  
    /* 모달의 스타일이 기존 CSS와 충돌하지 않도록 별도로 스타일링 */
.modal-content {
    background-color: white; /* 모달의 배경색을 흰색으로 설정 */
    border-radius: 10px; /* 모달의 테두리를 둥글게 설정 */
}

.modal-header, .modal-footer {
    border-bottom: 1px solid #e9ecef;
    border-top: 1px solid #e9ecef;
}

.modal-title {
    font-size: 20px;
}

.modal-body {
    font-size: 16px;
    text-align: left;
}

.modal-footer .btn {
   width: 100px;
   height: 30px;
    font-size: 14px;
}

hr {
  border: 1px solid #2C307D;
  margin-bottom: 20px;
  }
  
  /* FullCalendar 상단 버튼 스타일링 */
    .fc-button {
        background-color: #2C307D; /* 원하는 배경색으로 변경 */
        border-color: #2C307D; /* 원하는 테두리색으로 변경 */
        color: white; /* 텍스트 색상 변경 */
    }

    .fc-button:hover {
        background-color: #1A1F56; /* 버튼 호버 시 색상 변경 */
        border-color: #1A1F56; /* 호버 시 테두리색 변경 */
    }

    .fc-button:active {
        background-color: #2C307D; /* 버튼 클릭 시 색상 변경 */
        border-color: #2C307D; /* 클릭 시 테두리색 변경 */
    }
</style>
</head>
<body>
<%-- \${hoUser} : ${hoUser }
\${hosHolidayList} : ${hosHolidayList } --%>
   <h2 id="pageTitle">병원 휴무일 등록</h2>
   <div id="container">
   <a id="linkTag" href="hoMyPage.do">병원 마이페이지 가기</a>
   <hr>
      <div id="calendar" class="reserInfo"></div>
      <form id="holidayForm" action="insertHosHoliday.do" method="post">
         <input type="hidden" id="holiday" name="holiDateStr">
         <input type="hidden" id="hosIdx" name="hosIdx" value="${hoUser.hosIdx }">
      </form>
      <form id="DelHolidayForm" action="deleteHosHoliday.do" method="post">
         <input type="hidden" id="holiDateStr" name="holiDateStr" >
         <input type="hidden" id="hosIdx" name="hosIdx" value="${hoUser.hosIdx }">
      </form>
   </div>
</body>
</html>