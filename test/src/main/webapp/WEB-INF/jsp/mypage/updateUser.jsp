<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보수정</title>
<jsp:include page="../../css/myPetCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<script>
	window.onload = function() {
		var fileInput = document.getElementById("file");
		var clearBtn = document.getElementById("clearBtn");
	
		fileInput.addEventListener("change", function() {
			if (fileInput.value) {
				clearBtn.style.display = "inline-block";
			} else {
				clearBtn.style.display = "none";
			}
		});
	}
	
	function clearFileInput() {
	    var fileInput = document.getElementById("file");
	    fileInput.value = "";
	    var clearBtn = document.getElementById("clearBtn");
	    clearBtn.style.display = "none";
	}
	
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
<div id="container">
	<h1>내 정보 수정</h1>
	<form name="userUpdateForm" action="updateUser.do" method="post" enctype="multipart/form-data"> 
		<input type="hidden" name="userIdx" value="${user.userIdx}">
		<table class="tb">
		<tr>
			<td>프로필사진 </td>
		</tr>
		<tr>
			<td>
				<div class="fileContainer">
             		<input class="text" id="file" type="file" name="file">
             		<button class="clearBtn" id="clearBtn" type="button" onclick="clearFileInput()" style="display: none">삭제</button>
				</div>
			</td>
		</tr>
		<tr>
			<td>이메일 </td>
		</tr>
		<tr>	
			<td>
			 	<input class="text" type="text" name="email" value="${user.email}" readonly>
			</td>
		</tr>
		<tr>
			<td>닉네임</td>
		</tr>
		<tr>	
			<td>
				<input class="text" type="text" name="nickname" value="${user.nickname}">
			</td>
		</tr>
		<!-- 비밀번호가 null이 아닌 경우에만 비밀번호 필드를 표시(카카오는 비번이 없기 때문) -->
	        <c:if test="${user.password != null}">
	            <tr>
	                <td>비밀번호</td>
	            </tr>
				<tr>    
	                <td>
	                    <input class="pwdText" type="password" name="password" value="${user.password}" class="pwdInput" readonly>
	                </td>
	                <td>    
	                    <input class="pwdBtn" type="button" value="비밀번호 변경" onclick="updatePwd(document.userUpdateForm)">
	                </td>
	            </tr>
	        </c:if>
		<tr>
			<td>이름</td>
		</tr>
		<tr>
			<td>
				<input class="text" type="text" name="name" value="${user.name}" readonly>
			</td>
		</tr>
		<tr>
			<td>생년월일</td>
		</tr>
		<tr>
			<td>
				<input class="text" type="text" name="birth" value="${user.birth}" readonly>
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
		</tr>
		<tr>	
			<td>
				<input class="text" type="text" name="phone" value="${user.phone}">
			</td>
		</tr>
		<tr>
		<td colspan="2" class="center">
			<input class="loginBtn" type="submit" value="내 정보 수정" onclick="userUpdate_ok(this.form)">
		</td>
	</tr>
	</table>
	</form>
</div>
</body>
</html>