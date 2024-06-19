<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginCSS</title>
<style>
	#container { width: 700px; margin: auto; }
	h1, h3, p { text-align: center; }
	.center { text-align: center; }
	.tb {
	 margin-left:auto; 
    margin-right:auto;
	}
	.psTitle {
		position: relative;
		margin-top: 3px;
		width: 350px;
		height: 30px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
	 }
	 input::placeholder {
  
/*   font-size: 15px; */
 
}
	 
	 .loginBtn {
		position: relative;
border: 1px solid #bbb;
	background-color: #2C307D;
	border:  none;
border-radius: 7px;
	color: white;
	 width: 375px;
  height: 50px;
  margin-top: 20px;
  font-size: 16px;
  font-weight: bold;

	 }
	 .loginBtn:active{
		background-color: #4349B4;
        color: #FFFFFF; 
	}
	
	.loginBtn:disabled {
    background-color: #cccccc; /* 비활성화된 상태의 색상 */
    color: #FFFFFF;
	}
	.loginBtn:disabled:active {
	background-color: #E4E4E4; /* 비활성화된 상태의 색상 */
    color: #FFFFFF;
	}
	
	 .joinBtn {
	 color: #2E77AE;
	 position: relative;
	 border: 0;
	  background-color: transparent;
	font-size: 15px;
    font-style: normal;
	 }
	 .joinBtn:hover {color:#B6E5FF;}
	 .s {
	 color: #B5B5B5;
	 }
	 .select {
	 margin-top: 20px;
	 margin-left:auto; 
    margin-right:auto;
	 }
	.kakao-btn {
	margin-top: 30px;
	text-align: center;
	}

	a {	
		font-size: 15px;
		text-decoration: none;
		color: black;	
	}
	a:hover {color:#B6E5FF;}
	
	.text {
		position: relative;
		margin-bottom: 7px;
		width: 350px;
		height: 20px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
	}
	.btn {
		position: absolute;
		margin-top: -18px;
		margin-left: -80px;
		border-radius: 5px;
		padding: 3px;
		width: 70px;
		height: 30px;
		border: none;
		background-color: #2C307D;
        color: #FFFFFF; 
	}
	.btn:active{
		background-color: #4349B4;
        color: #FFFFFF; 
	}
	.sText {
		position: relative;
		margin-bottom: 7px;
		width: 160px;
		height: 20px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
	}
	.tText {
		position: relative;
		margin-bottom: 7px;
		width: 137px;
		height: 20px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
	}
	.wBtn {
		border-radius: 5px;
		padding: 3px;
		width: 100px;
		height: 30px;
		border: none;
		background-color: #2C307D;
        color: #FFFFFF; 
	}
	.wBtn:active{
		background-color: #4349B4;
        color: #FFFFFF; 
	}
	

	
</style>
</head>
<body>

</body>
</html>