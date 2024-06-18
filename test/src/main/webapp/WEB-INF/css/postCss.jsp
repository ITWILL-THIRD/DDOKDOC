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
	
	table { border-collapse: collapse; }
	
	table, th, td {
		border: 1px solid #B9B9B9;
		margin: 0 auto;
		padding: 5px;
		text-align: center;
	}
	
	th { background-color: #B6E5FF; }

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
	
	.btn {
		border-radius: 10px;
		background-color: #B6E5FF;
		padding: 3px;
		width: 50px;
		border: none;
	}
	
	.btnWhite {
		border-radius: 10px;
		border-color: #B6E5FF;
		background-color: #FFF;
		padding: 3px;
		width: 50px;
	}
	
	<%-- 글 수정 취소 --%>
	
	.aBtn {
		border-radius: 10px;
		padding: 3px;
		width: 45px;
		border: 1px solid #B6E5FF;	
		display: inline-block;
		font-size: 13px;
	}
	
	<%-- 수정, 취소, 목록 링크 --%>
	
	a {	
		text-decoration: none;
		color: black;	
	}
	a:hover {color:#B6E5FF;}
	
	<%-- 댓글 작성, 댓글 구분 --%>
	
	hr {    
		background-color:#B6E5FF;;
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
		border: 1px solid #B6E5FF;
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