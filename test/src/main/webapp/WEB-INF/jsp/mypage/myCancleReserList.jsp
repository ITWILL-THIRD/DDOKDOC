<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 내역</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
	#container { width: 800px; margin: auto; }
	h1, h3, p { text-align: center; }
	
	<%-- 목록 --%>
	table {
		width: 800px;
		border-collapse: collapse;
		margin-left:auto;margin-right:auto;
		margin-top: 23px;
	}
	
	table th, table td {
		position: static;
		text-align: center;
		margin: auto;
		padding: 5px;
		border: 1px #B9B9B9 solid;
		
		border-collapse: collapse;
	}
	
	table th:first-child,
	table td:first-child {
		border-left: 0;
	}

	table th:last-child,
	table td:last-child {
		border-right: 0;
	}

	th { 
		background-color: #E0EAF5;
	}
	
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	
	.center {
		margin-bottom: 20px;
	}
	<%-- 제목 링크 --%>
	#hosNameLink {	
		font-weight: bold;
		color: #2C307D;
		text-decoration: none;	
	}
	
	#hosNameLink:hover {
		color:#FFA217;
	}
	
    
        /* 버튼 */
    .btn {
    	border-radius: 5px;
    	background-color: #2C307D;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	display: inline-block;
    	border: 1px solid #2C307D;
    }
    
    .btn:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
	

  hr {
  	border: 1px solid #2C307D;
  }
</style>
</head>
<body>
<%-- \${myReserList } : ${myReserList }<br><br>
\${myOldReserList } : ${myOldReserList }<br><br>
\${myCancleReserList } : ${myCancleReserList }<br><br> --%>
	<h1>예약취소내역</h1>
	<div id="container">
		<hr>
		<a href="myPage.do">마이페이지 가기</a>
		<table border frame=void>
			<tr>
				<th>번호</th>
				<th>병원이름</th>
				<th>마이펫</th>
				<th>날짜</th>
				<th>시간</th>
				<th>상세보기</th>
			</tr>
		<c:forEach var="reser" items="${myCancleReserList }">
			<tr>
				<td>${reser.rownum }</td>
				<td><a id="hosNameLink" href="../hospital/hosDetail.do?hosIdx=${reser.hosIdx}">${reser.hosName }</a></td>
				<td>${reser.petName }</td>
				<td>${reser.reserDate }</td>
				<td>${reser.formattedTime }</td>
				<td>
					<button class="btn" id="reserDetailBtn" onclick="reservationDetail(${reser.reserIdx})">상세보기</button>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>	
<script>
	function reservationDetail(reserIdx) {
		location.href="../reservation/reservationDetail.do?reserIdx=" + reserIdx;
	}
</script>
</body>
</html>