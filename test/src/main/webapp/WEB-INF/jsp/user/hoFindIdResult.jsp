<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 아이디 찾기 결과</title>
</head>
<body>
<h1>병원 아이디 찾기 결과</h1>
<p class="title">회원님이 가입한 아이디 입니다.</p>
<div class="result-box">
	<c:choose>
		<c:when test="${empty findHosId}">
		<p class="inquiry">조회결과가 없습니다.</p>
		<a href="hoJoin.do">병원회원가입 하러가기</a>
		</c:when>
        <c:otherwise>
            <p>${findHosId}</p>
        </c:otherwise>
	</c:choose>
</div>
<a href="hoLogin.do">병원로그인</a>
</body>
</html>