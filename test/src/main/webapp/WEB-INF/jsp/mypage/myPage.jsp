<%@page import="com.todoc.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

</head>
<body>

	<h2>내 정보</h2>
	
	<h2>마이펫 정보</h2>
		<c:choose>
			<c:when test="${empty pets}">
				<p>등록된 펫 정보가 없습니다</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="pet" items="${pets}">
					<c:if test="${not empty pet.petImg}">
						<img src="${pet.petImg}" alt="${pet.petName}의 이미지" style="max-width: 150px;">
					</c:if>
					<p>동물분류: ${pet.animal}</p>
					<p>펫이름: ${pet.petName}</p>
					<p>펫나이: ${pet.petAge}살</p>
					
					<form action="updateMyPetView.do" method="get">
						<input type="hidden" name="petIdx" value="${pet.petIdx}">
						<button type="submit">수정</button>
					</form>
					
					<form action="deleteMyPet.do" method="post" onsubmit="return confirm('펫을 삭제하시겠습니까?')">
						<input type="hidden" name="petIdx" value="${pet.petIdx}">
						<button type="submit">삭제</button>
					</form>
				</c:forEach>
			</c:otherwise>
		</c:choose>			
	<p><a href="insertMyPetView.do">마이펫 등록</a></p>

</body>
</html>