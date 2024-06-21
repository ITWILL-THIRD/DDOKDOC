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
function deleteNotice(frm){
	if (confirm("공지사항을 삭제하시겠습니까?")) {
  	  //휴무 취소 함수 실행시키기
  	  alert("공지사항 삭제");
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
	<a href="hoMyPage.do">병원 마이페이지 가기</a>
	<h4>공지사항</h4>
	<div>
		<c:choose>
			<c:when test="${not empty notice}">
				<input type="button" value="공지 수정" data-hos-idx="${hosIdx}"
					onclick="updateNotice(this.dataset.hosIdx)">
				<form action="../notice/deleteNotice.do" method="post">
					<input type="hidden" name="hosIdx" value="${hoUser.hosIdx}">
					<input type="button" value="공지 삭제" data-hos-idx="${hosIdx}"
						onclick="deleteNotice(this.form)">		
				</form>
			</c:when>
			<c:otherwise>
				<input type="button" value="공지 등록" data-hos-idx="${hosIdx}"
					onclick="insertNotice(this.dataset.hosIdx)">
			</c:otherwise>
		</c:choose>
		
		<table border="">
		<c:choose>
			<c:when test="${not empty notice}">
				<tr>
					<th>작성일</th>
					<th>제목</th>
					<th>내용</th>
				</tr>
				<tr>
					<td>${notice.noticeDate }</td>
					<td>${notice.noticeTitle }</td>
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
</body>
</html>