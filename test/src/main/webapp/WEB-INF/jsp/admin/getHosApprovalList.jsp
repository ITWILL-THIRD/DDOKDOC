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
	function approval(frm, hosIdx) {
		if(confirm('승인 수락하시겠습니까?')) {
			let firstForm = document.forms[0];
			console.log(firstForm.elements);
// 			console.log(firstFrom.)
			
			location.href = "approvalBtn.do?hosIdx=" + hosIdx;
		}
		
		
	}
</script>
</head>
<body>
<div id="container">
	<h1>병원 승인 관리 [getApprovalList.jsp]</h1>   
\${beginDate} : ${beginDate}<br>  
\${endDate} : ${endDate}<br>  
\${condition} : ${condition}<br><hr> 	
	<!-- 검색 -->
	<form action="getHosApprovalList.do?cPage=${pagingVO.nowPage}" method="post">
	<table class="border-none">
		<tr><td>
			<input type="date" name="beginDate">~
			<input type="date" name="endDate">
			<input type="submit" value="검색" class="searchBtn">
		</td></tr>
	</table>
	<div id="condition" class="center" >
		<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage}&condition=all">전체</a>
		<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage}&condition=before">승인전</a>
		<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage}&condition=after">승인완료</a>
		<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage}&condition=payment">결제완료</a>
	</div>
	</form>
	
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
		<tbody>
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
				<td class="center">${hospital.condition}</td>
				<td class="center">
					<input type="button" class="approvalBtn" value="수락"
						data-hos-idx="${hospital.hosIdx}" onclick="approval(this.form, this.dataset.hosIdx)">
					<input type="hidden" name="hosIdx" value="${hospital.hosIdx}">
				</td>
			</tr>
		</c:forEach>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="9">
				<ol>
					<%--[이전]에 대한 사용여부 처리 --%>
					<c:if test="${pagingVO.nowPage == 1}">
						<li class="disable">이전</li>
					</c:if>
					<c:if test="${pagingVO.nowPage != 1}">
						<c:if test="${empty condition && empty beginDate && empty endDate}">
							<li>
								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}">이전</a>
							</li>
						</c:if>
					</c:if>
						
					<%--블록내에 표시할 페이지 태그 작성(시작~끝) --%>
					<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}">
					<c:choose>
						<c:when test="${pageNo == pagingVO.nowPage}">
							<li class="now">${pageNo}</li>
						</c:when>
						<c:otherwise>
							<c:if test="${empty condition && empty beginDate && empty endDate}">
								<li>
									<a href="getHosApprovalList.do?cPage=${pageNo}">${pageNo}</a>
								</li>
							</c:if>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					
					<%--[다음]에 대한 사용여부 처리 --%>
					<c:if test="${pagingVO.nowPage < pagingVO.totalPage}">
						<c:if test="${empty condition && empty beginDate && empty endDate}">
							<li>
								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}">다음</a>
							</li>
						</c:if>
					</c:if>
					<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}">
						<li class="disable">다음</li>
					</c:if>
				</ol>
				</td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td colspan="9"> -->
<!-- 					<ol> -->
<%-- 					[이전]에 대한 사용여부 처리 --%>
<%-- 					<c:if test="${pagingVO.nowPage == 1}"> --%>
<!-- 						<li class="disable">이전</li> -->
<%-- 					</c:if> --%>
<%-- 					<c:if test="${pagingVO.nowPage != 1}"> --%>
<%-- 						<c:if test="${not empty condition}"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${condition == 'before'}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}&condition=before">이전</a> --%>
<!-- 								</li> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${condition == 'after'}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}&condition=after">이전</a> --%>
<!-- 								</li> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${condition == 'payment'}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}&condition=payment">이전</a> --%>
<!-- 								</li> -->
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}&condition=all">이전</a> --%>
<!-- 								</li> -->
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${not empty beginDate && not empty endDate}"> --%>
<!-- 							<li> -->
<%-- 								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}&beginDate=${beginDate}&endDate=${endDate}">이전</a> --%>
<!-- 							</li> -->
<%-- 						</c:if> --%>
<%-- 						<c:if test="${empty condition && empty beginDate && empty endDate}"> --%>
<!-- 							<li> -->
<%-- 								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage - 1}">이전</a> --%>
<!-- 							</li> -->
<%-- 						</c:if> --%>
<%-- 					</c:if> --%>
						
<%-- 					블록내에 표시할 페이지 태그 작성(시작~끝) --%>
<%-- 					<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}"> --%>
<%-- 					<c:choose> --%>
<%-- 						<c:when test="${pageNo == pagingVO.nowPage}"> --%>
<%-- 							<li class="now">${pageNo}</li> --%>
<%-- 						</c:when> --%>
<%-- 						<c:otherwise> --%>
<%-- 							<c:if test="${not empty condition}"> --%>
<%-- 							<c:choose> --%>
<%-- 								<c:when test="${condition == 'before'}"> --%>
<!-- 									<li> -->
<%-- 										<a href="getHosApprovalList.do?cPage=${pageNo}&condition=after">${pageNo}</a> --%>
<!-- 									</li> -->
<%-- 								</c:when> --%>
<%-- 								<c:when test="${condition == 'after'}"> --%>
<!-- 									<li> -->
<%-- 										<a href="getHosApprovalList.do?cPage=${pageNo}&condition=after">${pageNo}</a> --%>
<!-- 									</li> -->
<%-- 								</c:when> --%>
<%-- 								<c:when test="${condition == 'payment'}"> --%>
<!-- 									<li> -->
<%-- 										<a href="getHosApprovalList.do?cPage=${pageNo}&condition=payment">${pageNo}</a> --%>
<!-- 									</li> -->
<%-- 								</c:when> --%>
<%-- 								<c:otherwise> --%>
<!-- 									<li> -->
<%-- 										<a href="getHosApprovalList.do?cPage=${pageNo}&condition=all">${pageNo}</a> --%>
<!-- 									</li> -->
<%-- 								</c:otherwise> --%>
<%-- 							</c:choose> --%>
<%-- 							</c:if> --%>
<%-- 							<c:if test="${not empty beginDate && not empty endDate}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pageNo}&beginDate=${beginDate}&endDate=${endDate}">${pageNo}</a> --%>
<!-- 								</li> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test="${empty condition && empty beginDate && empty endDate}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pageNo}">${pageNo}</a> --%>
<!-- 								</li> -->
<%-- 							</c:if> --%>
<%-- 						</c:otherwise> --%>
<%-- 					</c:choose> --%>
<%-- 					</c:forEach> --%>
					
<%-- 					[다음]에 대한 사용여부 처리 --%>
<%-- 					<c:if test="${pagingVO.nowPage < pagingVO.totalPage}"> --%>
<%-- 						<c:if test="${not empty condition}"> --%>
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${condition == 'before'}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}&condition=before">다음</a> --%>
<!-- 								</li> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${condition == 'after'}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}&condition=after">다음</a> --%>
<!-- 								</li> -->
<%-- 							</c:when> --%>
<%-- 							<c:when test="${condition == 'payment'}"> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}&condition=payment">다음</a> --%>
<!-- 								</li> -->
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<!-- 								<li> -->
<%-- 									<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}&condition=all">다음</a> --%>
<!-- 								</li> -->
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
<%-- 						</c:if> --%>
<%-- 						<c:if test="${not empty beginDate && not empty endDate}"> --%>
<!-- 							<li> -->
<%-- 								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}&beginDate=${beginDate}&endDate=${endDate}">다음</a> --%>
<!-- 							</li> -->
<%-- 						</c:if> --%>
<%-- 						<c:if test="${empty condition && empty beginDate && empty endDate}"> --%>
<!-- 							<li> -->
<%-- 								<a href="getHosApprovalList.do?cPage=${pagingVO.nowPage + 1}">다음</a> --%>
<!-- 							</li> -->
<%-- 						</c:if> --%>
<%-- 					</c:if> --%>
<%-- 					<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}"> --%>
<!-- 						<li class="disable">다음</li> -->
<%-- 					</c:if> --%>
<!-- 					</ol> -->
<!-- 				</td> -->
<!-- 			</tr> -->
			
		</tfoot>
	</table>
</div>
\${pagingVO} : ${pagingVO}<br><hr>
\${hosList} : ${hosList}<br>  
</body>
</html>
