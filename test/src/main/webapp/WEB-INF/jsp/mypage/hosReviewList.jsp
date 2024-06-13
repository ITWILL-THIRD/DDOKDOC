<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 리뷰 목록</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
.hidden {
    display: none;
}
.star-rating {
  display:flex;
  flex-direction: row-reverse;
  font-size:30px;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating input {
  display:none;
}

.star-rating label {
  color:#ccc;
  cursor:pointer;
}

.star-rating :checked ~ label {
  color:#f90;
}

.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}

.star-rating2 {
  display:flex;
  flex-direction: row-reverse;
  font-size:30px;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating2 input {
  display:none;
}

.star-rating2 label {
  color:#ccc;
  cursor:pointer;
}

.star-rating2 :checked ~ label {
  color:#f90;
}

.star-rating2 label:hover,
.star-rating2 label:hover ~ label {
  color:#fc0;
}
</style>
</head>
<body>
<%-- \${myReserList } : ${myReserList }<br><br>
\${myOldReserList } : ${myOldReserList }<br><br>
\${myCancleReserList } : ${myCancleReserList }<br><br>
\${reviewToWrite } : ${reviewToWrite }
\${myReviewList } = ${myReviewList } --%>
\${hosReviewList } = ${hosReviewList }
	<h2>리뷰 목록</h2>
	<div id="review">
	<p>총 평점 : ${hospital.score }</p>
		<table border=1>
			<tr>
				<th>내용</th>
				<th>평점</th>
				<th>방문일</th>
				<th>등록일</th>
			</tr>
			<tbody>
				<c:forEach var="review" items="${hosReviewList}">
				    <tr>
				        <td>${review.content}</td>
				        <td>
				        	<c:choose>
				                <c:when test="${review.score eq 1}">&#9733;</c:when>
				                <c:when test="${review.score eq 2}">&#9733;&#9733;</c:when>
				                <c:when test="${review.score eq 3}">&#9733;&#9733;&#9733;</c:when>
				                <c:when test="${review.score eq 4}">&#9733;&#9733;&#9733;&#9733;</c:when>
				                <c:when test="${review.score eq 5}">&#9733;&#9733;&#9733;&#9733;&#9733;</c:when>
				            </c:choose>
				        </td>
				        <td>${review.reserDate}</td>
				        <td>${review.reviewDate}</td>
				    </tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>