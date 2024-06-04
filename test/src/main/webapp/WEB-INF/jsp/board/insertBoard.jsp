<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글등록</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
</head>
<body>

<div id="container">
	<h1>글등록 [insertBoard.jsp]</h1>
	
	<form action="insertBoard.do" method="post">
	<table>
		<tr>
			<th>카테고리</th>
			<td>
			    <select id="category" name="category">
			        <option value="free">자유</option>
			        <option value="med">의료</option>
			        <option value="feed">사료/간식</option>
			        <option value="goods">용품</option>
    			</select>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="title">
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				<input type="text" name="useridx">
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="content" rows="10" cols="40"></textarea>
			</td>
		</tr>
		<tr>
			<th>사진 첨부</th>
			<td>
				<input type="file" name="uploadFile">
			</td>
		</tr>
		<tr>
			<td colspan="2" class="center">
				<input type="submit" value="등록" class="btn">
			</td>
		</tr>
	</table>
	</form>
	<p>
		<a href="getBoardList.do">글 목록 가기</a>
	</p>
</div>

</body>
</html>













