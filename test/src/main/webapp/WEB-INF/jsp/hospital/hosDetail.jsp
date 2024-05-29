<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 상세 보기(정보,지도,예약,리뷰)</title>
<script type="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
	\${hospital } : ${hospital } <br>
	\${hosIdx } : ${hosIdx } <br>
<div id="container">
	<h1>병원 상세 [hosDetail.jsp]</h1>
	
	<table>
		<tr>
			<th>병원명</th>
			<td>${hospital.hosname}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${hospital.roadaddressname}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${hospital.hosphone}</td>
		</tr>
		<tr>
			<th>영업시간</th>
			<td>${hospital.condition }</td>
		</tr>
		<tr>
			<th>진료동물</th>
			<td>${hospital.animal}</td>
		</tr>
		<tr>
			<th>평점</th>
			<td>${hospital.score}</td>
		</tr>
	</table>
	<div>
		<h4>지도 표시</h4>
		
	</div>
	
	<p class="center">
		<a href="reservationHos.do">예약</a>
		<a href="hosMain.do">병원 목록</a>
	</p>
</div>
	
</body>
</html>