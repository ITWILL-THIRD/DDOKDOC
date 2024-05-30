<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 회원가입</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	
	function check_pwd(frm) {
		var pwd = frm.hosPw.value;
		var checkPwd = frm.pwdCheck.value;
		
		if(pwd != checkPwd) {
			alert("비밀번호가 일치하지 않습니다.");
			frm.pwdCheck.value="";
			return false;
		}
		return true;
	}
	
	function checkDup(frm) {
	
	}
	

	function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
	
	var isCheckDup = false;
	
	function hosJoin_ok(frm) {
			
			console.log(document.forms[0]);
			let firstForm = document.forms[0];
			console.log(firstForm.elements);
			
			for (let htmlObj of firstForm.elements) {
				if (htmlObj.value.trim() == "") {
					console.log(htmlObj);
					if (htmlObj.getAttribute("type") == "file") continue;
					alert(htmlObj.title + " 입력하세요");
					htmlObj.focus();
					return;
				}
			}
			
			if(!isCheckDup) {
				alert("아이디 중복체크를 먼저 해주세요.");
				return;
			}
			
			frm.action="hoJoin.do";
			frm.submit();
		}
	
</script>

</head>
<body>
<h1>병원회원가입</h1>
<form action="hoJoin.do" method="post">
<table>
	<tr>
		<td>병원 아이디</td>
		<td><input type="text" name="hosId" value="${hospitalVO.hosId }" onblur="check_email(this.form)"></td>
		<td>
			<input type="button" value="중복확인" onclick="checkDup(this.form)"/>
		</td>
	</tr>
	<tr>
		<td>병원 비밀번호</td>
		<td><input type="password" name="hosPw" value="${hospitalVO.hosPw }"></td>
	</tr>
	<tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="pwdCheck" value="${hospitalVO.hosPw }" onblur="check_pwd(this.form)"></td>
	</tr>
	<tr>
		<td>병원 이름</td>
		<td><input type="text" name="hosName" value="${hospitalVO.hosName }"></td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td><input type="text" name="hosPhone" value="${hospitalVO.hosPhone }" oninput="oninputPhone(this)" maxlength="14"></td>
	</tr>
	<tr>
		<td>주소</td>
		<td><input type="text"></td>
	</tr>
	<tr>
		<td>사업자 등록증</td>
		<td><input type="file"></td>
	</tr>
	<tr>
		<td>담당동물</td>
		<td><input type="text" name="animal" value="${hospitalVO.animal }"></td>
	</tr>
	
	<tr>
		<td colspan="2">
			<input class="loginbtn" type="button" value="회원가입" onclick="hosJoin_ok(this.form)">
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