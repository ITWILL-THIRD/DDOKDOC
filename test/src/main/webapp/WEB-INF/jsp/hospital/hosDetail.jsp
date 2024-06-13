<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 상세 보기(정보,지도,예약,리뷰)</title>

<jsp:include page="../../css/commonCss.jsp"/>

<jsp:include page="../common/navigation.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
.hidden {
    display: none;
}
.star-rating {
  display:flex;
  flex-direction: row-reverse;
  font-size:30px;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating input {
  display:none;
}

.star-rating label {
  color:#ccc;
  cursor:pointer;
}

.star-rating :checked ~ label {
  color:#f90;
}

.star-rating label:hover,
.star-rating label:hover ~ label {
  color:#fc0;
}

.star-rating2 {
  display:flex;
  flex-direction: row-reverse;
  font-size:30px;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

.star-rating2 input {
  display:none;
}

.star-rating2 label {
  color:#ccc;
  cursor:pointer;
}

.star-rating2 :checked ~ label {
  color:#f90;
}

.star-rating2 label:hover,
.star-rating2 label:hover ~ label {
  color:#fc0;
}
.holiday {
	color: red;
	font: bold;
}
</style>
</head>
<body>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38a906000cd6c18d4d8489d1eddaec85&libraries=services,clusterer,drawing"></script>
<div id="container">
\${user} : ${user }<hr>
\${hospital} : ${hospital}

	<h1>병원 상세 [hosDetail.jsp]</h1>
	<table border="">
		<tr>
			<th>병원명</th>
			<td colspan="2">${hospital.hosName}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td colspan="2">${hospital.roadAddressName} ${hospital.detailAddress}</td>
		</tr>
		<tr>
			<th rowspan="3">진료시간</th>
			<c:set var="openTime" value="${hospital.openTime}"/>
			<c:set var="openTimeSub" value="${fn:substring(openTime, 0, 5)}"/>
			<c:set var="closeTime" value="${hospital.closeTime}"/>
			<c:set var="closeTimeSub" value="${fn:substring(closeTime, 0, 5)}"/>
			<c:set var="lunchTime" value="${hospital.lunchTime}"/>
			<c:set var="lunchTimeSub" value="${fn:substring(lunchTime, 0, 5)}"/>
			<c:set var="endLunchTime" value="${hospital.endLunchTime}"/>
			<c:set var="endLunchTimeSub" value="${fn:substring(endLunchTime, 0, 5)}"/>
			<td>
				평일 ${openTimeSub} - ${closeTimeSub}
			</td>
			<td>
				<c:choose>
					<c:when test="${hospital.lunchOff == 'Y'
 						or hospital.lunchTime == '00:00:00' or hospital.endLunchTime == '00:00:00'
 						or hospital.lunchTime == null or hospital.endLunchTime == null}">
					</c:when>
					<c:otherwise>
						점심 ${lunchTimeSub} - ${endLunchTimeSub}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<c:set var="satOpenTime" value="${hospital.satOpenTime}"/>
			<c:set var="satOpenTimeSub" value="${fn:substring(satOpenTime, 0, 5)}"/>
			<c:set var="satCloseTime" value="${hospital.satCloseTime}"/>
			<c:set var="satCloseTimeSub" value="${fn:substring(satCloseTime, 0, 5)}"/>
			<c:set var="satLunchTime" value="${hospital.satLunchTime}"/>
			<c:set var="satLunchTimeSub" value="${fn:substring(satLunchTime, 0, 5)}"/>
			<c:set var="satEndLunchTime" value="${hospital.satEndLunchTime}"/>
			<c:set var="satEndLunchTimeSub" value="${fn:substring(satEndLunchTime, 0, 5)}"/>
			<td>
				토요일 ${satOpenTimeSub} - ${satCloseTimeSub}
			</td>
			<td>
				<c:choose>
					<c:when test="${hospital.satLunchOff == 'Y'
 						or hospital.satLunchTime == '00:00:00' or hospital.satEndLunchTime == '00:00:00'
 						or hospital.satLunchTime == null or hospital.satEndLunchTime == null}">
					</c:when>
					<c:otherwise>
						점심 ${satLunchTimeSub} - ${satEndLunchTimeSub}
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<c:set var="sunOpenTime" value="${hospital.sunOpenTime}"/>
			<c:set var="sunOpenTimeSub" value="${fn:substring(sunOpenTime, 0, 5)}"/>
			<c:set var="sunCloseTime" value="${hospital.sunCloseTime}"/>
			<c:set var="sunCloseTimeSub" value="${fn:substring(sunCloseTime, 0, 5)}"/>
			<c:set var="sunLunchTime" value="${hospital.sunLunchTime}"/>
			<c:set var="sunLunchTimeSub" value="${fn:substring(sunLunchTime, 0, 5)}"/>
			<c:set var="sunEndLunchTime" value="${hospital.sunEndLunchTime}"/>
			<c:set var="sunEndLunchTimeSub" value="${fn:substring(sunEndLunchTime, 0, 5)}"/>
			<td>
				일요일
				<c:choose>
                    <c:when test="${hospital.sunDayOff == 'Y'
                     	or hospital.sunOpenTime == null or hospital.sunCloseTime == null}">
                      	<span class="holiday">휴무</span>
                    </c:when>
					<c:otherwise>
						 ${sunOpenTimeSub} - ${sunCloseTimeSub}
					</c:otherwise>
				</c:choose>
			</td>
			<td>
				<c:choose>
                    <c:when test="${hospital.sunLunchOff == 'Y'
 						or hospital.sunLunchTime == '00:00:00' or hospital.sunEndLunchTime == '00:00:00'
 						or hospital.sunLunchTime == null or hospital.sunEndLunchTime == null}">
					</c:when>
					<c:otherwise>
						점심 ${sunLunchTimeSub} - ${sunEndLunchTimeSub}
					</c:otherwise>
                </c:choose>
			</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td colspan="2">${hospital.hosPhone}</td>
		</tr>
		<tr>
			<th>병원분류</th>
			<td colspan="2">${hospital.animal}</td>
		</tr>
		<tr>
			<th>평점</th>
			<td colspan="2">${hospital.score}</td>
		</tr>
	</table>
	<p>
		<!-- CSS 사진 이동 처리 -->
		<c:forEach var="img" items="${imgList}">
			<img src="${img.hosImg}" alt="병원 내부사진" width="300px">
		</c:forEach> 
	</p>

	<h4>리뷰 목록</h4>
	<div id="review">
		<!-- 예약 후 진료 완료 상태인 사용자만 form 작성 가능 -->
		<c:if test="${not empty finishList}">
		    <form id="reviewForm"  action="insertReview.do" method="post">
		    	<p>방문일</p>
		    	<!-- 진료 완료 상태인 내역 선택 -->
		        <select id="finishSelect" onchange="updateHiddenField()">
		        	<option>리뷰를 작성할 방문일을 선택하세요.</option>
		            <c:forEach var="finish" items="${finishList}">
		                <option value="${finish.reserIdx}">
		                    <!-- openTime과 closeTime을 HH:MM 형식으로 변환 -->
		                    <fmt:formatDate value="${finish.reserTime}" pattern="HH:mm" var="reserTime" />
		                    ${finish.reserDate} &nbsp; ${reserTime} &nbsp; ${finish.petName}
		                </option>
		            </c:forEach>
		        </select>
		        <!-- 선택된 내역의 리뷰 작성 -->
		        <div class="star-rating">
		            <input type="radio" id="5-stars" name="score" value="5" />
		            <label for="5-stars" class="star">&#9733;</label>
		            <input type="radio" id="4-stars" name="score" value="4" />
		            <label for="4-stars" class="star">&#9733;</label>
		            <input type="radio" id="3-stars" name="score" value="3" />
		            <label for="3-stars" class="star">&#9733;</label>
		            <input type="radio" id="2-stars" name="score" value="2" />
		            <label for="2-stars" class="star">&#9733;</label>
		            <input type="radio" id="1-star" name="score" value="1" />
		            <label for="1-star" class="star">&#9733;</label>
		        </div>
		        <input type="text" name="content" placeholder="리뷰를 작성하세요.">
		        <input type="hidden" name="hosIdx" value="${hospital.hosIdx}">
		        <input type="hidden" id="selectedReserIdx" name="reserIdx" value="" />
		        <input type="submit" value="리뷰 작성">
		    </form>
		</c:if>

		<table border=1>
			<tr>
				<th>닉네임</th>
				<th>내용</th>
				<th>평점</th>
				<th>방문일</th>
				<th>등록일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tbody>
				<c:forEach var="review" items="${reviewList}">
				    <tr id="view_${review.reviewIdx}">
				        <td id="nickname_view_${review.reviewIdx}">${review.nickname}</td>
				        <td id="content_view_${review.reviewIdx}">${review.content}</td>
				        <td id="score_view_${review.reviewIdx}">
				            <c:choose>
				                <c:when test="${review.score eq 1}">&#9733;</c:when>
				                <c:when test="${review.score eq 2}">&#9733;&#9733;</c:when>
				                <c:when test="${review.score eq 3}">&#9733;&#9733;&#9733;</c:when>
				                <c:when test="${review.score eq 4}">&#9733;&#9733;&#9733;&#9733;</c:when>
				                <c:when test="${review.score eq 5}">&#9733;&#9733;&#9733;&#9733;&#9733;</c:when>
				            </c:choose>
				        </td>
				        <td>${review.reserDate}</td>
				        <td>${review.reviewDate}</td>
				        <!-- 사용자 본인만 리뷰 수정,삭제 가능 -->		        
				        <c:if test="${review.userIdx eq userIdx}">	        
					        <td><button class="editReview_btn" type="button" onclick="editReview(${review.reviewIdx})">수정</button></td>
					    	<form id="deleteReviewForm_${review.reviewIdx }" action="deleteReview.do" action="POST">				    
						        <td>				 
						        	<input type="hidden" name="reviewIdx" value="${review.reviewIdx}">
							        <input type="hidden" name="hosIdx" value="${hospital.hosIdx}">			        	
       						        <input type="hidden" name="reserIdx" value="${review.reserIdx}">			        	
						        	<input type="submit" value="삭제" onClick="confirmDelete(${review.reviewIdx})">    
						        </td> 
						    </form>
				        </c:if>
				    </tr>
				
				
				    <tr id="edit_${review.reviewIdx}" class="hidden">
					    <form action="updateReview.do" method="POST">
					        <td>${review.nickname}</td>	        
					        <td>
					            <textarea id="content_${review.reviewIdx}" name="content">${review.content}</textarea>
					        </td>
					        <td>
					            <div class="star-rating2">
					                <input type="radio" id="5-stars_${review.reviewIdx}" name="score" value="5" ${review.score == 5 ? 'checked' : ''} />
					                <label for="5-stars_${review.reviewIdx}" class="star">&#9733;</label>
					                <input type="radio" id="4-stars_${review.reviewIdx}" name="score" value="4" ${review.score == 4 ? 'checked' : ''} />
					                <label for="4-stars_${review.reviewIdx}" class="star">&#9733;</label>
					                <input type="radio" id="3-stars_${review.reviewIdx}" name="score" value="3" ${review.score == 3 ? 'checked' : ''} />
					                <label for="3-stars_${review.reviewIdx}" class="star">&#9733;</label>
					                <input type="radio" id="2-stars_${review.reviewIdx}" name="score" value="2" ${review.score == 2 ? 'checked' : ''} />
					                <label for="2-stars_${review.reviewIdx}" class="star">&#9733;</label>
					                <input type="radio" id="1-star_${review.reviewIdx}" name="score" value="1" ${review.score == 1 ? 'checked' : ''} />
					                <label for="1-star_${review.reviewIdx}" class="star">&#9733;</label>
					            </div>
					        </td>
					        <td>${review.reviewDate}</td>
					        <td>
						        <input type="hidden" name="hosIdx" value="${hospital.hosIdx}">
						        <input type="hidden" name="reviewIdx" value="${review.reviewIdx}">
					        	<input type="submit" value="저장">
					        </td>
					    </form>
					    <td><button class="cancelEdit_btn" type="button" onClick="cancelEdit(${review.reviewIdx})">취소</button></td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

	<h4>지도 표시</h4>
	<div id="map" style="width: 300px; height: 300px; margin-top: 10px;"></div>

	<p class="center">
		<!-- 예약 버튼 함수실행으로 수정 -->
		<input type="button" value="예약" onclick="userCheck('${user}')"/>
		<button ></button>
		<a href="hosMain.do">병원 목록</a>
	</p>

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
			<c:forEach var="notice" items="${noticeList }">
				<tr>
					<td>${notice.noticeDate }</td>
					<td><a
						href="../notice/getNotice.do?hosIdx=${notice.hosIdx}&noticeIdx=${notice.noticeIdx }">${notice.noticeTitle }</a>
					</td>
					<td>${notice.hit }</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
<jsp:include page="partials/hosDatailJS.jsp"></jsp:include>
<script>
//로그인 유무 체크
	function userCheck(user) {
		if (user == null) {
			alert("로그인 후 예약이 가능합니다.")
			location.href="../user/login.do";
		} else {
			location.href="../reservation/reservation.do?hosIdx=" + ${hospital.hosIdx};
		}
	}
</script>
</body>
</html>