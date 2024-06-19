<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 찾기 결과</title>
</head>
<body>
<h1>아이디 찾기 결과</h1>
<p class="title">회원님의 아이디 입니다.</p>
<div class="result-box">
	<c:choose>
		<c:when test="${empty findEmail}">
		<p class="inquiry">조회결과가 없습니다.</p>
		<a href="userJoin.do">회원가입 하러가기</a>
		</c:when>
        <c:otherwise>
            <p>${findEmail}</p>
        </c:otherwise>
	</c:choose>
</div>
<a href="login.do">로그인</a>
</body>
</html>