<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세보기 (예약 완료 화면)</title>
</head>
<body>
\${reservation } : ${reservation }
	<h2>예약 완료!!!!</h2>
	<h3>${reservation.userIdx } 유저이름님의 예약이 완료되었습니다!</h3>
	<table>
		<tr>
			<th>병원 이름</th>
			<td>${reservation.hosIdx }</td>
		</tr>
		<tr>
			<th>예약일시</th>
			<td>${reservation.reserDate }</td>
		</tr>
		<tr>
			<th>진료볼동물</th>
			<td>${reservation.petIdx }</td>
		</tr>
		<tr>
			<th>메모</th>
			<td>${reservation.memo }</td>
		</tr>
		<tr>
			<td><button onclick="reserUpdate()">수정</button></td>
			<td><button onclick="reserDelete()">삭제</button></td>
		</tr>
	</table>
</body>
</html>