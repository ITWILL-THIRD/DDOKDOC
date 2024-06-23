<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세보기</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
<%-- \${reservation } : ${reservation }<br>
\${hospital } : ${hospital }<br>
\${myPet } : ${myPet }<br>
\${user } : ${user }<br> --%>

	<h1>예약 상세보기</h1>
	<div id="container">
		<hr>
		<%-- <h3>${user.name } 님의 예약입니다</h3> --%>
		<table border frame=void>
			<tr>
				<th>병원 이름</th>
				<td><a id="hosNameLink" href="../hospital/hosDetail.do?hosIdx=${hospital.hosIdx}">${hospital.hosName }</a></td>
			</tr>
			<tr>
				<th>예약일</th>
				<td>${reservation.reserDate }</td>
			</tr>
			<tr>
				<th>예약시간</th>
				<td>${reservation.formattedTime }</td>
			</tr>
			<tr>
				<th>진료볼동물</th>
				<td>${myPet.petName }</td>
			</tr>
			<tr>
				<th>메모</th>
				<td>${reservation.memo }</td>
			</tr>
		</table>
		
		<%-- 현재 날짜를 'yyyy-mm-dd' 형식으로 변환하고 세션에 저장 --%>
	    <%
	    java.text.SimpleDateFormat dateSdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	    java.text.SimpleDateFormat timeSdf = new java.text.SimpleDateFormat("HH:mm");
	    String currentDateStr = dateSdf.format(new java.util.Date());
	    String currentTimeStr = timeSdf.format(new java.util.Date());
	    session.setAttribute("currentDateStr", currentDateStr);
	    session.setAttribute("currentTimeStr", currentTimeStr);
	    %>
	
	    <%-- 예약 날짜와 현재 날짜 비교 --%>
	    <c:choose>
	        <c:when test="${reservation.reserDate == sessionScope.currentDateStr && reservation.formattedTime <= sessionScope.currentTimeStr}">
	            <p id="info">예약 시간이 지나 변경/취소가 불가능 합니다.</p>
	        </c:when>
	        <c:otherwise>
	            <button class="btn" onclick="reserUpdate(${reservation.reserIdx})">예약 변경</button>
	            <button class="btn" onclick="reserDelete(${reservation.reserIdx})">예약 취소</button>
	        </c:otherwise>
	    </c:choose>
	</div>

	
	<script>
		function reserUpdate(reserIdx) {
			location.href="updateReservation.do?reserIdx=" + reserIdx;
		}
		function reserDelete(reserIdx) {
			location.href="cancleReservation.do?reserIdx=" + reserIdx;
		}
	</script>
</body>
</html>