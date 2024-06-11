<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>

	function user_join(frm) {
		location.href = "userJoin.do";
		frm.submit();
	}
	function ho_join(frm) {
		location.href = "hoJoin.do";
		frm.submit();
	}


// 	function getQueryParam(param) {
//         var urlParams = new URLSearchParams(window.location.search);
//         return urlParams.get(param);
//     }

//     window.onload = function() {
//         var msg = getQueryParam("msg");
//         if (msg === "failure") {
//             alert("로그인 실패");
//         }
//     }
    
	window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');
        if (msg === 'success') {
            alert('회원가입이 완료되었습니다.');
        } else if (msg === 'failure') {
            alert('아이디 또는 비밀번호를 확인해주세요.');
        }
    }
	</script>
</head>
<body>
<h1>병원 login</h1>
<form action="hoLogin.do" method="post">

<table>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="hosId" value="${hospitalVO.hosId }"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="hosPw" value="${hospitalVO.hosPw }" onclick="password(this.form)"></td>
		
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="로그인">
		</td>
	</tr>
	
	
</table>
</form>

<table>
	<tr>
		<td><input type="button" value="개인 회원가입" onclick="user_join(this.form)"></td>
		<td><input type="button" value="병원 회원가입" onclick="ho_join(this.form)"></td>
	</tr>
	<tr>
		<td><a href="hoFindId.do">아이디찾기</a></td>
		<td><a href="hoFindPwd.do">비밀번호 찾기</a></td>
	</tr>
	<tr>
		<td><a href="../index.jsp">메인화면 이동</a></td>
	</tr>
</table>
</body>
</html>