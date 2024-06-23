<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 입력폼</title>
<jsp:include page="../common/navigation.jsp"/>
<style>
	#container { width: 800px; margin: auto; }
	h1, h3, p { text-align: center; }
	
	<%-- 목록 --%>
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
	
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	
	.center {
		margin-bottom: 20px;
	}
	<%-- 제목 링크 --%>
	a {	
		font-weight: bold;
		color: #2C307D;
		text-decoration: none;	
	}
	
	a:hover {
		color:#FFA217;
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
	

  hr {
  	border: 1px solid #2C307D;
  }
</style>
</head>
<body>
	<h1>공지사항 입력</h1>
	<div id="container">
	<hr>
		<form action="insertNotice.do" method="post">
		<table border frame=void >
			<tr>
				<th>내용</th>
				<th>
					<textarea rows="10" cols="50" name="noticeContent"></textarea>
				</th>
			</tr>
		</table>
		<input type="hidden" name="hosIdx" value="${hosIdx}">
		<input class="btn" type="submit" value="등록">
		<input class="btn" type="button" value="뒤로가기" 
			onclick="javascript:location.href='../hospital/hosDetail.do?hosIdx=${hosIdx}'">
	</form>
	</div>
	
	
</body>
</html>