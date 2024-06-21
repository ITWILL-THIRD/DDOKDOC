<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

	#container { width: 1100px; margin: auto; }
	h1, h3, p { text-align: center; }
	
	<%-- 목록 --%>
	table { 
		border-collapse: collapse;
		margin-left:auto;margin-right:auto;
		margin-top: 23px;
	}
	table th, table td {
		position: static;
		text-align: center;
		margin: auto;
		padding: 5px;
		border: 1px #B9B9B9 solid;
		border-collapse: collapse;
	}
	th { background-color: #B6E5FF; }
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	tfoot {
		margin-top: 50px;
		border-top-style: hidden;
	}
	
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
	
	<%-- 파일 링크 --%>
	#fileLink a {	
		color: #76e4ff;	
		font:bold;
		text-decoration: underline;
	}
	
	<%-- 승인 버튼 --%>
	.approvalBtn {
		color: white;
		border-radius: 10px;
		background-color: #B6E5FF;
		padding: 3px;
		width: 50px;
		border: none;
	}
	.condition-payment {
	    background-color: green;
	    color: white;
	}
	.condition-before {
	    background-color: yellow;
	    color: black;
	}
	.condition-after {
	    background-color: red;
	    color: white;
	}
</style>