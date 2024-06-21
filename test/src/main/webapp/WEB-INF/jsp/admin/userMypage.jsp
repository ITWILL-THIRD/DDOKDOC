<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userMypage</title>
</head>
<body>
<h1>userMypage</h1>
<a href="getUserList.do">회원관리목록 가기</a>
<%-- \${user } : ${user } --%>
<%-- \${pets } : ${pets } --%>
<hr>
	<h2>회원 정보</h2>
	<c:if test="${user.condition == '결제전'}">
		토탁플러스 가입 후 병원예약이 가능합니다. <a href="../membership/checkout.do">토탁플러스 가입하러가기</a>
		</c:if>
		<c:if test="${user.condition == '결제완료'}">
		TODOCPLUS ${umo.startformattedDate } ~ ${umo.endformattedDate }
		</c:if>
		
<%-- 		${user.condition } --%>
	<table>
	<tr>
		<td>프로필사진 </td>
		<td>
		<c:if test="${not empty user.userImg}">
			<img src="${user.userImg}" alt="${user.userIdx}의 이미지" style="max-width: 150px;">
		</c:if>
		</td>
	</tr>
	<tr>
		<td>이메일 </td>
		<td>${user.email}</td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td>${user.nickname}</td>
	</tr>
	<tr>
		<td>이름</td>
		<td>${user.name}</td>
	</tr>
	<tr>
		<td>생년월일</td>
		<td>${user.birth}</td>
	</tr>
	<tr>
		<td>전화번호</td>
		<td>${user.phone}</td>
	</tr>
	<tr>
		<td><input type="hidden" name="userIdx" value="${user.userIdx}"></td>
	</tr>
	</table>
	
	<hr>
	<h2>회원 마이펫 정보</h2>
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
				</c:forEach>
			</c:otherwise>
		</c:choose>
	
</body>
</html>