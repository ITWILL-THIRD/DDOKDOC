<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#container {
		width: 1100px;
		margin: auto;
	}
	h1, h3, p { text-align: center; }
  	.center {width: 700px; margin: auto; padding:2px; text-align: center;}
  	.right {width: 700px; margin-left: 408px; padding:2px; text-align: center;}
 	button { 
 		margin:1px; 
 	}  
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
	.border-none, .border-none td { border: none; }
	
	<%-- 검색창 --%>
	#category {
		padding: 10px;
	}
	.select {
		width: 160px;
		height: 40px;
		border: 1px solid #bbb;
		border-radius: 5px;
		padding: 10px 12px;
		font-size: 14px;
	}
	.search {
		position: relative;
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
		border : none;
		background-color: #2C307D;
		font-size: 14px;
		color: white;
    }
    .searchBtn:hover {
    	background-color: #4349B4;
    }
    #getAdSearch {
    	margin: 0 120px 0 0;
    }
    #getHosSearch {
    	margin: -10px 0 5px 0;
    }
    
	<%-- 버튼 --%>
    .btn {
    	color: #2C307D;
  		font-weight: bold;
  		font-size:  1rem; 
		border-style: none;
     	background-color: #fff;
     	cursor: pointer; 
    }
    .btn:hover {
     	color: #FFA217; 
    }
    .none {
    	border-style: none;
    	background-color: #fff;
    }
    .searchBtn {
		width: 70px;
		height: 40px;
		border-radius: 5px;
		border : none;
		background-color: #2C307D;
		font-size: 14px;
		color: white;
		cursor: pointer; 
    }
    .searchBtn:hover {
    	background-color: #4349B4;
    }
    .getAdSearch{
    	display: inline-block;
        text-align: center;
    }
    /* 버튼 정렬 */
	.row, #searchDate {
		display: flex;
		gap: 10px;
		justify-content: center;
		align-items: center;
	}
	.row {
		padding: 10px 0;
	}
	#searchDate {
		flex-direction: row;
		flex-wrap: wrap;
	}
	hr {
  		border: 1px solid #2C307D;
  		width: 895px;
/*   		margin-bottom: -10px; */
  	}
	<%-- 제목 링크 --%>
	a {text-decoration: none;} 
	a[href^="hosDetail.do"] {	
  		color: #2C307D;
  		font-weight: bold;  
		text-decoration: none;	
	}
	a:hover {color:#FFA217;}
	tbody {border-bottom-style: hidden; }
	
	tfoot a {
		color: #2C307D;
		font-weight: normal;
	}
	tfoot a:hover {color:#FFA217;}
	
/* 	페이징 */
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