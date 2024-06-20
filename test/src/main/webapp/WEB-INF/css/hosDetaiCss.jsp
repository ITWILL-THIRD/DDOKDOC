<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
	#container {
	    padding: 0;
	    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
	    font-size: 14px;
	    width: 1200px;
	    display: flex;
	    margin:0 auto;
	}
	h3, p { text-align: center; }
	.center { text-align: center; }

	table { 
		border-collapse: collapse; 
		border: none;
	}
	
	th, td {
		margin: 0 auto;
		padding: 5px;
	}
	h1 {margin-left: 20px;}
	
	
	#reservation {
		border: none;
		width:80px;
		height: 30px;
		border-radius: 10px / 10px;
		background-color: #B6E5FF;
		float: right;
		margin-top: 20px;
	}
	
	#reservation:hover  {background-color: #C0E9FF;}
	
	/* -----병원정보----- */
	#hospital {
	    width: 500px; /* 필요에 따라 조정 */
	    display: flex;
	    align-items: center; /* 수직 중앙 정렬 */
	    vertical-align: middle;
	    position: relative;
	    flex-direction: column; /* 자식을 수직으로 배치 */
	    margin-top: 50px
	    margin-right: 20px;
	}
	#hospital table {
		width: 400px;
		height: 400px;
		font-size: 14px;
	}
	
	#hospital th {color: #B6E5FF;}
	
	#hospital td{text-align: left;}
	
	#hosDetailContainer{
		margin: 20px;
		width: 500px;
		height: 400px;
		border: 1px solid #B9B9B9;
		border-radius: 40px / 40px;
	}
	
	#hosContainer{margin-top: 20px}
	
	.hosTime{height: 20px;}
	
	/* -----submit 버튼-----  */
	.sbtn {
		border: none;
		width:80px;
		height: 30px;
		border-radius: 10px / 10px;
		background-color: #B6E5FF;
		margin: 10px;
	}
	.sbtn:hover  {background-color: #C0E9FF;}
	
	
	/* -----지도----- */
	
	#map {
		margin: 50px 20px 20px 20px;
	    width: 400px;
	    height: 400px;
	    top: 35px;
	    display: flex;
	    align-items: center; /* 수직 중앙 정렬 */
	    vertical-align: top;
	    position: relative;
	    flex-direction: column; /* 자식을 수직으로 배치 */
	}
	
	/* -----사진----- */
	#img {
	    width: 100%; /* 필요에 따라 조정 */
	    position : absolute
	    vertical-align: middle;
	}
	
	/* -----공지사항-----  */
	#post {
		position : absolute
	    vertical-align: middle;
	}
	
/* 	.reviewContainer{
		margin: 5px;
		height: 100px;
		border: 1px solid #B9B9B9;
		border-radius: 20px / 20px;

	}*/
	
	/* -----리뷰----- */
	#reviewContainer {
		margin-top: 60px;
	}
	
	#review select {float: left;}
	#review table {text-align: center;}
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