<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>

	#container {
	    padding: 0;
	    margin:0 auto;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 14px;
	    width: 1100px;
	    display: flex;
	}
	
	p { 
		text-align: center; 
	}
	.center { 
		text-align: center; 
	}

	table { 
		border-collapse: collapse; 
		border: none;
	}
	
	th, td {
		margin: 0 auto;
		padding: 5px;
	}
	
	h1 {
		margin-left: 20px;
	}
	
	select {
		width: 230px;
		height: 30px;
	}
	
	option {
		height: 40px;
	}
	
	/* -----병원정보----- */
	#leftContainer {
	    margin-top: 20px;
	    width: 500px;
/* 	    height: 400px; /* 고정된 높이 추가 */ */
	    overflow: hidden; /* 컨테이너 크기를 넘는 내용 숨김 */
	}
	
	#hospital {
	    width: 400px;
	    display: flex;
	    align-items: center; /* 수직 중앙 정렬 */
	    vertical-align: middle;
	    position: relative;
	    flex-direction: column; /* 자식을 수직으로 배치 */
	    margin-top: 50px
	    margin-right: 20px;
	}
	
	#hosDetailContainer{
		margin: 10px;
		padding: 20px;
		width: 440px;
		height: 800px;
		border: 1px solid #B9B9B9;
		border-radius: 40px 40px;
	}
	
	#hospital table {
		width: 400px;
		height: 300px;
		font-size: 16px;
	}
	
	#hospital th {
		color: #B6E5FF;
	}
	
	#hospital td {
		text-align: left;
	}

	.hosTime{
		height: 15px;
	}
	
	.hosInfo{
		height: 25px;
	}
	
	/* -----submit 버튼-----  */
	.sbtn {
		border: none;
		width:80px;
		height: 30px;
		border-radius: 10px 10px;
		background-color: #B6E5FF;
		margin: 10px;
	}
	.sbtn:hover  {
		color: #FFFFFF; 
		background-color: #2C307D;
	}
	
	.ubtn {
		border: none;
		width:40px;
		height: 20px;
		border-radius: 10px 10px;
		background-color: #B6E5FF;
	}
	.ubtn:hover  {
		color: #FFFFFF; 
		background-color: #86CFF8;
	}
	
	/* -----지도----- */
	
	#map {
	    width: 400px;
	    height: 400px;
	    top:20px;
	    display: flex;
	    align-items: center; /* 수직 중앙 정렬 */
	    vertical-align: top;
	    position: relative;
	    flex-direction: column; /* 자식을 수직으로 배치 */
	}
	
	/* -----사진----- */
	
/* 	#slide {
	    width: 400px;
	    height: 400px;
	    margin: auto;
	}
	
	.carousel-item {
	    display: flex;
	    justify-content: center; /* 이미지를 중앙 정렬 */
	    align-items: center; /* 이미지를 수직으로 중앙 정렬 */
	    width: 400px; /* 부모 요소의 너비에 맞추기 */
	    height: 400px; /* 부모 요소의 높이에 맞추기 */
	    overflow: hidden; /* 부모 요소를 벗어나는 이미지 부분 숨김 */
	    margin: 0 auto; /* 부모 요소를 중앙에 배치 */
	}
	
	.carousel-item img {
	    width: 400px; /* 부모 요소의 너비에 맞추기 */
	    height: 400px; /* 부모 요소의 높이에 맞추기 */
	    object-fit: cover; /* 이미지가 요소를 채우도록 조정 */
	    object-position: center; /* 이미지의 중심을 기준으로 조정 */
	}
	
	.carousel-control-prev, .carousel-control-next {
	    */ height: 100%; /* 컨트롤 버튼의 높이를 슬라이드 높이에 맞춤 */
	} */
	.image-gallery {
    display: flex;
    flex-wrap: wrap; /* 줄바꿈을 처리 */
    max-width: 500px; /* 컨테이너의 최대 너비 */
    margin: 0 auto; /* 중앙 정렬 */
}

.image-item {
    flex: 0 0 calc(33.333% - 10px); /* 3개의 이미지가 한 줄에 들어가도록 설정 */
    box-sizing: border-box; /* 패딩과 보더를 포함하여 크기 계산 */
    margin-bottom: 10px; /* 이미지 간의 간격을 위한 마진 */
}

.image-item img {
    width: 100%; /* 이미지 너비를 부모 요소에 맞춤 */
    height: auto; /* 이미지 비율을 유지하면서 크기 조정 */
    display: block;
}


	
	
	

	
	/* 예약 버튼 */	
	#reservation {
		border: none;
		width:80px;
		height: 30px;
		border-radius: 10px / 10px;
		background-color: #B6E5FF;
		margin-top: 20px;
		float: right;
		margin-right: 30px;
		top: 50px;
	}
	
	#reservation:hover  {
		color: #FFFFFF; 
		background-color: #2C307D;
	}
	
	/* -----공지사항-----  */
	#rightContainer {
		width: 600px;
		float: right;
	}
	
	#post {
		width: 500px;
		display: inline-block;
	    vertical-align: middle;
	    margin: 30px; 
	}
	
	#postContainer {
		margin: 30px 50px 20px 20px;
		top: 50px;
		width: 550px;
		border: 1px solid #B9B9B9;
		border-radius: 40px 40px;
		display: inline-block;
	}
	
/* 	.reviewContainer{
		margin: 5px;
		height: 100px;
		border: 1px solid #B9B9B9;
		border-radius: 20px / 20px;

	}*/
	
	/* -----리뷰----- */
	#reviewContainer {
    	margin: 20px;
	}
	
	#review select {
	    float: left;
	}
	
	#review table {
	    text-align: center;
	}
	
	#review tr {
	    border-top: 1px solid #f0f1f1;
	    border-bottom: 1px solid #f0f1f1;
	}

	.hidden {
	    display: none;
	}
	
	.star-rating {
	  display:flex;
	  float: left;
	  flex-direction: row-reverse;
	  font-size:30px;
	  justify-content:space-around;
	  padding:0 .2em;
	  text-align:center;
	  width:5em;
	  margin-left: 10px;
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
	
	.form {
		position: relative;
		margin-top: 3px;
		width: 350px;
		height: 30px;
		border: 1px solid #bbb;
		border-radius: 7px;
/* 		padding: 10px 12px; */
		font-size: 14px;
	}
	
	
</style>