<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>postListCSS</title>
<style>

	#container { width: 1100px; margin: auto; }
	h1, h3, p { text-align: center; }
	
	<%-- 목록 --%>
	table { border-collapse: collapse; }
	table, th, td {
		border: 1px solid #B9B9B9;
		margin: 0 auto;
		padding: 5px;
		text-align: center;
	}
	th { background-color: #E0EAF5; }
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	.top-margin {margin-top: 100px;}
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
		background-color: #E0EAF5;
		padding: 3px;
		width: 50px;
		border: none;
	}
	
	<%-- 제목 링크 --%>
	a {	
		text-decoration: none;
		color: black;	
	}
	a:hover {color:#E0EAF5;}
	
	
</style>
</head>
<body>

</body>
</html>