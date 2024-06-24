<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 통계</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<jsp:include page="../../css/statsCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<jsp:include page="statsScript.jsp"/>
<jsp:include page="dateButtons.jsp" />
</head>
<body>
    <div id="container">
    	<h1>멤버십 통계</h1>
        <div class="center">
            <button class="btn" id="monthlyRevenueBtn">수익통계</button>
            <button class="btn" id="memberStatsBtn">멤버십 건수</button>
            <button class="btn" id="paymentsByAccountBtn">계정별 결제내역</button>
        </div>
        
        <div id="searchDate" style="display:none;">
            <div class="row">
                <label for="type">가입구분</label>
                <select class="select" id="type" name="type">
                    <option value="user">개인</option>
                    <option value="hospital">병원</option>
                </select>
                
                <label for="startDate">가입일</label>
                <input class="searchInput" type="date" id="startDate" name="startDate">

                <label for="endDate">종료일</label>
                <input class="searchInput" type="date" id="endDate" name="endDate">
                
                <div id="userButtons">
                    <button class="dateBtn" id="monthBtn">1개월</button>
                    <button class="dateBtn" id="threeMonthsBtn">3개월</button>
                    <button class="dateBtn" id="sixMonthsBtn">6개월</button>
                </div>            
                <div id="hosButtons" style="display:none;">
                    <button class="dateBtn" id="oneYearBtn">1년</button>
                    <button class="dateBtn" id="threeYearsBtn">3년</button>
                    <button class="dateBtn" id="fiveYearsBtn">5년</button>
                </div>
                <button class="searchBtn" id="searchBtn">검색</button>
            </div>
        </div>
		
		<div id="searchAccount" style="display:none;">
			<div class="row">
				<label for="accountType">가입구분</label>
				<select class="select" id="accountType" name="type">
					<option value="user">개인</option>
					<option value="hospital">병원</option>
				</select>
				<label for="account">계정</label>
				<input type="text" id="account" name="account" class="searchInput">
				<button class="searchBtn" id="accountSearchBtn">검색</button>
			</div>
		</div>
		
		<div id="searchStats" style="display: none;">
			<div class="row">
				<label for="statsType">가입구분</label>
				<select class="select" id="statsType" name="type">
					<option value="user">개인</option>
					<option value="hospital">병원</option>
				</select>
				<label for="searchType">기간선택</label>	
				<select class="select" id="searchType" name="searchType">
					<option value="all">전체</option>
					<option value="year">연도별</option>
					<option value="month">월별</option>
				</select>
				<div id="dateInput" style="display: none;">
					<label for="dateValue">날짜</label>
					<select class="select" id="dateValue" name="dateValue"></select>
				</div>
				<button class="searchBtn" id="statsSearchBtn">검색</button>
			</div>	
		</div>
		
		<div id="result">
			<!-- 검색 결과 -->
		</div>
		<p id="initAccount" style="display: none;">계정을 입력해주세요.</p>
		<canvas id="revenueChart"></canvas>
		<canvas id="statsChart"></canvas>
	</div>

</body>
</html>