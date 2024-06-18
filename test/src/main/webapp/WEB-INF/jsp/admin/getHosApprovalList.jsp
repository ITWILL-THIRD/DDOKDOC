<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 병원 승인 페이지 [approvalPage.jsp]</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<jsp:include page="../../css/hosApprovalListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<script>
// 	window.onload = function() {
// 		const urlParams = new URLSearchParams(window.location.search);
// 		const msg = urlParams.get('msg');
// 		if (msg === 'sucess') {
// 			alert('승인 처리했습니다.');
// 		} else if (msg === 'fail') {
// 			alert('승인 처리를 실패했습니다.');
// 		}
// 	};
	
	function approval(frm, hosIdx, condition) {
		//승인전, 승인완료, 결제완료 상태 확인 후, 승인전 -> 승인완료 변경 처리!
		console.log("hosIdx : " + hosIdx + ", condition : " + condition);
		
		if (condition == '승인전') {
			if (confirm('승인 수락하시겠습니까?')) {
				location.href = "approvalPro.do?hosIdx=" + hosIdx;
		    }
		} else if (condition == '승인완료') {
			alert('이미 승인 처리된 병원입니다!');
		} else if (condition == '결제완료') {
			alert('이미 결제 완료된 병원입니다!\n이전 단계로(승인완료) 변경할 수 없습니다.');
		}
	}
	//동적 검색 ajax - 오류 중단
// 	function searchData(category) {
// 		let vo = {};
// 		vo.searchCondition = category;
// 		vo.beginDate = document.querySelector("input[name='beginDate']").value;
// 		vo.endDate = document.querySelector("input[name='endDate']").value;

// 		$.ajax("getHosApprovalSearch.do", { 
// 	        type: 'GET',
// 	        data: vo,
// 	        success: function(data) {
// 	        	$("#listDisp").empty();
 
// 			    let dispHtml = "";

// 			    for (let hospital of data) {
// 			    	let openTimeSub = hospital.openTime.substring(0, 5);
// 			    	let closeTimeSub = hospital.closeTime.substring(0, 5);
			    	
// 			        dispHtml += "<tr>";
// 			        dispHtml += "<td class='center'>" + hospital.hosIdx + "</td>";
// 			        dispHtml += "<td class='center'>" + hospital.animal + "</td>";
// 			        dispHtml += "<td class='center'><a href='../hospital/hosDetail.do?hosIdx=" + hospital.hosIdx + "'>" + hospital.hosName + "</a></td>";
// 			        dispHtml += "<td class='center'>" + hospital.roadAddressName + " " + ${hospital.detailAddress} + "</td>";
// 			        dispHtml += "<td class='center'>" + openTimeSub + " - " + closeTimeSub + "</td>";
// 			        dispHtml += "<td class='center'>" + hospital.hosPhone + "</td>";
// 			        dispHtml += "<td class='center' id='fileLink'><a href='" + hospital.certificateImg + "'" + " target='_blank'>파일 </a></td>";
// 			        dispHtml += "<td class='center'>" + hospital.hosPhone + "</td>";
// 			        dispHtml += "<td class='center'>" + hospital.condition + "</td>";
// 			        dispHtml += "<td class='center'><input type='button' class='approvalBtn' value='수락' data-hos-idx='"
// 			        			+  hospital.hosIdx + "' onclick='approval(this.form, this.dataset.hosIdx)'>";
//         			dispHtml += "<input type='hidden' name='hosIdx' value='" + hospital.hosIdx + "'></td>";
// 			        dispHtml += "</tr>";
// 			    }
// 			    console.log('Final HTML:', dispHtml);
			    
// 			    $("#listDisp").html(dispHtml);
// 	        },
// 	        error : function(jqXHR, textStatus, errorThrown){
// 	            alert("Ajax 처리 실패:\n" +
// 	                      "jqXHR.readyState: " + jqXHR.readyState + "\n" +
// 	                      "textStatus: " + textStatus + "\n" +
// 	                      "errorThrown: " + errorThrown);
// 	        }
// 	    });
// 	}
</script>
</head>
<body>
<div id="container">
	<h1>병원 승인 관리 [getApprovalList.jsp]</h1> 
\${pagingVO} : ${pagingVO}<br><hr>  
\${beginDate} : ${beginDate}<br>  
\${endDate} : ${endDate}<br>  
\${searchCondition} : ${searchCondition}<br><hr> 	
	<!-- 검색 -->
	<form action="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&beginDate=${beginDate}&endDate=${endDate}" method="post">
<!-- 	<form id="getDateSearch" onsubmit="searchData('date'); return false;"> -->
	<table class="border-none">
		<tr><td>
			<input type="date" name="beginDate">~
			<input type="date" name="endDate">
			<input type="submit" value="검색" class="searchBtn">
			<input type="hidden" id="hospitalListInput" name="hospitalOpenTimeList">
		</td></tr>
	</table>
	</form>
	<form>
	<div id="getConditionSearch" class="center">
<!-- 		<input type="button" onclick="searchData('all')" value="전체"> -->
<!-- 		<input type="button" onclick="searchData('before')" value="승인전"> -->
<!-- 		<input type="button" onclick="searchData('after')" value="승인완료"> -->
<!-- 		<input type="button" onclick="searchData('payment')" value="결제완료"> -->
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=all">전체</a>
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=before">승인전</a>
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=after">승인완료</a>
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=payment">결제완료</a>
	</div>
	
	<!-- 데이터 표시 -->
	<table>
		<thead>
			<tr>
				<th width="70">번호</th>
				<th width="70">분류</th>
				<th width="300">병원명</th>
				<th width="500">주소</th>
				<th width="200">진료시간</th>
				<th width="250">전화번호</th>
				<th width="200">사업자 등록증</th>
				<th width="150">승인 상태</th>
				<th width="100">승인 관리</th>
			</tr>
		</thead>
		<tbody id="listDisp">
		<c:forEach var="hospital" items="${hosList}">
			<tr>
				<td class="center">${hospital['hosIdx'] }</td>
				<td class="center">${hospital.animal }</td>
				<td class="center"><a href="../hospital/hosDetail.do?hosIdx=${hospital.hosIdx}">${hospital.hosName }</a></td>
				<td class="center">${hospital.roadAddressName} ${hospital.detailAddress}</td>
				<c:set var="openTime" value="${hospital.openTime}"/>
				<c:set var="openTimeSub" value="${fn:substring(openTime, 0, 5)}"/>
				<c:set var="closeTime" value="${hospital.closeTime}"/>
				<c:set var="closeTimeSub" value="${fn:substring(closeTime, 0, 5)}"/>
				<td class="center">${openTimeSub} - ${closeTimeSub}</td>
				<td class="center">${hospital.hosPhone }</td>
				<td class="center" id="fileLink">
					<a href="${hospital.certificateImg}" target="_blank">파일</a>
				</td>
				<td class="center" id="condition">${hospital.condition}</td>
				<td class="center">
					<input type="button" class="approvalBtn" value="수락"
						data-hos-idx="${hospital.hosIdx}" data-condition="${hospital.condition}" onclick="approval(this.form, this.dataset.hosIdx, this.dataset.condition)">
					<input type="hidden" name="hospital" value="${hospital}">
					<input type="hidden" name="condition" value="${hospital.condition}">
				</td>
			</tr>
		</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="9">
					<!-- [이전]에 대한 사용여부 처리 -->
					<c:if test="${pagingVO.nowPage == 1}">
						<span class="disable">이전</span>
					</c:if>
					<c:if test="${pagingVO.nowPage != 1}">
						<c:if test="${not empty searchCondition}">
						<c:choose>
							<c:when test="${searchCondition == 'before'}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage - 1}&searchCondition=before">이전</a>
								</span>
							</c:when>
							<c:when test="${searchCondition == 'after'}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage - 1}&searchCondition=after">이전</a>
								</span>
							</c:when>
							<c:when test="${searchCondition == 'payment'}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage - 1}&searchCondition=payment">이전</a>
								</span>
							</c:when>
							<c:otherwise>
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage - 1}&searchCondition=all">이전</a>
								</span>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${not empty beginDate && not empty endDate}">
							<span>
								<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage - 1}&beginDate=${beginDate}&endDate=${endDate}">이전</a>
							</span>
						</c:if>
						<c:if test="${empty searchCondition && empty beginDate && empty endDate}">
							<span>
								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}">이전</a>
							</span>
						</c:if>
					</c:if>
						
					<!-- 블록내에 표시할 페이지 태그 작성(시작~끝) -->
					<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}">
					<c:choose>
						<c:when test="${pageNo == pagingVO.nowPage}">
							<span class="now">${pageNo}</span>
						</c:when>
						<c:otherwise>
							<c:if test="${not empty searchCondition}">
							<c:choose>
								<c:when test="${searchCondition == 'before'}">
									<span>
										<a href="getHosApprovalSearch.do?cPage=${pageNo}&searchCondition=after">${pageNo}</a>
									</span>
								</c:when>
								<c:when test="${searchCondition == 'after'}">
									<span>
										<a href="getHosApprovalSearch.do?cPage=${pageNo}&searchCondition=after">${pageNo}</a>
									</span>
								</c:when>
								<c:when test="${searchCondition == 'payment'}">
									<span>
										<a href="getHosApprovalSearch.do?cPage=${pageNo}&searchCondition=payment">${pageNo}</a>
									</span>
								</c:when>
								<c:otherwise>
									<span>
										<a href="getHosApprovalSearch.do?cPage=${pageNo}&searchCondition=all">${pageNo}</a>
									</span>
								</c:otherwise>
							</c:choose>
							</c:if>
							<c:if test="${not empty beginDate && not empty endDate}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pageNo}&beginDate=${beginDate}&endDate=${endDate}">${pageNo}</a>
								</span>
							</c:if>
							<c:if test="${empty searchCondition && empty beginDate && empty endDate}">
								<span>
									<a href="getHosApprovalList.do?cPage=${pageNo}">${pageNo}</a>
								</span>
							</c:if>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					
					<!-- [다음]에 대한 사용여부 처리 -->
					<c:if test="${pagingVO.nowPage < pagingVO.totalPage}">
						<c:if test="${not empty searchCondition}">
						<c:choose>
							<c:when test="${searchCondition == 'before'}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage + 1}&searchCondition=before">다음</a>
								</span>
							</c:when>
							<c:when test="${searchCondition == 'after'}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage + 1}&searchCondition=after">다음</a>
								</span>
							</c:when>
							<c:when test="${searchCondition == 'payment'}">
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage + 1}&searchCondition=payment">다음</a>
								</span>
							</c:when>
							<c:otherwise>
								<span>
									<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage + 1}&searchCondition=all">다음</a>
								</span>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${not empty beginDate && not empty endDate}">
							<span>
								<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage + 1}&beginDate=${beginDate}&endDate=${endDate}">다음</a>
							</span>
						</c:if>
						<c:if test="${empty searchCondition && empty beginDate && empty endDate}">
							<span>
								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}">다음</a>
							</span>
						</c:if>
					</c:if>
					<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}">
						<span class="disable">다음</span>
					</c:if>
				</td>
			</tr>
			<!-- 			<tr> -->
<!-- 				<td colspan="9"> -->
<%-- 					[이전]에 대한 사용여부 처리 --%>
<%-- 					<c:if test="${pagingVO.nowPage == 1}"> --%>
<!-- 						<span class="disable">이전</span> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${pagingVO.nowPage != 1}"> --%>
<%-- 						<c:if test="${empty condition && empty beginDate && empty endDate}"> --%>
<!-- 							<span> -->
<%-- 								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}">이전</a> --%>
<!-- 							</span> -->
<%-- 						</c:if> --%>
<%-- 					</c:if> --%>
						
<%-- 					블록내에 표시할 페이지 태그 작성(시작~끝) --%>
<%-- 					<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}"> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${pageNo == pagingVO.nowPage}"> --%>
<%-- 							<span class="now">${pageNo}</span> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<c:if test="${empty condition && empty beginDate && empty endDate}"> --%>
<!-- 								<span> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pageNo}">${pageNo}</a> --%>
<!-- 								</span> -->
<%-- 							</c:if> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 					</c:forEach> --%>
					
<%-- 					[다음]에 대한 사용여부 처리 --%>
<%-- 					<c:if test="${pagingVO.nowPage < pagingVO.totalPage}"> --%>
<%-- 						<c:if test="${empty condition && empty beginDate && empty endDate}"> --%>
<!-- 							<span> -->
<%-- 								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}">다음</a> --%>
<!-- 							</span> -->
<%-- 						</c:if> --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}"> --%>
<!-- 						<span class="disable">다음</span> -->
<%-- 					</c:if> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
		</tfoot>
	</table>
	</form>
</div>

\${hosList} : ${hosList}<br>  
</body>
</html>
