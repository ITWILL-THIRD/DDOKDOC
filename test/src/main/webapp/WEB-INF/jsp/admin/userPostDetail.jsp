<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userPostDetail</title>
<%-- <jsp:include page="../../css/postCss.jsp"/> --%>
<jsp:include page="../../css/getUserListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
table tr:nth-last-child(2) td, table tr:nth-last-child(2) th {
      border-bottom: none;
    }
    table tr:last-child td, table tr:last-child th {
      border: none;
    }
</style>
</head>
<body>
<h1>회원 게시글 상세</h1>
<div id="container">
<a href="getUserList.do">회원관리목록 가기</a>
<hr>

	
	<h2>${board.title }</h2>
	<hr class="hr">
	<table border frame=void  style="width:100%">
		<tr>
			<th width="20%">카테고리</th>
			<td width="30%">
				<c:choose>
                        <c:when test="${board.category == 'free'}">자유</c:when>
                        <c:when test="${board.category == 'med'}">의료</c:when>
                        <c:when test="${board.category == 'feed'}">사료/간식</c:when>
                        <c:when test="${board.category == 'goods'}">용품</c:when>
                        <c:otherwise>자유</c:otherwise>
                </c:choose>
			</td>
			<th  width="20%">작성자</th>
			<td>${board.nickname}</td>
		</tr>
		<tr>
			<th >조회수</th>
			<td>${board.hit }</td>
			<th>작성일</th>
			<td>${board.formattedDate }</td>
		</tr>
		
		<tr>
			<td style="white-space:pre-line" colspan="6" class="content">
				${board.content}
				<c:if test="${not empty board.img}">
				<c:forEach var="board.img" items="${board.img}">
					<img src="${board.img}" alt="${board.img} 이미지" style="max-width:500px;">
				</c:forEach>
				</c:if>
			</td>
		</tr>
	</table>
	
	</div>
</body>
</html>