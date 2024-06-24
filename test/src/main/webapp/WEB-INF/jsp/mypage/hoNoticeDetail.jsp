<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<style>
	#container {
		width: 700px;
		margin : auto;
	}
	h1, h3 {
		text-align: center;
	}
	table {
		border-collapse: collapse;
	}
	table, th, td {
		border: 1px solid black;
		margin: 0 auto;
	}
	
</style>
</head>
<body>
<h1>공지 상세</h1>
<div id="container">
	<form id="noticeForm" method="post">
		<table>
			<tbody>
			<tr>
				<td>${notice.noticeTitle }</td>
			</tr>
			<tr>
				<td>${notice.noticeDate } | ${notice.hit }</td>
			</tr>
			<tr>
				<td>${notice.noticeContent }</td>
			</tr>
			</tbody>
			<tfoot>
			<tr>
				<td>
					<input type="submit" value="수정" 
						onclick="javascript:noticeForm.action='../notice/updateProNotice.do';">
					<input type="submit" value="삭제" 
						onclick="javascript:noticeForm.action='../notice/deleteNotice.do';">
					<input type="hidden" name="noticeIdx" value="${notice.noticeIdx}">  
					<input type="hidden" name="noticeTitle" value="${notice.noticeTitle}">  
					<input type="hidden" name="noticeContent" value="${notice.noticeContent}">  
					<input type="hidden" name="hosIdx" value="${notice.hosIdx}">  
					
					
					<input type="button" value="마이페이지  공지사항" 
					onclick="javascript:location.href='hosNoticeList.do?hosIdx=${hoUser.hosIdx}'">
				</td>
			</tr>
			</tfoot>
		</table>
	</form>
	</div>
</body>
</html>