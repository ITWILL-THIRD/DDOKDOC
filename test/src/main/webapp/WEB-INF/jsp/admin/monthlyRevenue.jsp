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
<body>
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
</body>
</html>