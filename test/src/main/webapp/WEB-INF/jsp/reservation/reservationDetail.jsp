<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세보기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style type="text/css">
	#info {
		color: gray;
		font-style: italic;
	}
</style>
</head>
<body>
<%-- \${reservation } : ${reservation }<br>
\${hospital } : ${hospital }<br>
\${myPet } : ${myPet }<br>
\${user } : ${user }<br> --%>


	<h3>${user.name } 님의 예약입니다</h3>
	<table>
		<tr>
			<th>병원 이름</th>
			<td><a href="../hospital/hosDetail.do?hosIdx=${hospital.hosIdx}">${hospital.hosName }</a></td>
		</tr>
		<tr>
			<th>예약일</th>
			<td>${reservation.reserDate }</td>
		</tr>
		<tr>
			<th>예약시간</th>
			<td>${reservation.formattedTime }</td>
		</tr>
		<tr>
			<th>진료볼동물</th>
			<td>${myPet.petName }</td>
		</tr>
		<tr>
			<th>메모</th>
			<td>${reservation.memo }</td>
		</tr>
	</table>
	
	<%-- 현재 날짜를 'yyyy-mm-dd' 형식으로 변환하고 세션에 저장 --%>
    <%
    java.text.SimpleDateFormat dateSdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.text.SimpleDateFormat timeSdf = new java.text.SimpleDateFormat("HH:mm");
    String currentDateStr = dateSdf.format(new java.util.Date());
    String currentTimeStr = timeSdf.format(new java.util.Date());
    session.setAttribute("currentDateStr", currentDateStr);
    session.setAttribute("currentTimeStr", currentTimeStr);
    %>

    <%-- 예약 날짜와 현재 날짜 비교 --%>
    <c:choose>
        <c:when test="${reservation.reserDate == sessionScope.currentDateStr && reservation.formattedTime <= sessionScope.currentTimeStr}">
            <p id="info">예약 시간이 지나 변경/취소가 불가능 합니다.</p>
        </c:when>
        <c:otherwise>
            <button onclick="reserUpdate(${reservation.reserIdx})">예약 변경</button>
            <button onclick="reserDelete(${reservation.reserIdx})">예약 취소</button>
        </c:otherwise>
    </c:choose>

	
	<script>
		function reserUpdate(reserIdx) {
			location.href="updateReservation.do?reserIdx=" + reserIdx;
		}
		function reserDelete(reserIdx) {
			location.href="cancleReservation.do?reserIdx=" + reserIdx;
		}
	</script>
</body>
</html>