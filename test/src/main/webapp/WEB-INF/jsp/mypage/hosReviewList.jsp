<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 리뷰 목록</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
	
  	#container {  
		width: 800px; 
		margin-left: auto;
		margin-right: auto;
		margin-top: 37px;
	}
	
	#container table {
		width: 800px;
	}
	.side {
		margin-top: 37px;
	 	position: sticky;
	    float: left;
	    margin-left: 0;
	}
	ul {
	  list-style-type: none;
	  margin: 0;
	  padding: 0;
	  width: 200px;
	  display: flex;
	  flex-direction: column;
	  
	}
	
	li a {
	  display: block;
	  color: #000;
	  padding: 8px 16px;
	  text-decoration: none;
	  margin-right: auto;
	}
	
	
	li a:hover {
	background-color: #F3F3F3;
	  color: #FFA217;
	}
	
	.review {
		font-size: 20px;
		font-weight: bold;
		margin-left: 17px;
		margin-bottom: 10px;
	}
	table {
		border-collapse: collapse;
		margin-left:auto;margin-right:auto;
		margin-top: 23px;
	}
	
	table th, table td {
		position: static;
		text-align: center;
		margin: auto;
		padding: 5px;
		border: 1px #B9B9B9 solid;
		border-collapse: collapse;
	}
	
	table th:first-child,
	table td:first-child {
		border-left: 0;
	}
	
	table th:last-child,
	table td:last-child {
		border-right: 0;
	}
	th { 
		background-color: #E0EAF5;
	}
	tbody {
		border-bottom-style: hidden;
		border-top-style: hidden; 
	}
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
	p {
		float: right;
		font-size: 18px bold;
		font-weight: bold;
	}
	hr {
 
  border: 1px solid #2C307D;
  }
  h1{ text-align: center; }
  #linkTag {	
		font-weight: bold;
		color: #2C307D;
		text-decoration: none;	
	}
	
	#linkTag:hover {
		color:#FFA217;
	}
</style>
</head>
<body>
<h1>리뷰목록</h1>
		<div id="container">
		<a id="linkTag" href="hoMyPage.do">병원 마이페이지 가기</a>
		<hr>
			<p>총 평점 &nbsp;
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16" color="#B6E5FF">
					<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
				</svg> ${hospital.score }
			</p>
			<table>
				<tbody>
					<tr>
						<th width="10%">닉네임</th>
						<th width="10%">평점</th>
						<th width="50%">내용</th>
						<th width="15%">방문일</th>
						<th width="15%">등록일</th>
					</tr>
					<c:if test="${empty hosReviewList}">
						<tr>
							<td colspan="5">
								작성된 리뷰가 없습니다.
							</td>
						</tr>
					</c:if>
					<c:forEach var="review" items="${hosReviewList}">
					    <tr>
					    	<td>${review.nickname}</td>
					        <td>
					        	<c:choose>
					                <c:when test="${review.score eq 1}">&#9733;</c:when>
					                <c:when test="${review.score eq 2}">&#9733;&#9733;</c:when>
					                <c:when test="${review.score eq 3}">&#9733;&#9733;&#9733;</c:when>
					                <c:when test="${review.score eq 4}">&#9733;&#9733;&#9733;&#9733;</c:when>
					                <c:when test="${review.score eq 5}">&#9733;&#9733;&#9733;&#9733;&#9733;</c:when>
					            </c:choose>
					        </td>
					        <td>${review.content}</td>
					        <td>${review.reserDate}</td>
					        <td>${review.reviewDate}</td>
					    </tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
</body>
</html>