<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>작성한 리뷰</title>
<jsp:include page="../../css/postCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
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
<%-- \${myReserList } : ${myReserList }<br><br>
\${myOldReserList } : ${myOldReserList }<br><br>
\${myCancleReserList } : ${myCancleReserList }<br><br> --%>
\${reviewToWrite } : ${reviewToWrite }
	<h2>리뷰 목록</h2>
	<h3>작성 대기중인 목록</h3>
	<div id="review">
		<!-- 예약 후 진료 완료 상태만 form 작성 가능 -->
		<c:if test="${not empty reviewToWrite}">
	    <form id="reviewForm" action="myReviewInsert.do" method="post">
		    <table>
		        <thead>
		            <tr>
		                <th>방문일</th>
		                <th>방문시간</th>
		                <th>동물이름</th>
		                <th>리뷰작성</th>
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="finish" items="${reviewToWrite}">
					    <tr>
					        <td>${finish.reserDate}</td>
					        <td>
					            <fmt:formatDate value="${finish.reserTime}" pattern="HH:mm" var="reserTime" />
					            ${reserTime}
					        </td>
					        <td>${finish.petName}</td>
					        <td>
					            <button type="button" onclick="showReviewForm('${finish.reserIdx}', '${finish.hosIdx}')">리뷰 작성</button>
					        </td>
					        <td id="reviewSection" style="display:none;">
					            <form action="myReviewInsert" method="POST">
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
					                <input type="hidden" id="selectedReserIdx" name="reserIdx" value="" />
					                <input type="hidden" id="selectedHosIdx" name="hosIdx" value="" />
					                <input type="submit" value="저장">
					                <button type="button" onclick="hideReviewForm()">취소</button>
					            </form>
					        </td>
					    </tr>
					</c:forEach>
		        </tbody>
		    </table>
    
		</form>

		</c:if>
	</div>
	<h3>작성한 목록</h3>
	\${myReviewList } = ${myReviewList }
	<div id="review">
	<table border=1>
			<tr>
				<th>내용</th>
				<th>평점</th>
				<th>방문일</th>
				<th>등록일</th>
				<th>수정</th>
				<th>삭제</th>
			</tr>
			<tbody>
				<c:forEach var="review" items="${myReviewList}">
				    <tr id="view_${review.reviewIdx}">
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
					    	<form id="deleteReviewForm_${review.reviewIdx }" action="myReviewDelete.do" action="POST">				    
						        <td>				 
						        	<input type="hidden" name="reviewIdx" value="${review.reviewIdx}">
							        <input type="hidden" name="hosIdx" value="${review.hosIdx}">			        	
       						        <input type="hidden" name="reserIdx" value="${review.reserIdx}">			        	
						        	<input type="submit" value="삭제" onClick="confirmDelete(${review.reviewIdx})">    
						        </td> 
						    </form>
				        </c:if>
				    </tr>
				
				
				    <tr id="edit_${review.reviewIdx}" class="hidden">
					    <form action="myReviewUpdate.do" method="POST">      
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
					        <td>${review.reserDate}</td>
				        	<td>${review.reviewDate}</td>
					        <td>
						        <input type="hidden" name="hosIdx" value="${review.hosIdx}">
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
<script>
	//리뷰 수정 버튼 클릭 이벤트
	function editReview(reviewIdx) {
	 	console.log("editReview Index: " + reviewIdx);
		    document.getElementById('view_' + reviewIdx).classList.add('hidden');
		    document.getElementById('edit_' + reviewIdx).classList.remove('hidden');
	}
	// 리뷰 삭제 버튼 클릭 이벤트
	function confirmDelete(reviewIdx) {
	    if (confirm("삭제하시겠습니까?")) {
	        document.getElementById("deleteReviewForm_" + reviewIdx).submit();
	    }
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

    function showReviewForm(reserIdx, hosIdx) {
        document.getElementById('selectedReserIdx').value = reserIdx;
        document.getElementById('selectedHosIdx').value = hosIdx;
        document.getElementById('reviewSection').style.display = 'block';
    }

    function hideReviewForm() {
        document.getElementById('reviewSection').style.display = 'none';
    }

</script>
</body>
</html>