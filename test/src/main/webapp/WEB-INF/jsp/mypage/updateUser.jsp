<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<form name="userUpdateForm" action="updateUser.do" method="post" enctype="multipart/form-data"> 
	<table>
	<tr>
		<td>프로필사진 </td>
		<td>
		 	<input type="file" name="file" value="${user.userImg}" readonly>
		</td>
	</tr>
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
	<!-- 비밀번호가 null이 아닌 경우에만 비밀번호 필드를 표시(카카오는 비번이 없기 때문) -->
        <c:if test="${user.password != null}">
            <tr>
                <td>비밀번호</td>
                <td>
                    <input type="password" name="password" value="${user.password}" readonly>
                </td>
                <td>
                    <input type="button" value="비밀번호 변경" onclick="updatePwd(document.userUpdateForm)">
                </td>
            </tr>
        </c:if>
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