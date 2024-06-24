<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	#container { width: 1100px; margin: auto; }
	h1, h3, p { text-align: center; }
	<%-- 목록 --%>
	table {
		border-collapse: collapse;
		margin-left:auto;margin-right:auto;
		margin-top: 23px;
	}
	table th, table td {
		position: static;
		text-align: center;
		margin: auto;
		padding: 5px;
		border: 1px #B9B9B9 solid;
		border-collapse: collapse;
	}
	
	table th:first-child,
	table td:first-child {
		border-left: 0;
	}
	
	table th:last-child,
	table td:last-child {
		border-right: 0;
	}
	th { 
		background-color: #E0EAF5;
	}
	tbody {border-bottom-style: hidden; }
	.center { text-align: center; }
	.border-none, .border-none td { border: none; }
	
	<%-- 버튼 --%>
    .btn {
    	border-radius: 5px;
    	background-color: #2C307D;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	display: inline-block;
    	border: 1px solid #2C307D;
    }
    .btn:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
	<%-- 버튼 배경색 변경 --%>
    .btn.active {
        background-color: #FFFFFF;
        color: #2C307D;
    	border: 1px solid #2C307D; 	
    }
	hr {
  		border: 1px solid #2C307D;
  	}
	<%-- 제목 링크 --%>
 	a {text-decoration: none;} 
	a[href^="getHosApprovalSearch.do"],
	a[href^="../hospital/hosDetail.do"],
	a[target="_blank"] {
		color: #2C307D;
		text-decoration: none;	
		margin: 0 10px 0 10px;
		font-weight: bold;
	}
	a:hover {color:#FFA217;}
	<%-- 카테고리 버튼 활성화 --%>
	a[href^="getHosApprovalSearch.do"].active {
        color: #FFA217;
		text-decoration: none;	
		margin: 0 10px 0 10px;
		font-weight: bold;
	}
	<%-- 페이징 a 스타일 일괄 미적용 --%>
	#paging a {
		color: #2C307D;
		text-decoration: none;
		font-weight: normal;
	}
	#paging a:hover {color:#FFA217;}
	#getConditionSearch {
		padding-bottom : 5px;
	}
	a.none {
		color: #2C307D;
		font-weight: bold;
	}
	<%-- 승인버튼 동적 작용 --%>
	.condition-payment {
		border-radius: 5px;
    	background-color: #2C307D;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	display: inline-block;
    	border: 1px solid #2C307D;
    }
    .condition-payment:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
    .condition-before {
    	border-radius: 5px;
    	background-color: #FFA217;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #FFFFFF;
    	text-decoration: none;
    	display: inline-block;
    	border: 1px solid #FFA217;
    }
    .condition-before:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
    .condition-after {
        border-radius: 5px;
    	background-color: #B8DAFF;
    	padding: 7px 18px;
    	border: none;
    	cursor: pointer;
    	color: #2C307D;
/*     	color: #FFFFFF; */
    	text-decoration: none;
    	display: inline-block;
    	border: 1px solid #B8DAFF;
    }
    .condition-after:hover {
    	background-color: #FFFFFF;
    	color: #2C307D;
    	border: 1px solid #2C307D;
    }
    .condition-none {
    	border: 0;
   		background-color:#FFFFFF;
    }
    
    /* 	페이징 */
	#paging td {
		padding-top: 15px;
	}
	#paging span{
		margin: 0 20px 0 20px;
	}
</style>