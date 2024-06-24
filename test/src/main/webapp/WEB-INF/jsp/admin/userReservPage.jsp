<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userReservPage</title>
<jsp:include page="../../css/getUserListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<h1>회원 예약현황</h1>
<div id="container">
<a href="getUserList.do">회원관리목록 가기</a>

<%-- \${userReserList } : ${userReserList }<br> --%>
<%-- \${pagingVO} : ${pagingVO}<br> --%>
<%-- ${condition } --%>
<%-- ${userIdx } --%>
<!-- 카테고리별  -->

<div id="condition" class="center">
	<a href="userReservPage.do?userIdx=${userIdx}">전체</a>
	<a class="none">|</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=RESERVATION">예약완료</a>
	<a class="none">|</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=CANCLE">예약취소</a>
	<a class="none">|</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=FINISH">진료완료</a>
	<a class="none">|</a>
	<a href="userReservPage.do?userIdx=${userIdx}&condition=REVIEW">리뷰작성</a>
</div>


<script>
		document.addEventListener('DOMContentLoaded', (event) => {
	        // 현재 URL에서 searchCondition 값을 가져옵니다.
	        const params = new URLSearchParams(window.location.search);
	        const condition = params.get('condition');
	        
	        // 모든 링크 요소를 가져옵니다.
	        const links = document.querySelectorAll('#condition a');
	        
	        // 각 링크의 href 속성을 확인하여 searchCondition에 해당하는 경우 active 클래스를 추가합니다.
	        links.forEach(link => {
	            const url = new URL(link.href, window.location.origin);
	            if (url.searchParams.get('condition') === condition) {
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
<table border frame=void  style="width:100%">
	<c:choose>
		<c:when test="${empty userReserList}">
			<p>내역이 없습니다.</p>
		</c:when>
		<c:otherwise>
			<tr>
				<th height="35px">병원이름</th>
				<th>마이펫</th>
				<th>날짜</th>
				<th>시간</th>
				<th>메모</th>
				<th>상태</th>
			</tr>
		<c:forEach var="reser" items="${userReserList }">
			<tr>
				<td height="30px">${reser.hosName }</td>
				<td>${reser.petName }</td>
				<td>${reser.reserDate }</td>
				<td>${reser.formattedTime }</td>
				<td>${reser.memo }</td>
				<td>
	                <c:choose>
	                    <c:when test="${reser.condition == 'RESERVATION'}">
	                        	예약완료
	                    </c:when>
	                    <c:when test="${reser.condition == 'CANCLE'}">
	                       	 	예약취소
	                    </c:when>
	                    <c:when test="${reser.condition == 'REVIEW'}">
	                        	리뷰작성
	                    </c:when>
	                    <c:when test="${reser.condition == 'FINISH'}">
	                        	진료완료
	                    </c:when>
	                    <c:otherwise>
	                       	 알 수 없음
	                    </c:otherwise>
	                </c:choose>
	            </td>
			</tr>
		</c:forEach>
		</c:otherwise>
	</c:choose>
	<c:if test="${not empty userReserList}">
	<tfoot id="paging">
	<tr>
	 <td colspan="6">
            <!-- [이전]에 대한 사용여부 처리 -->
            <c:if test="${pagingVO.nowPage == 1}">
                <span class="disable">이전</span>
            </c:if>
            <c:if test="${pagingVO.nowPage != 1}">
                <span>
                    <a href="userReservPage.do?cPage=${pagingVO.nowPage - 1}&userIdx=${userIdx }&condition=${condition}">이전</a>
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
                            <a href="userReservPage.do?cPage=${pageNo}&userIdx=${userIdx }&condition=${condition}">${pageNo}</a>
                        </span>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <!-- [다음]에 대한 사용여부 처리 -->
            <c:if test="${pagingVO.nowPage < pagingVO.totalPage}">
                <span>
                    <a href="userReservPage.do?cPage=${pagingVO.nowPage + 1}&userIdx=${userIdx }&condition=${condition}">다음</a>
                </span>
            </c:if>
            <c:if test="${pagingVO.nowPage >= pagingVO.totalPage}">
                <span class="disable">다음</span>
            </c:if>
        </td>
			</tr>
	<tfoot>
	</c:if>
</table>
</div>
</body>
</html>