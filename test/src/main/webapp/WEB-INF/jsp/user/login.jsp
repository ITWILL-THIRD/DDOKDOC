<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
<script>
  Kakao.init("acf11f058fbec41d694ad1e1201bcc23"); // 사용하려는 앱의 JavaScript 키 입력
</script>


<script>
	

	function user_join(frm) {
		location.href = "userJoin.do";
		frm.submit();
	}
	function ho_join(frm) {
		location.href = "hoJoin.do";
		frm.submit();
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
  Kakao.init('c089c8172def97eb00c07217cae17495'); // 사용하려는 앱의 JavaScript 키 입력
</script>

<a id="kakao-login-btn" href="javascript:loginWithKakao()">
  <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg" width="222"
    alt="카카오 로그인 버튼" />
</a>
<p id="token-result"></p>

<script>
  function loginWithKakao() {
    Kakao.Auth.authorize({
      redirectUri: 'https://developers.kakao.com/tool/demo/oauth',
    });
  }

  // 아래는 데모를 위한 UI 코드입니다.
  displayToken()
  function displayToken() {
    var token = getCookie('authorize-access-token');

    if(token) {
      Kakao.Auth.setAccessToken(token);
      Kakao.Auth.getStatusInfo()
        .then(function(res) {
          if (res.status === 'connected') {
            document.getElementById('token-result').innerText
              = 'login success, token: ' + Kakao.Auth.getAccessToken();
          }
        })
        .catch(function(err) {
          Kakao.Auth.setAccessToken(null);
        });
    }
  }

  function getCookie(name) {
    var parts = document.cookie.split(name + '=');
    if (parts.length === 2) { return parts[1].split(';')[0]; }
  }
</script>
</head>
<body>

<h1>login</h1>
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
			<input type="submit" value="로그인">
		</td>
	</tr>
	
</table>

<div id="kakaologin">
	<div class="kakaobtn">
		<input type="hidden" name="kakaoemail" id="kakaoemail" />
		<input type="hidden" name="kakaonickname" id="kakaonickname" />
		<a href="javascript:kakaoLogin();">
			<img src="../img/kakao_login.png" />
		</a>
	</div>
</div>

</form>


<table>
	<tr>
		<td><input type="button" value="개인 회원가입" onclick="user_join(this.form)"></td>
		<td><input type="button" value="병원 회원가입" onclick="ho_join(this.form)"></td>
	</tr>
</table>

</body>
</html>