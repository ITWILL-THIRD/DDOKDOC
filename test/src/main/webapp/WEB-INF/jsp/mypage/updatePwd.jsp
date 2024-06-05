<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script>

	function check_pwd(frm) {
		var pwd = frm.password.value;
		var checkPwd = frm.pwdCheck.value;
		
		if(pwd != checkPwd) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.pwdCheck.value="";
			return false;
		}
		return true;
	}

	function pwdUpdate_ok(frm) {
		alert("변경하시겠습니까?")
		frm.action="updatePwd.do";
		frm.submit();
	}
</script>
</head>
<body>
<h2>비밀번호 변경</h2>
 <c:if test="${not empty error}">
        <p style="color: red;">${error}</p>
    </c:if>
<form action="updatePwd.do" method="post">
	<table>
		<tr>
			<td>현재 비밀번호</td>
			 <td><input type="password" name="currentPassword"></td>
		</tr>
		<tr>
			<td>변경할 비밀번호</td>
			<td><input type="password" name="password" ></td>
		</tr>
		<tr>
			<td>비밀번호 확인</td>
			<td><input type="password" name="pwdCheck" onblur="check_pwd(this.form)"></td>
		</tr>
		<tr>
			<td><input type="hidden" name="userIdx" value="${user.userIdx}"></td>
		</tr>
		<tr>
			<td>
			<input type="button" value="비밀번호 변경" onclick="pwdUpdate_ok(this.form)">
			</td>
		</tr>
	</table>
</form>

</body>
</html>