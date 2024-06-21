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
	table { border-collapse: collapse; text-align: center; margin: 0 auto;}
	th, td {
		border: 1px solid #B9B9B9;
		margin: 0 auto;
		padding: 5px;
		text-align: center;
		border-collapse: collapse;
	}
	th { background-color: #E0EAF5; }
	
	table th:first-child,
	table td:first-child {
		border-left: 0;
	}
	th:last-child,
	td:last-child {
		border-right: 0;
	}
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	.top-margin {margin-top: 100px;}
	<%-- 검색창 --%>
	#category {
		padding: 10px;
	}
	.select {
		width: 100px;
		height: 40px;
	 	border: 1px solid #bbb;
		border-radius: 5px;
	  	padding: 10px 12px;
	  	font-size: 14px;
	  	margin-right: 5px;
	}
	.searchInput {
		margin-top: 16px;
		width: 200px;
		height: 19px;
		border: 1px solid #bbb;
		border-radius: 5px;
		padding: 10px 12px;
		font-size: 14px;
	}
	.searchBtn {
		border-radius: 5px;
    	background-color: #2C307D;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
	}
	.searchBtn:hover {
		background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;}
	
	<%-- 제목 링크 --%>
	a {	
		 color: #2C307D;
         font-weight: bold;  
      	 text-decoration: none; 
	}
	a:hover {color:#FFA217;}
	
	
</style>
</head>
<body>

</body>
</html>