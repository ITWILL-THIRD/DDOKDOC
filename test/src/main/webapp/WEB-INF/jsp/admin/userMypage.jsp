<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userMypage</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
	/* 컨테이너 */
	#container {
		width: 800px;
		margin: auto;
	}
	h1, h2, p {
		text-align: center;
	}
	h2 {
		margin: 20px 0;
		color: #425587;
	}
	
	/* 테이블 */
	table {
		width: 100%;
		margin: 20px 0;
		border-radius: 10px;
		border-collapse: collapse; 
		
	}
	table, th, td {
		border: none;
		padding: 10px 15px;
		text-align: center;
	}
	th, td {
		border-bottom: 1px solid #589DE1;
	}
	th {
		width: 150px;
        background-color: #589DE1;
        color: #FFFFFF;
    }
	td {
        text-align: left;
        color: #425587;
    }
	
	/* 버튼 */
	.btn {
		display: inline-block;
		background-color: #589DE1;
		color: #FFFFFF;
		padding: 10px 20px;
		border: none;
		cursor: pointer;
		text-align: center;
		margin: 5px;
		border-radius: 5px;
	}
	.btn:active {
		background-color: #1F526B;
		color: #FFFFFF;
	}
	
    /* 구분선 */
    hr {    
		background-color:#B6E5FF;;
    	height:2px;
    	border:0;
    	margin: 20px 0 40px 0;
	}
	
	.center {
		text-align: center;
	}
	
	/* 프로필 이미지 */
	.profileImg {
		max-width: 150px;
		border-radius: 50%;
	}	
	
	/* 마이펫 정보 */
	.myPetContainer {
		display: flex;
		flex-wrap: wrap;
		justify-content: center;
		text-align: center;
	}
	.myPet {
		display: inline-block;
		width: calc(30% - 10px);
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		box-sizing: border-box;
		border-radius: 10px;
		margin: 10px;
		padding: 20px;
	}
	.myPet img, .noImg {
		display: block;
		max-width: 100%;
		max-height: 50%;
		min-width: 150px;
		min-height: 200px;
		border-radius: 10px;
		line-height: 150px;
	}
	.noImg {
		background-color: #E0EAF5;
	}
	.myPet button {
        background-color: #FFFFFF;
        border: 1px solid #1F526B;
        border-radius: 5px;
        padding: 10px 20px;
        cursor: pointer;
    }
    .myPet button:active {
        background-color: #1F526B;
        color: #FFFFFF;
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
	<a href="getUserList.do">회원관리목록 가기</a>
<%-- \${user } : ${user } --%>
<%-- \${pets } : ${pets } --%>
		
		<hr>
		<h2>내 정보</h2>
		<c:if test="${user.condition == '결제전'}">
		[토탁플러스 가입 후 병원예약이 가능합니다.] <a href="../membership/usercheckout.do">토탁플러스 가입 하러가기</a>
		</c:if>
		<c:if test="${user.condition == '결제완료'}">
		[TODOCPLUS] ${umo.startformattedDate } ~ ${umo.endformattedDate }
		</c:if>
		
<%-- 		${user.condition } --%>
			<form action="updateUser.do">
			<input type="hidden" name="userIdx" value="${user.userIdx}">
			<table>
			<tr>
				<td colspan="2" class="center">
				<c:if test="${not empty user.userImg}">
					<img src="${user.userImg}" alt="${user.userIdx}의 이미지" style="max-width: 150px;" class="profileImg">
				</c:if>
				</td>
			</tr>
			<tr>
				<th>이메일 </th>
				<td>${user.email}</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>${user.nickname}</td>
			</tr>
		<!-- 	<tr> -->
		<!-- 		<td>비밀번호<td> -->
		<%-- 		<td>${user.password}</td> --%>
		<!-- 	</tr> -->
			<tr>
				<th>이름</th>
				<td>${user.name}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${user.birth}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${user.phone}</td>
			</tr>
			</table>
			<p>
				<input type="submit" value="내 정보 수정" class="btn">
				<input type="button" value="탈퇴하기" class="btn" onclick="userDelete_ok(this.form)">
			</p>
			</form>
			
        <hr>
        <c:if test="${user.role == 'user'}">
            <h2>마이펫 정보</h2>
            
            <div class="myPetContainer">
                <c:choose>
                    <c:when test="${empty pets}">
                        <div>등록된 펫 정보가 없습니다.</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="pet" items="${pets}">
                            <div class="myPet">
                                <c:if test="${not empty pet.petImg}">
                                    <img src="${pet.petImg}" alt="${pet.petName}의 이미지">
                                </c:if>
                                <c:if test="${empty pet.petImg}">
                                    <div class="noImg"></div>
                                </c:if>
                                <h3>${pet.petName}</h3>
                                <p>동물분류: ${pet.animal}</p>
                                <p>펫나이: ${pet.petAge}살</p>
                                <form action="updateMyPetView.do" method="get" style="display:inline;">
                                    <input type="hidden" name="petIdx" value="${pet.petIdx}">
                                    <button type="submit">수정</button>
                                </form>
                                <form action="deleteMyPet.do" method="post" onsubmit="return confirm('펫을 삭제하시겠습니까?')" style="display:inline;">
                                    <input type="hidden" name="petIdx" value="${pet.petIdx}">
                                    <button type="submit">삭제</button>
                                </form>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
		    
			<p><button class="btn" onclick="location.href='insertMyPetView.do'">마이펫 등록</button></p>
			</c:if>

	</div>
</body>
</html>