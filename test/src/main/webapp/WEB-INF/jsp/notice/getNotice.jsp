<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 공지사항 상세보기</title>
<jsp:include page="../common/navigation.jsp"/>
<script type="https://code.jquery.com/jquery-1.12.4.js"></script>
<style>
	#container {
		width: 700px;
		margin : auto;
	}
	h1, h3 {
		text-align: center;
	}
	table {
		border-collapse: collapse;
	}
	table, th, td {
		border: 1px solid black;
		margin: 0 auto;
	}
	th { background-color: orange; }
	.center {text-align: center; }
	.border-none, .border-none td {
		border: none; 
	}
</style>
<script>
// 	function updateProNotice(){
// 		document.noticeForm.action = "updateProNotice.do";
// 		document.noticeForm.submit();
		
// 		//location.href = "updateProNotice.do";
// 	}
	
// 	function deleteNotice(){
// 		document.noticeForm.action = "deleteNotice.do";
// 		document.noticeForm.submit();
		
// 		//location.href = "updateProNotice.do";
// 	}
	
</script>
</head>
<body>
	\${notice } : ${notice }
	<div id="container">
	<form id="noticeForm" method="post">
		<table>
			<tbody>
			<tr>
				<td>${notice.noticeTitle }</td>
			</tr>
			<tr>
				<td>${notice.noticeDate } | ${notice.hit }</td>
			</tr>
			<tr>
				<td>${notice.noticeContent }</td>
			</tr>
			</tbody>
			<tfoot>
			<tr>
				<td>
<!-- 					<input type="submit" value="수정"  -->
<!-- 						onclick="javascript:noticeForm.action='updateProNotice.do';"> -->
<!-- 					<input type="submit" value="삭제"  -->
<!-- 						onclick="javascript:noticeForm.action='deleteNotice.do';"> -->
<%-- 					<input type="hidden" name="noticeIdx" value="${notice.noticeIdx}">   --%>
<%-- 					<input type="hidden" name="noticeTitle" value="${notice.noticeTitle}">   --%>
<%-- 					<input type="hidden" name="noticeContent" value="${notice.noticeContent}">   --%>
<%-- 					<input type="hidden" name="hosIdx" value="${notice.hosIdx}">   --%>
					
					<input type="button" value="병원 상세 뒤로 가기" 
						onclick="javascript:location.href='../hospital/hosDetail.do?hosIdx=${notice.hosIdx}'">
<!-- 					<input type="button" value="마이페이지  공지사항"  -->
<%-- 					onclick="javascript:location.href='../mypage/hosNoticeList.do?hosIdx=${hoUser.hosIdx}'"> --%>
				</td>
			</tr>
			</tfoot>
		</table>
	</form>
	</div>
</body>
</html>