<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 로그인 리다이렉션</title>
</head>
<body>
  <div id="container">
        <h1>카카오 로그인 리다이렉션 [redirect.jsp]</h1>
        <p id="token-result">토큰을 처리 중입니다...</p>
        <button class="api-btn" onclick="requestUserInfo()">
         	사용자 정보 가져오기</button>
         <p id="user-info">사용자 정보가 여기에 표시됩니다...</p>
         
         <p>이메일: ${sessionScope.user.email}</p>
          <p>닉네임: ${sessionScope.user.nickname}</p>
         
         
    </div>

<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
<script>
    Kakao.init('acf11f058fbec41d694ad1e1201bcc23'); // 사용하려는 앱의 JavaScript 키 입력

    // URL에서 쿼리 파라미터를 추출하는 함수
    function getQueryParam(param) {
      let urlParams = new URLSearchParams(window.location.search);
      return urlParams.get(param);
    }

    // 인증 코드 가져오기
    let code = getQueryParam('code');
    if (code) {
      // 인증 코드를 사용하여 토큰 요청
      fetch(`https://kauth.kakao.com/oauth/token`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: new URLSearchParams({
          grant_type: 'authorization_code',
          client_id: 'acf11f058fbec41d694ad1e1201bcc23',
          redirect_uri: 'http://localhost:8080/todoc/user/redirect.do',
          code: code, 
        })
      })
      .then(response => response.json())
      .then(data => {
        if (data.access_token) {
          console.log(data);
          Kakao.Auth.setAccessToken(data.access_token);
          document.querySelector('#token-result').innerText = '토큰: ' + data.access_token;
          // 사용자 정보 요청
          requestUserInfo();
        } else {
          document.querySelector('#token-result').innerText = '토큰 요청에 실패했습니다.';
        }
      })
      .catch(err => {
        console.error(err);
        document.querySelector('#token-result').innerText = '토큰 요청에 실패했습니다.';
      });
    }

    function requestUserInfo() {
      Kakao.API.request({
        url: '/v2/user/me',
        data: {
            property_keys: ['kakao_account.email', 'properties.nickname'],
          },
      })
        .then(function(res) {
          alert(JSON.stringify(res));
       // 이메일과 닉네임 추출
          const email = res.kakao_account.email;
          const nickname = res.properties.nickname;
          console.log("email : "+ email);
          console.log("nickname: " + nickname);
          // 이메일과 닉네임 표시
          document.querySelector('#user-info').innerText = "이메일 : " + email + "닉네임 : " + nickname ;
      
          // 사용자 정보를 서버로 전송
          sendUserInfoToServer(email, nickname);
        })
        .catch(function(err) {
          alert('failed to request user information: ' + JSON.stringify(err));
        });
    }
    //==============추가================
    function sendUserInfoToServer(email, nickname) {
        fetch('saveUserInfo.do', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ email: email, nickname: nickname }),
        })
        .then(response => response.json())
        .then(data => {
          if (data.success) {
            alert('사용자 정보를 성공적으로 저장했습니다.');
          } else {
            alert('사용자 정보 저장에 실패했습니다.');
          }
        })
        .catch(err => {
          console.error('Error:', err);
        });
      }
    //===============================

    // 아래는 데모를 위한 UI 코드입니다.
    function displayToken() {
      var token = getCookie('authorize-access-token');

      if(token) {
        Kakao.Auth.setAccessToken(token);
        document.querySelector('#token-result').innerText = 'login success, ready to request API';
        document.querySelector('button.api-btn').style.visibility = 'visible';
      }
    }

    function getCookie(name) {
      var parts = document.cookie.split(name + '=');
      if (parts.length === 2) { return parts[1].split(';')[0]; }
    }

    displayToken();
  </script>


</body>
</html>