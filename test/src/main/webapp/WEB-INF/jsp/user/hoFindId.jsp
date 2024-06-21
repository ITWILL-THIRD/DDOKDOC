<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 아이디 찾기</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
</head>
<body>
<div id="container">
<h1>병원 아이디 찾기</h1>
<form name="frm" action="hoFindId.do" method="post">
	<table class="tb">
		<tr>
			<td><input class="psTitle" type="text" name="hosName" placeholder="병원이름"></td>
		</tr>
		<tr>
			<td><input class="psTitle" type="text" name="hosPhone" placeholder="전화번호" oninput="oninputPhone(this)" maxlength="14"></td>
		</tr>
		<tr>
			<td><input class="loginBtn" type="submit" id="submit" value="아이디 찾기"></td>
		</tr>
	</table>
</form>
<table class="select">
<tr>
<td><a href="hoJoin.do">회원가입하기</a></td>
<td class="s">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
<td><a href="hoLogin.do">로그인하기</a></td>
</tr>
</table>
</div>
</body>
</html>