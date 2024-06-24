<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${hospital.hosName}</title>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="../../css/hosDetaiCss.jsp"/>
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script></head> -->
<body>
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38a906000cd6c18d4d8489d1eddaec85&libraries=services,clusterer,drawing"></script>
<div id="container">
	<div id="leftContainer">
		<div id="hosDetailContainer">
			<h1>${hospital.hosName}</h1>
			<div id="hospital">
				<table>
					<tr class="hosInfo">
						<th>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-geo-alt-fill" viewBox="0 0 16 16">
	  						<path d="M8 16s6-5.686 6-10A6 6 0 0 0 2 6c0 4.314 6 10 6 10m0-7a3 3 0 1 1 0-6 3 3 0 0 1 0 6"/>
							</svg>
						</th>
						<td colspan="2">${hospital.roadAddressName} ${hospital.detailAddress}</td>
					</tr>
					<tr class="hosTime">
					    <th>
					        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-fill" viewBox="0 0 16 16">
					            <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
					        </svg>
					    </th>
					    <c:set var="openTime" value="${hospital.openTime}"/>
					    <c:set var="closeTime" value="${hospital.closeTime}"/>
					    <c:set var="lunchTime" value="${hospital.lunchTime}"/>
					    <c:set var="endLunchTime" value="${hospital.endLunchTime}"/>
					    <td>
					        <c:if test="${openTime == '00:00:00' and closeTime == '23:59:59'}">
					            평 일 24시간
					        </c:if>
					        <c:if test="${openTime != '00:00:00' or closeTime != '23:59:59'}">
					            평 일 ${fn:substring(openTime, 0, 5)} - ${fn:substring(closeTime, 0, 5)}
					        </c:if>
					    </td>
					    <td>
					        <c:choose>
					            <c:when test="${hospital.lunchOff == 'Y' or lunchTime == '00:00:00' or endLunchTime == '00:00:00' or lunchTime == null or endLunchTime == null}">
					            </c:when>
					            <c:otherwise>
					                점심 ${fn:substring(lunchTime, 0, 5)} - ${fn:substring(endLunchTime, 0, 5)}
					            </c:otherwise>
					        </c:choose>
					    </td>
					</tr>
					<tr class="hosTime">
					    <th> </th>
					    <c:set var="satOpenTime" value="${hospital.satOpenTime}"/>
					    <c:set var="satCloseTime" value="${hospital.satCloseTime}"/>
					    <c:set var="satLunchTime" value="${hospital.satLunchTime}"/>
					    <c:set var="satEndLunchTime" value="${hospital.satEndLunchTime}"/>
					    <td>
					        <c:if test="${satOpenTime == '00:00:00' and satCloseTime == '23:59:59'}">
					            토요일 24시간
					        </c:if>
					        <c:if test="${satOpenTime != '00:00:00' or satCloseTime != '23:59:59'}">
					            토요일 ${fn:substring(satOpenTime, 0, 5)} - ${fn:substring(satCloseTime, 0, 5)}
					        </c:if>
					    </td>
					    <td>
					        <c:choose>
					            <c:when test="${hospital.satLunchOff == 'Y' or satLunchTime == '00:00:00' or satEndLunchTime == '00:00:00' or satLunchTime == null or satEndLunchTime == null}">
					            </c:when>
					            <c:otherwise>
					                점심 ${fn:substring(satLunchTime, 0, 5)} - ${fn:substring(satEndLunchTime, 0, 5)}
					            </c:otherwise>
					        </c:choose>
					    </td>
					</tr>
					<tr class="hosTime">
					    <th> </th>
					    <c:set var="sunOpenTime" value="${hospital.sunOpenTime}"/>
					    <c:set var="sunCloseTime" value="${hospital.sunCloseTime}"/>
					    <c:set var="sunLunchTime" value="${hospital.sunLunchTime}"/>
					    <c:set var="sunEndLunchTime" value="${hospital.sunEndLunchTime}"/>
					    <td>
					        일요일
					        <c:choose>
					            <c:when test="${hospital.sunDayOff == 'Y' or sunOpenTime == null or sunCloseTime == null}">
					                <span class="holiday">휴무</span>
					            </c:when>
					            <c:otherwise>
					                <c:if test="${sunOpenTime == '00:00:00' and sunCloseTime == '23:59:59'}">
					                    24시간
					                </c:if>
					                <c:if test="${sunOpenTime != '00:00:00' or sunCloseTime != '23:59:59'}">
					                    ${fn:substring(sunOpenTime, 0, 5)} - ${fn:substring(sunCloseTime, 0, 5)}
					                </c:if>
					            </c:otherwise>
					        </c:choose>
					    </td>
					    <td>
					        <c:choose>
					            <c:when test="${hospital.sunLunchOff == 'Y' or sunLunchTime == '00:00:00' or sunEndLunchTime == '00:00:00' or sunLunchTime == null or sunEndLunchTime == null}">
					            </c:when>
					            <c:otherwise>
					                점심 ${fn:substring(sunLunchTime, 0, 5)} - ${fn:substring(sunEndLunchTime, 0, 5)}
					            </c:otherwise>
					        </c:choose>
					    </td>
					</tr>

					<tr class="hosInfo">
						<th>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-telephone-fill" viewBox="0 0 16 16">
							  <path fill-rule="evenodd" d="M1.885.511a1.745 1.745 0 0 1 2.61.163L6.29 2.98c.329.423.445.974.315 1.494l-.547 2.19a.68.68 0 0 0 .178.643l2.457 2.457a.68.68 0 0 0 .644.178l2.189-.547a1.75 1.75 0 0 1 1.494.315l2.306 1.794c.829.645.905 1.87.163 2.611l-1.034 1.034c-.74.74-1.846 1.065-2.877.702a18.6 18.6 0 0 1-7.01-4.42 18.6 18.6 0 0 1-4.42-7.009c-.362-1.03-.037-2.137.703-2.877z"/>
							</svg>
						</th>
						<td colspan="2">${hospital.hosPhone}</td>
					</tr>
					<tr  class="hosInfo">
						<th>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-info-circle" viewBox="0 0 16 16">
							  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
							  <path d="m8.93 6.588-2.29.287-.082.38.45.083c.294.07.352.176.288.469l-.738 3.468c-.194.897.105 1.319.808 1.319.545 0 1.178-.252 1.465-.598l.088-.416c-.2.176-.492.246-.686.246-.275 0-.375-.193-.304-.533zM9 4.5a1 1 0 1 1-2 0 1 1 0 0 1 2 0"/>
							</svg>
						</th>
						<td>${hospital.animal} 진료 병원</td>
						<td>
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16" color="#B6E5FF">
	  							<path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
							</svg> ${hospital.score}
						</td>
					</tr>
				</table>
			</div>
			<div id="map"></div>
		</div>
			<!-- 이미지 갤러리 -->
			<div class="image-gallery">
		        <c:forEach var="img" items="${imgList}">
		            <div class="image-item">
		                <img src="${img.hosImg}" alt="병원 내부사진" onclick="openPopup(this)">
		            </div>
		        </c:forEach>
		    </div>
	
	   	 	<div class="overlay" onclick="closePopup()"></div>
	    	<div class="popup" id="popup">
	        <img id="popup-img" src="" alt="팝업 이미지">
	    </div>
	</div>
	<div id="rightContainer">
		<button id="reservation" onclick="userCheck('${user}')">예약하기</button>
		<div id="postContainer">
			<div id="post">
				<h3>공지사항</h3>
				<div>
					<table>
					    <c:choose>
					        <c:when test="${empty notice}">
					            <tr>
					                <td colspan="2" style="text-align: center;">등록된 공지사항이 없습니다.</td>
					            </tr>
					        </c:when>
					        <c:otherwise>
					            <c:if test="${not empty notice}">
					                <tr>
					                    <td>${notice.noticeContent}</td><br>
					                </tr>
					                <tr>
					                    <td id="right">${notice.noticeDate} 작성</td>
					                </tr>
					            </c:if>
					        </c:otherwise>
					    </c:choose>
					</table>
				</div>
			</div>
		</div>
		<div id="reviewContainer">
			<h3>리뷰</h3>
			<div id="review">
				<!-- 예약 후 진료 완료 상태인 사용자만 form 작성 가능 -->
				<c:if test="${not empty finishList}">
				    <form id="reviewForm" action="insertReview.do" method="post" onsubmit="return validateForm()">
				        <!-- <span>방문일</span> -->
				        <!-- 진료 완료 상태인 내역 선택 -->
				        <select id="finishSelect" onchange="updateHiddenField()">
				            <option value="">리뷰를 작성할 방문일을 선택하세요.</option>
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
							<label for="5-stars" class="star">★</label>
							<input type="radio" id="4-stars" name="score" value="4" />
							<label for="4-stars" class="star">★</label>
							<input type="radio" id="3-stars" name="score" value="3" />
							<label for="3-stars" class="star">★</label>
							<input type="radio" id="2-stars" name="score" value="2" />
							<label for="2-stars" class="star">★</label>
							<input type="radio" id="1-star" name="score" value="1" />
							<label for= "1-star" class="star">★</label>
						</div>
				        <input type="text" class="form" name="content" placeholder="리뷰를 작성하세요.">
				        <input type="hidden" name="hosIdx" value="${hospital.hosIdx}">
				        <input type="hidden" id="selectedReserIdx" name="reserIdx" value="" />
				        <input type="submit" class="sbtn" value="리뷰 작성">
				    </form>
				</c:if>
				<table>
					<tbody>
						<c:if test="${empty reviewList}"><tr colspan="7">작성된 리뷰가 없습니다.</tr></c:if>
						<c:forEach var="review" items="${reviewList}">
							<div class="reviewContainer">
							    <tr id="view_${review.reviewIdx}">
							        <td id="nickname_view_${review.reviewIdx}" width="10%">${review.nickname}</td>
							        <td id="content_view_${review.reviewIdx}" width="35%">${review.content}</td>
							        <td id="score_view_${review.reviewIdx}" width="10%">
							            <c:choose>
							                <c:when test="${review.score eq 1}">&#9733;</c:when>
							                <c:when test="${review.score eq 2}">&#9733;&#9733;</c:when>
							                <c:when test="${review.score eq 3}">&#9733;&#9733;&#9733;</c:when>
							                <c:when test="${review.score eq 4}">&#9733;&#9733;&#9733;&#9733;</c:when>
							                <c:when test="${review.score eq 5}">&#9733;&#9733;&#9733;&#9733;&#9733;</c:when>
							            </c:choose>
							        </td>
							        <td width="25%">${review.reserDate} 방문</td>
							        <!-- 사용자 본인만 리뷰 수정,삭제 가능 -->		        
							        <c:if test="${review.userIdx eq userIdx}">	        
									    <td width="10%"><button class="ubtn" type="button" onclick="editReview(${review.reviewIdx})">수정</button></td>
									    <form id="deleteReviewForm_${review.reviewIdx}" action="deleteReview.do" method="POST">				    
									        <td width="10%">			 
									            <input type="hidden" name="reviewIdx" value="${review.reviewIdx}">
									            <input type="hidden" name="hosIdx" value="${hospital.hosIdx}">			        	
									            <input type="hidden" name="reserIdx" value="${review.reserIdx}">			        	
									            <input type="button" class="ubtn" value="삭제" onclick="confirmDelete(${review.reviewIdx}, ${hospital.hosIdx})">    
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
								        	<input type="submit" class="ubtn" value="저장">
								        </td>
								    </form>
								    <td><button class="ubtn" type="button" onClick="cancelEdit(${review.reviewIdx})">취소</button></td>
								</tr>
							</div>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<jsp:include page="partials/hosDatailJS.jsp"></jsp:include>
<script>
//로그인 유무 체크
	function userCheck() {
		const userCondition = '${user.condition}';
		const hoUser = '${hoUser}';
		console.log('userCondition:', userCondition);
		if (userCondition === 'null' || userCondition === '') { // JSP에서 null인 경우 'null' 문자열로 전달될 수 있음
	        if (hoUser != 'null') {
	        	alert("병원계정은 예약이 불가능합니다.");
	        	return false;
	        }
			alert("로그인 후 예약이 가능합니다.");
	        location.href="../user/login.do";
	    } else if (userCondition === '결제전') {
	        alert("토탁플러스 가입 후 병원예약이 가능합니다.");
	    } else if (userCondition === '결제완료')
	        location.href="../reservation/reservation.do?hosIdx=" + ${hospital.hosIdx};
		
	}
</script>
</body>
</html>