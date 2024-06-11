<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 공지사항 리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function insertNotice(hosIdx){
	//병원(기업)계정만 공지 작성
	//해당 병원 계정 일치 여부 확인 후, 공지 입력
	location.href = "../notice/insertProNotice.do?hosIdx=${hoUser.hosIdx}";
	//location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
}
</script>
</head>
<body>
<h1>공지사항</h1>
<%-- \${hosNoticeList } : ${hosNoticeList } --%>
<%-- \${hoUser } : ${hoUser } --%>
<%-- \${hoUser.hosIdx } : ${hoUser.hosIdx } --%>
	<a href="hoMyPage.do">병원 마이페이지 가기</a>
	<h4>공지사항</h4>
	<div>
		<input type="button" value="공지 등록" data-hos-idx="${hosIdx}"
			onclick="insertNotice(this.dataset.hosIdx)">
			
		<table border="">
			<tr>
				<th>작성일</th>
				<th>제목</th>
				<th>조회수</th>
			</tr>
			<c:forEach var="notice" items="${hosNoticeList }">
				<tr>
					<td>${notice.noticeDate }</td>
					<td><a
						href="../notice/getNotice.do?hosIdx=${notice.hosIdx}&noticeIdx=${notice.noticeIdx }">${notice.noticeTitle }</a>
					</td>
					<td>${notice.hit }</td>
				</tr>
			</c:forEach>
<%-- 				<a href="../notice/insertProNotice.do?hosIdx=${hoUser.hosIdx}">공지 등록</a> --%>
		</table>
	</div>
</body>
</html>