<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginCSS</title>
<style>
	#container { width: 700px; margin: auto; }
	h1, h3, p { text-align: center; }
	.center { text-align: center; }
	
	.psTitle {
		position: relative;
		margin-top: 5px;
		width: 350px;
		height: 25px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
	 }
	 
	 .loginBtn {
		position: relative;
border: 1px solid #bbb;
	background-color: #2C307D;
	border:  none;
border-radius: 7px;
	color: white;
	 width: 375px;
  height: 50px;
  margin-top: 20px;
  font-size: 16px;

	 }
	 .joinBtn {
	 position: relative;
border: 1px solid #bbb;
	background-color:  white;
	border: 2px solid #888888;
border-radius: 5px;

	 width: 185px;
  height: 42px;
  margin-top: 14px;
	 
	 }
	
	
	<%-- 글내용 --%>
	
	
	
	
	th { background-color: #B6E5FF; }

	.border-none, .border-none td { border: none; }
	
	.getBoard {
		width: 600px;
	}
	
	.insertBoard {width: 600px;	}
	
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