<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userCommentList</title>
</head>
<body>
<h1>userCommentList</h1>
<%-- \${userCommentList } : ${userCommentList } --%>
<a href="getUserList.do">회원관리목록 가기</a>
<table>
<tr>
<th>게시글</th>
<th>댓글</th>
<th>작성자</th>
<th>작성일</th>
</tr>

<c:forEach var="comment" items="${userCommentList }">
<tr>
	<td><a href="userPostDetail.do?postidx=${comment.postidx }">${comment.title }</a></td>
	<td>${comment.content }</td>
	<td>${comment.nickname }</td>
	<td>${comment.formattedCommentDate }</td>
</tr>
</c:forEach>
</table>
</body>
</html>