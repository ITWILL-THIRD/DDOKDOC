<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥 메인</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

</head>
<body>
\${hosList } : ${hosList }<br>
	<div id="container">
		<h1>병원 예약</h1>
		<hr>
		<br>
		<h3>병원 검색</h3>
		<form>
			<select name="searchCondition">
				<option selected disabled>선택</option>
				<option value="0">병원명</option>
				<option value="1">주소</option>
				<option value="2">일반병원</option>
				<option value="3">특수병원</option>
				<option value="4">야간진료</option>
			</select>
			
			<input type="text" name="searchKeyword" placeholder="병원명/주소 입력하세요">
			<input type="button" value="검색" onclick = "getAjaxHosList(this.form)">
<!-- 			<input type="submit" value="검색"> -->
		</form>
		<table border="">
			<thead>
				<tr>
					<th>번호</th>
					<th>병원명</th>
					<th>주소</th>
					<th>전화번호</th>
					<th>진료시간</th>
					<th>진료동물</th>
				</tr>
			</thead>
			<tbody id="listDisp">
				<c:forEach var="hospital" items="${hosList }">
				<tr>
					<td>${hospital.hosidx}</td>
					<td>
						<a href="hosDetail.do?hosIdx=${hospital.hosidx}">${hospital.hosname}</a>
					</td>
					<td>${hospital.roadaddressname} ${hospital.detailAddress}</td>
					<td>${hospital.hosphone}</td>
					<td>${hospital.openTime} ~ ${hospital.closeTime}</td>
					<td>${hospital.animal}</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<hr>
		<p><a href="temp.do">병원 입력</a></p>
	</div>
</body>
</html>