<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 선택</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script>
function login() {
	location.href = "login.do";
}
function hoLogin() {
	location.href = "hoLogin.do";
}
</script>
</head>
<body>
로고
<hr>
<table class="tb">
<tr>
<td colspan=2><h1>TODOC 로그인</h1></td>
</tr>
<tr>
<td class="p" colspan=2>TODOC에 로그인 하신 후 다양한 서비스를 경험해보세요.</td>
</tr>
<tr>
<td><input class="selectBtn" type="button" value="개인 로그인 / 회원가입" onclick="login()"></td>
<td><input class="selectBtn2" type="button" value="병원 로그인 / 회원가입" onclick="hoLogin()"></td>
</tr>
</table>
</body>
</html>