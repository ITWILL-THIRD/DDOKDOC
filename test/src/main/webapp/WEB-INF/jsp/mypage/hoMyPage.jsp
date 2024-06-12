<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 마이페이지</title>
<jsp:include page="../common/navigation.jsp"/>
</head>
<body>
<h1>병원 마이페이지</h1>
<a href="index.do">메인가기</a>
<hr>
<h2>병원정보</h2>
<form action="updateHoUser.do">
	<table>
		<tr>
			<td>병원아이디</td>
			<td>${hoUser.hosId }</td>
		</tr>
		<tr>
			<td>병원이름</td>
			<td>${hoUser.hosName }</td>
		</tr>
		<tr>
			<td>병원 연락처</td>
			<td>${hoUser.hosPhone }</td>
		</tr>
		<tr>
			<td>분류</td>
			<td>${hoUser.animal }</td>
		</tr>
		<tr>
			<td>평점</td>
			<td>${hoUser.score }</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${hoUser.addressName }</td>
			<td>${hoUser.roadAddressName }</td>
			<td>${hoUser.detailAddress }</td>
		</tr>
		<tr>
			<td>평일 운영시간</td>
			<td>${hoUser.openTime } - ${hoUser.closeTime }</td>
		</tr>
		<tr>
			<td>평일 점심시간</td>
			<td>${hoUser.lunchTime } - ${hoUser.endLunchTime }</td>
		</tr>
		<tr>
			<td>토요일 운영시간</td>
			<td>${hoUser.satOpenTime } - ${hoUser.satCloseTime }</td>
		</tr>
		<tr>
			<td>토요일 점심시간</td>
			<td>${hoUser.satLunchTime } - ${hoUser.satEndLunchTime }</td>
		</tr>
		<tr>
			<td>일요일 운영시간</td>
			<td>
			  <c:choose>
                    <c:when test="${hoUser.sunOpenTime == null && hoUser.sunCloseTime == null}">
                       	 휴무
                    </c:when>
                    <c:otherwise>
                        ${hoUser.sunOpenTime} - ${hoUser.sunCloseTime}
                    </c:otherwise>
                </c:choose>
               </td>
		</tr>
		<tr>
			<td>일요일 점심시간</td>
			<td>
			  <c:choose>
                    <c:when test="${hoUser.sunLunchTime == null && hoUser.sunEndLunchTime == null}">
                       	 휴무
                    </c:when>
                    <c:otherwise>
                        ${hoUser.sunLunchTime} - ${hoUser.sunEndLunchTime}
                    </c:otherwise>
                </c:choose>
               </td>
		</tr>
		<tr>
			<td><input type="hidden" name="hosIdx" value="${hoUser.hosIdx }"></td>
		</tr>
		<tr>
		<td>
			<input type="submit" value="병원정보수정">
		</td>
		<td>
			<input type="button" value="탈퇴하기">
		</td>
		</tr>
	</table>
</form>
<hr>
	<!-- 병원 휴무일 등록 페이지 -->
	<a href="insertHosHoliday.do">휴무일 등록하기</a>
</body>
</html>