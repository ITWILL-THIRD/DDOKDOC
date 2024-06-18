<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입자 통계</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty stats}">
			<p>선택한 기간 내에 데이터가 없습니다.</p>
		</c:when>
		<c:otherwise>
		    <table style="display:none;">
		        <tr>
		            <th>기간</th>
		            <th>총 가입자</th>
		            <th>신규 가입자</th>
		            <th>증가율</th>
		        </tr>
		        <c:forEach var="stat" items="${stats}">
		            <tr>
		                <td>${stat.PERIOD}</td>
		                <td>
		                    <c:if test="${type == 'hospital'}">${stat.TOTALHOS}</c:if>
		                    <c:if test="${type == 'user'}">${stat.TOTALUSERS}</c:if>
		                </td>
		                <td>
		                    <c:if test="${type == 'hospital'}">${stat.NEWHOS}</c:if>
		                    <c:if test="${type == 'user'}">${stat.NEWUSERS}</c:if>
		                </td>
		                <td>
		                    <fmt:formatNumber value="${stat.GROWTHRATE}" pattern="##.##"/>%
		                </td>
		            </tr>
		        </c:forEach>
		    </table>
		</c:otherwise>
	</c:choose>
</body>
</html>