<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글목록</title>
<jsp:include page="../../css/postListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<div id="container">
	<h1>정보나눔</h1>
	<!-- 검색 -->
	<form action="getBoardList.do" method="get">
	<table class="border-none">
		<tr>
			<td>
				<select name="searchCondition" class="select">
				<c:forEach var="option" items="${conditionMap }">
					<option value="${option.value}">${option.key }</option>
				</c:forEach>
				<input type="text" name="searchKeyword" class="searchInput">
				<input type="submit" value="검색" class="searchBtn">
				</select>
			</td>
		</tr>
	</table>
	<div id="category" class="center">
		<a href="getBoardList.do">전체</a>
		<a class="none">|</a>
		<a href="getBoardList.do?category=free">자유</a>
		<a class="none">|</a>
		<a href="getBoardList.do?category=med">의료</a>
		<a class="none">|</a>
		<a href="getBoardList.do?category=feed">사료/간식</a>
		<a class="none">|</a>
		<a href="getBoardList.do?category=goods">용품</a>
	</div>
	</form>
	<script>
		document.addEventListener('DOMContentLoaded', (event) => {
	        // 현재 URL에서 searchCondition 값을 가져옵니다.
	        const params = new URLSearchParams(window.location.search);
	        const category = params.get('category');
	        
	        // 모든 링크 요소를 가져옵니다.
	        const links = document.querySelectorAll('#category a');
	        
	        // 각 링크의 href 속성을 확인하여 searchCondition에 해당하는 경우 active 클래스를 추가합니다.
	        links.forEach(link => {
	            const url = new URL(link.href, window.location.origin);
	            if (url.searchParams.get('category') === category) {
	                link.classList.add('active');
	            }
	
	            // 링크 클릭 시 이벤트를 가로채서 기본 동작을 방지합니다.
	            link.addEventListener('click', (event) => {
	                event.preventDefault();
	                //alert(url.href); // 클릭한 링크의 URL을 출력합니다.
	                
	                const text = url.href;
	                const searchString = "todoc";


	                const result = extractStringAfter(text, searchString);
	                console.log(result);
	                
	                function extractStringAfter(text, searchString) {
	                    const index = text.indexOf(searchString);
	                    if (index === -1) {
	                        // searchString이 text에 없는 경우
	                        return null;
	                    }
	                    // 검색된 문자열의 끝 인덱스 이후의 문자열을 추출
	                    return text.slice(index + searchString.length);
	                }
	                // 여기서 원하는 동작을 수행
	                const locRef = ".." + result;
					location.href = locRef;
	            });
	        });
	    });
	</script>
	
	<hr>
	<!-- 데이터 표시영역 -->
	<table border frame=void>
		<thead>
			<tr>
				<th width="50">번호</th>
				<th width="100">카테고리</th>
				<th width="310">제목</th>
				<th width="150">작성자</th>
				<th width="140">작성일</th>
				<th width="50">조회수</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="board" items="${boardList }">
			<tr>
				<td class="center">${board.postidx }</td>
				<td class="center">
					<c:choose>
                        <c:when test="${board.category == 'free'}">자유</c:when>
                        <c:when test="${board.category == 'med'}">의료</c:when>
                        <c:when test="${board.category == 'feed'}">사료/간식</c:when>
                        <c:when test="${board.category == 'goods'}">용품</c:when>
                        <c:otherwise>자유</c:otherwise>
                    </c:choose>
                </td>    
				<td>
					<a href="getBoard.do?postidx=${board.postidx }">${board.title }</a>
				</td>
				<td>${board.nickname }</td>
				<td>${board.formattedDate }</td>
				<td>${board.hit }</td>
			</tr>
		</c:forEach>
		</tbody>
		<tfoot id="paging">
			<tr>
				<td colspan="9">
					<!-- [이전]에 대한 사용여부 처리 -->
					<c:if test="${pagingVO.nowPage == 1}">
						<span class="disable">이전</span>
					</c:if>
					<c:if test="${pagingVO.nowPage != 1}">
						<c:if test="${not empty searchCondition}">
						<c:choose>
							<c:when test="${searchCondition == 'CONTENT'}">
								<span>
									<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage - 1}&searchCondition=${content}">이전</a>
								</span>
							</c:when>
							<c:when test="${searchCondition == 'TITLE'}">
								<span>
									<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage - 1}&searchCondition=${title}">이전</a>
								</span>
							</c:when>
							<c:otherwise>
								<span>
									<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage - 1}">이전</a>
								</span>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${not empty category}">
							<span>
								<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage - 1}&category=${category}">이전</a>
							</span>
						</c:if>
						<c:if test="${empty searchCondition && empty category}">
							<span>
								<a href="getBoardList.do?cPage=${pagingVO.nowPage - 1}">이전</a>
							</span>
						</c:if>
					</c:if>
						
					<!-- 블록내에 표시할 페이지 태그 작성(시작~끝) -->
					<c:forEach var="pageNo" begin="${pagingVO.beginPage}" end="${pagingVO.endPage}">
					<c:choose>
						<c:when test="${pageNo == pagingVO.nowPage}">
							<span class="now">${pageNo}</span>
						</c:when>
						<c:otherwise>
							<c:if test="${not empty searchCondition}">
							<c:choose>
								<c:when test="${searchCondition == 'CONTENT'}">
									<span>
										<a href="getSearchBoardList.do?cPage=${pageNo}&searchCondition=${content}">${pageNo}</a>
									</span>
								</c:when>
								<c:when test="${searchCondition == 'TITLE'}">
									<span>
										<a href="getSearchBoardList.do?cPage=${pageNo}&searchCondition=${title}">${pageNo}</a>
									</span>
								</c:when>								
								<c:otherwise>
									<span>
										<a href="getSearchBoardList.do?cPage=${pageNo}">${pageNo}</a>
									</span>
								</c:otherwise>
							</c:choose>
							</c:if>
							<c:if test="${not empty category}">
							<span>
								<a href="getSearchBoardList.do?cPage=${pageNo}&category=${category}">${pageNo}</a>
							</span>
							</c:if>
							<c:if test="${empty searchCondition && empty category}">
								<span>
									<a href="getBoardList.do?cPage=${pageNo}">${pageNo}</a>
								</span>
							</c:if>
						</c:otherwise>
					</c:choose>
					</c:forEach>
					
					<!-- [다음]에 대한 사용여부 처리 -->
					<c:if test="${pagingVO.nowPage < pagingVO.totalPage}">
						<c:if test="${not empty searchCondition}">
						<c:choose>
							<c:when test="${searchCondition == 'CONTENT'}">
								<span>
									<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage + 1}&searchCondition=${content}">다음</a>
								</span>
							</c:when>
							<c:when test="${searchCondition == 'TITLE'}">
								<span>
									<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage + 1}&searchCondition=${title}">다음</a>
								</span>
							</c:when>			
							<c:otherwise>
								<span>
									<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage + 1}">다음</a>
								</span>
							</c:otherwise>
						</c:choose>
						</c:if>
						<c:if test="${not empty category}">
							<span>
								<a href="getSearchBoardList.do?cPage=${pagingVO.nowPage + 1}&category=${category}">다음</a>
							</span>
						</c:if>
						<c:if test="${empty searchCondition && empty category}">
							<span>
								<a href="getBoardList.do?cPage=${pagingVO.nowPage + 1}">다음</a>
							</span>
						</c:if>
					</c:if>
					<c:if test="${pagingVO.nowPage >= pagingVO.totalPage}">
						<span class="disable">다음</span>
					</c:if>
				</td>
			</tr>
		</tfoot>
	</table>
	<c:if test="${not empty sessionScope.user}">
			<p><a href="getInsertBoard.do">새글등록</a></p>
	</c:if>  

</div>

</body>
</html>












