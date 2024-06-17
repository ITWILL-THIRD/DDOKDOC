<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 수익 통계</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
	<c:choose>
		<c:when test="${empty revenue}">
			<p>지정된 기간 내에 데이터가 없습니다.</p>
		</c:when>
		<c:otherwise>
			<table style="display:none;">
				<tr>
					<th>월</th>
					<th>수익</th>
				</tr>
				<c:forEach var="item" items="${revenue}">
					<tr>
						<td>${item.MONTH}</td>
						<td><fmt:formatNumber value="${item.TOTAL_PAY}" pattern="#,###"/></td>
					</tr>
				</c:forEach>
			</table>
		</c:otherwise>
	</c:choose>
</body>
</html>