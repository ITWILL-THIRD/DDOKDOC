<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 병원 승인 페이지 [approvalPage.jsp]</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<jsp:include page="../../css/approvalListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<%-- \${hosList} : ${hosList}<br> --%>
<div id="container">
	<h1>병원 승인 관리 [getApprovalList.jsp]</h1>   
	
	<!-- 검색 -->
	
	
	<!-- 데이터 표시 -->
	<table>
		<thead>
			<tr>
				<th width="20">병원번호</th>
				<th width="20">분류</th>
				<th width="30">병원명</th>
				<th width="30">주소</th>
				<th width="30">진료시간</th>
				<th width="20">전화번호</th>
				<th width="20">사업자 등록증</th>
				<th width="20">승인 단계</th>
				<th width="20">비고</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="hospital" items="${hosList}">
			<tr>
				<td class="center">${hospital['hosIdx'] }</td>
				<td class="center">${hospital.animal }</td>
				<td class="center">${hospital.hosName }</td>
				<td class="center">${hospital.roadAddressName} ${hospital.detailAddress}</td>
				<td class="center">${hospital.openTime} - ${hospital.closeTime}</td>
				<td class="center">${hospital.hosPhone }</td>
				<td class="center">${hospital.certificateImg}</td>
				<td class="center">${hospital.condition}</td>
				<td class="center"><input type="button" value="승인 처리"></td>
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
</div>
  
</body>
</html>
