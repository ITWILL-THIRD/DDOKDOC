<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥 메인</title>
<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
			    function formatTime(time) {
			        // "HH:MM:SS"에서 "HH:MM" time 포맷 변환 함수
			        if (typeof time === 'string' && time.length === 8) {
			            var hours = time.substring(0, 2);
			            var minutes = time.substring(3, 5);
			            return hours + ':' + minutes;
			        } else {
			            return time; // 예상치 못한 형식인 경우 그대로 반환
			        }
			    }

			    for (let hospital of data) {
			        let openTimeFormatted = formatTime(hospital.openTime);
			        let closeTimeFormatted = formatTime(hospital.closeTime);
			        let detailAddressOri = hospital.detailAddress;
			        if (detailAddressOri == null) {
			        	detailAddressOri = "";
			        } 

			        dispHtml += "<tr>";
			        dispHtml += "<td>" + hospital.hosIdx + "</td>";
			        dispHtml += "<td><a href='hosDetail.do?hosIdx=" + hospital.hosIdx + "'>" + hospital.hosName + "</a></td>";
			        dispHtml += "<td>" + hospital.roadAddressName + " " + detailAddressOri + "</td>";
			        dispHtml += "<td>" + openTimeFormatted + " - " + closeTimeFormatted + "</td>";
			        dispHtml += "<td>" + hospital.hosPhone + "</td>";
			        dispHtml += "<td>" + hospital.animal + "</td>";
			        dispHtml += "</tr>";
			    }

			    console.log('Final HTML:', dispHtml);

			    
			    $("#listDisp").html(dispHtml);
	        },
	        error: function() {
	        	alert("실패");
	        }
	    });
	}

</script>
<style>
	#hosTitle {
		background-color: #B6E5FF;
	}
</style>
</head>
<body>
<%-- \${hosList} : ${hosList } --%>
	<div class="container">
		
		<h1>병원 검색</h1>
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
	<table class="table">
		<thead>
			<tr id="hosTitle">
				<th width="50">번호</th>
				<th width="150">병원명</th>
				<th width="300">주소</th>
				<th width="150">진료시간</th>
				<th width="150">전화번호</th>
				<th width="30">분류</th>
			</tr>
		</thead>
		
		<c:set var="hasCompletedPayment" value="false" scope="page" />
		<tbody id="listDisp">
			<c:forEach var="hospital" items="${hosList }">
				<c:choose>
					<c:when test="${hospital.condition == '결제완료'}">
						<c:set var="hasCompletedPayment" value="true" scope="page"/>
						<tr>
							<td>${hospital.hosIdx}</td>
							<td>
								<a href="hosDetail.do?hosIdx=${hospital.hosIdx}">${hospital.hosName}</a>
							</td>
							<td>${hospital.roadAddressName} ${hospital.detailAddress}</td>
							<td>
								<c:set var="openTime" value="${hospital.openTime}"/>
								<c:set var="openTimeSub" value="${fn:substring(openTime, 0, 5)}"/>
								<c:set var="closeTime" value="${hospital.closeTime}"/>
								<c:set var="closeTimeSub" value="${fn:substring(closeTime, 0, 5)}"/>
								<c:choose>
						            <c:when test="${openTimeSub == '00:00' and closeTimeSub == '23:59'}">
						                24시
						            </c:when>
						            <c:otherwise>
						                ${openTimeSub} - ${closeTimeSub}
						            </c:otherwise>
						        </c:choose>
																
							</td>
							<td>${hospital.hosPhone}</td>
							<td>${hospital.animal}</td>
						</tr>
					</c:when>
				</c:choose>
			</c:forEach>
			
			<c:if test="${not hasCompletedPayment}">
				<tr>
					<th colspan="6">예약 가능한 병원이 없습니다.</th>
				</tr>
			</c:if>
		</tbody>
	</table>
	</div>
</body>
</html>