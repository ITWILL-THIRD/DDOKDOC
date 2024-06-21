<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥[main.jsp]</title>
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
        
        function login() {
        	location.href = "user/login.do";
        }
        function hoLogin() {
        	location.href = "user/hoLogin.do";
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

	#container { width: 80%; height:800px; margin: auto; margin-top: 30px;}
	.abcd {width:100%; height:50%;}
	
	.a {
		border-radius: 15px;
		background-color: #2C307D;
		width: 60%;
		height: 95%;
		margin:10px;
		display: inline-block;
		position: relative;
	}
	.todocImg {width: 300px; margin: 20px; position: absolute; right:0;}
	.a > .txt {
		font-size: 3rem;
		position: absolute;
		left: 20%;
		  top: 50%;
		  /*요소의 높이의 반(50%) 만큼 위로 이동*/
		  transform: translateY(-50%);
		color:#fff;
	}
	
	.b {
		border-radius: 15px;
		background-color: #F3F3F3;
		width: 30%;
		height: 95%;
		margin:10px;
		display: inline-block;
		position: relative;
		text-align: center;
	}
	.userLogin {
		border-radius: 15px;
		background-color: #E0EAF5;
		width:43%;
		height:40%;
		position: absolute;
		left: 5%;
		top: 50%;
		/*요소의 높이의 반(50%) 만큼 위로 이동*/
		transform: translateY(-50%);
		text-align: center;
		line-height: 150px;
		border:none;
		font-size: 1rem;
		font-weight: 600;
	}
	.userLogin:hover {background-color: #B8DAFF;}
	.hosLogin {
		border-radius: 15px;
		background-color: #FFA217;
		width:43%;
		height:40%;
		position: absolute;
		right: 5%;
		top: 50%;
		/*요소의 높이의 반(50%) 만큼 위로 이동*/
		transform: translateY(-50%);
		text-align: center;
		line-height: 150px;
		border:none;
		font-size: 1rem;
		font-weight: 600;
	}
	.hosLogin:hover {background-color: #FF8E2B;}
	.b > .txt {
		font-size: 2rem;
		position: absolute;
		top: 50%;
		/*요소의 높이의 반(50%) 만큼 위로 이동*/
		transform: translateY(-50%);
	}
	.profileImg{
		position: absolute;
		top: 30%;
        left: 50%;
        transform: translate(-50%, -50%);
		max-width: 150px;
		border-radius: 50%;
		justify-content: center;
	}
	.nickname {
		position: absolute;
		top: 70%;
        left: 50%;
        transform: translate(-50%, -50%);
		text-align: center;
		aligns-item: center;
		justify-content: center;
		font-size: 1.3rem;
		font-weight: 600;
	}
	
	.c {
		border-radius: 15px;
		background-color: #F3F3F3;
		width: 45%;
		height: 95%;
		margin:10px;
		display: inline-block;
		position: relative;
	}
	.catImg {width: 300px; margin: 20px; position: absolute; left:10;}
	.c > .txt {
		font-size: 2rem;
		position: absolute;
		right: 20%;
		  top: 50%;
		  /*요소의 높이의 반(50%) 만큼 위로 이동*/
		  transform: translateY(-50%);
	}
	
	.d {
		border-radius: 15px;
		background-color: #E0EAF5;
		width: 45%;
		height: 95%;
		margin:10px;
		display: inline-block;
		position: relative;
	}
	.dogImg {width: 300px; margin-top: 50px; position: absolute; right:0;}
	.d > .txt {
		font-size: 2rem;
		position: absolute;
		left: 10%;
		  top: 50%;
		  /*요소의 높이의 반(50%) 만큼 위로 이동*/
		  transform: translateY(-50%);
	}
	
	span {color: #FFA217;}

	.txt {
		font-weight:600;
		display: inline;
	}
	
	
	
</style>

</head>
<body>
<div class="top">
<%--    <a>&nbsp <%=vo.getName()%>님</a>--%>
</div>
<div class="nav">
    <div class="logo">
    	<a href="index.jsp">
        	<img src="" alt="로고">
    	</a>    
    </div>
    
    <div class="topnav">
    	<a href="hospital/hosMain.do">병원예약</a>
        <a href="board/getBoardList.do">정보나눔</a>
        
        
    	<c:if test="${empty sessionScope.hoUser and empty sessionScope.user}">
    		<a href="user/selectLogin.do">로그인 /회원가입</a>
    	</c:if>
    	
    	<c:if test="${not empty sessionScope.hoUser}">
    		<a href="membership/checkout.do">멤버십</a>
	        <a href="mypage/hoMyPage.do">병원 마이페이지</a>
	        <a href="logout.do">로그아웃</a>
    	</c:if>
    	
    	<c:if test="${sessionScope.user.role == 'user'}">
    		<a href="membership/usercheckout.do">멤버십</a>
    		<a href="mypage/myPage.do">마이페이지</a>
    		<a href="logout.do">로그아웃</a>
    	</c:if>
    	<c:if test="${sessionScope.user.role == 'admin'}">
    		<div class="adminDropdown">
				<a>관리</a>
				<div class="dropdownList">
					<a href="admin/getHosApprovalList.do">병원 승인</a>
				    <a href="admin/getUserList.do">개인 회원</a>
					<a href="admin/statsPage.do">통계</a>
				</div>
			</div>
			<a href="logout.do">로그아웃</a>
    	</c:if>
    	
    </div>
</div>
	<div id="container">
		<div class="abcd">
			<div class="a">
				<div class="txt">토닥토닥</div>
				<img src="https://i.ibb.co/1scnHR7/casual-life-3d-female-veterinarian-with-dog.png" alt="todoc" class="todocImg">
			</div>
			
			<div class="b">
			<c:choose>
				<c:when test="${sessionScope.user.role == 'admin'}">
					<img src="https://i.ibb.co/9GGQYgD/admin.png" alt="administrator의 이미지" class="profileImg">
					<div class="nickname">Admin</div>
				</c:when>
				<c:when test="${not empty sessionScope.user}">
					<img src="${user.userImg}" alt="${user.userIdx}의 이미지" class="profileImg">
					<div class="nickname">${sessionScope.user.nickname }</div>
				</c:when>
				<c:when test="${not empty sessionScope.hoUser}">
					<img src="https://i.ibb.co/qnKFVpL/hospital.png" alt="${hoUser.hosIdx}의 이미지" class="profileImg">
					<div class="nickname">${sessionScope.hoUser.hosName }</div>
				</c:when>
				<c:otherwise>
					<input class="userLogin" type="button" value="개인 로그인 / 회원가입" onclick="login()">
					<input class="hosLogin" type="button" value="병원 로그인 / 회원가입" onclick="hoLogin()">
			    </c:otherwise>
			</c:choose>
			</div>	
		</div>
		<div class="abcd">
			<div class="c">				
				<img src="https://i.ibb.co/j8Bs1kN/casual-life-3d-top-view-of-cat-lying-on-back.png" alt="cat" class="catImg">
				<div class="txt">내 펫을 <span>등록</span>하고 </br> 병원을 <span>예약</span>하세요!</div>
			</div>
			<div class="d">
				<div class="txt">다양한 주제로 </br>  이야기를 나눠요</div>
				<img src="https://i.ibb.co/5cczVHP/casual-life-3d-front-view-of-a-beagle-dog.png" alt="dog" class="dogImg">
			</div>
		</div>
	</div>
	

</body>
</html>

