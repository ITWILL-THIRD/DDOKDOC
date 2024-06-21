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
		width: 100%;
		margin: 20px 0;
	}
	table, th, td {
		border: 1px solid #B9B9B9;
		padding: 8px;
		text-align: center;
	}
	th { 
		background-color: #B6E5FF; 
	}
	.center { 
		text-align: center; 
	}
	.border-none, .border-none td { 
		border: none; 
	}
    
    /* 버튼 */
    .btn, .searchBtn, .dateBtn {
    	border-radius: 10px;
    	background-color: #B6E5FF;
    	padding: 5px 10px;
    	border: none;
    	cursor: pointer;
    	color: #2C307D;
    	 
    }
    .dateBtn {
    	background-color: #E0EAF5;
    }
    .btn:hover, .searchBtn:hover {
    	background-color: #2C307D;
    	color: #FFFFFF;
    }
    .dateBtn:hover {
    	background-color: #2E77AE;
    	color: #FFFFFF;
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
        background-color: #2C307D;
        color: #FFFFFF;   	
    }
	.dateBtn.active {
        background-color: #2E77AE;
	}
  
    /* 차트 */
    #revenueChart, #statsChart {
    width: 100%;
    margin: 20px auto;
    }
    
	/* 검색창 */
	.searchInput {
		border-radius: 10px;
		margin: 5px 0;
	}
	
	/* 자동완성창 */
	.ui-autocomplete {
		background-color: #E0EAF5;
		border-radius: 10px;
		z-index: 1000; /* 요소 맨 위 표시 */
		font-size: 14px;
	}
	.ui-menu-item-wrapper.ui-state-active {
		background-color: #2E77AE !important;
		color: #FFFFFF !important;
		border-radius: 10px;
	}
	.ui-menu-item {
		padding: 5px 10px;
	}
</style>
</head>
<body>

</body>
</html>