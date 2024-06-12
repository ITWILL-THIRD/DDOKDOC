<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글상세 ${board.title }</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<div id="container">
	<h1>글상세 [getBoard.jsp]</h1>
	
	<form action="updateBoard.do" method="get">
		<input type="hidden" name="postIdx" value="${board.postidx }">
	<table class="getBoard">
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
			<th>제목</th>
			<td colspan="2">
				${board.title }
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${board.nickname}</td>
			<th>조회수</th>
			<td>${board.hit }</td>
			<th>작성일</th>
			<td>${board.formattedDate }</td>
		</tr>
		<tr>
			
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
	</form>
	<p>
	<c:if test="${user.userIdx == board.useridx}">
		<a href="getUpdateBoard.do?postidx=${board.postidx }">수정 |</a>
		<a href="deleteBoard.do?postidx=${board.postidx }">삭제 |</a>
	</c:if>  	
		<a href="getBoardList.do"> 목록</a>
	</p>
	
	<div class="center">
	<c:if test="${not empty sessionScope.user }">
		<form action="insertComment.do" method="get" class="width">
			<input type="hidden" name="useridx" class="idInput" value="${user.userIdx}">
			<textarea name="content" rows="4" cols="60" class="commentInput"></textarea>
			<input type="submit" value="등록" class="btn">
			<input type="hidden" name="postidx" value="${board.postidx }">
			<%--<input type="hidden" name="cPage" value="${cPage }"> --%>
		</form>
	</c:if>	
	</div>
	<hr>
	<div class="scroll">
		<c:forEach var="comment" items="${comments}">
			<div class="comments">
				<form action="deleteComment.do" method="get">
					<p>작성자 : ${comment.nickname} | 작성일시 : ${comment.formattedCommentDate }
					<c:if test="${user.userIdx == comment.useridx}">
						<input type="submit" value="삭제"  class="btn deleteBtn"></p>
					</c:if> 
					<p>${comment.content}</p>
					<input type="hidden" name="commentidx" value="${comment.commentidx}">
					<input type="hidden" name="postidx" value="${comment.postidx}">
				</form>
			</div>
			<hr>
		</c:forEach>
	
	</div>
</div>

</body>
</html>














