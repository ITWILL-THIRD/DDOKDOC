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
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	
	<%-- 검색창 --%>
	#category {
		padding: 10px;
	}
	.selectTb {
	border: none;
	}
	.select {
width: 100px;
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
.center {
margin-bottom: 20px;
}
	<%-- 제목 링크 --%>
	a {text-decoration: none;} 
	a[href^="user"] {	
		font-weight: bold;
		color: #2C307D;
		text-decoration: none;	
	}
	a:hover {color:#FFA217;}
	
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
    
   .searchForm{
    display: inline-block;
          text-align: center;
    }	
    
    .resetBtn{
    width: 70px;
  height: 40px;
  border-radius: 5px;
  border : 1px solid #2C307D;
  background-color: white;
  color: #2C307D;
  font-size: 14px;
 
    }
    .resetBtn:hover {
    	background-color: #EAEAEA;
    	
    }
    
    
        /* 버튼 */
    .btn {
    	border-radius: 5px;
    	background-color: #2C307D;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	 display: inline-block;
    	 border: 1px solid #2C307D;
    }
    
    
    .btn:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
    /* 버튼 배경색 변경 */
    .btn.active {
        background-color: #FFFFFF;
        color: #2C307D;
    	border: 1px solid #2C307D; 	
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