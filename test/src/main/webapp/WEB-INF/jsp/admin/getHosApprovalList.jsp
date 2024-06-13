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
<%-- \${hosList} : ${hosList}<br> --%>
<div id="container">
	<h1>병원 승인 관리 [getApprovalList.jsp]</h1>   
	
	<!-- 검색 -->
	
	
	<!-- 데이터 표시 -->
	<form method="post">
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
					<a>이전</a><a>현재 번호</a><a>다음</a>
				</td>
			</tr>
			
		</tfoot>
	</table>
	</form>
</div>
  
</body>
</html>
