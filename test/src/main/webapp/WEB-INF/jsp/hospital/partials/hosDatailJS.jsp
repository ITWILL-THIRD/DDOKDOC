<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function insertNotice(hosIdx){
		//병원(기업)계정만 공지 작성
		//해당 병원 계정 일치 여부 확인 후, 공지 입력
		location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
	}
	window.onload = function(){
   	console.log("windowOpen() 실행~~");
   	console.log("${hospital}");
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
	    center: new kakao.maps.LatLng("${hospital.addy}","${hospital.addx}"), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
	};  
	
	//지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	//주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	//주소로 좌표를 검색합니다
	geocoder.addressSearch("${hospital.roadAddressName}", function(result, status) {
	
		// 정상적으로 검색이 완료됐으면 
		if (status === kakao.maps.services.Status.OK) {
		
		    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		    console.log("result[0].y : " + result[0].y + ", result[0].x : " + result[0].x);
		
		    // 결과값으로 받은 위치를 마커로 표시합니다
		    var marker = new kakao.maps.Marker({
		        map: map,
		        position: coords
		    });
		
		    // 인포윈도우로 장소에 대한 설명을 표시합니다
		    var infowindow = new kakao.maps.InfoWindow({
		        content: '<div style="width:150px;text-align:center;padding:6px 0;">${hospital.hosName}</div>'
		    });
		    infowindow.open(map, marker);
		
		    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
		    map.setCenter(coords);
		 	// 마커를 결과값으로 받은 위치로 옮긴다.
            	//marker.setPosition(coords)
		} 
	});
	
};
	//동적 리뷰 수정 이벤트 위임
	document.addEventListener("DOMContentLoaded", function() {
	    // 이벤트 위임을 설정
	    document.getElementById("review").addEventListener("click", function(event) {
	        if (event.target.classList.contains("editReview_btn")) {
	            const reviewIdx = event.target.getAttribute("data-reviewIdx");
	            console.log("Review Index: " + reviewIdx);
	            editReview(reviewIdx);
	        } else if (event.target.classList.contains("saveReview_btn")) {
	            const reviewIdx = event.target.getAttribute("data-reviewIdx");
	            saveReview(reviewIdx);
	        } else if (event.target.classList.contains("cancelEdit_btn")) {
	            const reviewIdx = event.target.getAttribute("data-reviewIdx");
	            cancelEdit(reviewIdx);
	        }
	    });
	});
	
	function editReview(reviewIdx) {
	    console.log("editReview Index: " + reviewIdx);
	    document.getElementById('view_' + reviewIdx).classList.add('hidden');
	    document.getElementById('edit_' + reviewIdx).classList.remove('hidden');
	}
	
	function saveReview(reviewIdx) {
	    console.log("saveReview Index: " + reviewIdx);
	
	    var updateContent = document.getElementById("content_" + reviewIdx); // 수정됨
	    console.log("saveReview updateContent: " + updateContent);
	    var updateScore = document.querySelector('input[name="updateScore_' + reviewIdx + '"]:checked').value; // 수정됨
	
	    let vo = {
	        reviewIdx: reviewIdx,
	        content: updateContent.value,
	        score: updateScore
	    };
	    console.log("saveReview vo: " + vo.reviewIdx + vo.content + vo.score);
	    $.ajax("updateReview.do", {
	        type: 'POST',
	        data: JSON.stringify(vo),
	        contentType: "application/json",
	        dataType: "json",
	        success: function(response) {
	            //alert("성공~~");
	            console.log(response);
	            document.getElementById('edit_' + reviewIdx).classList.add('hidden');
	            document.getElementById('view_' + reviewIdx).classList.remove('hidden');
	        },
	        error: function() {
	            //alert("실패~~");
	        	document.getElementById('edit_' + reviewIdx).classList.add('hidden');
	            document.getElementById('view_' + reviewIdx).classList.remove('hidden');
	        }
	    });
	}
	
	function cancelEdit(reviewIdx) {
	    document.getElementById('edit_' + reviewIdx).classList.add('hidden');
	    document.getElementById('view_' + reviewIdx).classList.remove('hidden');
	}
	//ajax 처리중 ㅠㅠ - 지수
	/* $(document).ready(function() {
		function getReviewList(hosIdx) {
			console.log("getReviewList()실헹 : " + hosIdx);
			
			$.ajax("getHosReview.do", { 
			    type: 'GET',
			    data: JSON.stringify(hosIdx),
			    success: function(data) {
			        $("#listDisp").empty();
			        
			        let dispHtml = "";
			        
			        for (let review of data) {
			            // 별점을 위한 로직을 먼저 처리
			            let stars = "";
			            for (let i = 0; i < review.score; i++) {
			                stars += "★";
			            }

			            // 수정된 부분: 템플릿 문자열 사용
			            dispHtml += `<tr>
			                <td id="nickname_view_${review.reviewIdx}">${review.nickname}</td>
			                <td id="content_view_${review.reviewIdx}">${review.content}</td>
			                <td id="score_view_${review.reviewIdx}">${review.score}</td>
			                <td>${review.reviewDate}</td>
			                <td><button class="editReview_btn" type="button" data-reviewIdx="${review.reviewIdx}">수정</button></td>
			                <td><a href="deleteReview.do?reviewIdx=${review.reviewIdx}">삭제</a></td>
			            </tr>`;
			        }
			        
			        $("#listDisp").html(dispHtml);
			    },
			    error: function() {
			        alert("실패");
			    }
			});

		}
		
	    // 리뷰 수정 버튼 클릭 이벤트
	    $(".editReview_btn").on("click", function() {
	        var reviewIdx = $(this).data('reviewidx');
	        $('#view_' + reviewIdx).hide();
	        $('#edit_' + reviewIdx).removeClass('hidden').show();
	    });

	    // 리뷰 저장 버튼 클릭 이벤트
	    $(".saveReview_btn").on("click", function() {
	    	var hosIdx = $(this).data("hosIdx");
	    	var reviewIdx = $(this).data('reviewidx');
	    	console.log("hosIdx: " + hosIdx);
	        var updateContent = document.getElementById("content_" + reviewIdx).value;
		    var updateScore = document.querySelector('input[name="updateScore_' + reviewIdx + '"]:checked').value;
	        console.log("reviewIdx : " + reviewIdx + ", updateContent : " +updateContent + ", updateScore: " + updateScore);
		    let vo = {
	   	        reviewIdx: reviewIdx,
	   	        content: updateContent,
	   	        score: updateScore
	    	};
	        $.ajax("updateReview.do", {
		        type: 'POST',
		        data: JSON.stringify(vo),
		        contentType: "application/json",
		        dataType: "json",
		        success: function(response) {
	                // 성공적으로 업데이트되었을 때, DOM 업데이트
	                $('#nickname_view_' + reviewIdx).text(response.nickname);
	                $('#content_view_' + reviewIdx).text(response.content);
	                $('#score_view_' + reviewIdx).html(renderStars(response.score));
	                $('#view_' + reviewIdx).show();
	                $('#edit_' + reviewIdx).hide();
	                getReviewList(reviewIdx);
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	            	console.error("Error details:", textStatus, errorThrown); 
	                alert('리뷰 업데이트에 실패했습니다.');
	            }
	        });
	    });

	    // 리뷰 취소 버튼 클릭 이벤트
	    $(".cancelEdit_btn").on("click", function() {
	        var reviewIdx = $(this).data("reviewidx");
	        $("#edit_" + reviewIdx).hide();
	        $("#view_" + reviewIdx).show();
	    });

	    function renderStars(score) {
	        var stars = '';
	        for (var i = 0; i < 5; i++) {
	            stars += i < score ? '★' : '';
	        }
	        return stars;
	    }
	}); */



</script>