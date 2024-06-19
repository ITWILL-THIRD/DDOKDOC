<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPetCSS</title>
<style>
	/* 컨테이너 */
	#container {
		width: 800px;
		margin: auto;
	}
	h1, h3, p {
		text-align: center;
	}
	
	/* 테이블 */
	table {
		border-collapse: collapse; 
		width: 100%;
		margin: 20px 0;
	}
	table, th, td {
		border: 1px solid #B9B9B9;
		padding: 8px;
		text-align: center;
	}
	th { 
		background-color: #B6E5FF;
		width: 120px;
	}	
	td {
		text-align: left;
		height: 70px;
	}
	
	/* 버튼 */
	.btn, .fileBtn {
		border-radius: 10px;
		background-color: #B6E5FF;
		padding: 5px 10px;
		border: none;
		cursor: pointer;
		color: #2C307D;
		margin-right: 5px;
	}
	.btn:hover, .fileBtn:hover, #clearBtn:hover {
		background-color: #2C307D;
		color: #FFFFFF;
	}
	.fileBtn, #fileName {
	    font-size: 14px;
	    color: #2C307D;
	}
	#clearBtn {
		background-color: #FFFFFF;
		border: 1px solid #589DE1;
		margin: 0 10px;
	}
	
	.center {
		text-align: center;
	}

	/* 파일 선택 버튼 숨기기 */
	input[type="file"] {
		display: none;
	}
	
	/* 입력필드 */
	input[type="text"], input[type="number"], select {
	    width: calc(100% - 20px);
	    padding: 8px;
	    margin: 8px 0;
	    border: 1px solid #B9B9B9;
	    border-radius: 10px;
	    box-sizing: border-box;
	}
</style>
</head>
<body>

</body>
</html>