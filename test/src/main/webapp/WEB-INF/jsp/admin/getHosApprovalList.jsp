<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 승인 페이지</title>
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
	        } else {
	        	$(this).addClass('condition-none');
	            $(this).val('');
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
</head>
<body>
<div id="container">
	<h1>병원 승인 관리</h1> 
<%-- \${pagingVO} : ${pagingVO}<br><hr>   --%>
<%-- \${beginDate} : ${beginDate}<br>   --%>
<%-- \${endDate} : ${endDate}<br>   --%>
<%-- \${searchCondition} : ${searchCondition}<br><hr> 	 --%>
	<!-- 검색 -->
	<br>
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
	
	<script>
		document.addEventListener('DOMContentLoaded', (event) => {
	        // 현재 URL에서 searchCondition 값을 가져옵니다.
	        const params = new URLSearchParams(window.location.search);
	        const searchCondition = params.get('searchCondition') || 'all';
	        
	        // 모든 링크 요소를 가져옵니다.
	        const links = document.querySelectorAll('#getConditionSearch a');
	        
	        // 각 링크의 href 속성을 확인하여 searchCondition에 해당하는 경우 active 클래스를 추가합니다.
	        links.forEach(link => {
	            const url = new URL(link.href, window.location.origin);
	            if (url.searchParams.get('searchCondition') === searchCondition) {
	                link.classList.add('active');
	            }
	
	            // 링크 클릭 시 이벤트를 가로채서 기본 동작을 방지합니다.
	            link.addEventListener('click', (event) => {
	                event.preventDefault();
	                //alert(url.href); // 클릭한 링크의 URL을 출력합니다.
	                
	                const text = url.href;
	                const searchString = "todoc";


	                const result = extractStringAfter(text, searchString);
	                console.log(result);
	                
	                function extractStringAfter(text, searchString) {
	                    const index = text.indexOf(searchString);
	                    if (index === -1) {
	                        // searchString이 text에 없는 경우
	                        return null;
	                    }
	                    // 검색된 문자열의 끝 인덱스 이후의 문자열을 추출
	                    return text.slice(index + searchString.length);
	                }
	                // 여기서 원하는 동작을 수행
	                const locRef = ".." + result;
					location.href = locRef;
	            });
	        });
	    });
	</script>
	
	<hr>
	<!-- 데이터 표시 -->
	<table border frame=void >
		<thead>
			<tr>
				<th width="70">번호</th>
				<th width="70">분류</th>
				<th width="300">병원명</th>
				<th width="250">아이디</th>
				<th width="250">비밀번호</th>
<!-- 				<th width="500">주소</th> -->
				<th width="200">진료시간</th>
				<th width="250">전화번호</th>
				<th width="200">사업자 등록증</th>
				<th width="150">상태</th>
				<th width="150">관리</th>
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
				<td class="center">${hospital.hosId}</td>
				<td class="center">${hospital.hosPw}</td>
<%-- 				<td class="center">${hospital.roadAddressName} ${hospital.detailAddress}</td> --%>
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
				<td colspan="10">
<!-- 				<td colspan="9"> -->
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
