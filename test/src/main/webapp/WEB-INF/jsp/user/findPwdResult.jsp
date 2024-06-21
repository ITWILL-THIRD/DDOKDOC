<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기 결과</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script>
function login() {
	location.href = "login.do";
}
</script>
</head>
<body>
<div id="container">
<h1>비밀번호 찾기 결과</h1>
<p class="title">회원님의 임시 비밀번호 입니다</p>
<div>
<p class="result">${newPwd}</p>
<p class="red">*안전을 위해 비밀번호를 변경해주세요.</p>
</div>
<input class="btnToLogin" type="button" value="로그인 하러가기" onclick="login()">
</div>
</body>
</html>