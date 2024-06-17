<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 상세</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
</head>
<body>
<h1>게시물 상세</h1>
<table border>
		<tr>
			<th>카테고리</th>
			<td colspan="2">
				<c:choose>
                        <c:when test="${board.category == 'free'}">자유</c:when>
                        <c:when test="${board.category == 'med'}">의료</c:when>
                        <c:when test="${board.category == 'feed'}">사료/간식</c:when>
                        <c:when test="${board.category == 'goods'}">용품</c:when>
                        <c:otherwise>자유</c:otherwise>
                </c:choose>
			</td>
			</tr>
			<tr>
			<th>제목</th>
			<td colspan="2">
				${board.title }
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${board.nickname}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${board.hit }</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${board.formattedDate }</td>
		</tr>
		<tr>
			<th>내용</th>
			<td  style="white-space:pre-line" colspan="5" class="content">
				${board.content}
				<c:if test="${not empty board.img}">
				<c:forEach var="board.img" items="${board.img}">
					<img src="${board.img}" alt="${board.img} 이미지">
				</c:forEach>
				</c:if>
			</td>
		</tr>
	</table>
</body>
</html>