<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 비밀번호 찾기</title>
<script>
window.onload = function() {
    var msg = "${msg}"; // 서버 사이드에서 전달된 msg를 받아옵니다.
    if (msg) {
        alert(msg); // msg가 존재하면, alert 창으로 메시지를 띄웁니다.
    }

    document.getElementById('submit').onclick = function(event) {
//         event.preventDefault(); // 폼 제출을 방지합니다.
        
        var form = document.forms['frm'];
        if (form.hosName.value.trim() === '') {
            alert('병원이름을 입력해주세요');
            return false;
        }
        if (form.hosId.value.trim() === '') {
            alert('병원아이디를 입력해주세요');
            return false;
        }
        form.submit();
    }
}
</script>
</head>
<body>
<h1>병원 비밀번호 찾기</h1>
<form name="frm" action="hoFindPwd.do" method="post">
	<table>
		<tr>
			<td><input type="text" name="hosName" placeholder="병원이름"></td>
		</tr>
		<tr>
			<td><input type="text" name="hosId" placeholder="병원 아이디"></td>
		</tr>
		<tr>
			<td><input type="submit" id="submit" value="비밀번호 찾기"></td>
		</tr>
	</table>
</form>
<a href="hoJoin.do">병원 회원가입하기</a>
<a href="hoLogin.do">병원 로그인하기</a>
</body>
</html>