<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

</head>
<body>
<div id="container">
	<h1>TODOC</h1>
	<hr>
	<p>
		<a href="hospital/hosMain.do">병원 검색으로 이동</a>
	</p>
	<br>
	<!-- <네비게이션 바>병원예약 페이지 연결 -->
	<h2>[병원 예약]</h2>
	<hr><hr>
	<h2>세션에 로그인 정보 저장</h2>
	<%
		session.setAttribute("user", "1");
	%>
	<h2>병원예약하기</h2>
	<p><a href="getHospitalList.do">병원목록페이지로 이동</a></p>
	<hr>
	
</div>

</body>
</html>












