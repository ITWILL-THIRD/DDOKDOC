<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPetCSS</title>
<style>
	#container { width: 700px; margin: auto; }
	h1, h3, p { text-align: center; }
	.center { text-align: center; }
	.tb {
		margin-left:auto; 
		margin-right:auto;
	}
	.btn {
		position: relative;
		border: 1px solid #bbb;
		background-color: #2C307D;
		border: none;
		border-radius: 7px;
		color: white;
		width: 185px;
		height: 50px;
		margin-top: 20px;
		font-size: 16px;
		font-weight: bold;
		display: inline-block;
	}
	.btn:active, .clearBtn:active {
		background-color: #4349B4;
        color: #FFFFFF; 
	}
	.clearBtn {
		border-radius: 5px;
		padding: 3px;
		width: 50px;
		height: 30px;
		border: none;
		background-color: #2C307D;
        color: #FFFFFF;
	}
	.text {
		position: relative;
		margin-bottom: 7px;
		width: 350px;
		height: 20px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
		margin-bottom: 10px;
	}
	.select {
		width: 375px;
		height: 45px;
	 	border: 1px solid #bbb;
		border-radius: 7px;
	  	padding: 10px 12px;
	  	font-size: 14px;
	  	margin-right: 5px;
	  	margin-bottom: 10px;
	}
    .fileContainer {
        position: relative;
        width: 375px;
        height: 42px;
        border: 1px solid #bbb;
        border-radius: 7px;
        padding: 10px 12px;
        font-size: 14px;
        box-sizing: border-box;
        display: flex;
        align-items: center;
		margin-bottom: 10px;
    }
    .fileContainer input[type="file"] {
		flex: 1;
		border: none;
        padding-top: 15px;
    }
    .imageContainer {
        position: relative;
        width: 375px;
        height: auto;
        border: 1px solid #bbb;
        border-radius: 7px;
        padding: 10px 12px;
        font-size: 14px;
        box-sizing: border-box;
        display: flex;
        align-items: center;
        justify-content: center;
        margin-bottom: 10px;
    }
    .imageContainer img {
        max-width: 100%;
        max-height: 150px;
        border-radius: 7px;
    }
    .pwdText {
		position: relative;
		margin-bottom: 7px;
		width: 350px;
		height: 20px;
		border: 1px solid #bbb;
		border-radius: 7px;
		padding: 10px 12px;
		font-size: 14px;
	}
    .pwdBtn {
		position: absolute;
		margin-top: -18px;
		margin-left: -93px;
		border-radius: 5px;
		padding: 3px;
		width: 83px;
		height: 30px;
		border: none;
		background-color: #2C307D;
		color: #FFFFFF;
	}
	.pwdBtn:active {
		background-color: #4349B4;
		color: #FFFFFF;
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
    
</style>
</head>
<body>

</body>
</html>