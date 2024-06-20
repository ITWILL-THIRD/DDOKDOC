<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정폼</title>
</head>
<body>
\${notice } : ${notice }
	<h2>공지사항 수정[updateNotice.jsp]</h2>
	<form action="updateNotice.do" method="post">
		<table>
			<tr>
				<th>제목</th>
				<th>
					<input type="text" name="noticeTitle" value="${notice.noticeTitle }">
				</th>
			</tr>
			<tr>
				<th>내용</th>
				<th>
					<textarea rows="10" cols="50" name="noticeContent">${notice.noticeContent }</textarea>
				</th>
			</tr>
		</table>
		<input type="hidden" name="hosIdx" value="${hosIdx}">
		<input type="submit" value="등록">
		<input type="button" value="뒤로가기" 
			onclick="javascript:location.href='../hospital/hosDetail.do?hosIdx=${hosIdx}'">
	</form>
	
</body>
</html>