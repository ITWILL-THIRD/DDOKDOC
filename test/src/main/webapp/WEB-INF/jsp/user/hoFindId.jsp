<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 아이디 찾기</title>
</head>
<body>
<h1>병원 아이디 찾기</h1>
<form name="frm" action="hoFindId.do" method="post">
	<table>
		<tr>
			<td><input type="text" name="hosName" placeholder="병원이름"></td>
		</tr>
		<tr>
			<td><input type="text" name="hosPhone" placeholder="전화번호" oninput="oninputPhone(this)" maxlength="14"></td>
		</tr>
		<tr>
			<td><input type="submit" id="submit" value="아이디 찾기"></td>
		</tr>
	</table>
</form>
<a href="hoJoin.do">회원가입하기</a>
<a href="hoLogin.do">로그인하기</a>
</body>
</html>