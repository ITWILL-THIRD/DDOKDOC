<%@page import="com.todoc.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	
</script>
</head>
<body>
<%
	// 임시 사용자 데이터 저장
    HttpSession ss = request.getSession();
    if (session.getAttribute("user") == null) {
        UserVO user = new UserVO(1, "user@example.com", "usernick");
        session.setAttribute("user", user);
        System.out.println(user);
    }
%>

<div id="container">
	<h1>TODOC</h1>
	<hr>
	<p>
		<a href="login.do">로그인 페이지로 이동(GET)</a>
	</p>
	<hr><hr>
	
	<h2>병원예약하기</h2>
	<p><a href="getHospitalList.do">병원목록페이지로 이동</a></p>
	<hr>
	
	<h2>마이페이지</h2>
    <p><a href="myPage.do">마이페이지로 이동</a></p>
    <hr>
	
</div>
<script>
	
</script>
</body>
</html>
