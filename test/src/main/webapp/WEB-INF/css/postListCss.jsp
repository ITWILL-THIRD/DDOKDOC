<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>postListCSS</title>
<style>

	#container { width: 800px; margin: auto; }
	h1, h3, p { text-align: center; }
	
	<%-- 목록 --%>
	table { border-collapse: collapse; text-align: center; margin: 0 auto;
	margin-top: 23px;}

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
		width: 70px;
		height: 40px;
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
	hr {
  		border: 1px solid #2C307D;
  	}
	<%-- 제목 링크 --%>
	a {text-decoration: none;} 
	a[href^="get"] {	
		 color: #2C307D;
      	 text-decoration: none;
      	 margin: 0 10px 0 10px; 
         font-weight: bold;  
	}
	a:hover {color:#FFA217;}
	<%-- 카테고리 버튼 활성화 --%>
	a[href^="getBoardList.do"].active {
        color: #FFA217;
		text-decoration: none;	
		margin: 0 10px 0 10px;
		font-weight: bold;
	}
	#paging a {
		color: #2C307D;
		text-decoration: none;
		font-weight: normal;
	}
	#paging a:hover {color:#FFA217;}
	a.none {
		color: #2C307D;
		font-weight: bold;
	}	
	hr {
  		border: 1px solid #2C307D;
  	}
	tbody {border-bottom-style: hidden; }
	/* 	페이징 */
	tfoot a {
		color: #2C307D;
		font-weight: normal;
	}
	tfoot a:hover {color:#FFA217;}
	#paging td {
		padding-top: 15px;
	}
	#paging span{
		margin: 0 20px 0 20px;
	}
	#paging a {
		text-decoration: none;
	}
</style>
</head>
<body>

</body>
</html>