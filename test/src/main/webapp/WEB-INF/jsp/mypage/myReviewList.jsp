<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지난 예약 내역</title>
<%-- <jsp:include page="../../css/postCss.jsp"/> --%>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
.hidden {
    display: none;
}
h1 { text-align: center; }
#container {
    padding: 0;
    margin:0 auto;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
    width: 800px;
}
.center {text-align: center;}
.left {text-align: left;}

.star-rating {
  display:flex;
  flex-direction: row-reverse;
  font-size:30px;
  justify-content:space-around;
  padding:0 .2em;
  text-align:center;
  width:5em;
}

th {
	background-color: #E0EAF5;
}

hr {
	width: 760px;
	border: 1px solid #2C307D;
	display: flex; 
}

table {
	margin: 20px auto;
    text-align: center;
    border-collapse: collapse; 
	border: none;
	text-align: center; 
}

tr {
    border-top: 1px solid #f0f1f1;
    border-bottom: 1px solid #f0f1f1;
    height: 30px;
}

#back {
	display: flex; 
	align-items: center;
	float: right;
	text-decoration-line: none;
	color: #000000;
	margin-right: 20px;
}
#back:hover {
	display: flex; 
	align-items: center;
	text-decoration-line: none;
	color: #B6E5FF;
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

#reservation {
	margin: 30px 20px 20px 20px;
}

#review {
	margin: 30px 20px 20px 20px;
}

.ibtn {
	border: none;
	width:70px;
	height: 20px;
	border-radius: 10px 10px;
	background-color: #B6E5FF;
	margin: 3px;
}
.ibtn:hover  {
	color: #FFFFFF; 
	background-color: #86CFF8;
}
.sbtn {
	border: none;
	width:40px;
	height: 20px;
	border-radius: 10px 10px;
	background-color: #B6E5FF;
	margin: 3px;
}
.sbtn:hover  {
	color: #FFFFFF; 
	background-color: #86CFF8;
}

.form {
	position: relative;
	margin-top: 3px;
	width: 200px;
	height: 30px;
	border: 1px solid #bbb;
	border-radius: 7px;
/* 		padding: 10px 12px; */
	font-size: 14px;
} 

	/* 모달 배경 */
.modal {
    display: none; /* 기본적으로 숨김 */
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0, 0, 0);
    background-color: rgba(0, 0, 0, 0.4);
    padding-top: 60px;
}

/* 모달 */
.modal-content {
    background-color: #fefefe;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #888;
    width: 30%;
}

/* 닫기 버튼 */
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}

.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
.modal-data {
    text-align: left; 
}
.modal-content p {
    margin: 0; 
    padding: 5px 0; 
}
.inline-group {
    display: flex;
}
.inline-group p {
    margin-right: 10px;
    margin-left: 8px;
}
#modalHosName {
	font-size: 16px;
	font-weight: bold;
}
	
.inline-container {
    display: inline-flex;
    align-items: center; /* 아이콘과 텍스트를 수직으로 중앙 정렬 */
}
.inline-container svg {
    margin-right: 8px; /* 아이콘과 텍스트 사이의 간격 조정 */
}
</style>
</head>
<body>
	<h1>나의 리뷰</h1>
	<div id="container">
<!-- 		<h2 class="left">지난 예약 내역</h2> -->
		
		<!-- 마이페이지로 돌아가기 -->
		<span>
		    <a href="../mypage/myPage.do" id="back">
		        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-backspace-reverse-fill" viewBox="0 0 16 16">
		            <path d="M0 3a2 2 0 0 1 2-2h7.08a2 2 0 0 1 1.519.698l4.843 5.651a1 1 0 0 1 0 1.302L10.6 14.3a2 2 0 0 1-1.52.7H2a2 2 0 0 1-2-2zm9.854 2.854a.5.5 0 0 0-.708-.708L7 7.293 4.854 5.146a.5.5 0 1 0-.708.708L6.293 8l-2.147 2.146a.5.5 0 0 0 .708.708L7 8.707l2.146 2.147a.5.5 0 0 0 .708-.708L7.707 8z"/>
		        </svg> &nbsp;돌아가기
		    </a>
		</span>

		<div id="reservation">
		<h3 class="left">
		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-highlighter" viewBox="0 0 16 16">
		  <path fill-rule="evenodd" d="M11.096.644a2 2 0 0 1 2.791.036l1.433 1.433a2 2 0 0 1 .035 2.791l-.413.435-8.07 8.995a.5.5 0 0 1-.372.166h-3a.5.5 0 0 1-.234-.058l-.412.412A.5.5 0 0 1 2.5 15h-2a.5.5 0 0 1-.354-.854l1.412-1.412A.5.5 0 0 1 1.5 12.5v-3a.5.5 0 0 1 .166-.372l8.995-8.07zm-.115 1.47L2.727 9.52l3.753 3.753 7.406-8.254zm3.585 2.17.064-.068a1 1 0 0 0-.017-1.396L13.18 1.387a1 1 0 0 0-1.396-.018l-.068.065zM5.293 13.5 2.5 10.707v1.586L3.707 13.5z"/>
		</svg>&nbsp;
		리뷰 작성을 기다리고 있어요</h3>
		<hr>
	    <table>
	        <thead>
	            <tr>
	            	<th width="160px">병원명</th>
	                <th width="160px">방문일</th>
	                <th width="160px">방문시간</th>
	                <th width="160px">동물이름</th>
	                <th width="160px"> </th>
	            </tr>
	        </thead>
	        <c:if test="${empty reviewToWrite}">
				<tr>
					<td colspan="7">진료 내역이 없습니다.</td>
				</tr>
			</c:if>
			<!-- 예약 후 진료 완료 상태만 form 작성 가능 -->
			<c:if test="${not empty reviewToWrite}">
			    <tbody>
			        <c:if test="${empty reviewToWrite}">
			            <tr>
			                <td colspan="7">리뷰 내역이 없습니다.</td>
			            </tr>
			        </c:if>
			        <form id="reviewForm" action="myReviewInsert.do" method="post">
			            <c:forEach var="finish" items="${reviewToWrite}">
			                <tr>
			                    <td>${finish.hosName}</td>
			                    <td>${finish.reserDate}</td>
			                    <td>
			                        <fmt:formatDate value="${finish.reserTime}" pattern="HH:mm" var="reserTime"/>
			                        ${reserTime}
			                    </td>
			                    <td>${finish.petName}</td>
			                    <td>
								    <button type="button" class="ibtn" onclick="showReviewForm('${finish.reserIdx}', '${finish.hosIdx}', '${finish.reserDate}', '${reserTime}', '${finish.hosName}', '${finish.petName}')">리뷰 작성</button>
								</td>
			                </tr>
			            </c:forEach>
			        </form>
			    </tbody>
			</c:if>
			
				<!-- 리뷰 작성 모달 -->
				<div id="reviewModal" class="modal">
				    <div class="modal-content">
				        <span class="close" onclick="hideReviewForm()">&times;</span>
				        <form action="myReviewInsert.do" method="POST">
				            <div class="modal-data">
				            	<span class="inline-container">
					            	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building" viewBox="0 0 16 16">
									  <path d="M4 2.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3 0a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zM4 5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zM7.5 5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zM4.5 8a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm2.5.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5zm3.5-.5a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
									  <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1zm11 0H3v14h3v-2.5a.5.5 0 0 1 .5-.5h3a.5.5 0 0 1 .5.5V15h3z"/>
									</svg>&nbsp; 
							        <p id="modalHosName"></p>
				            	</span>
						        <div class="inline-group">
						        	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-event" viewBox="0 0 16 16">
									  <path d="M11 6.5a.5.5 0 0 1 .5-.5h1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-1a.5.5 0 0 1-.5-.5z"/>
									  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4z"/>
									</svg>&nbsp; 
						            <p id="modalReserDate"></p>
						            <p id="modalReserTime"></p>
						            <p id="modalPetName"></p>
						        </div>
						    </div>
				            <div class="star-rating">
				                <input type="radio" id="5-stars" name="score" value="5"/>
				                <label for="5-stars" class="star">&#9733;</label>
				                <input type="radio" id="4-stars" name="score" value="4"/>
				                <label for="4-stars" class="star">&#9733;</label>
				                <input type="radio" id="3-stars" name="score" value="3"/>
				                <label for="3-stars" class="star">&#9733;</label>
				                <input type="radio" id="2-stars" name="score" value="2"/>
				                <label for="2-stars" class="star">&#9733;</label>
				                <input type="radio" id="1-star" name="score" value="1"/>
				                <label for="1-star" class="star">&#9733;</label>
				            </div>
				            <input type="text" class="form" name="content" placeholder="리뷰를 작성하세요.">
				            <input type="hidden" id="selectedReserIdx" name="reserIdx" value=""/>
				            <input type="hidden" id="selectedHosIdx" name="hosIdx" value=""/>
				            <input type="submit" value="저장" class="sbtn">
				            <button type="button" class="sbtn" onclick="hideReviewForm()">취소</button>
				        </form>
				    </div>
				</div>

		    </table>
		</div>
		<div id="review">
		<h3 class="left">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-left-dots-fill" viewBox="0 0 16 16">
			  <path d="M0 2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H4.414a1 1 0 0 0-.707.293L.854 15.146A.5.5 0 0 1 0 14.793zm5 4a1 1 0 1 0-2 0 1 1 0 0 0 2 0m4 0a1 1 0 1 0-2 0 1 1 0 0 0 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
			</svg> &nbsp;
		리뷰를 남겼어요
		</h3><hr>
		<table>
				<tr>
					<th width="150px">병원명</th>
					<th width="150px">방문일</th>
					<th width="200px">내용</th>
					<th width="50px">평점</th>
					<th width="150px">등록일</th>
					<th width="50px"> </th>
					<th width="50px"> </th>
				</tr>
				<tbody>
					<c:if test="${empty myReviewList}">
						<tr>
							<td colspan="7">리뷰 내역이 없습니다.</td>
						</tr>
					</c:if>
					<c:forEach var="review" items="${myReviewList}">
					    <tr id="view_${review.reviewIdx}">
					    <td>${review.hosName}</td>
					    <td>${review.reserDate}</td>
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
					    <!-- 사용자 본인만 리뷰 수정,삭제 가능 -->
					    <c:if test="${review.userIdx eq userIdx}">
					        <td>
					            <button class="sbtn" type="button" onclick="editReview(${review.reviewIdx})">수정</button>
					        </td>
					        <form id="deleteReviewForm_${review.reviewIdx}" action="myReviewDelete.do" method="POST" onsubmit="return confirmDelete(${review.reviewIdx})">
					            <td>
					                <input type="hidden" name="reviewIdx" value="${review.reviewIdx}">
					                <input type="hidden" name="hosIdx" value="${review.hosIdx}">
					                <input type="hidden" name="reserIdx" value="${review.reserIdx}">
					                <input type="submit" value="삭제"  class="sbtn">
					            </td>
					        </form>
					    </c:if>
					</tr>
	
					    <tr id="edit_${review.reviewIdx}" class="hidden">
						    <form action="myReviewUpdate.do" method="POST">     
						    	<td>${review.hosName}</td>
						        <td>${review.reserDate}</td>
						        <td>
						            <textarea id="content_${review.reviewIdx}" class="form" name="content">${review.content}</textarea>
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
							        <input type="hidden" name="hosIdx" value="${review.hosIdx}">
							        <input type="hidden" name="reviewIdx" value="${review.reviewIdx}">
						        	<input type="submit" class="sbtn" value="저장">
						        </td>
						    </form>
						    <td><button class="sbtn" type="button" onClick="cancelEdit(${review.reviewIdx})">취소</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
<script>
	//리뷰 수정 버튼 클릭 이벤트
	function editReview(reviewIdx) {
	 	console.log("editReview Index: " + reviewIdx);
		    document.getElementById('view_' + reviewIdx).classList.add('hidden');
		    document.getElementById('edit_' + reviewIdx).classList.remove('hidden');
	}
	
	// 리뷰 삭제 버튼 클릭 이벤트
	function confirmDelete(reviewIdx) {
	    const isConfirmed = confirm("삭제하시겠습니까?");
	    if (isConfirmed) {
	        document.getElementById("deleteReviewForm_" + reviewIdx).submit();
	    } else {
	        console.log("삭제가 취소되었습니다.");
	    }
	    return false;
	}

	// 리뷰 수정 취소 버튼 클릭 이벤트
	function cancelEdit(reviewIdx) {
	    console.log("cancelEdit Index: " + reviewIdx);
	    document.getElementById('view_' + reviewIdx).classList.remove('hidden');
	    document.getElementById('edit_' + reviewIdx).classList.add('hidden');
	}
	
	// 선택된 진료 완료 상태 내역의 reserIdx를 hidden필드에 설정
	function updateHiddenField() {
	    var selectBox = document.getElementById("finishSelect");
	    var selectedValue = selectBox .options[selectBox.selectedIndex].value;
	    document.getElementById("selectedReserIdx").value = selectedValue;
	    console.log("Selected ReserIdx: " + selectedValue); // 확인용 로그
	}
	
	function showReviewForm(reserIdx, hosIdx, reserDate, reserTime, hosName, petName) {
	    document.getElementById('selectedReserIdx').value = reserIdx;
	    document.getElementById('selectedHosIdx').value = hosIdx;
	    
	    // 예약 정보를 모달창에 표시
	    document.getElementById('modalHosName').innerText = hosName;
	    document.getElementById('modalReserDate').innerText = reserDate;
	    document.getElementById('modalReserTime').innerText = reserTime;
	    document.getElementById('modalPetName').innerText = petName;

	    document.getElementById('reviewModal').style.display = 'block';
	}

	function hideReviewForm() {
	    document.getElementById('reviewModal').style.display = 'none';
	}

	// 모달 창 외부를 클릭했을 때 모달을 닫는 기능
	window.onclick = function(event) {
	    var modal = document.getElementById('reviewModal');
	    if (event.target == modal) {
	        modal.style.display = 'none';
	    }
	}

	function goMypage() {
		window.location.href = 'mypage.do';
	}
</script>
</body>
</html>