<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 찾기 결과</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script>
function login() {
	location.href = "login.do";
}
function userJoin() {
	location.href = "userJoin.do";
}
</script>
</head>
<body>
<div id="container">
<h1>아이디 찾기</h1>


<p class="find">회원님의 아이디 찾기가 완료되었습니다.</p>
	<c:choose>
		<c:when test="${empty findEmail}">
		<p class="inquiry">조회결과가 없습니다.</p>
		<input class="btnToLogin" type="button" value="회원가입 하러가기" onclick="userJoin()">
		</c:when>
        <c:otherwise>
             <p class="result">아이디 : ${findEmail}</p>
	<input class="btnToLogin" type="button" value="로그인 하러가기" onclick="login()">
        </c:otherwise>
	</c:choose>


</div>
</body>
</html>