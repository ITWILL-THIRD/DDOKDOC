<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 마이페이지</title>
<jsp:include page="../common/navigation.jsp"/>
<script>
function hosDelete_ok(frm) {
	if (confirm("정말로 탈퇴하시겠습니까?")) {
        frm.action = "deleteHos.do"; // 탈퇴 요청을 보낼 URL을 지정합니다.
        frm.method = "POST";
        frm.submit(); // 폼을 제출합니다.
    }
}
</script>
<style>
	.holiday {
		color: red;
		font: bold;
	}
</style>
</head>
<body>
<h1>병원 마이페이지</h1>
<hr>
<h2>병원정보</h2>
\${hoUser} : ${hoUser}
<form action="updateHoUser.do">
	<table border="">
		<tr>
			<th>병원아이디</th>
			<td colspan="2">${hoUser.hosId }</td>
		</tr>

		<tr>
			<th>병원이름</th>
			<td colspan="2">${hoUser.hosName }</td>
		</tr>
		<tr>
			<th>병원 연락처</th>
			<td colspan="2">${hoUser.hosPhone }</td>
		</tr>
		<tr>
			<th>분류</th>
			<td colspan="2">${hoUser.animal }</td>
		</tr>
		<tr>
			<th>평점</th>
			<td colspan="2">${hoUser.score }</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${hoUser.roadAddressName }</td>
			<td>${hoUser.detailAddress }</td>
		</tr>
		<tr>
			<th rowspan="6">진료시간</th>
			<c:set var="openTime" value="${hoUser.openTime}"/>
			<c:set var="openTimeSub" value="${fn:substring(openTime, 0, 5)}"/>
			<c:set var="closeTime" value="${hoUser.closeTime}"/>
			<c:set var="closeTimeSub" value="${fn:substring(closeTime, 0, 5)}"/>
			<td colspan="2">평일
		        <c:choose>
		            <c:when test="${openTimeSub == '00:00' and closeTimeSub == '23:59'}">
		                24시간
		            </c:when>
		            <c:otherwise>
		                ${openTimeSub} - ${closeTimeSub}
		            </c:otherwise>
		        </c:choose>
		    </td>
			
		</tr>
		<tr>
			<c:set var="lunchTime" value="${hoUser.lunchTime}"/>
			<c:set var="lunchTimeSub" value="${fn:substring(lunchTime, 0, 5)}"/>
			<c:set var="endLunchTime" value="${hoUser.endLunchTime}"/>
			<c:set var="endLunchTimeSub" value="${fn:substring(endLunchTime, 0, 5)}"/>
			<td colspan="2">
				<c:choose>
					<c:when test="${hoUser.lunchOff == 'Y'
						or hoUser.lunchTime == '00:00:00' or hoUser.endLunchTime == '00:00:00'
						or hoUser.lunchTime == null or hoUser.endLunchTime == null}">
					</c:when>
					
					<c:otherwise>
						점심 ${lunchTimeSub} - ${endLunchTimeSub}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<c:set var="satOpenTime" value="${hoUser.satOpenTime}"/>
			<c:set var="satOpenTimeSub" value="${fn:substring(satOpenTime, 0, 5)}"/>
			<c:set var="satCloseTime" value="${hoUser.satCloseTime}"/>
			<c:set var="satCloseTimeSub" value="${fn:substring(satCloseTime, 0, 5)}"/>
			
			<td colspan="2">토요일
		        <c:choose>
		            <c:when test="${satOpenTimeSub == '00:00' and satCloseTimeSub == '23:59'}">
		                24시간
		            </c:when>
		            <c:otherwise>
		                ${satOpenTimeSub} - ${satCloseTimeSub}
		            </c:otherwise>
		        </c:choose>
		    </td>
			
		</tr>
		<tr>
			<c:set var="satLunchTime" value="${hoUser.satLunchTime}"/>
			<c:set var="satLunchTimeSub" value="${fn:substring(satLunchTime, 0, 5)}"/>
			<c:set var="satEndLunchTime" value="${hoUser.satEndLunchTime}"/>
			<c:set var="satEndLunchTimeSub" value="${fn:substring(satEndLunchTime, 0, 5)}"/>
			<td colspan="2">
				<c:choose>
					<c:when test="${hoUser.satLunchOff == 'Y'
						or hoUser.satLunchTime == '00:00:00' or hoUser.satEndLunchTime == '00:00:00'
						or hoUser.satLunchTime == null or hoUser.satEndLunchTime == null}">
					</c:when>
					<c:otherwise>
						점심 ${satLunchTimeSub} - ${satEndLunchTimeSub}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<c:set var="sunOpenTime" value="${hoUser.sunOpenTime}"/>
			<c:set var="sunOpenTimeSub" value="${fn:substring(sunOpenTime, 0, 5)}"/>
			<c:set var="sunCloseTime" value="${hoUser.sunCloseTime}"/>
			<c:set var="sunCloseTimeSub" value="${fn:substring(sunCloseTime, 0, 5)}"/>
			<td colspan="2">일요일
			  <c:choose>
                    <c:when test="${hoUser.sunDayOff == 'Y'
                    	or hoUser.sunOpenTime == null or hoUser.sunCloseTime == null}">
                      	<span class="holiday">휴무</span>
                    </c:when>
                     <c:when test="${sunOpenTime == '00:00:00' and sunCloseTime == '23:59:00'}">
		                24시간
		            </c:when>
                    <c:otherwise>
						${sunOpenTimeSub} - ${sunCloseTimeSub}
                    </c:otherwise>
                </c:choose>
               </td>
		</tr>
		<tr>
			<c:set var="sunLunchTime" value="${hoUser.sunLunchTime}"/>
			<c:set var="sunLunchTimeSub" value="${fn:substring(sunLunchTime, 0, 5)}"/>
			<c:set var="sunEndLunchTime" value="${hoUser.sunEndLunchTime}"/>
			<c:set var="sunEndLunchTimeSub" value="${fn:substring(sunEndLunchTime, 0, 5)}"/>
			<td colspan="2">
			  <c:choose>
                    <c:when test="${hoUser.sunDayOff == 'Y'
                    	or hoUser.sunLunchTime == '00:00:00' or hoUser.sunEndLunchTime == '00:00:00'
                    	or hoUser.sunLunchTime == null or hoUser.sunEndLunchTime == null}">
                    </c:when>
                    <c:otherwise>
                    	점심 ${sunLunchTimeSub} - ${sunEndLunchTimeSub}
                    </c:otherwise>
                </c:choose>
               </td>
		</tr>
	
		<tr>
			<td colspan="3">
				<input type="hidden" name="hosIdx" value="${hoUser.hosIdx }">
				<input type="submit" value="병원정보수정">
				<input type="button" value="탈퇴하기" onclick="hosDelete_ok(this.form)">
			</td>
		</tr>
	</table>
</form>
<hr>

<p><a href="hosNoticeList.do">공지사항 내역</a></p>
<p><a href="#">병원예약 현황</a></p>
<p><a href="hosReviewList.do">리뷰 목록 조회</a></p>
	<!-- 병원 휴무일 등록 페이지 -->
	<a href="insertHosHoliday.do">휴무일 등록하기</a>
</body>
</html>