<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	 .image-gallery {
            display: flex;
            flex-wrap: wrap;
            width: 500px;
        }
        .image-item {
            width: calc(33.333% - 10px);
            margin: 5px;
            box-sizing: border-box;
            position: relative;
        }
        .image-item img {
            width: 100%;
            height: 100px; /* 이미지 크기를 통일 */
            object-fit: cover; /* 이미지 비율을 유지하며 크기를 조정 */
            cursor: pointer;
            transition: opacity 0.3s;
        }
        .image-item img:hover {
            opacity: 0.7;
            background-color: rgba(135, 206, 250, 0.2);
        }
        .popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: rgba(255, 255, 255, 0.9);
            padding: 20px;
            z-index: 1000;
            max-width: 90%;
            max-height: 90%;
        }
        .popup img {
            max-width: 100%;
            max-height: 100%;
        }
        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
        .overlay.active, .popup.active {
            display: block;
        }
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
	    overflow: hidden;
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
	
	.image-gallery {
	    display: flex;
	    flex-wrap: wrap; /* 줄바꿈 처리 */
	    max-width: 500px; 
	    margin: 0 auto;
	}
	
	.image-item {
	    flex: 0 0 calc(33.333% - 10px);
	    box-sizing: border-box; 
	    margin-bottom: 10px;
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
		margin-top: 30px;
		margin-left: 20px;
		/* margin: 30px 50px 20px 20px; */
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
	    width: 500px;
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