<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 공지사항</title>
<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
  
  #reserDetailBtn {
  	border: none;
  	background-color: white;
  	color: #2C307D;
  	text-decoration: none;
  }
  
  #reserDetailBtn:hover {
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
    	background-color: #4349B4;
        color: #FFFFFF; 
    	border: 1px solid #4349B4;
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
    #container div {
    	position: relative;
    }
    #container div .btn {
    	position: absolute;
    	top : -15px;
    	right: 0px;
    }
    #container div .delBtn {
    	position: absolute;
    	top : -15px;
    	right: 100px;
    }
    #container div + div {
    	position: absolute;
		top: 180px;    	
    }
</style>
<script>
function insertNotice(hosIdx){
	//병원(기업)계정만 공지 작성
	//해당 병원 계정 일치 여부 확인 후, 공지 입력
	location.href = "../notice/insertProNotice.do?hosIdx=${hoUser.hosIdx}";
	//location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
}
function updateNotice(hosIdx){
	//병원(기업)계정만 공지 작성
	//해당 병원 계정 일치 여부 확인 후, 공지 입력
	location.href = "../notice/updateProNotice.do?hosIdx=${hoUser.hosIdx}";
	//location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
}
function deleteNotice(frm, hosIdx){
	if (confirm("공지사항을 삭제하시겠습니까?")) {
  	  //휴무 취소 함수 실행시키기
  		alert("공지사항 삭제");
//   		location.href = "../notice/deleteNotice.do?hosIdx=${hoUser.hosIdx}";
		frm.submit();
	} else {
        return;
    }
	//병원(기업)계정만 공지 작성
	//해당 병원 계정 일치 여부 확인 후, 공지 입력
	//location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
}


</script>

</head>
<body>
<h1>공지사항</h1>
<%-- \${hosNoticeList } : ${hosNoticeList } --%>
<%-- \${hoUser } : ${hoUser } --%>
<%-- \${hoUser.hosIdx } : ${hoUser.hosIdx } --%>
	<div id="container">
		<hr>
		<a href="hoMyPage.do">병원 마이페이지 가기</a>
		<div>
			<c:choose>
				<c:when test="${not empty notice}">
					<input type="button" class="btn" value="공지 수정" data-hos-idx="${hosIdx}"
						onclick="updateNotice(this.dataset.hosIdx)">
					<form action="../notice/deleteNotice.do" method="post">
						<input type="hidden" name="hosIdx" value="${hoUser.hosIdx}">
						<input type="button" class="delBtn" value="공지 삭제" data-hos-idx="${hosIdx}"
							onclick="deleteNotice(this.form, this.dataset.hosIdx)">		
					</form>
				</c:when>
				<c:otherwise>
					<input type="button" class="btn" value="공지 등록" data-hos-idx="${hosIdx}"
						onclick="insertNotice(this.dataset.hosIdx)">
				</c:otherwise>
			</c:choose>
		</div>
		<div>	
			<table border="">
			<c:choose>
				<c:when test="${not empty notice}">
					<tr>
						<th width="10%">작성일</th>
						<td>${notice.noticeDate }</td>
					</tr>
					<tr>
						<th>내용</th>
						<td>${notice.noticeContent }</td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<p>작성된 공지사항이 없습니다</p>
					</tr>
				</c:otherwise>
			</c:choose>
				
	<%-- 				<a href="../notice/insertProNotice.do?hosIdx=${hoUser.hosIdx}">공지 등록</a> --%>
			</table>
		</div>
	</div>
</body>
</html>