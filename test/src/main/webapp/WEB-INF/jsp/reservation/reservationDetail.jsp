<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 상세보기</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<%-- \${reservation } : ${reservation }<br>
\${hospital } : ${hospital }<br>
\${myPet } : ${myPet }<br>
\${user } : ${user }<br> --%>


	<h3>${user.name } 님의 예약입니다</h3>
	<table>
		<tr>
			<th>병원 이름</th>
			<td>${hospital.hosName }</td>
		</tr>
		<tr>
			<th>예약일</th>
			<td>${reservation.reserDate }</td>
		</tr>
		<tr>
			<th>예약시간</th>
			<td>${reservation.formattedTime }</td>
		</tr>
		<tr>
			<th>진료볼동물</th>
			<td>${myPet.petName }</td>
		</tr>
		<tr>
			<th>메모</th>
			<td>${reservation.memo }</td>
		</tr>
		<tr>
			<td colspan="2">
				<button onclick="reserUpdate(${reservation.reserIdx})">예약변경</button>
				<button onclick="reserDelete(${reservation.reserIdx})">예약취소</button>
			</td>
		</tr>
	</table>
	<script>
		function reserUpdate(reserIdx) {
			location.href="updateReservation.do?reserIdx=" + reserIdx;
		}
		function reserDelete(reserIdx) {
			location.href="cancleReservation.do?reserIdx=" + reserIdx;
		}
	</script>
</body>
</html>