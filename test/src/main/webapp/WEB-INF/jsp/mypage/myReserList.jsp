<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 내역</title>
<!-- 부트스트랩 -->
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script> -->
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<%-- \${myReserList } : ${myReserList }<br><br>
\${myOldReserList } : ${myOldReserList }<br><br>
\${myCancleReserList } : ${myCancleReserList }<br><br> --%>
	<h2>예약 내역 보기</h2>
	<table class="table">
		<tr>
			<th>번호</th>
			<th>병원이름</th>
			<th>마이펫</th>
			<th>날짜</th>
			<th>시간</th>
			<th>예약변경/취소</th>
		</tr>
	<c:forEach var="reser" items="${myReserList }">
		<tr>
			<td>${reser.rownum }</td>
			<td>${reser.hosName }</td>
			<td>${reser.petName }</td>
			<td>${reser.reserDate }</td>
			<td>${reser.formattedTime }</td>
			<td>
				<button onclick="reservationDetail(${reser.reserIdx})">상세보기</button>
			</td>
		</tr>
	</c:forEach>
	</table>
	
<script>
	function reservationDetail(reserIdx) {
		location.href="../reservation/reservationDetail.do?reserIdx=" + reserIdx;
	}
</script>
</body>
</html>