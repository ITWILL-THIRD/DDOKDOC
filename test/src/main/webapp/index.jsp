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
		<a href="myPage.do">마이페이지</a>
	<li>
<c:choose>
	<c:when test="${not empty sessionScope.user}">
		<a href="logout.do">로그아웃</a>
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



	<h1>TODOC</h1>
	<br>
	<c:if test="${not empty sessionScope.user}">
		<a href="user/userReserList.do">내 예약조회</a>
	</c:if>	
	
</div>


</body>
</html>












