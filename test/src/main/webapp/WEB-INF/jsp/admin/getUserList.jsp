<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<jsp:include page="../../css/getUserListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<!-- 자바스크립트 추가 -->
<script>
    function resetForm() {
        // 폼을 초기화
        document.getElementById("searchForm").reset();
        
        // 기본 검색 조건으로 설정
        document.getElementsByName("searchType")[0].value = "ALL";
        document.getElementsByName("searchKeyword")[0].value = "";
        
        // 전체 목록을 다시 로드하기 위해 폼 제출
        document.getElementById("searchForm").action = "getUserList.do";
        document.getElementById("searchForm").submit();
    }
</script>
<body>
<h1>회원관리</h1>
<div id="container">
<!-- 검색 -->
<form id="searchForm" action="getUserList.do" method="get">
	
		<div class="center">
				<select class="select" name="searchType">
				<c:forEach var="option" items="${conditionMap }">
				<option value="${option.value }">${option.key }</option>
				</c:forEach>
				</select> 
				<input class="search" type="text" name="searchKeyword" placeholder="회원검색" /> 
				<input class="searchBtn" type="submit" value="검색" />
			<input class="resetBtn" type="button" value="새로고침" onclick="resetForm()">
	</div>
</form>
<hr>
<table border frame=void>
 <tr>
            <th width="7%" height="35px">회원 번호</th>
            <th width="7%">프로필</th>
            <th width="10%">이메일</th>
            <th width="7%">이름</th>
            <th width="15%">전화번호</th>
	        <th width="7%">예약완료</th>
	        <th width="7%">진료완료</th>
	        <th width="5%">노쇼</th>
	        <th width="7%">예약현황</th>
            <th width="5%">리뷰</th>
	        <th width="6%">게시물</th>
	        <th width="5%">댓글</th>
        </tr>
 <c:choose>
        <c:when test="${empty getUserList}">
            <tr>
                <td colspan="12" style="text-align:center;">검색 결과가 없습니다</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="user" items="${getUserList}">
                <tr>
                    <td height="30px">${user.userIdx}</td>
                    <td><img src="${user.userImg}" height="50px"></td>
                    <td><a href="userMypage.do?userIdx=${user.userIdx}">${user.email}</a></td>
                    <td>${user.name}</td>
                    <td>${user.phone}</td>
                    <td>${user.reserCount }</td>
			        <td>${user.finishCount }</td>
			        <td>${user.noShowCount }</td>
			        <td><a href="userReservPage.do?userIdx=${user.userIdx}">예약현황</a></td>
                    <td><a href="userReviewList.do?userIdx=${user.userIdx}">${user.reviewCount}</a></td>
                    <td><a href="userPostList.do?userIdx=${user.userIdx}">${user.postCount}</a></td>
                    <td><a href="userCommentList.do?userIdx=${user.userIdx}">${user.commentCount}</a></td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
   <tfoot>
	<tr>
		<td colspan="12">
				<!-- [이전]에 대한 사용여부 처리 -->
				<c:if test="${pagingVO.nowPage == 1}">
					<span class="disable">이전</span>
				</c:if>
				<c:if test="${pagingVO.nowPage != 1}">
					<span>
						<a href="getUserList.do?cPage=${pagingVO.nowPage - 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">이전</a>
					</span>
				</c:if>

				<!-- 블록내에 표시할 페이지 태그 작성(시작~끝) -->
				<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}">
					<c:choose>
						<c:when test="${pageNo == pagingVO.nowPage}">
							<span class="now">${pageNo}</span>
						</c:when>
						<c:otherwise>
							<span>
								<a href="getUserList.do?cPage=${pageNo}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">${pageNo}</a>
							</span>
						</c:otherwise>
					</c:choose>
				</c:forEach>

				<!-- [다음]에 대한 사용여부 처리 -->
				<c:if test="${pagingVO.nowPage < pagingVO.totalPage}">
					<span>
						<a href="getUserList.do?cPage=${pagingVO.nowPage + 1}&searchType=${param.searchType}&searchKeyword=${param.searchKeyword}">다음</a>
					</span>
				</c:if>
				<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}">
					<span class="disable">다음</span>
				</c:if>
		</td>
	</tr>
</tfoot>
</table>

</div>
</body>
</html>