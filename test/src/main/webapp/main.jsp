<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>토닥토닥 메인</title>
<script>
// 	function hosSearch() {
// 		alert("병원 검색~~");
// 	}
</script>

</head>
<body>
	<div id="container">
		<h1>병원 예약</h1>
		<hr>
		<hr>
		<br>
		
		<h3>병원 검색</h3>
		<form action="hosSearch.do" method="post">
			<select name="category">
				<option value="hosName">병원명</option>
				<option value="address">주소</option>
				<option value="2">일반병원</option>
				<option value="3">특수병원</option>
				<option value="4">야간진료</option>
			</select>
			
			<input type="text" name="keyword" placeholder="병원명/주소 입력하세요">
			<input type="submit" value="검색">
		</form>
<!-- 		<table> -->
<!-- 			<thead> -->
<!-- 				<tr> -->
<!-- 					<th>번호</th> -->
<!-- 					<th>병원명</th> -->
<!-- 					<th>주소</th> -->
<!-- 					<th>전화번호</th> -->
<!-- 				</tr> -->
<!-- 			</thead> -->
<!-- 			<tbody> -->
<!-- 				<tr> -->
<!-- 					<td>번호-1</td> -->
<!-- 					<td>병원명-메이병원</td> -->
<!-- 					<td>주소-강남구 역삼동~~</td> -->
<!-- 					<td>전화번호-02~~</td> -->
<!-- 				</tr> -->
<!-- 			</tbody> -->
<!-- 		</table> -->
		
		<hr>
		<p><a href="insertHosAdrress.do">병원 입력</a></p>
	</div>
</body>
</html>