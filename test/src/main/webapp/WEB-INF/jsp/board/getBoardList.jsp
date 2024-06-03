<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글목록</title>
<jsp:include page="../../css/postListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<div id="container">
	<h1>글목록 [getBoardList.jsp]</h1>
	
	<!-- 검색 -->
	<form action="getBoardList.do" method="get">
	<table class="border-none">
		<tr>
			<td>
				<select name="searchCondition">
				<c:forEach var="option" items="${conditionMap }">
					<option value="${option.value}">${option.key }</option>
				</c:forEach>
				<input type="text" name="searchKeyword" class="searchInput">
				<input type="submit" value="검색" class="searchBtn">
			</td>
		</tr>
	</table>
	<div id="category" class="center">
		<a href="getBoardList.do">전체</a> |
		<a href="getBoardList.do?category=free">자유</a> |
		<a href="getBoardList.do?category=med">의료</a> |
		<a href="getBoardList.do?category=feed">사료/간식</a> |
		<a href="getBoardList.do?category=goods">용품</a>
	</div>
	</form>
	
	<!-- 데이터 표시영역 -->
	<table>
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
		<c:forEach var="board" items="${boardList }">
			<tr>
				<td class="center">${board.postidx }</td>
				<td class="center">
					<c:choose>
                        <c:when test="${board.category == 'free'}">자유</c:when>
                        <c:when test="${board.category == 'med'}">의료</c:when>
                        <c:when test="${board.category == 'feed'}">사료/간식</c:when>
                        <c:when test="${board.category == 'goods'}">용품</c:when>
                        <c:otherwise>자유</c:otherwise>
                    </c:choose>
                </td>    
				<td>
					<a href="getBoard.do?postidx=${board.postidx }">${board.title }</a>
				</td>
				<td>${board.nickname }</td>
				<td>${board.formattedDate }</td>
				<td>${board.hit }</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	
	<p><a href="getInsertBoard.do">새글등록</a></p>
</div>

</body>
</html>












