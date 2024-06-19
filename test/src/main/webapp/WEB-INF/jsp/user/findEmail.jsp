<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>
<script>
    window.onload = function() {
        var msg = "${msg}"; // 서버 사이드에서 전달된 msg를 받아옵니다.
        if (msg) {
            alert(msg); // msg가 존재하면, alert 창으로 메시지를 띄웁니다.
        }

        document.getElementById('submit').onclick = function(event) {
//             event.preventDefault(); // 폼 제출을 방지합니다.
            
            var form = document.forms['frm'];
            if (form.name.value.trim() === '') {
                alert('이름을 입력해주세요');
                return false;
            }
            if (form.phone.value.trim() === '') {
                alert('전화번호를 입력해주세요');
                return false;
            }
            form.submit();
        }
    }
    
    function oninputPhone(target) {
	    target.value = target.value
	        .replace(/[^0-9]/g, '')
	        .replace(/(^02.{0}|^01.{1}|[0-9]{3,4})([0-9]{3,4})([0-9]{4})/g, "$1-$2-$3");
	}
</script>
</head>
<body>
<div id="container">
<h1>아이디 찾기</h1>
<form name="frm" action="findEmail.do" method="post">
	<table class="tb">
		<tr>
			<td><input class="psTitle" type="text" name="name" placeholder="이름"></td>
		</tr>
		<tr>
			<td><input class="psTitle" type="text" name="phone" placeholder="전화번호" oninput="oninputPhone(this)" maxlength="14"></td>
		</tr>
		<tr>
			<td><input class="loginBtn" type="submit" id="submit" value="아이디 찾기"></td>
		</tr>
	</table>
</form>
<table class="select">
<tr>
<td><a href="userJoin.do">회원가입하기</a></td>
<td class="s">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
<td><a href="login.do">로그인하기</a></td>
</tr>
</table>
</div>
</body>
</html>