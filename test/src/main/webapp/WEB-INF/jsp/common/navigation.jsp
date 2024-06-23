<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>navigation</title>
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
	 	border-color: #E0EAF5;
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
	  color: #E0EAF5;
	}
	/* 현재 페이지의 네비게이션 링크 활성화 */
/*	
	.topnav a.active {
 		color: #FFA217; 
		font-weight: bold; 
	}
*/	
	.adminDropdown, .userDropdown {
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
   		width: 150px; /* 세로 */
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
<%-- 	<a>&nbsp <%=vo.getName()%>님</a>--%>
</div>
<div class="nav">
    <div class="logo">
        <a href="../index.jsp">
        	<img src="https://i.ibb.co/7zMj5XR/2.png" alt="토닥토닥로고">
    	</a>    
    </div>
    
    <div class="topnav">
    	<a href="../hospital/hosMain.do">병원예약</a>
        <a href="../board/getBoardList.do">정보나눔</a>
    	<c:if test="${empty sessionScope.hoUser and empty sessionScope.user}">
    		<a href="../user/selectLogin.do">로그인 /회원가입</a>
    	</c:if>
    	
    	<c:if test="${not empty sessionScope.hoUser}">
    		<a href="../membership/checkout.do">토닥+</a>
	        <a href="../mypage/hoMyPage.do">병원 마이페이지</a>
	        <a href="../logout.do">로그아웃</a>    		
    	</c:if>
    	
    	<c:if test="${sessionScope.user.role == 'user'}">
    		<a href="../membership/usercheckout.do">토닥+</a>
    		<div class="userDropdown">
				<a href="../mypage/myPage.do">마이페이지</a>
			</div>
    		<a href="../logout.do">로그아웃</a>
    	</c:if>
    	<c:if test="${sessionScope.user.role == 'admin'}">
    		<div class="adminDropdown">
				<a>관리</a>
				<div class="dropdownList">
					<a href="../admin/getHosApprovalList.do">병원 승인</a>
				    <a href="../admin/getUserList.do">개인 회원</a>
					<a href="../admin/statsPage.do">통계</a>
				</div>
			</div>
			<a href="../logout.do">로그아웃</a>
    	</c:if>
    </div>
    
<!--     <script> -->
<!--  	    // 모든 네비게이션 링크 선택 -->
<!--  	    const navLinks = document.querySelectorAll('.topnav a'); -->
	
<!--  	    // 각 링크에 클릭 이벤트 리스너 추가 -->
<!--  	    navLinks.forEach(link => { -->
<!--  	    	link.addEventListener('click', () => { -->
<!--  	    		alert('link : ' + link); -->
<!--  	    		// 이전에 활성화된 링크의 active 클래스 제거 -->
<!--  	    	    const activeLink = document.querySelector('.topnav a.active'); -->
<!--  	    	    if (activeLink) { -->
<!--  	    	    	activeLink.classList.remove('active'); -->
<!--  	    	    } -->
<!--  	    	    // 현재 클릭된 링크에 active 클래스 추가 -->
<!--  	    	    link.classList.add('active'); -->
<!--      	    }); -->
<!--  	    }); -->
<!--     </script> -->
    
</div>

</body>
</html>