<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정별 결제내역</title>
</head>
<body>
	<c:choose>
		<c:when test="${empty payments}">
			<p>입력한 계정에 대한 결제 내역이 없습니다.</p>
		</c:when>
		<c:otherwise>
				<table>
					<tr>
						<th>계정</th>
						<th>이름</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>결제금액</th>
					</tr>
					<c:forEach var="payment" items="${payments}" varStatus="status">
						<tr>
							<td>
								<c:if test="${type == 'hospital'}">${payment.hosId}</c:if>
								<c:if test="${type == 'user'}">${payment.email}</c:if>
							</td>
							<td>
								<c:if test="${type == 'hospital'}">${payment.hosName}</c:if>
								<c:if test="${type == 'user'}">${payment.name}</c:if>
							</td>
							<td>
			                    <c:if test="${type == 'hospital'}">
			                        <fmt:formatDate value="${payment.hosStart}" pattern="yyyy-MM-dd"/>
			                    </c:if>
			                    <c:if test="${type == 'user'}">
			                        <fmt:formatDate value="${payment.memStart}" pattern="yyyy-MM-dd"/>
			                    </c:if>
							</td>
			                <td>
			                    <c:if test="${type == 'hospital'}">
			                        <fmt:formatDate value="${payment.hosEnd}" pattern="yyyy-MM-dd"/>
			                    </c:if>
			                    <c:if test="${type == 'user'}">
			                        <fmt:formatDate value="${payment.memEnd}" pattern="yyyy-MM-dd"/>
			                    </c:if>
			                </td>
							<td><fmt:formatNumber value="${payment.amount}" pattern="#,###"/></td>
						</tr>
						<c:if test="${status.last}">
							<tr>
								<td colspan="5">총 결제금액: <fmt:formatNumber value="${payment.totalAmount}" pattern="#,###"/>원</td>
							</tr>
						</c:if>
					</c:forEach>
				</table>
		</c:otherwise>
	</c:choose>
</body>
</html>