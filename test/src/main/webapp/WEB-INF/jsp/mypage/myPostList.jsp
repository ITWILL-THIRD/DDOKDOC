<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 작성 게시물</title>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/postListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
</head>
<body>
<h1>나의 게시물</h1>
<div id="container">
<hr>
<a href="myPage.do" style="font-weight: bold;">마이페이지 가기</a>
<%-- ${myPostList } --%>
	<table border frame=void>
		<thead>
			<tr>
				<th width="50">번호</th>
				<th width="100">카테고리</th>
				<th width="200">제목</th>
				<th width="150">작성자</th>
				<th width="180">작성일</th>
				<th width="50">조회수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="board" items="${myPostList }">
			<tr>
				<td>${board.postidx }</td>
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
					<a href="../board/getBoard.do?postidx=${board.postidx }">${board.title }</a>
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