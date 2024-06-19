<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>개인회원가입</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
	
	

	function check_email(frm) {
	    var checkEmail = frm.email.value;
	    var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	    if (!emailReg.test(checkEmail)) {
	        alert("이메일 형식이 올바르지 않습니다.");
// 	        frm.email.value = "";
	        return false;
	    }
	   
	    return true;
	}
	
// 	function checkDup(frm) {
// 		var checkDup = frm.email.value;
// 		if (checkDup.trim().length == 0) {
// 			alert("이메일을 입력해주세요");
// 			return false;
// 		}
// 		var email = $('#email').val();
// 		$.ajax({
// 			url:'/getJsonuserJoin.do',
// 			type:'post',
// 			data: { email: email },
// 			dataType: "json",
// 			success:function(response){
// 				if (response.exists === true){
// 					alert("이미 사용중인 이메일 입니다.")
// 					frm.email.value="";
// 					isCheckDup = false;
// 				} else {
// 					alert("사용 가능한 이메일입니다.");
// 					isCheckDup = true;
// 				}
// 			},
// 			 error: function(jqXHR, textStatus, errorThrown) {
// 		            console.error("Request failed: " + textStatus + ", " + errorThrown); // Log error details
// 		            alert("에러입니다");
// 		        }
// 		});
// 	};
	
	var isCheckDup = false;
	
	function checkDup(frm) {
		var checkDup = frm.email.value;
		if (checkDup.trim().length == 0) {
			alert("이메일을 입력해주세요");
			return false;
		}
		var email = $('#email').val();
		$.ajax({
			url:'email.do',
			type:'POST',
			data: JSON.stringify ({ "email" : $("#email").val() }),
// 			data: JSON.stringify(vo),
			contentType: "application/json",
			dataType: "json",
			success:function(data){
				if (data == 1){
// 					$('#email').val(1);
					alert("이미 사용중인 이메일 입니다.")
					isCheckDup = false;
					
				} else if (data == 0){
// 					$('#email').val(0);
					alert("사용 가능한 이메일입니다.");
					isCheckDup = true;
					
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
	            alert("Ajax 처리 실패:\n" +
	                      "jqXHR.readyState: " + jqXHR.readyState + "\n" +
	                      "textStatus: " + textStatus + "\n" +
	                      "errorThrown: " + errorThrown);
	         }
		});
	};
	
	function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
	
	var isCheckDup = false;
	
	function userJoin_ok(frm) {
		
		console.log(document.forms[0]);
		var firstForm = document.forms[0];
		console.log(firstForm.elements);
		
		for (let htmlObj of firstForm.elements) {
			if (htmlObj.value.trim() == "") {
				console.log(htmlObj);
				alert(htmlObj.title + " 입력하세요");
				htmlObj.focus();
				return;
			}
		}
		
		if(!isCheckDup) {
			alert("이메일 중복체크를 먼저 해주세요.");
			return;
		}
		
		frm.action="userJoin.do";
		frm.submit();
		
		
	}
	function checkFormFilled() {
	    const form = document.forms[0];
	    const email = form.email.value.trim();
	    const nickname = form.nickname.value.trim();
	    const password = form.password.value.trim();
	    const pwdCheck = form.pwdCheck.value.trim();
	    const name = form.name.value.trim();
	    const birth = form.birth.value.trim();
	    const phone = form.phone.value.trim();

	    const isFormFilled = email && nickname && password && pwdCheck && name && birth && phone;

	    document.querySelector('.loginBtn').disabled = !isFormFilled;
	}
	
	function resetForm() {
	    // 폼 초기화 후 checkFormFilled 함수 호출
	    document.forms[0].reset();
	    checkFormFilled();
	};
	
	window.onload = function() {
	    checkFormFilled(); // 페이지 로드 시 초기 체크
	};
// 	 window.onload = function() {
//          const urlParams = new URLSearchParams(window.location.search);
//          const msg = urlParams.get('msg');
//          if (msg === 'failure') {
//              alert('회원가입 실패');
//          }
//      }
 
</script>
</head>
<body>
<h1>개인회원가입</h1>
<form action="userJoin.do" method="post">
<table class="tb">
	<tr>
		<td>이메일</td>
	</tr>
	<tr>
		<td><input class="text" id="email" type="text" name="email" value="${userVO.email }"oninput="checkFormFilled()" onblur="check_email(this.form)" placeholder="이메일 입력 (ex: todoc@todoc.com)"></td>
		<td>
			<input class="btn" type="button" value="중복확인" onclick="checkDup(this.form)"/>
		</td>
	</tr>
	<tr>
		<td>닉네임</td>
	</tr>
	<tr>
		<td><input class="text" type="text" name="nickname" value="${userVO.nickname }" oninput="checkFormFilled()" placeholder="닉네임 입력"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
	</tr>
	<tr>
		<td><input class="text" id="password" type="password" name="password" value="${userVO.password }" oninput="checkFormFilled()" placeholder="비밀번호 입력"></td>
	</tr>
	<tr>
		<td>비밀번호 확인</td>
	</tr>
	<tr>
		<td><input class="text" type="password" name="pwdCheck" value="${userVO.password }" onblur="check_pwd(this.form)" oninput="checkFormFilled()" placeholder="비밀번호 확인"></td>
	</tr>
	<tr>
		<td>이름</td>
	</tr>
	<tr>
		<td><input class="text" type="text" name="name" value="${userVO.name }" oninput="checkFormFilled()" placeholder="이름을 입력해주세요"></td>
	</tr>
	<tr>
		<td>생년월일</td>
	</tr>
	<tr>
		<td><input class="text" type="date" name="birth" value="${userVO.birth }" oninput="checkFormFilled()"></td>

	</tr>
	<tr>
		<td>전화번호</td>
	</tr>
	<tr>
		<td>
		<input class="text" type="text"  name="phone" value="${userVO.phone }" oninput="checkFormFilled()" oninput="oninputPhone(this)" maxlength="14" placeholder="휴대폰 번호 입력 ('-' 제외 입력)">
		</td>
	</tr>
	
	<tr>
		<td>
			<input class="loginBtn" type="button" value="회원가입" onclick="userJoin_ok(this.form)">
		</td>
	</tr>
	</table>
</form>
	<table class="select">
	<tr>
		<td><a href="login.do">로그인</a></td>
		<td class="s">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
		<td><input class="joinBtn" type="reset" value="회원가입 초기화" onclick="resetForm()"></td>
	</tr>
	</table>

</body>
</html>