<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>postListCSS</title>
<style>

	#container { width: 1000px; margin: auto; }
	h1, h3, p { text-align: center; }
	
	<%-- 목록 --%>
	table { border-collapse: collapse; }
	table, th, td {
		border: 1px solid #B9B9B9;
		margin: 0 auto;
		padding: 5px;
		text-align: center;
	}
	th { background-color: #B6E5FF; }
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	
	<%-- 검색창 --%>
	#category {
		padding: 10px;
	}
	.searchInput {
		margin-left: 5px;
		border-radius: 10px;
	}
	.searchBtn {
		border-radius: 10px;
		background-color: #B6E5FF;
		padding: 3px;
		width: 50px;
		border: none;
	}
	
	<%-- 제목 링크 --%>
	a {	
		text-decoration: none;
		color: black;	
	}
	a:hover {color:#B6E5FF;}
	
	
</style>
</head>
<body>

</body>
</html>