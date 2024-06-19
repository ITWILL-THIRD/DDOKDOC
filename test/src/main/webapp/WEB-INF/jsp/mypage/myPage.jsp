<%@page import="com.todoc.user.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
    .myPetTable td {
        width: 200px;
        text-align: center;
        vertical-align: center;
    }
    
    /* 구분선 */
    hr {    
		background-color:#B6E5FF;;
    	height:1px;
    	border:0;
	}
	
	/* 컨테이너 */
	#container {
		width: 800px;
		margin: auto;
	}
	h1, h2, p {
		text-align: center;
	}
	
	/* 테이블 */
	table {
		border-collapse: collapse; 
		width: 100%;
		margin: 20px 0;
	}
	table, th, td {
		border: 1px solid #B9B9B9;
		padding: 8px;
		text-align: center;
	}
</style>
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
	<div id="container">
		<a href="index.do">메인가기</a>
		
		<hr>
		<h2>내 정보</h2>
		   <c:if test="${user.condition == '결제전'}">
		   일반회원
		   </c:if>
		   <c:if test="${user.condition == '결제완료'}">
		   MEMBERSHIP ${umo.startformattedDate } ~ ${umo.endformattedDate }
		   </c:if>
		   
		   ${user.condition }
		<%-- 	${user.condition } --%>
			<form action="updateUser.do">
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
			<c:if test="${user.role == 'user'}">
		    <h2>마이펫 정보</h2>
		    <table class="myPetTable" border="1">
		        <c:choose>
		            <c:when test="${empty pets}">
		                <tr>
		                    <td colspan="2">등록된 펫 정보가 없습니다.</td>
		                </tr>
		            </c:when>
		            <c:otherwise>
		                <tr>
		                    <c:forEach var="pet" items="${pets}">
		                        <td>
		                            <c:if test="${not empty pet.petImg}">
		                                <img src="${pet.petImg}" alt="${pet.petName}의 이미지" style="max-width: 150px;">
		                            </c:if>
		                        </td>
		                    </c:forEach>
		                </tr>
		                <tr>
		                    <c:forEach var="pet" items="${pets}">
		                        <td>동물분류: ${pet.animal}</td>
		                    </c:forEach>
		                </tr>
		                <tr>
		                    <c:forEach var="pet" items="${pets}">
		                        <td>펫이름: ${pet.petName}</td>
		                    </c:forEach>
		                </tr>
		                <tr>
		                    <c:forEach var="pet" items="${pets}">
		                        <td>펫나이: ${pet.petAge}살</td>
		                    </c:forEach>
		                </tr>
		                <tr>
		                    <c:forEach var="pet" items="${pets}">
		                        <td>
		                            <form action="updateMyPetView.do" method="get" style="display:inline;">
		                                <input type="hidden" name="petIdx" value="${pet.petIdx}">
		                                <button type="submit">수정</button>
		                            </form>
		                            <form action="deleteMyPet.do" method="post" onsubmit="return confirm('펫을 삭제하시겠습니까?')" style="display:inline;">
		                                <input type="hidden" name="petIdx" value="${pet.petIdx}">
		                                <button type="submit">삭제</button>
		                            </form>
		                        </td>
		                    </c:forEach>
		                </tr>
		            </c:otherwise>
		        </c:choose>
		    </table>
		    
			<p><button class="btn" onclick="location.href='insertMyPetView.do'">마이펫 등록</button></p>
			<p><a href="insertMyPetView.do">마이펫 등록</a></p>
		
			<p><a href="myReserList.do">내 진료 예약내역 보기</a>
		<!-- 	<p><a href="myOldReserList.do">내 진료 지난 예약내역 보기</a> -->
			<p><a href="myCancleReserList.do">취소한 예약내역 보기</a>
			<p><a href="myReviewList.do">내 진료 지난 예약내역 보기</a></p>
			<p><a href="myPostList.do">나의 작성 게시물</a>
			</c:if>

	</div>
</body>
</html>