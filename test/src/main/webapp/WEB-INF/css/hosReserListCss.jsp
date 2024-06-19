<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
  #reserBody {
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
    width: 2000px; 
    margin: auto; 
    margin-top: 50px;
  }

  #calendar {
    max-width: 600px;
    margin-left: 100px;
    margin-right: 100px;
    display: inline-block;
  }
  
  .reserInfo {
    display: inline-block;
    vertical-align: top;
  }
  
  .time-btn {
       margin: 5px;
       padding: 10px;
       border: 1px solid #ccc;
       background-color: #f9f9f9;
       cursor: pointer;
   }

   .time-btn.selected {
       background-color: lightblue;
   }
   
   /* 예약된 시간 버튼 스타일 */
	.reserved {
	  background-color: #87CEEB; /* 하늘색 */
	  color: white;
	  cursor: not-allowed; /* 마우스 커서를 변경하여 클릭할 수 없음을 표시 */
	}
	
	.reserved:hover {
	  background-color: #6495ED; /* 버튼에 마우스를 올리면 약간 더 어두운 색으로 변경 */
	}
	.reserDate {
	  color: #f9fafb;
	  background-color: #3182f6;
	  margin: 30px 15px 0px 15px;
	  font-size: 15px;
	  font-weight: 600;
	  line-height: 18px;
	  white-space: nowrap;
	  text-align: center;
	  /* vertical-align: middle; */
	  cursor: pointer;
	  border: 0 solid transparent;
	  user-select: none;
	  transition: background 0.2s ease, color 0.1s ease;
	  text-decoration: none;
	  border-radius: 7px;
	  padding: 11px 16px;
	  width: 250px;
	}

/* 	.container { width: 2000px; margin: auto; margin-top: 40px;} */
	h1, h3, p { text-align: center; }
	.center { text-align: center; }

	table { 
		border-collapse: collapse; 
		border: none;
	}
	
	table, th, td {
		border: 1px solid #B9B9B9;
		margin: 0 auto;
		padding: 5px;
		text-align: center;
		border: none;
	}

	th { background-color: #B6E5FF; }

	#reserBody {
		margin: auto;
		padding: 10px;
		display: flex;
		justify-content: center;
	}
	
	.reserTime {
		color: blue;
	}
	.complete-btn {
		position: relative;
		border: 1px solid #bbb;
		background-color: #2C307D;
		border:  none;
		border-radius: 7px;
		color: white;
		width: 50px;
		height: 20px;
		font-size: 10px;
	}
	.complete-btn:hover {
		background-color: #3940C8;
	}
	li { font-size: 16px; }
</style>