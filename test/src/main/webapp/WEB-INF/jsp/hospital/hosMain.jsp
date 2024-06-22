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
<jsp:include page="../../css/hosMainCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
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
	        success: function(response) {
	        	let data = response.hospitalList;
            	let pagingVO = response.pagingVO;
                
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
			    function formatOperatingHours(openTime, closeTime) {
		            if (openTime === "00:00:00" && closeTime === "23:59:00") {
		                return "24시간";
		            } else {
		                return formatTime(openTime) + " - " + formatTime(closeTime);
		            }
		        }
			    if (data.length === 0) {
	                // 검색 결과가 없을 경우
	                dispHtml = "<tr><td colspan='6'>검색 결과가 없습니다</td></tr>";
	            } else {
				    for (let hospital of data) {
				    	let operatingHours = formatOperatingHours(hospital.openTime, hospital.closeTime);
		                let detailAddressOri = hospital.detailAddress;
		                if (detailAddressOri == null) {
		                    detailAddressOri = "";
		                } 
// 				    	let openTimeFormatted = formatTime(hospital.openTime);
// 				        let closeTimeFormatted = formatTime(hospital.closeTime);
// 				        let detailAddressOri = hospital.detailAddress;
// 				        if (detailAddressOri == null) {
// 				        	detailAddressOri = "";
// 				        } 
	
				        dispHtml += "<tr>";
				        dispHtml += "<td>" + hospital.hosIdx + "</td>";
				        dispHtml += "<td><a href='hosDetail.do?hosIdx=" + hospital.hosIdx + "'>" + hospital.hosName + "</a></td>";
				        dispHtml += "<td>" + hospital.roadAddressName + " " + detailAddressOri + "</td>";
				        dispHtml += "<td>" + operatingHours  + "</td>";
// 				        dispHtml += "<td>" + openTimeFormatted + " - " + closeTimeFormatted + "</td>";
				        dispHtml += "<td>" + hospital.hosPhone + "</td>";
				        dispHtml += "<td>" + hospital.animal + "</td>";
				        dispHtml += "</tr>";
				    }
	            }
			    console.log('Final HTML:', dispHtml);
			    
			    $("#searchResults").html(dispHtml);
			    
			 // 페이징 처리
             let pagingHtml = "";
             //[이전]에 대한 사용여부 처리 
             if (pagingVO.nowPage == 1) {
                 pagingHtml += '<span class="disable">이전</span>';
             } else {
                 pagingHtml += '<span><a href="javascript:fetchData(\'' + category + '\', ' + (pagingVO.nowPage - 1) + ')">이전</a></span>';
             }

             for (let pageNo = pagingVO.beginPage; pageNo <= pagingVO.endPage; pageNo++) {
                 if (pageNo == pagingVO.nowPage) {
                     pagingHtml += '<span class="now">' + pageNo + '</span>';
                 } else {
                     pagingHtml += '<span><a href="javascript:fetchData(\'' + category + '\', ' + pageNo + ')">' + pageNo + '</a></span>';
                 }
             }

             if (pagingVO.nowPage < pagingVO.totalPage) {
                 pagingHtml += '<span><a href="javascript:fetchData(\'' + category + '\', ' + (pagingVO.nowPage + 1) + ')">다음</a></span>';
             } else {
                 pagingHtml += '<span class="disable">다음</span>';
             }

             $("#paging").html(pagingHtml);

			    
	        },
	        error: function() {
	        	console.error('Error fetching hospitals:', error);
	        	alert("실패");
	        }
	        
	    });
	}

</script>

</head>
<body>
<div class="container">
	<h1>병원 검색</h1>
	<!-- 검색 -->
	<form id="getAdSearch" onsubmit="fetchData('address'); return false;">
		<div class="center">
			<jsp:include page="partials/searchAdress.jsp"></jsp:include> 
			<input class="searchBtn" type="submit" value="검색">
		</div>
	</form>
	<form id="getHosSearch" onsubmit="fetchData('search'); return false;">
		<div class="center">
			<input class="search" type="text" name="searchKeyword" placeholder="통합검색" style="width:300px">
			<input class="searchBtn" type="submit" value="검색">
		</div>	
	</form>
	<div class="center">	
		<button class="btn" onclick="fetchData('all')">전체</button>
		<button class="none">|</button>
		<button class="btn" onclick="fetchData('common')">일반병원</button>
		<button class="none">|</button>
		<button class="btn" onclick="fetchData('special')">특수병원</button>
		<button class="none">|</button>
		<button class="btn" onclick="fetchData('night')">야간진료</button>
		<button class="none">|</button>
		<button class="btn" onclick="fetchData('24h')">24시</button>
	</div>	
	<hr>
	<!-- 데이터 표시 -->
	<table border frame=void>
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
		<tbody id="searchResults">
			<c:forEach var="hospital" items="${hosList }" varStatus="status">
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
						                24시간
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
		
<!-- 		페이징 표시 없음 처리 -->
		<tfoot id="paging">
			<tr>
				<td colspan="6">
					<!-- [이전]에 대한 사용여부 처리 -->
					<c:if test="${pagingVO.nowPage == 1}">
						<span class="disable">이전</span>
					</c:if>
					<c:if test="${pagingVO.nowPage != 1}">
						<span>
							<a href="hosMain.do?cPage=${pagingVO.nowPage - 1}">이전</a>
						</span>
					</c:if>
						
					<!-- 블록내에 표시할 페이지 태그 작성(시작~끝) -->
					<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}">
					<c:choose>
						<c:when test="${pageNo == pagingVO.nowPage}">
							<span class="now">${pageNo}</span>
						</c:when>
						<c:otherwise>
							<span>
								<a href="hosMain.do?cPage=${pageNo}">${pageNo}</a>
							</span>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					
					<!-- [다음]에 대한 사용여부 처리 -->
					<c:if test="${pagingVO.nowPage < pagingVO.totalPage}">
						<span>
							<a href="hosMain.do?cPage=${pagingVO.nowPage + 1}">다음</a>
						</span>
					</c:if>
					<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}">
						<span class="disable">다음</span>
					</c:if>
				</td>
			</tr>
		</tfoot>
	</table>
</div>
<%-- \${hosList} : ${hosList }<br><br> --%>
<%-- \${pagingVO} : ${pagingVO } --%>
</body>
</html>