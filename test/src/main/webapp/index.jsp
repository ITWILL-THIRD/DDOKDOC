<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지</title>

<script></script>
<style>

li {
	 	 float: left;
	   	 display: block;
		 padding: 10px 26px;
</style>

<script src="https://code.jquery.com/jquery-1.12.4.js"></script>


</head>
<body>
<div id="container">

	<h1>토닥토닥 로고</h1>
<ul>
	<li>
		<a href="hospital/hosMain.do">병원예약</a>
	</li>
	<li>
		<a href="user/login.do">정보나눔</a>
	</li>
	<li>
		<a href="user/login.do">멤버십</a>
	</li>

	<li>
<c:choose>
	<c:when test="${not empty sessionScope.user}">
		<a href="logout.do">로그아웃</a>
		<a href="#">마이페이지</a>
	</c:when>
	<c:otherwise>
        <a href="user/login.do">로그인 /회원가입</a>
    </c:otherwise>

</c:choose>	
	</li>

</ul>
</div>	
<br><br><br>

<hr>

<p>이메일: ${sessionScope.user.email}</p>
<p>닉네임: ${sessionScope.user.nickname}</p>

<%-- <p>병원아이디: ${sessionScope.user.hosId}</p> --%>
<%-- <p>병원이름: ${sessionScope.user.hosName}</p> --%>

	<h1>TODOC</h1>

	<br>
	
	
</div>


</body>
</html>












