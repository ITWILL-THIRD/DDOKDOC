<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시작페이지</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	//Ajax 요청처리에 의해 데이터 가져와서 화면 표시
	function getJsonBoardListData() {
		alert("getJsonBoardListData() 실행~~");
		$.ajax("getJsonBoardList.do", {
			type: "get", //method와 동일
			dataType: "json",
			success: function(data) {
				alert("성공~~");
				
				let dispHtml = "<ul>";
				for (let board of data) {
					dispHtml += "<li>";
					dispHtml += board.seq + ", ";
					dispHtml += board.title + ", ";
					dispHtml += board["writer"] + ", ";
					dispHtml += board["content"] + ", ";
					dispHtml += board.regdate + ", ";
					dispHtml += board.cnt + ", ";
					dispHtml += "</li>";
				}
				dispHtml += "</ul>";
				$("#listDisp").html(dispHtml);
			},
			error: function() {
				alert("실패~~");
			}
		});
	}
</script>
</head>
<body>

<div id="container">
	<h1>프로젝트명 수정</h1>
	<hr>
	<p>
		<a href="login.do">로그인 페이지로 이동(GET)</a>
	</p>
	<hr><hr>
	
	<h2>Ajax 요청 처리</h2>
	<p><a href="javascript:getJsonBoardListData()">JSON 데이터 가져오기(BoardList)</a></p>
	<p><a href="javascript:getJsonBoardData()">JSON 데이터 가져오기(Board)</a></p>
	<hr>
	<div id="listDisp">
		<ul>
			<li>데이터 가져와서 출력하기</li>
		</ul>
	</div>
	
	<!-- <네비게이션 바>병원예약 페이지 연결 -->
	<h2>[병원 예약]</h2>
	<p>
		<a href="hospital/hosMain.do">병원 검색으로 이동</a>
	</p>
</div>
<script>
	function getJsonBoardData() {
		alert("getJsonBoardData() 실행~");
		let vo = {seq:10};
		console.log(vo);
		console.log(JSON.stringify(vo));
		
		$.ajax("getJsonBoard.do", {
			type: "post", //method 별칭
			//data: "seq=1",
			data: JSON.stringify(vo), // {seq: 1} 문자열 서버로 전송(JSON 문자열)
			contentType: "application/json", //서버로 전송하는 컨텐츠 유형(JSON 형식)
			dataType: "json", //서버로부터 응답받는 데이터 형식
			success: function(data){
				alert("성공~~");
				console.log(data);
				
				let dispHtml = "<ul>";
				
				dispHtml += "<li>";
				dispHtml += data.seq + ", ";
				dispHtml += data.title + ", ";
				dispHtml += data["writer"] + ", ";
				dispHtml += data["content"] + ", ";
				dispHtml += data.regdate + ", ";
				dispHtml += data.cnt + ", ";
				dispHtml += "</li>";
				dispHtml += "</ul>";
				
				$("#listDisp").html(dispHtml);
			},
			error: function(){
				alert("실패~~");
			}
		});
	}
</script>
</body>
</html>












