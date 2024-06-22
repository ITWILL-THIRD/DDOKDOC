<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정폼</title>
<jsp:include page="../common/navigation.jsp"/>
<style>
	#container { width: 800px; margin: auto; }
	h1, h3, p { text-align: center; }
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
	th, td { 
		background-color: #E0EAF5;
	}
    form {position: relative;}
    /* 버튼 */
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
    .btn {
    	border-radius: 5px;
    	width: 70px;
    	height: 40px;
    	background-color: #2C307D;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	border: 1px solid #2C307D;
    	position:relative;
    	left: 300px;
    	margin: 10px;
    }
    
    .btn:hover {
    	background-color: #4349B4;
    	color: #FFFFFF;
    	border: 1px solid #2C307D;
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
    	position:relative;
    	left: 300px;
    	margin: 10px;
    }
    .delBtn:hover {
    	background-color: #EAEAEA;
    }
    /* 버튼 배경색 변경 */
    .btn.active {
        background-color: #FFFFFF;
        color: #2C307D;
    	border: 1px solid #2C307D; 	
    }
    
    /* 버튼 배경색 변경 */
    .btn.active, .dateBtn.active {
        background-color: #2C307D;
        color: #FFFFFF;   	
    }
    hr {
  		border: 1px solid #2C307D;
    }
</style>
</head>
<body>
<%-- \${notice } : ${notice } --%>
	<div id="container">
	<h2>공지사항 수정</h2>
		<hr>
		<form action="updateNotice.do" method="post">
			<table border frame=void>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="10" cols="90" name="noticeContent">${notice.noticeContent }</textarea>
					</td>
				</tr>
			</table>
			<input type="hidden" name="hosIdx" value="${hosIdx}">
			<input type="submit" class="btn" value="수정">
			<input type="reset" class="resetBtn" value="초기화">
			<input type="button" class="resetBtn" value="뒤로가기" 
			onclick="javascript:location.href='../mypage/hosNotice.do'">
<!-- 			<input type="button" class="deleteBtn" value="뒤로가기"  -->
<%-- 				onclick="javascript:location.href='../hospital/hosDetail.do?hosIdx=${hosIdx}'"> --%>
		</form>
	</div>
	
</body>
</html>