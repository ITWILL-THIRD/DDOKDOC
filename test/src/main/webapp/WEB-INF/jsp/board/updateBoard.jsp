<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글수정</title>
<jsp:include page="../../css/updateBoard.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>

<div id="container">
	<h2>글 수정</h2>
	<hr>
	<form action="updateBoard.do" method="post" enctype="multipart/form-data">
	<table class="insertBoard">
		<tr>
			<th>카테고리</th>
			<td>
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
			<td>
				<input type="text" name="title" value="${board.title }" style="width: 100%" class="border-none">
			</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>
				${board.nickname }
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="content" rows="10" cols="40" style="width: 100%" class="border-none">${board.content }
				</textarea>
				<c:if test="${not empty board.img}">
	                   <img src="${board.img}" alt="${board.img}의 이미지">
	            </c:if>
			</td>
		</tr>
		<tr>
		<%-- 
			<th>사진 첨부</th>
			<td>
				<input type="file" name="file">
			</td>
		</tr>--%>
<!-- 		<tr> -->
<!-- 			<td colspan="2" class="center"> -->
<!-- 				<input type="submit" value="수정" class="btn"> -->
<!-- 				<div class="resetBtn"> -->
<%-- 				<a href="getBoard.do?postidx=${board.postidx }">취소</a> --%>
<!-- 				</div> -->
<!-- 			</td> -->
<!-- 		</tr> -->
	</table>
	<input type="submit" class="btn" value="수정">
	<input type="reset" class="resetBtn" value="초기화">
	<input type="button" class="resetBtn" value="취소"
	onclick="javascript:location.href='../board/getBoardList.do'">
	</form>
</div>

</body>
</html>
