<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저의 작성게시물</title>
<jsp:include page="../../css/getUserListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<h1>회원 작성게시물</h1>
<%-- \${userPostList } : ${userPostList } --%>
<div id="container">
<a href="getUserList.do">회원관리목록 가기</a>
<hr>
<table border frame=void  style="width:100%">
<tr>
	<th height="35px">번호</th>
	<th>카테고리</th>
	<th>제목</th>
	<th>작성자</th>
	<th>작성일</th>
	<th>조회수</th>
</tr>
<tbody>
		<c:forEach var="board" items="${userPostList }">
			<tr>
				<td height="30px" class="center">${board.postidx }</td>
				<td >
					<c:choose>
                        <c:when test="${board.category == 'free'}">자유</c:when>
                        <c:when test="${board.category == 'med'}">의료</c:when>
                        <c:when test="${board.category == 'feed'}">사료/간식</c:when>
                        <c:when test="${board.category == 'goods'}">용품</c:when>
                        <c:otherwise>자유</c:otherwise>
                    </c:choose>
                </td>    
				<td>
					<a href="userPostDetail.do?postidx=${board.postidx }">${board.title }</a>
				</td>
				<td>${board.nickname }</td>
				<td>${board.formattedDate }</td>
				<td>${board.hit }</td>
			</tr>
		</c:forEach>
		</tbody>
</table>
</div>
</body>
</html>