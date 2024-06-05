<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 상세 보기(정보,지도,예약,리뷰)</title>
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

</style>
</head>
<body>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38a906000cd6c18d4d8489d1eddaec85&libraries=services,clusterer,drawing"></script>

<div id="container">

	<h1>병원 상세 [hosDetail.jsp]</h1>
	<table>

		<tr>
			<th>병원명</th>
			<td>${hospital.hosName}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${hospital.roadAddressName}${hospital.detailAddress}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${hospital.hosPhone}</td>
		</tr>
		<tr>
			<th>진료시간</th>
			<td>${hospital.openTime}~${hospital.closeTime}</td>
		</tr>
		<tr>
			<th>진료동물</th>
			<td>${hospital.animal}</td>
		</tr>
		<tr>
			<th>평점</th>
			<td>${hospital.score}</td>
		</tr>
	</table>

	<h4>리뷰 목록</h4>
	<div id="review">
		<!-- 예약자만 리뷰 작성 가능하도록 추가하기 -->

		<form action="insertReview.do" method="post">
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
			<input type="hidden" name="score" value="">
			<input type="submit" value="리뷰 작성">
		</form>

		<table border=1>
			<tr>
				<th>닉네임</th>
				<th>내용</th>
				<th>평점</th>
				<th>등록일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tbody id="listDisp">
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
						<td>${review.reviewDate}</td>
						<td><button class="editReview_btn" type="button" data-reviewIdx="${review.reviewIdx}">수정</button></td>
						<td><a href="deleteReview.do?reviewIdx=${review.reviewIdx}">삭제</a></td>
					</tr>
				
					<tr id="edit_${review.reviewIdx}" class="hidden">
						<td>${review.nickname}</td>
						<td><textarea id="content_${review.reviewIdx}" name="updateContent">${review.content}</textarea></td>
						<td>
							<div class="star-rating2">
								<input type="radio" id="5-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="5" ${review.score == 5 ? 'checked' : ''} />
								<label for="5-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="4-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="4" ${review.score == 4 ? 'checked' : ''} />
								<label for="4-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="3-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="3" ${review.score == 3 ? 'checked' : ''} />
								<label for="3-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="2-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="2" ${review.score == 2 ? 'checked' : ''} />
								<label for="2-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="1-star_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="1" ${review.score == 1 ? 'checked' : ''} />
								<label for="1-star_${review.reviewIdx}" class="star">&#9733;</label>
							</div>
						</td>
						<td>${review.reviewDate}</td>
						<td><button class="saveReview_btn" type="button" data-hosIdx="${hospital.hosIdx}" data-reviewIdx="${review.reviewIdx}">저장</button></td>
						<td><button class="cancelEdit_btn" type="button" data-reviewIdx="${review.reviewIdx}">취소</button></td>
					</tr>
					<tr id="view_${review.reviewIdx}">
						<td id="nickname_view_${review.reviewIdx}">${review.nickname}</td>
						<td id="content_view_${review.reviewIdx}">${review.content}</td>
						<td id="score_view_${review.reviewIdx}">
							<c:choose>
								<c:when test="${review.score eq 1}">★</c:when>
								<c:when test="${review.score eq 2}">★★</c:when>
								<c:when test="${review.score eq 3}">★★★</c:when>
								<c:when test="${review.score eq 4}">★★★★</c:when>
								<c:when test="${review.score eq 5}">★★★★★</c:when>
							</c:choose>
						</td>
						<td>${review.reviewDate}</td>
						<td><button class="editReview_btn" type="button" data-reviewIdx="${review.reviewIdx}">수정</button></td>
						<td><a href="deleteReview.do?reviewIdx=${review.reviewIdx}">삭제</a></td>
					</tr>
					
					<tr id="edit_${review.reviewIdx}" class="hidden">
						<td>${review.nickname}</td>
						<td><textarea id="content_${review.reviewIdx}" name="updateContent">${review.content}</textarea></td>
						<td>
							<div class="star-rating2">
								<input type="radio" id="5-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="5" ${review.score == 5 ? 'checked' : ''} />
								<label for="5-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="4-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="4" ${review.score == 4 ? 'checked' : ''} />
								<label for="4-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="3-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="3" ${review.score == 3 ? 'checked' : ''} />
								<label for="3-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="2-stars_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="2" ${review.score == 2 ? 'checked' : ''} />
								<label for="2-stars_${review.reviewIdx}" class="star">&#9733;</label>
								<input type="radio" id="1-star_${review.reviewIdx}" name="updateScore_${review.reviewIdx}" value="1" ${review.score == 1 ? 'checked' : ''} />
								<label for="1-star_${review.reviewIdx}" class="star">&#9733;</label>
							</div>
						</td>
						<td>${review.reviewDate}</td>
						<td><button class="saveReview_btn" type="button" data-hosIdx="${hospital.hosIdx }" data-reviewIdx="${review.reviewIdx}">저장</button></td>
						<td><button class="cancelEdit_btn" type="button" data-reviewIdx="${review.reviewIdx}">취소</button></td>
					</tr>
				</c:forEach>
			</tbody>

		</table>
	</div>

	<h4>지도 표시</h4>
	<div id="map" style="width: 300px; height: 300px; margin-top: 10px;"></div>

	<p class="center">
		<a href="../reservation/reservation.do?hosIdx=1">예약</a> 
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
</body>
</html>