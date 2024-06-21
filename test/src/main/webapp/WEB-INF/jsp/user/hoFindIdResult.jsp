<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 아이디 찾기 결과</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script>
function hoLogin() {
	location.href = "hoLogin.do";
}
function hoJoin() {
	location.href = "hoJoin.do";
}
</script>
</head>
<body>
<div id="container">
<h1>병원 아이디 찾기</h1>
<p class="find">회원님의 아이디 찾기가 완료되었습니다.</p>

	<c:choose>
		<c:when test="${empty findHosId}">
		<p class="inquiry">조회결과가 없습니다.</p>
		<input class="btnToLogin" type="button" value="병원 회원가입 하러가기" onclick="hoJoin()">
		</c:when>
        <c:otherwise>
            <p class="result">아이디 : ${findHosId}</p>
            <input class="btnToLogin" type="button" value="병원 로그인 하러가기" onclick="hoLogin()">
        </c:otherwise>
	</c:choose>
</div>
</body>
</html>