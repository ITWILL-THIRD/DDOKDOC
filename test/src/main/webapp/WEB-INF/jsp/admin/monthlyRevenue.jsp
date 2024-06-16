<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 수익 통계</title>
</head>
	<c:choose>
		<c:when test="${empty revenue}">
			<p>지정된 기간 내에 수익 데이터가 없습니다.</p>
		</c:when>
		<c:otherwise>
			<table>
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
</html>