<%@page import="com.todoc.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script>
function userDelete_ok(frm) {
    if (confirm("정말로 탈퇴하시겠습니까?")) {
        frm.action = "deleteUser.do"; // 탈퇴 요청을 보낼 URL을 지정합니다.
        frm.method = "POST";
        frm.submit(); // 폼을 제출합니다.
    }
}
</script>
</head>
<body>
<h1>마이페이지</h1>
<a href="index.do">메인가기</a>

<hr>
	<h2>내 정보</h2>
	<form action="updateUser.do">
	<table>
	<tr>
		<td>이메일 </td>
		<td>${user.email}</td>
	</tr>
	<tr>
		<td>닉네임</td>
		<td>${user.nickname}</td>
	</tr>
<!-- 	<tr> -->
<!-- 		<td>비밀번호<td> -->
<%-- 		<td>${user.password}</td> --%>
<!-- 	</tr> -->
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
	<tr>
	<td class="center">
		<input type="submit" value="내 정보 수정">
	</td>
	<td>
		<input type="button" value="탈퇴하기" onclick="userDelete_ok(this.form)">
	</td>
	</tr>
	</table>
	</form>
	
	
	<hr>
	<h2>마이펫 정보</h2>
		<c:choose>
			<c:when test="${empty pets}">
				<p>등록된 펫 정보가 없습니다</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="pet" items="${pets}">
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
	<p><a href="insertMyPetView.do">마이펫 등록페이지로 이동</a></p>

	<p><a href="myReserList.do">내 진료 예약내역 보기</a>
	<p><a href="myOldReserList.do">내 진료 지난 예약내역 보기</a>
	<p><a href="myCancleReserList.do">취소한 예약내역 보기</a>

</body>
</html>