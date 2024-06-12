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
</style>
</head>
<body>
<div class="top">
<%-- 	<a>&nbsp <%=vo.getName()%>님</a>--%>
</div>
<div class="nav">
    <div class="logo">
        <img src="" alt="로고">
    </div>
    <div class="topnav">
        <a href="../hospital/hosMain.do">병원예약</a>
        <a href="../board/getBoardList.do">정보나눔</a>
        <a href="../membership/checkout.do">멤버십</a>
        
        <c:choose>
			<c:when test="${not empty sessionScope.user}">
				<a href="../logout.do">로그아웃</a>
				<a href="../mypage/myPage.do">마이페이지</a>
			</c:when>
			<c:when test="${not empty sessionScope.hoUser}">
		        <a href="../logout.do">로그아웃</a>
		        <a href="../mypage/hoMyPage.do">병원 마이페이지</a>
		    </c:when>
			<c:otherwise>
		        <a href="../user/login.do">로그인 /회원가입</a>
		    </c:otherwise>
		</c:choose>	
    </div>
</div>

</body>
</html>