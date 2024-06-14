<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userReservDetail</title>
</head>
<body>
<h1>userReservDetail</h1>
<%-- \${reserv } : ${reserv } --%>
<table>
		<tr>
			<th>병원 이름</th>
			<td>${reserv.hosName }</td>
		</tr>
		<tr>
			<th>예약일</th>
			<td>${reserv.reserDate }</td>
		</tr>
		<tr>
			<th>예약시간</th>
			<td>${reserv.formattedTime }</td>
		</tr>
		<tr>
			<th>진료볼동물</th>
			<td>${reserv.petName }</td>
		</tr>
		<tr>
			<th>메모</th>
			<td>${reserv.memo }</td>
		</tr>
</table>
		<a href="userReservPage.do?userIdx=${reserv.userIdx }">예약내역</a>

</body>
</html>