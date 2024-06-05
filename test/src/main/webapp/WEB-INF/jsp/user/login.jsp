<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

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
	
	function login_ok(frm) {
		var msg = '${msg}';
		alert(msg);
	}
	
	window.onload = function() {
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');
        if (msg === 'success') {
            alert('회원가입 성공');
        }
    }

	
// 	function kakaoLogin() {
// 		window.kakao.Auth.login({
// 			scope: 'profile_nickname, account_email',
// 			success: function(authObj){
// 				window.Kakao.API.request({
// 					url: 'user/login'
// 					success: res => {
// 						const name = res.kakao_account.nickname;
// 						const email = res.kakao_account.email;
						
// 						console.log(name);
// 						console.log(email);
						
// 						${'#kakaoemail'}.val(email);
// 						${'#kakaonickname'}.val(name);
// 						document.login_frm.submit();
// 					}
// 				})
				
				
// 			}
			
// 		})
// 	}
	
	
	
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

<h1>login</h1>
<a href= "hoLogin.do">병원로그인</a>
<form action="login.do" method="post">
<table>
	<tr>
		<td>아이디</td>
		<td><input type="text" name="email" value="${userVO.email }"></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td><input type="password" name="password" value="${userVO.password }"  onclick="password(this.form)"></td>
		
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="로그인" onclick="login_ok(this.form)">
		</td>
	</tr>
	
	 
	 
</table>
<!-- 로그아웃 메인페이지로 옮기기 -->
<p><a href="logout.do">로그아웃</a></p>

<!-- 카카오 로그인 -->

<!-- <a id="kakao-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=f42292ed4450e56e6fb79480339b9fd8&redirect_uri=http://localhost:8080/biz/user/login.do&response_type=code"> -->
<!--   <img src="../img/kakao_login.png" alt="카카오 로그인 버튼" /> -->
<!-- </a> -->



</form>

<!-- 자바스크립트 카카오 -->
 <div class="kakao-btn" onclick="loginWithKakao()">
         <img
            src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
            width="222" alt="카카오 로그인 버튼" />
      </div>


<table>
	<tr>
		<td><input type="button" value="개인 회원가입" onclick="user_join(this.form)"></td>
		<td><input type="button" value="병원 회원가입" onclick="ho_join(this.form)"></td>
	</tr>
<!-- 	아이디 비번 찾기 아직 구현 안함 -->
	<tr>
		<td><a href=#>아이디찾기</a></td>
		<td><a href=#>비밀번호 찾기</a></td>
	</tr>
	<tr>
		<td><a href="../index.jsp">메인화면 이동</a></td>
	</tr>
</table>

</body>
</html>