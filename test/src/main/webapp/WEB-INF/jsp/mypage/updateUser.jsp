<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function updatePwd(frm) {
		const userIdx = frm.userIdx.value;
		location.href = "updatePwd.do?userIdx=" + userIdx;
	}


	function userUpdate_ok(frm) {
		return confirm("수정하시겠습니까?")
	}
</script>
</head>
<body>
<h2>내 정보 수정</h2>
<form name="userUpdateForm" action="updateUser.do" method="post">
	<table>
	<tr>
		<td>이메일 </td>
		<td>
		 	<input type="text" name="email" value="${user.email}" readonly>
		</td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td>
			<input type="text" name="nickname" value="${user.nickname}">
		</td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td>
			<input type="text" name="password" value="${user.password}" readonly>
		</td>
		<td>
		<input type="button" value="비밀번호 변경" onclick="updatePwd(document.userUpdateForm)">
		</td>
	</tr>
	<tr>
	<td>이름</td>
		<td>
			<input type="text" name="name" value="${user.name}" readonly>
		</td>
	</tr>
	<tr>
	<td>생년월일</td>
		<td>
			<input type="text" name="birth" value="${user.birth}" readonly>
		</td>
	</tr>
	<tr>
	<td>전화번호</td>
		<td>
			<input type="text" name="phone" value="${user.phone}">
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="userIdx" value="${user.userIdx}"></td>
	</tr>
	<tr>
	<td colspan="2" class="center">
		<input type="submit" value="내 정보 수정" onclick="userUpdate_ok(this.form)">
	</td>
</tr>
</table>
</form>
</body>
</html>