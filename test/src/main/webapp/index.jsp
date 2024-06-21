<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지 [main.jsp]</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

<script>
        function getQueryParam(param) {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(param);
        }

        window.onload = function() {
            var msg = getQueryParam("msg");
            var nickname = "${user.nickname}";
            var hosname = "${hoUser.hosName}";
            if (msg === "success" && nickname) {
                alert(nickname + "님 환영합니다.");
            } else if (msg === "delete") {
            	alert("탈퇴가 완료되었습니다.");
            } else if (msg === 'admin') {
                alert('관리자로 로그인 됐습니다.');
            } else if (msg === 'hosuccess' && hosname) {
            	alert(hosname + "님 환영합니다. ")
            } else if (msg === "deleteHos") {
            	alert("병원탈퇴가 완료되었습니다.")
            }
        }

</script>
<style>
@font-face {
    font-family: 'Pretendard-Regular';
    src: url('https://cdn.jsdelivr.net/gh/Project-Noonnu/noonfonts_2107@1.1/Pretendard-Regular.woff') format('woff');
    font-weight: 400;
    font-style: normal;
}

* {
	font-family: 'Pretendard-Regular';
}
	.nav {background-color: #fff;}

	.top {
		background-color: #fff;
		height: 5%;
		text-align: right;
	}
	.top a {
		text-decoration: none;
		color: #000;
		margin-right: 30px;
	}
	.nav {
	 	display: flex;
	 	item-align: center;
	 	border-style: none none solid none;
	 	border-color: #B6E5FF;
	 	justify-content: space-between;
	 	line-height: 30px;
	}
	
	.logo {
		font-weight: 600;
		font-size: 1.5rem;
		margin-top: 10px;
		margin-left: 20px;

	}
	
	.logo img {
		height: 30px;
	}
	
	.topnav {
	  overflow: hidden;
	  background-color: #fff;
	}
	
	.topnav a {
	  float: left;
	  display: block;
	  color: black;
	  text-align: center;
	  padding: 14px 16px;
	  text-decoration: none;
	  margin-left: 10px;
	  margin-right: 20px;
	}
	
	.topnav a:hover {
	  color: #B6E5FF;
	}
	
	.adminDropdown {
		float:right;
		position: relative;
		display: inline-block;
		cursor: pointer
	}
	.dropdownList {
		display: none;
 	  	position: fixed;
 	  	right: 10px;
 	  	top: 66px; /* 69px */
		background-color: #f9f9f9;
   		min-width: 130px; /* 가로 */
   		width: 0px; /* 세로 */
  		z-index: 1;  
	}
	.adminDropdown:hover .dropdownList {
		
		display: block;
	}
/* 	.dropdownList:active { */
/* 		font: bold; */
/* 		text-decoration: underline; */
/* 	} */
</style>

</head>
<body>
<div class="top">
<%--    <a>&nbsp <%=vo.getName()%>님</a>--%>
</div>
<div class="nav">
    <div class="logo">
        <img src="" alt="로고">
    </div>
    
    <div class="topnav">
    	<a href="hospital/hosMain.do">병원예약</a>
        <a href="board/getBoardList.do">정보나눔</a>
        
        
    	<c:if test="${empty sessionScope.hoUser and empty sessionScope.user}">
    		<a href="user/selectLogin.do">로그인 /회원가입</a>
    	</c:if>
    	
    	<c:if test="${not empty sessionScope.hoUser}">
    		<a href="membership/checkout.do">멤버십</a>
    		<a href="logout.do">로그아웃</a>
	        <a href="mypage/hoMyPage.do">병원 마이페이지</a>
    	</c:if>
    	
    	<c:if test="${not empty sessionScope.user}">
    		<a href="membership/usercheckout.do">멤버십</a>
    		<a href="logout.do">로그아웃</a>
    		
    		<c:choose>
		    	<c:when test="${sessionScope.user.role == 'admin'}">
		    		<a href="mypage/myPage.do">관리자 마이페이지</a>
					<div class="adminDropdown">
						<a>관리</a>
						<div class="dropdownList">
							<a href="admin/getHosApprovalList.do">병원 승인</a>
						    <a href="admin/getUserList.do">개인 회원</a>
							<a href="admin/statsPage.do">통계</a>
						</div>
					</div>
		    	</c:when>
		    	<c:otherwise>
					<a href="mypage/myPage.do">마이페이지</a>
		    	</c:otherwise>
    		</c:choose>
    	</c:if>
    	
    </div>
</div>

	<h1>TODOC</h1>

</body>
</html>

