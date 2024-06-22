<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mypageCSS</title>

<style>

	#container { width: 1100px; margin: auto;}
	#container2 {  width: 800px; margin-left: 220px; }
	
	<%-- 목록 --%>
	table {
	border-collapse: collapse;
	margin-left:auto;margin-right:auto;
	margin-top: 23px;
	}
	table th,
table td {
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

table tr {
height: 35px;
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
	a {	
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
    .delBtn {
    	border-radius: 5px;
    	background-color: #FFFFFF;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    	text-decoration: none;
    	display: inline-block;
    	
    }
    .delBtn:hover {
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
    	background-color: #4349B4;
        color: #FFFFFF; 
    	border: 1px solid #4349B4;
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
  .box {
  background-color: #F3F3F3;
  width: auto;
    height: 70px;
    display: block;
    border-radius: 10px; 
    margin-top: 30px;
     padding: 30px;
  }
.img {
	position: absolute;
	top: 85px;
	margin-left: -45px;
}
.date {
	margin-left: 60px;
}
ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  width: 200px;
  display: flex;
  flex-direction: column;
  
}

li a {
  display: block;
  color: #000;
  padding: 8px 16px;
  text-decoration: none;
  margin-right: auto;
}


li a:hover {
background-color: #F3F3F3;
  color: #FFA217;
}
.side {
margin-top: 37px;
 position: sticky;
    float: left;
    margin-left: 0;
}
.mypage {
font-size: 20px;
font-weight: bold;
margin-left: 17px;
margin-bottom: 10px;
}
.divBtn {
margin-top: 15px;
float: right;
}
</style>
</head>
<body>
    
	
</style>
</head>
<body>

</body>
</html>