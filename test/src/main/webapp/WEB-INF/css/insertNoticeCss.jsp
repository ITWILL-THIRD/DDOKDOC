<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#container { width: 800px; margin: auto; }
	h1, h3, p { text-align: center; }
	hr {border: 1px solid #2C307D;}
	table {
		width: 800px;
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
	table th:first-child,
	table td:first-child {
		border-left: 0;
	}
	table th:last-child,
	table td:last-child {
		border-right: 0;
	}
	th { 
		background-color: #E0EAF5;
	}
	td {
		background-color: #FFFFFF;
	}
	/* 버튼 */
    .resetBtn{
	    width: 70px;
    	height: 40px;
    	border-radius: 5px;
   		border : 1px solid #2C307D;
  		background-color: white;
  		color: #2C307D;
    	cursor: pointer;
    	position:relative;
    	left: 300px;
    	margin: 10px
    }
    .resetBtn:hover {
    	background-color: #EAEAEA;
    }
    .btn {
    	border-radius: 5px;
    	width: 70px;
    	height: 40px;
    	background-color: #2C307D;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	border: 1px solid #2C307D;
    	position:relative;
    	left: 300px;
    	margin: 10px;
    }
    
    .btn:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
	.delBtn {
    	border-radius: 5px;
    	background-color: #FFFFFF;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    	text-decoration: none;
    	position:relative;
    	left: 300px;
    	margin: 10px;
    }
    .delBtn:hover {
    	background-color: #EAEAEA;
    }
</style>