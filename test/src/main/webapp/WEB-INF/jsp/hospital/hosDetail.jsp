<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 상세 보기(정보,지도,예약,리뷰)</title>
<script type="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>
	function insertNotice(hosIdx){
		//병원(기업)계정만 공지 작성
		//해당 병원 계정 일치 여부 확인 후, 공지 입력
		location.href = "../notice/insertProNotice.do?hosIdx=" + hosIdx;
	}
</script>
</head>
<body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=38a906000cd6c18d4d8489d1eddaec85&libraries=services,clusterer,drawing"></script>

	\${hospital } : ${hospital } <br>
	\${hosIdx } : ${hosIdx } <br>
<div id="container">
	<h1>병원 상세 [hosDetail.jsp]</h1>
	
	<table>
		<tr>
			<th>병원명</th>
			<td>${hospital.hosName}</td>
		</tr>
		<tr>
			<th>주소</th>
			<td>${hospital.roadAddressName} ${hospital.detailAddress}</td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td>${hospital.hosPhone}</td>
		</tr>
		<tr>
			<th>진료시간</th>
			<td>${hospital.openTime} ~ ${hospital.closeTime}</td>
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
	
	<h4>지도 표시</h4>
	<div id="map" style="width:300px;height:300px;margin-top:10px;"></div>
	
	<p class="center">
		<a href="temp.do">예약</a>
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
				<td>
					<a href="../notice/getNotice.do?hosIdx=${notice.hosIdx}&noticeIdx=${notice.noticeIdx }">${notice.noticeTitle }</a>
				</td>
				<td>${notice.hit }</td>
			</tr>
			</c:forEach>
		</table>
	</div>
</div>
	
<script>
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
</script>
</body>
</html>