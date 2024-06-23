<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>statsCSS</title>
<style>
	/* 컨테이너 */
	#container {
		width: 1100px;
		margin: auto;
	}
	
	h1, h3, p {
		text-align: center;
	}
	
	/* 테이블 */
	table {
		border-collapse: collapse;
		margin-left: auto;
		margin-right: auto;
		margin-top: 23px;
		width: 100%;
		margin: 20px 0;		
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
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	.total-row {
		background-color: #E0EAF5;
		font-weight: bold;
	}
	.center { 
		text-align: center; 
	}
	.border-none, .border-none td { 
		border: none; 
	}
    
    /* 버튼 */
    .btn, .searchBtn, .dateBtn {
    	border-radius: 5px;
    	background-color: #2C307D;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	 
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
    .dateBtn {
    	width: 70px;
    	height: 40px;
    	background-color: #E0EAF5;
    	color: #2C307D;
    }
    .btn:hover, .dateBtn:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #B8DAFF;
    }
    .searchBtn:hover {
    	background-color: #4349B4;
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
	
    /* 버튼 배경색 변경 */
    .btn.active, .dateBtn.active {
        background-color: #B8DAFF;
        color: #2C307D;
        /* border: 1px solid #2C307D; */
    }
	.dateBtn.active {
        background-color: #B8DAFF;
    	color: #2C307D;
    	/* border: 1px solid #2C307D;  */
	}
  
    /* 차트 */
    #revenueChart, #statsChart {
    width: 100%;
    margin: 20px auto;
    }
    
	/* 검색창 */
	.searchInput {
		position: relative;
	    width: 200px;
	    height: 19px;	
	    border: 1px solid #bbb;
	    border-radius: 5px;
	    padding: 10px 12px;
	    font-size: 14px;
	}
	
	/* 자동완성창 */
	.ui-autocomplete {
		background-color: #FFFFFF;
		border-radius: 5px;
		z-index: 1000; /* 요소 맨 위 표시 */
		font-size: 14px;
	}
	.ui-menu-item-wrapper.ui-state-active {
		background-color: #B8DAFF !important;
		color: #2C307D !important;
		border-radius: 5px;
		font-size: 14px;
		padding: 5px;
	}
	.ui-menu-item {
		padding: 5px 10px;
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
</style>
</head>
<body>

</body>
</html>