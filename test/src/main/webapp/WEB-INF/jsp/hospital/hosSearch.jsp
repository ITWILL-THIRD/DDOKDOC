<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥 메인</title>


</head>
<body>
	<div id="container">
		<h1>병원 예약</h1>
		<hr>
		<hr>
		<br>
		
		<h3>병원 검색</h3>
		<form action="hosSearch.do" method="post">
			<select name="searchCondition">
				<option value="HOSNAME">병원명</option>
				<option value="ADDRESS">주소</option>
				<option value="2">일반병원</option>
				<option value="3">특수병원</option>
				<option value="4">야간진료</option>
			</select>
			
			<input type="text" name="keyword" placeholder="병원명/주소 입력하세요">
			<input type="submit" value="검색">
		</form>
		<table>
			<thead>
				<tr>
					<th>번호</th>
					<th>병원명</th>
					<th>주소</th>
					<th>전화번호</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="hospital" items="hospitalList">
				<tr>
					<td>${hospital.hosidx }</td>
					<td>${hospital.hosname }</td>
					<td>${hospital.roadaddressname }</td>
					<td>${hospital.hosphone }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<hr>
		<p><a href="insertHosAdrress.do">병원 입력</a></p>
	</div>
</body>
</html>