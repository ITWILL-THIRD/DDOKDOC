<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>

	#container {
	    padding: 0;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 14px;
	    width: 1100px;
	    display: flex;
	    margin:0 auto;
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
	
	#reservation {
		border: none;
		width:80px;
		height: 30px;
		border-radius: 10px / 10px;
		background-color: #B6E5FF;
		pading-top: 20px;
		float: right;
		left: 200px;
		top: 50px;
	}
	
	#reservation:hover  {
		color: #FFFFFF; 
		background-color: #86CFF8;
	}
	
	/* -----병원정보----- */
	#hosContainer{
		margin-top: 20px;
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
		width: 430px;
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
		height: 20px;
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
		background-color: #86CFF8;
	}
	
	.ubtn {
		border: none;
		width:40px;
		height: 20px;
		border-radius: 10px 10px;
		background-color: #B6E5FF;
		margin: 5px;
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
	#img {
	    width: 100%; /* 필요에 따라 조정 */
	    vertical-align: middle;
	}
	.carousel-item {
	    display: flex;
	    justify-content: center; /* 이미지를 중앙 정렬 */
	    align-items: center; /* 이미지를 수직으로 중앙 정렬 */
	    width: 400px; /* 부모 요소의 너비 고정 */
	    height: 400px; /* 부모 요소의 높이 고정 */
	    overflow: hidden; /* 부모 요소를 벗어나는 이미지 부분 숨김 */
	    margin: 0 auto; /* 부모 요소를 중앙에 배치 */
	}
	
	.carousel-item img {
	    width: 400px; /* 부모 요소의 너비에 맞추기 */
	    height: 400px; /* 부모 요소의 높이에 맞추기 */
	    object-fit: cover; /* 이미지가 요소를 채우도록 조정 */
	    object-position: center; /* 이미지의 중심을 기준으로 조정 */
	}

	
	/* -----공지사항-----  */
	#post {
		width: 300px;
		height: 400px;
	    vertical-align: middle;
	    margin: 30px;
	    
	}
	
	#postContainer {
		margin: 70px 20px 50px 20px;
		top: 50px;
		width: 590px;
		height: 450px;
		border: 1px solid #B9B9B9;
		border-radius: 40px 40px;
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