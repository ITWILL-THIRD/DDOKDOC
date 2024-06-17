<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 내역</title>
<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
	.reserHead {
		background-color: #B6E5FF;
	}
	
	#reserDetailBtn {
		width: 100px;
		border: none;
		background-color: #f0f1f1;
		border-radius: 10px;
	}
	#reserDetailBtn:hover {
	  box-shadow: 0 5px 20px rgba(0,0,0,0.25), 0 3px 5px rgba(0,0,0,0.22);
	}
	
</style>
</head>
<body>
<%-- \${myReserList } : ${myReserList }<br><br>
\${myOldReserList } : ${myOldReserList }<br><br>
\${myCancleReserList } : ${myCancleReserList }<br><br> --%>
	<div class="container">
		<h1>예약 내역 보기</h1>
		<table class="table">
			<tr class="reserHead">
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
				<td><a href="../hospital/hosDetail.do?hosIdx=${reser.hosIdx}">${reser.hosName }</a></td>
				<td>${reser.petName }</td>
				<td>${reser.reserDate }</td>
				<td>${reser.formattedTime }</td>
				<td>
					<button id="reserDetailBtn" onclick="reservationDetail(${reser.reserIdx})">상세보기</button>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	
	
<script>
	function reservationDetail(reserIdx) {
		location.href="../reservation/reservationDetail.do?reserIdx=" + reserIdx;
	}
</script>
</body>
</html>