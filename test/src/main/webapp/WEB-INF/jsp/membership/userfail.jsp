<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/style.css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원 멤버십</title>
    <jsp:include page="../../css/payCss.jsp"/>
  </head>

  <body>
    <div id="info" class="box_section" style="width: 600px">
      <img width="100px" src="https://static.toss.im/lotties/error-spot-no-loop-space-apng.png" />
      <h2>결제를 실패했어요</h2>

      <div class="p-grid typography--p" style="margin-top: 50px">
        <div class="p-grid-col text--left"><b>에러메시지</b></div>
        <div class="p-grid-col text--right" id="message"></div>
      </div>
      <div class="p-grid typography--p" style="margin-top: 10px">
        <div class="p-grid-col text--left"><b>에러코드</b></div>
        <div class="p-grid-col text--right" id="code"></div>
      </div>
      <div class="p-grid">
        <button class="button p-grid-col5" onclick="location.href='http://localhost:8080/todoc/index.jsp';">메인으로</button>
        <button class="button p-grid-col5" onclick="location.href='http://localhost:8080/todoc/membership/usercheckout.do';" style="background-color: #e8f3ff; color: #1b64da">다시시도</button>
      </div>
    </div>

    <script>
      const urlParams = new URLSearchParams(window.location.search);

      const codeElement = document.getElementById("code");
      const messageElement = document.getElementById("message");

      codeElement.textContent = urlParams.get("code");
      messageElement.textContent = urlParams.get("message");
    </script>
  </body>
</html>