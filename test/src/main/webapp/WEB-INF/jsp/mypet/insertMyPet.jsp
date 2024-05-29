<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이펫 등록하기</title>
</head>
<body>
\${user } : ${user }<br>
	<div id="container">
		<h1>마이펫 등록</h1>
		<form action="insertMyPet.do" method="post">
			<table>
				<tr>
					<th>펫종류:</th>
					<td><input type="text" name="animal"></td>
				</tr>
				<tr>
					<th>펫이름:</th>
					<td><input type="text" name="petName"></td>
				</tr>
				<tr>
					<th>펫나이:</th>
					<td><input type="number" name="petAge"></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="등록"></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>

