<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 회원가입</title>
</head>
<body>
<h1>병원회원가입</h1>
<form action="userJoin.do" method="post">
<table>
	<tr>
		<td>병원 아이디</td>
		<td><input id="email" type="text" name="email" value="${userVO.email }" onblur="check_email(this.form)"></td>
		<td>
			<input type="button" value="중복체크" onclick="checkDup(this.form)"/>
		</td>
	</tr>
	<tr>
		<td>병원 비밀번호</td>
		<td><input type="text" name="nickName" value="${userVO.nickName }"></td>
	</tr>
	<tr>
		<td>병원 이름</td>
		<td><input type="password" name="password" value="${userVO.password }"></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><input type="password" name="pwdCheck" value="${userVO.password }" onblur="check_pwd(this.form)"></td>
	</tr>
	<tr>
		<td>담당동물</td>
		<td><input type="text" name="name" value="${userVO.name }"></td>
	</tr>
	<tr>
		<td>병원주소</td>
		<td><input type="date" name="birth" value="${userVO.birth }"></td>

	</tr>
	<tr>
		<td>병원 운영시간</td>
		<td>
		<input type="text"  name="phone" value="${userVO.phone }" oninput="oninputPhone(this)" maxlength="14">
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input class="loginbtn" type="button" value="회원가입" onclick="userJoin_ok(this.form)">
		</td>
	</tr>
	<tr>
		<td><a href="login.do">로그인으로 이동</a></td>
		<td><input type="reset" value="초기화"></td>
	</tr>
	
</table>
</form>
</body>
</html>