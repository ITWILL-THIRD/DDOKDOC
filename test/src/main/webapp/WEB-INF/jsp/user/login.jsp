<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../../css/loginCss.jsp"/>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script>

	function user_join(frm) {
		location.href = "userJoin.do";
		frm.submit();
	}
	function ho_join(frm) {
		location.href = "hoJoin.do";
		frm.submit();
	}
	

	function getQueryParam(param) {
        var urlParams = new URLSearchParams(window.location.search);
        return urlParams.get(param);
    }

	window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const msg = urlParams.get('msg');
            if (msg === 'success') {
                alert('회원가입이 완료되었습니다.');
            } else if (msg === 'admin') {
                alert('관리자로 회원가입 완료됐습니다.');
            } else if (msg === 'failure') {
                alert('아이디 또는 비밀번호를 확인해주세요.');
            }
        }

</script>

<!-- 카카오데모 -->

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
<script>
  Kakao.init('acf11f058fbec41d694ad1e1201bcc23'); // 사용하려는 앱의 JavaScript 키 입력

  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'http://localhost:8080/todoc/user/redirect.do',
      state: 'userme'
    });
  }
</script>
</head>
<body>
<div id="container">
<h1>개인 로그인</h1>
<!-- <a href= "hoLogin.do">병원로그인</a> -->
<form action="login.do" method="post">
<table class="tb">
	<tr>
		<td><input class="psTitle" type="text" name="email" value="${userVO.email }" placeholder="아이디"></td>
	</tr>
	<tr>
		<td><input class="psTitle" type="password" name="password" value="${userVO.password }"  onclick="password(this.form)" placeholder="비밀번호"></td>
		
	</tr>
	<tr>
		<td>
			<input class="loginBtn" type="submit" value="로그인">
		</td>
	</tr>
	
	 
	 
</table>

<!-- 카카오 로그인 -->

<!-- <a id="kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=f42292ed4450e56e6fb79480339b9fd8&redirect_uri=http://localhost:8080/biz/user/login.do&response_type=code"> -->
<!--   <img src="../img/kakao_login.png" alt="카카오 로그인 버튼" /> -->
<!-- </a> -->

</form>






<table class="select">
	
		
<!-- 		<td><input class="joinBtn" type="button" value="병원 회원가입" onclick="ho_join(this.form)"></td> -->
	

	<tr>
		<td><a href="findEmail.do">아이디 찾기</a></td>
		<td class="s">&nbsp;&nbsp;|&nbsp;&nbsp;</td>
		<td><a href="findPwd.do">비밀번호 찾기</a></td>
		<td  class="s">&nbsp;&nbsp;|&nbsp;</td>
		<td><input class="joinBtn" type="button" value="개인 회원가입" onclick="user_join(this.form)"></td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td><a href="../index.jsp">메인화면 이동</a></td> -->
<!-- 	</tr> -->
</table>

<!-- 자바스크립트 카카오 -->
 <div class="kakao-btn" onclick="loginWithKakao()">
         <img
            src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
            width="180" alt="카카오 로그인 버튼" />
      </div>
</div>
</body>
</html>