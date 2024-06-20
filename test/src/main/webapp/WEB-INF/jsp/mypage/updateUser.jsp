<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보수정</title>
<jsp:include page="../../css/myPetCss.jsp" />
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<script>
	function updatePwd(frm) {
		const userIdx = frm.userIdx.value;
		location.href = "updatePwd.do?userIdx=" + userIdx;
	}

	function userUpdate_ok(frm) {
		return confirm("수정하시겠습니까?")
	}
	
	function fileName() {
		var input = document.getElementById('fileUpload');
		var fileName = document.getElementById('fileName');
		var clearBtn = document.getElementById('clearBtn');
		
	    if (input.files.length > 0) {
	        fileName.textContent = input.files[0].name;
	        clearBtn.style.display = 'inline';
	    } else {
	        fileName.textContent = '선택된 파일이 없습니다.';
	        clearBtn.style.display = 'none';
	    }
	}
	
	function clearFileInput() {
	    var fileInput = document.getElementById("fileUpload");
	    fileInput.value = "";
	    document.getElementById('fileName').textContent = '선택된 파일이 없습니다.';
	    clearBtn.style.display = 'none';
	}
</script>
</head>
<body>
<div id="container">
	<h1>내 정보 수정</h1>
	<form name="userUpdateForm" action="updateUser.do" method="post" enctype="multipart/form-data"> 
		<input type="hidden" name="userIdx" value="${user.userIdx}">
		<table>
		<tr>
			<th>프로필사진 </th>
			<td>
		        <label class="fileBtn" for="fileUpload">파일 선택</label>
		        <input type="file" id="fileUpload" name="file" onchange="fileName()">
		        <span id="fileName">선택된 파일이 없습니다.</span>
		        <button type="button" id="clearBtn" class="btn" onclick="clearFileInput()" style="display: none;">취소</button>
			</td>
		</tr>
		<tr>
			<th>이메일 </th>
			<td>
			 	<input type="text" name="email" value="${user.email}" readonly>
			</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>
				<input type="text" name="nickname" value="${user.nickname}">
			</td>
		</tr>
		<!-- 비밀번호가 null이 아닌 경우에만 비밀번호 필드를 표시(카카오는 비번이 없기 때문) -->
	        <c:if test="${user.password != null}">
	            <tr>
	                <th>비밀번호</th>
	                <td  class="pwdField">
	                    <input type="password" name="password" value="${user.password}" class="pwdInput" readonly>
	                    <input type="button" value="비밀번호 변경" class="btn" onclick="updatePwd(document.userUpdateForm)">
	                </td>
	            </tr>
	        </c:if>
		<tr>
		<th>이름</th>
			<td>
				<input type="text" name="name" value="${user.name}" readonly>
			</td>
		</tr>
		<tr>
		<th>생년월일</th>
			<td>
				<input type="text" name="birth" value="${user.birth}" readonly>
			</td>
		</tr>
		<tr>
		<th>전화번호</th>
			<td>
				<input type="text" name="phone" value="${user.phone}">
			</td>
		</tr>
		<tr>
		<td colspan="2" class="center">
			<input class="btn" type="submit" value="내 정보 수정" onclick="userUpdate_ok(this.form)">
		</td>
	</tr>
	</table>
	</form>
</div>
</body>
</html>