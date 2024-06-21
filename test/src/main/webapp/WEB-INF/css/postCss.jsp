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
	.center { text-align: center; }
	.top-margin {margin-top: 100px;}
	
	<%-- 글내용 --%>
	
	.hr {border: 1px solid #E0EAF5;  }
	
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
	
	.getBoard {
		width: 800px;
	}
	
	.insertBoard {width: 800px;	}
	
	#category {
		padding: 10px;
	}
	
	.searchInput {
		margin-left: 5px;
		border-radius: 10px;
	}
	
	<%-- 글 등록, 수정, 댓글 등록, 삭제--%>
	<%--
	.btn {
		border-radius: 10px;
		background-color: #E0EAF5;
		padding: 3px;
		width: 50px;
		border: none;
	}--%>
	
	.btn {
		border-radius: 5px;
    	background-color: #2C307D;
    	padding: 3px 13px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
	}
	.btn:hover {
		background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;}
	
	<%--
	.btnWhite {
		border-radius: 10px;
		border-color: #E0EAF5;
		background-color: #FFF;
		padding: 3px;
		width: 50px;
	}--%>
	
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
	
	a {	
		 color: #2C307D;
         font-weight: bold;  
      	 text-decoration: none; 
	}
	a:hover {color:#FFA217;}
	
	<%-- 댓글 작성, 댓글 구분 --%>
	
	hr {    
		background-color:#E0EAF5;
    	height:1px;
    	border:0;
	}
	
	.width {
		display: inline-block;
	}
	
	.hosname {color:#2C307D;}
	
	<%-- 댓글 작성자 로그인처리 후 삭제 --%>
	
	.idInput {
		width: 100px;
	}
	
	.commentInput {
		border-radius: 5px;
		border: 1px solid #E0EAF5;
		align-items: center;
	}
	
	form > textarea { align-items: center;}
	

	.content { min-height: 200px;}
	
	<%-- 댓글 목록 스크롤 --%>
	.scroll {
	    overflow-y: auto;
	    max-height: 500px;
	}


	
</style>
</head>
<body>

</body>
</html>