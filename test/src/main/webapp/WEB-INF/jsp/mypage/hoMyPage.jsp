<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 마이페이지</title>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<h1>병원 마이페이지</h1>
<hr>
<h2>병원정보</h2>
<form>
	<table>
		<tr>
			<td>병원아이디</td>
			<td>${hoUser.hosId }</td>
		</tr>
		<tr>
			<td>병원이름</td>
			<td>${hoUser.hosName }</td>
		</tr>
		<tr>
			<td>병원 연락처</td>
			<td>${hoUser.hosPhone }</td>
		</tr>
		<tr>
			<td>분류</td>
			<td>${hoUser.animal }</td>
		</tr>
		<tr>
			<td>평점</td>
			<td>${hoUser.score }</td>
			
		</tr>
	</table>
</form>


<hr>
</body>
</html>