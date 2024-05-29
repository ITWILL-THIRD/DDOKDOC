<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 입력폼</title>
</head>
<body>
	<h2>공지사항 입력[insertNotice.jsp]</h2>
	<form action="notice/insertNotice/do" method="post">
		<input type="text" name="noticeTitle">
		<textarea rows="5" cols="20" name="noticeContent"></textarea>
		
		<input type="submit" value="등록">
	</form>
	
</body>
</html>