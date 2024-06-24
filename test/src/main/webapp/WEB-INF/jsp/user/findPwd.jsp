<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호찾기</title>
<jsp:include page="../common/navigation.jsp"/>
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
            if (form.email.value.trim() === '') {
                alert('이메일을 입력해주세요');
                return false;
            }
            form.submit();
        }
    }
</script>

</head>
<body>
<div id="container">
<h1>비밀번호 찾기</h1>

<form name="frm" action="findPwd.do" method="post">
	<table class="tb">
		<tr>
			<td><input class="psTitle" type="text" name="name" placeholder="이름"></td>
		</tr>
		<tr>
			<td><input class="psTitle" type="text" name="email" placeholder="아이디"></td>
		</tr>
		<tr>
			<td><input class="loginBtn" type="submit" id="submit" value="비밀번호 찾기"></td>
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