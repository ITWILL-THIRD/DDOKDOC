<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추가 정보 입력</title>
</head>
<body>
<form id="additionalInfoForm" style="display: none;">
    <h2>추가 정보 입력</h2>
    <label for="name">이름:</label>
    <input type="text" id="name" title="이름" name="name" required><br>
    <label for="birth">생년월일:</label>
    <input type="date" id="birth" title="생년월일" name="birth" required><br>
    <label for="phone">전화번호:</label>
    <input type="text" id="phone" title="전화번호" name="phone" required><br>
    <button type="button" onclick="saveAdditionalInfo()">저장</button>
</form>

<form id="additionalInfoForm" style="display: none;">
    <h2>추가 정보 입력</h2>
    <label for="name">이름:</label>
    <input type="text" id="name" title="이름" name="name" required><br>
    <label for="birth">생년월일:</label>
    <input type="date" id="birth" title="생년월일" name="birth" required><br>
    <label for="phone">전화번호:</label>
    <input type="text" id="phone"title="전화번호" name="phone" required><br>
    <button type="button" onclick="saveAdditionalInfo()">저장</button>
  </form>
  <div id="container">
<!--         <h1>카카오 로그인 리다이렉션 [redirect.jsp]</h1> -->
        <p id="token-result"></p>
<!--         <button class="api-btn" onclick="requestUserInfo()"> -->
<!--          	사용자 정보 가져오기</button> -->
<!--          <p id="user-info">사용자 정보가 여기에 표시됩니다...</p> -->
         
<%--          <p>이메일: ${sessionScope.user.email}</p> --%>
<%--           <p>닉네임: ${sessionScope.user.nickname}</p> --%>
         
         
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
//           document.querySelector('#token-result').innerText = '토큰: ' + data.access_token;
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
            property_keys: ['kakao_account.email', 'properties.nickname', 'kakao_account.profile'],
          },
      })
        .then(function(res) {
//           alert(JSON.stringify(res));
       // 이메일과 닉네임 추출
          const email = res.kakao_account.email;
          const nickname = res.properties.nickname;
          const profile = res.kakao_account.profile;
          console.log("email : "+ email);
          console.log("nickname : " + nickname);
          console.log("profile : " + profile);
          // 이메일과 닉네임 표시
//           document.querySelector('#user-info').innerText = "이메일 : " + email + "닉네임 : " + nickname ;
      
          // 사용자 정보를 서버로 전송
          sendUserInfoToServer(email, nickname, profile);
        })
        .catch(function(err) {
          alert('failed to request user information: ' + JSON.stringify(err));
        });
    }
    //추가=================
        function sendUserInfoToServer(email, nickname, profile) {
      fetch('saveUserInfo.do', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ email: email, nickname: nickname, profile: profile }),
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          if (data.newUser) {
            document.getElementById('additionalInfoForm').style.display = 'block';
          } else {
            alert(nickname + '님 환영합니다.');
            window.location.href = '../index.jsp';
          }
        } else {
          alert('사용자 정보 저장에 실패했습니다.');
        }
      })
      .catch(err => {
        console.error('Error:', err);
      });
    }

    function saveAdditionalInfo() {
    	let firstForm = document.getElementById('additionalInfoForm');
        console.log('Form Elements:', firstForm.elements);

        for (let htmlObj of firstForm.elements) {
            console.log('Checking element:', htmlObj);

            // type이 "button"인 요소를 검사에서 제외합니다.
            if (htmlObj.type === "button") {
                continue;
            }

            if (htmlObj.value.trim() === "") {
                console.log('Empty element found:', htmlObj);
                alert(htmlObj.title + " 입력하세요");
                htmlObj.focus();
                return;
            }
        }
    	
      const name = document.getElementById('name').value;
      const birth = document.getElementById('birth').value;
      const phone = document.getElementById('phone').value;

      fetch('saveAdditionalInfo.do', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ name: name, birth: birth,  phone: phone }),
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          alert('추가 정보가 저장되었습니다.');
          window.location.href = '../index.jsp';
        } else {
          alert('추가 정보 저장에 실패했습니다.');
        }
      })
      .catch(err => {
        console.error('Error:', err);
      });
    }
    
    
    
    //==============추가================
//     function sendUserInfoToServer(email, nickname, profile) {
//         fetch('saveUserInfo.do', {
//           method: 'POST',
//           headers: {
//             'Content-Type': 'application/json',
//           },
//           body: JSON.stringify({ email: email, nickname: nickname, profile: profile }),
//         })
//         .then(response => response.json())
//         .then(data => {
//           if (data.success) {
// //             alert('사용자 정보를 성공적으로 저장했습니다.');
//             alert('로그인 되었습니다.');
//             window.location.href='../index.jsp';
//           } else {
//             alert('사용자 정보 저장에 실패했습니다.');
//           }
//         })
//         .catch(err => {
//           console.error('Error:', err);
//         });
//       }
    //===============================

    // 아래는 데모를 위한 UI 코드입니다.
//     function displayToken() {
//       var token = getCookie('authorize-access-token');

//       if(token) {
//         Kakao.Auth.setAccessToken(token);
//         document.querySelector('#token-result').innerText = 'login success, ready to request API';
//         document.querySelector('button.api-btn').style.visibility = 'visible';
//       }
//     }

//     function getCookie(name) {
//       var parts = document.cookie.split(name + '=');
//       if (parts.length === 2) { return parts[1].split(';')[0]; }
//     }

    displayToken();
  </script>


</body>
</html>