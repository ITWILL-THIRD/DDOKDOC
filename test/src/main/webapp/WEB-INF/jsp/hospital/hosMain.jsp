<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥 메인</title>
<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	function fetchData(category) {
		let intSido = document.querySelector("select[name='sido']").value;
		let sidoNames = ["서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종", 
			"경기", "강원", "충북", "충남", "전북", "전남", "경북", "경남", "제주"];
		intSido = sidoNames[intSido - 1];

		let vo = {};
		vo.searchCondition = category;
		vo.searchKeyword = document.querySelector("input[name='searchKeyword']").value;
		vo.sido = intSido;

		vo.sigungu = document.querySelector("select[name='sigungu']").value;
		$.ajax("getHosSearch.do", { 
	        type: 'GET',
	        data: vo,
	        success: function(data) {
	        	$("#listDisp").empty();
 
			    let dispHtml = "";
			    
			    for (let hospital of data) {
			        dispHtml += "<tr>";
			        dispHtml += "<td>" + hospital.hosIdx + "</td>";
			        dispHtml += "<td><a href='hospital/hosDetail.do?hosIdx=" + hospital.hosIdx + "'>" + hospital.hosName + "</a></td>";
			        dispHtml += "<td>" + hospital.roadAddressName + "</td>";
			        dispHtml += "<td>" + hospital.hosPhone + "</td>";
			        dispHtml += "<td>" + hospital.openTime + " ~ " + hospital.closeTime + "</td>";
			        dispHtml += "<td>" + hospital.animal + "</td>";
			        dispHtml += "</tr>";
			    }
			    
			    $("#listDisp").html(dispHtml);
	        },
	        error: function() {
	        	alert("실패");
	        }
	    });
	}

</script>
</head>
<body>
	<div id="container">
		<h1>병원 예약</h1>
		<hr>
		<br>
		<h3>병원 검색</h3>
		<form id="getHosSearch" onsubmit="fetchData('search'); return false;">
			<p>통합검색</p>
			<input type="text" name="searchKeyword" placeholder="Search">
			<input type="submit" value="검색">
		</form>
		<form id="getAdSearch" onsubmit="fetchData('address'); return false;">
			<jsp:include page="partials/searchAdress.jsp"></jsp:include> 
			<input type="submit" value="검색">
		</form>
		<div>
			<button class="tab" onclick="fetchData('all')">전체</button>
			<button class="tab" onclick="fetchData('common')">일반병원</button>
			<button class="tab" onclick="fetchData('special')">특수병원</button>
			<button class="tab" onclick="fetchData('night')">야간진료</button>
			<button class="tab" onclick="fetchData('24h')">24시</button>
		</div>
	</div>
	<table>
		<thead>
			<tr>
				<th>번호</th>
				<th>병원명</th>
				<th>주소</th>
				<th>운영시간</th>
				<th>전화번호</th>
				<th>분류</th>
			</tr>
		</thead>
		<tbody id="listDisp">
			<c:forEach var="hospital" items="${hosList }">

			<tr>
				<td>${hospital.hosIdx}</td>
				<td><a href="hosDetail.do?hosIdx=${hospital.hosIdx}">${hospital.hosName}</a>
				</td>
				<td>${hospital.roadAddressName} ${hospital.detailAddress}</td>
				<td>${hospital.openTime} ~ ${hospital.closeTime}</td>
				<td>${hospital.hosPhone}</td>
				<td>${hospital.animal}</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<hr>
	<p><a href="temp.do">병원 등록</a></p>
</body>
</html>

