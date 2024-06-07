<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 예약 내역</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<%-- \${myReserList } : ${myReserList }<br><br>
\${myOldReserList } : ${myOldReserList }<br><br>
\${myCancleReserList } : ${myCancleReserList }<br><br> --%>
	<h2>취소한 예약 내역 보기</h2>
	<table>
		<tr>
			<th>번호</th>
			<th>병원이름</th>
			<th>마이펫</th>
			<th>날짜</th>
			<th>시간</th>
			<th>예약변경/취소</th>
		</tr>
	<c:forEach var="reser" items="${myCancleReserList }">
		<tr>
			<td>${reser.rownum }</td>
			<td>${reser.hosName }</td>
			<td>${reser.petName }</td>
			<td>${reser.reserDate }</td>
			<td>${reser.formattedTime }</td>
			<td>
				<button onclick="reservationDetail(${reser.reserIdx})">상세보기</button>
			</td>
		</tr>
	</c:forEach>
	</table>
<script>
	function reservationDetail(reserIdx) {
		location.href="../reservation/reservationDetail.do?reserIdx=" + reserIdx;
	}
</script>
</body>
</html>