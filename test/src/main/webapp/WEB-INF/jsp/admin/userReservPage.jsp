<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userReservPage</title>
</head>
<body>
<h1>userReservPage</h1>
<a href="getUserList.do">회원관리목록 가기</a>
<hr>
<h2>회원 진료 예약내역</h2>
<%-- \${userReserList } : ${userReserList } --%>
<%-- ${userIdx } --%>
<!-- 카테고리별  -->
<div id="condition">
	<a href="userReservPage.do?userIdx=${userIdx}">전체</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=RESERVATION">예약완료</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=CANCLE">예약취소</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=FINISH">진료완료</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=REVIEW">리뷰작성</a>
</div>
<table border>
	<c:choose>
		<c:when test="${empty userReserList}">
			<p>내역이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<tr>
				<th>병원이름</th>
				<th>마이펫</th>
				<th>날짜</th>
				<th>시간</th>
				<th>메모</th>
				<th>상태</th>
			</tr>
		<c:forEach var="reser" items="${userReserList }">
			<tr>
				<td>${reser.hosName }</td>
				<td>${reser.petName }</td>
				<td>${reser.reserDate }</td>
				<td>${reser.formattedTime }</td>
				<td>${reser.memo }</td>
				<td>
	                <c:choose>
	                    <c:when test="${reser.condition == 'RESERVATION'}">
	                        	예약완료
	                    </c:when>
	                    <c:when test="${reser.condition == 'CANCLE'}">
	                       	 예약취소
	                    </c:when>
	                    <c:when test="${reser.condition == 'REVIEW'}">
	                        	리뷰작성
	                    </c:when>
	                    <c:when test="${reser.condition == 'FINISH'}">
	                        	진료완료
	                    </c:when>
	                    <c:otherwise>
	                       	 알 수 없음
	                    </c:otherwise>
	                </c:choose>
	            </td>
			</tr>
		</c:forEach>
		</c:otherwise>
	</c:choose>
</table>

</body>
</html>