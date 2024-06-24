<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#container { width: 800px; margin: auto; }
	h1, h3, p { text-align: center; }
	.center { text-align: center; }
	.top-margin {margin-top: 100px;}
	
	<%-- 글내용 --%>
	hr {border: 1px solid #E0EAF5;  }
	
	table { border-collapse: collapse; }
	
	th, td {
		border: 1px solid #B9B9B9;
		margin: 0 auto;
		padding: 5px;
		text-align: center;
	}
	
	th { background-color: #E0EAF5; }

	table th:first-child,
	table td:first-child {
		border-left: 0;
	}
	table th:last-child,
	table td:last-child {
		border-right: 0;
	}
	.border-none, .border-none td { border: none; }
	#category {
		padding: 10px;
	}
	.getBoard {
		width: 800px;
	}
	.insertBoard {width: 800px;	}
	
	<%-- 파일 등록 --%>
	.file-input-wrapper {
        position: relative;
        display: inline-block;
    }
    .file-input-wrapper input[type="file"] {
        display: none;
    }
    .file-input-label {
        border-radius: 5px;
        background-color: #4349B4;
        padding: 7px 18px;
        border: 1px solid #4349B4;
        color: #ffffff;
        cursor: pointer;
        display: inline-block;
    	margin: 10px;
    }
    .file-input-label:hover {
    	color: #2C307D;
    	background-color: #EAEAEA;
    }
    .file-name {
        margin-left: 10px;
        font-size: 14px;
        color: #2C307D;
    }
    
	.btn {
    	width: 70px;
    	height: 40px;
    	border-radius: 5px;
    	border: 1px solid #2C307D;
    	background-color: #2C307D;
    	color: #FFFFFF;
    	cursor: pointer;
    	position:relative;
    	left: 300px;
    	margin: 10px;
    }
    .btn:hover {
    	background-color: #4349B4;
    	color: #FFFFFF;
    	border: 1px solid #2C307D;
    }
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
    .comments {position: relative;}
    .upBtn {
    	border-radius: 5px;
    	background-color: #2C307D;
    	padding: 8px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	border: 1px solid #2C307D;
    	position:absolute;
    	left: 100px;
    	margin: 10px;
    }
    .upBtn:hover {
    	background-color: #4349B4;
    	color: #FFFFFF;
    	border: 1px solid #2C307D;
    }
    .delBtn {
    	border-radius: 5px;
    	background-color: #FFFFFF;
    	padding: 8px 18px;
    	border: none;
    	cursor: pointer;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    	text-decoration: none;
    	position:relative;
    	left: 0px;
    	margin: 10px;
    }
    .delBtn:hover {
    	background-color: #EAEAEA;
    	color: #2C307D;
    }

	<%-- 글 수정 취소 --%>
	
	.aBtn {
		border-radius: 10px;
		padding: 3px;
		width: 45px;
		border: 1px solid #E0EAF5;	
		display: inline-block;
		font-size: 13px;
	}
	
	<%-- 수정, 취소, 목록 링크 --%>
	a {text-decoration: none;} 
	a[href^="get"], a[href^="delete"] {	
		 color: #2C307D;
         font-weight: bold;  
      	 text-decoration: none; 
	}
	a:hover {color:#FFA217;}
</style>