<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 댓글 목록</title>
<jsp:include page="../../css/getUserListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<h1>회원 댓글 목록</h1>
<div id="container">
<%-- \${userCommentList } : ${userCommentList } --%>
<a href="getUserList.do">회원관리목록 가기</a>
<hr>
<table border frame=void  style="width:100%">
<tr>
<th height="35px">게시글</th>
<th>댓글</th>
<th>작성자</th>
<th>작성일</th>
</tr>

<c:forEach var="comment" items="${userCommentList }">
<tr>
	<td height="30px"><a href="userPostDetail.do?postidx=${comment.postidx }">${comment.title }</a></td>
	<td>${comment.content }</td>
	<td>${comment.nickname }</td>
	<td>${comment.formattedCommentDate }</td>
</tr>
</c:forEach>
</table>
</div>
</body>
</html>