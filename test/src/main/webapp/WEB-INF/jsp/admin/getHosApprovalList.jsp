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
	$(document).ready(function() {
	    // 모든 approvalBtn 버튼에 대해
	    $('.approvalBtn').each(function() {
	        var condition = $(this).data('condition');
	        
	        // condition 값에 따라 클래스 추가
	        if (condition === '결제완료') {
	            $(this).addClass('condition-payment');
	        	$(this).val('결제완료');
	        } else if (condition === '승인전') {
	            $(this).addClass('condition-before');
	            $(this).val('승인수락');
	        } else if (condition === '승인완료') {
	            $(this).addClass('condition-after');
	            $(this).val('승인취소');
	        }
	    });
	});

	function approval(frm, hosIdx, condition, hosName) {
		//토글(승인전 <-> 승인완료) 처리
		if (condition == '결제완료') {
			alert('이미 결제 완료된 [' + hosName + '] 병원입니다!\n이전 단계로(승인완료) 변경할 수 없습니다.');
		} else if (condition == '승인전') {
			if (confirm('[' + hosName + '] 병원 "승인완료" 처리하시겠습니까?')) {
				location.href = "approvalPro.do?hosIdx=" + hosIdx;
		    }
		} else if (condition == '승인완료') {
			if (confirm('이미 승인된 [' + hosName + '] 병원입니다.\n"승인전" 상태로 변경하시겠습니까?')) {
				location.href = "approvalBeforePro.do?hosIdx=" + hosIdx;
			}
		}
	}
</script>
<style>
/* 	#container { width: 1100px; margin: auto; } */
/* 	h1, h3, p { text-align: center; } */
<%-- 	<%-- 목록 --%> --%>
/* 	table { */
/* 		border-collapse: collapse; */
/* 		margin-left:auto;margin-right:auto; */
/* 		margin-top: 23px; */
/* 	} */
/* 	table th, table td { */
/* 		position: static; */
/* 		text-align: center; */
/* 		margin: auto; */
/* 		padding: 5px; */
/* 		border: 1px #B9B9B9 solid; */
/* 		border-collapse: collapse; */
/* 	} */
	
/* 	table th:first-child, */
/* 	table td:first-child { */
/* 		border-left: 0; */
/* 	} */
	
/* 	table th:last-child, */
/* 	table td:last-child { */
/* 		border-right: 0; */
/* 	} */
/* 	th {  */
/* 		background-color: #E0EAF5; */
/* 	} */
/* 	tbody {border-bottom-style: hidden; } */
/* 	.center { text-align: center; } */
/* 	.border-none, .border-none td { border: none; } */
	
<%-- 	<%-- 버튼 --%> --%>
/*     .btn { */
/*     	border-radius: 5px; */
/*     	background-color: #2C307D; */
/*     	padding: 7px 18px; */
/*     	border: none; */
/*     	cursor: pointer; */
/*     	color: #FFFFFF; */
/*     	text-decoration: none; */
/*     	display: inline-block; */
/*     	border: 1px solid #2C307D; */
/*     } */
/*     .btn:hover { */
/*     	background-color: #FFFFFF; */
/*     	color: #2C307D; */
/*     	border: 1px solid #2C307D; */
/*     } */
/*     /* 버튼 정렬 */ */
/* 	.row, #searchDate { */
/* 		display: flex; */
/* 		gap: 10px; */
/* 		justify-content: center; */
/* 		align-items: center; */
/* 	} */
/* 	.row { */
/* 		padding: 10px 0; */
/* 	} */
<%-- 	<%-- 버튼 배경색 변경 --%> --%>
/*     .btn.active { */
/*         background-color: #FFFFFF; */
/*         color: #2C307D; */
/*     	border: 1px solid #2C307D; 	 */
/*     } */
/* 	hr { */
/*   		border: 1px solid #2C307D; */
/*   	} */
<%-- 	<%-- 제목 링크 --%> --%>
/* 	a {	 */
/* 		color: #2C307D; */
/* 		font-weight: bold; */
/* 		text-decoration: none; */
/* 	} */
/* 	a[href^="getHosApprovalSearch.do"] { */
/* 		margin: 0 10px 0 10px; */
/* 		font-size:  1rem;  */
/* 	} */
/* 	a:hover {color:#FFA217;} */
/* 	.paging {border-top-style: hidden; } */
/* 	.paging a { */
/* 		color: #2C307D; */
/* 		font-weight: normal; */
/* 	} */
/* 	.paging a:hover {color:#FFA217;} */
/* 	a.none { */
/*     	color: #2C307D; */
/*     } */
/* 	#getConditionSearch { */
/* 		padding-bottom : 5px; */
/* 	} */
<%-- 	<%-- 승인버튼 동적 작용 --%> --%>
/* 	.condition-payment { */
/* 		border-radius: 5px; */
/*     	background-color: #2C307D; */
/*     	padding: 7px 18px; */
/*     	border: none; */
/*     	cursor: pointer; */
/*     	color: #FFFFFF; */
/*     	text-decoration: none; */
/*     	display: inline-block; */
/*     	border: 1px solid #2C307D; */
/*     } */
/*     .condition-payment:hover { */
/*     	background-color: #FFFFFF; */
/*     	color: #2C307D; */
/*     	border: 1px solid #2C307D; */
/*     } */
/*     .condition-before { */
/*     	border-radius: 5px; */
/*     	background-color: #FFA217; */
/*     	padding: 7px 18px; */
/*     	border: none; */
/*     	cursor: pointer; */
/*     	color: #FFFFFF; */
/*     	text-decoration: none; */
/*     	display: inline-block; */
/*     	border: 1px solid #FFA217; */
/*     } */
/*     .condition-before:hover { */
/*     	background-color: #FFFFFF; */
/*     	color: #2C307D; */
/*     	border: 1px solid #2C307D; */
/*     } */
/*     .condition-after { */
/*         border-radius: 5px; */
/*     	background-color: #B8DAFF; */
/*     	padding: 7px 18px; */
/*     	border: none; */
/*     	cursor: pointer; */
/*     	color: #FFFFFF; */
/*     	text-decoration: none; */
/*     	display: inline-block; */
/*     	border: 1px solid #B8DAFF; */
/*     } */
/*     .condition-after:hover { */
/*     	background-color: #FFFFFF; */
/*     	color: #2C307D; */
/*     	border: 1px solid #2C307D; */
/*     } */
/*     /* 	페이징 */ */
/* 	#paging td { */
/* 		padding-top: 15px; */
/* 	} */
/* 	#paging span{ */
/* 		margin: 0 20px 0 20px; */
/* 	} */
</style>
</head>
<body>
<div id="container">
	<h1>병원 승인 관리</h1> 
<%-- \${pagingVO} : ${pagingVO}<br><hr>   --%>
<%-- \${beginDate} : ${beginDate}<br>   --%>
<%-- \${endDate} : ${endDate}<br>   --%>
<%-- \${searchCondition} : ${searchCondition}<br><hr> 	 --%>
	<!-- 검색 -->
	<form method="post">
	<div id="getConditionSearch" class="center">
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=all">전체</a>
		<a class="none">|</a>
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=before">승인전</a>
		<a class="none">|</a>
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=after">승인완료</a>
		<a class="none">|</a>
		<a href="getHosApprovalSearch.do?cPage=${pagingVO.nowPage}&searchCondition=payment">결제완료</a>
	</div>
	<hr>
	<!-- 데이터 표시 -->
	<table border frame=void >
		<thead>
			<tr>
				<th width="70">번호</th>
				<th width="70">분류</th>
				<th width="300">병원명</th>
				<th width="500">주소</th>
				<th width="200">진료시간</th>
				<th width="250">전화번호</th>
				<th width="200">사업자 등록증</th>
				<th width="150">상태</th>
				<th width="150">승인 관리</th>
			</tr>
		</thead>
		<c:set var="hasSearchHos" value="false" scope="page"/>
		<tbody id="listDisp">
		<c:forEach var="hospital" items="${hosList}">
			<c:set var="hasSearchHos" value="true" scope="page"/>
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
					<input type="button" class="approvalBtn"
						data-hos-idx="${hospital.hosIdx}" 
						data-condition="${hospital.condition}"
						data-hos-name="${hospital.hosName}" 
						onclick="approval(this.form, this.dataset.hosIdx, this.dataset.condition, this.dataset.hosName)">
					<input type="hidden" name="hospital" value="${hospital}">
				</td>
			</tr>
		</c:forEach>
		
		<c:if test="${not hasSearchHos}">
			<tr>
				<td colspan="9">검색 결과가 없습니다.</td>
			</tr>
		</c:if>
		</tbody>
		
		<tfoot id="paging">
<!-- 		페이징 표시 없음 처리 -->
<%-- 			<c:set var="hasPage" value="false" scope="page"/> --%>
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
			
		</tfoot>
	</table>
	</form>
</div>

<%-- \${hosList} : ${hosList}<br>   --%>
</body>
</html>
