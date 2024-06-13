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
	<table>
		<tr>
			<td>
				<select name="searchType">
				<c:forEach var="option" items="${conditionMap }">
				<option value="${option.value }">${option.key }</option>
				</c:forEach>
				</select> 
				<input type="text" name="searchKeyword" placeholder="회원검색" /> 
				<input type="submit" value="검색" />
			</td>
			<td><input type="button" value="새로고침" onclick="resetForm()"></td>
		</tr>
	</table>
</form>

<table>
 <tr>
            <th width="10%">회원 번호</th>
            <th width="10%">프로필</th>
            <th width="10%">이메일</th>
            <th width="10%">닉네임</th>
            <th width="10">이름</th>
            <th width="20%">생년월일</th>
            <th width="20%">전화번호</th>
        </tr>
 <c:choose>
        <c:when test="${empty getUserList}">
            <tr>
                <td colspan="8" style="text-align:center;">검색 결과가 없습니다</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="user" items="${getUserList}">
                <tr>
                    <td>${user.userIdx}</td>
                    <td><img src="${user.userImg}" height="50px"></td>
                    <td>${user.email}</td>
                    <td>${user.nickname}</td>
                    <td>${user.name}</td>
                    <td>${user.birth}</td>
                    <td>${user.phone}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</table>
</div>
</body>
</html>