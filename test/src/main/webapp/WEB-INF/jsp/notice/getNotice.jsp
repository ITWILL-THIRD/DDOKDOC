<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 공지사항 상세보기</title>
<script type="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
	#container {
		width: 700px;
		margin : auto;
	}
	h1, h3 {
		text-align: center;
	}
	table {
		border-collapse: collapse;
	}
	table, th, td {
		border: 1px solid black;
		margin: 0 auto;
	}
	th { background-color: orange; }
	.center {text-align: center; }
	.border-none, .border-none td {
		border: none; 
	}
</style>
<script>
	function insertNotice(){
		//병원(기업)계정만 공지 작성
		//해당 병원 계정 일치 여부 확인 후, 공지 입력
		
		location.href="/notice/insertNotice.do";
	}
</script>
</head>
<body>
	\${notice } : ${notice }
	<div id="container">
		<table>
			<tbody>
			<tr>
				<td>${notice.noticeTitle }</td>
			</tr>
			<tr>
				<td>${notice.noticeDate } | ${notice.hit }</td>
			</tr>
			<tr>
				<td>${notice.noticeContent }</td>
			</tr>
			</tbody>
			<tfoot>
				<tr>
					<td>
						<input type="button" value="뒤로 가기" onclick="javascript:hosMain.do">
						<input type="button" value="공지 작성" onclick="insertNotice()">
					</td>
				</tr>
			</tfoot>
		</table>
	</div>
</body>
</html>