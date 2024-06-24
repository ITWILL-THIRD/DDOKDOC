<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리뷰 목록</title>
<jsp:include page="../../css/getUserListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<h1>회원 리뷰 목록</h1>
<div id="container">
<%-- \${userReviewList } : ${userReviewList } --%>
<a href="getUserList.do">회원관리목록 가기</a>
<hr>
<table border frame=void  style="width:100%">
<tr>
<th>병원명</th>
<th>방문일</th>
<th>리뷰내용</th>
<th>평점</th>
<th>작성자</th>
<th>등록일</th>
</tr>
<c:forEach var="review" items="${userReviewList}">
<tr>
	<td>${review.hosName }</td>
	<td>${review.reserDate}</td>
	<td>${review.content}</td>
	<td id="score_view_${review.reviewIdx}">
        <c:choose>
            <c:when test="${review.score eq 1}">&#9733;</c:when>
            <c:when test="${review.score eq 2}">&#9733;&#9733;</c:when>
            <c:when test="${review.score eq 3}">&#9733;&#9733;&#9733;</c:when>
            <c:when test="${review.score eq 4}">&#9733;&#9733;&#9733;&#9733;</c:when>
            <c:when test="${review.score eq 5}">&#9733;&#9733;&#9733;&#9733;&#9733;</c:when>
        </c:choose>
    </td>
	<td>${review.nickname}</td>
	<td>${review.reviewDate}</td>
</tr>
</c:forEach>
</table>
</div>
</body>
</html>