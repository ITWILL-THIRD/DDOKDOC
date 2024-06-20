<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<jsp:include page="../../css/myPetCss.jsp" />
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
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
	<div id="container">
	<h1>비밀번호 변경</h1>
	 <c:if test="${not empty error}">
	        <p style="color: red;">${error}</p>
	 </c:if>
		<form action="updatePwd.do" method="post">
		<input type="hidden" name="userIdx" value="${user.userIdx}">
		<table>
			<tr>
				<th>현재 비밀번호</th>
				 <td><input type="password" name="currentPassword"></td>
			</tr>
			<tr>
				<th>변경할 비밀번호</th>
				<td><input type="password" name="password" ></td>
			</tr>
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" name="pwdCheck" onblur="check_pwd(this.form)"></td>
			</tr>
			<tr>
				<td colspan="2" class="center">
				<input class="btn" type="button" value="비밀번호 변경" onclick="pwdUpdate_ok(this.form)">
				</td>
			</tr>
		</table>
		</form>
	</div>
</body>
</html>