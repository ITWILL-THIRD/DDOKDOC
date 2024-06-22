<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 입력폼</title>
<jsp:include page="../../css/insertNoticeCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<div id="container">
	<h2>공지사항 등록</h2>
	<hr>
	<form action="insertNotice.do" method="post">
		<table border frame=void>
			<tr>
				<th>내용</th>
				<th>
					<textarea rows="10" cols="90" name="noticeContent"></textarea>
				</th>
			</tr>
		</table>
		<input type="hidden" name="hosIdx" value="${hosIdx}">
		<input type="submit" class="btn" value="등록">
		<input type="reset" class="resetBtn" value="초기화">
		<input type="button" class="resetBtn" value="뒤로가기" 
			onclick="javascript:location.href='../mypage/hosNotice.do'">
	</form>
</div>	
</body>
</html>