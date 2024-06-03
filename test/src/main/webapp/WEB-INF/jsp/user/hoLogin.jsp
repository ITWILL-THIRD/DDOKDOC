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


	function hosLogin_ok(frm) {
		var msg = '${msg}';
		alert(msg);
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
		<td><input type="password" name="hosPw" value="${hospitalVO.hosPw }"  onclick="password(this.form)"></td>
		
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="로그인" onclick="hosLogin_ok(this.form)">
		</td>
	</tr>
	
	
</table>
</form>
<!-- 로그아웃 메인페이지로 옮기기 -->
<p><a href="logout.do">로그아웃</a></p>

<table>
	<tr>
		<td><input type="button" value="개인 회원가입" onclick="user_join(this.form)"></td>
		<td><input type="button" value="병원 회원가입" onclick="ho_join(this.form)"></td>
	</tr>
	<tr>
		<td><a href="../index.jsp">메인화면 이동</a></td>
	</tr>
</table>
</body>
</html>