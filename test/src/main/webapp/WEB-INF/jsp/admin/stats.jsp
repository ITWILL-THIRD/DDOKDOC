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
<jsp:include page="../../css/approvalListCss.jsp"/>
<jsp:include page="../../css/commonCss.jsp"/>
<jsp:include page="../common/navigation.jsp"/>
<style>
    #searchDate {
        display: flex;
        flex-direction: row;
        gap: 10px;
        flex-wrap: wrap;
    }
    .row {
        display: flex;
        align-items: center;
        gap: 10px;
    }
    #revenueChart, #statsChart {
    	display: none;
        max-width: 700px;
        max-height: 350px;
    }
</style>
</head>
<body>
    <div id="container">
        <div>
            <button id="monthlyRevenueBtn">수익통계</button>
            <button id="paymentsByAccountBtn">계정별 결제내역</button>
            <button id="memberStatsBtn">가입자통계</button>
        </div>
        
        <div id="searchDate" style="display:none;">
            <div class="row">
                <label for="type">가입구분:</label>
                <select id="type" name="type">
                    <option value="user">개인</option>
                    <option value="hospital">병원</option>
                </select>
           </div>
            <div class="row">
                <label for="startDate">가입일:</label>
                <input type="date" id="startDate" name="startDate">
            </div>
            <div class="row">
                <label for="endDate">종료일:</label>
                <input type="date" id="endDate" name="endDate">
                
                <div id="userButtons">
                    <button id="monthBtn">1개월</button>
                    <button id="threeMonthsBtn">3개월</button>
                    <button id="sixMonthsBtn">6개월</button>
                </div>            
                <div id="hosButtons" style="display:none;">
                    <button id="oneYearBtn">1년</button>
                    <button id="threeYearsBtn">3년</button>
                    <button id="fiveYearsBtn">5년</button>
                </div>
                <button id="searchBtn">검색</button>
            </div>
        </div>
		
		<div id="searchAccount" style="display:none;">
			<label for="accountType">가입구분:</label>
			<select id="accountType" name="type">
				<option value="user">개인</option>
				<option value="hospital">병원</option>
			</select>
			<label for="account">계정:</label>
			<input type="text" id="account" name="account">
			<button id="accountSearchBtn">검색</button>
		</div>
		
		<div id="searchStats" style="display: none;">
			<div class="row">
				<label for="statsType">가입구분:</label>
				<select id="statsType" name="type">
					<option value="user">개인</option>
					<option value="hospital">병원</option>
				</select>
				<label for="searchType">기간선택:</label>	
				<select id="searchType" name="searchType">
					<option value="all">전체</option>
					<option value="year">연도별</option>
					<option value="month">월별</option>
				</select>
				<div id="dateInput" style="display: none;">
					<label for="dateValue">날짜:</label>
					<select id="dateValue" name="dateValue"></select>
				</div>
				<button id="statsSearchBtn">검색</button>
			</div>	
		</div>
		
		<div id="result">
			<!-- 검색 결과 -->
		</div>
		
		<canvas id="revenueChart" width="400" height="400"></canvas>
		<canvas id="statsChart" width="400" height="400"></canvas>
		
		
        <script>
            $(document).ready(function() {
            	var revenueChart, statsChart;
            	
				// 상태 초기화
                function resetAll() {
                	$("#type").val("user");
                    $("#startDate").val("");
                    $("#endDate").val("");
                	$("#accountType").val("user");
                	$("#account").val("");
                    $("#statsType").val("user");
                    $("#searchType").val("all");
                    $("#dateValue").val("");
                    $("#dateInput").hide(); // 다른 버튼 클릭 시 폼 숨기기
                    $("#revenueChart").hide(); 
                    $("#statsChart").hide();
                }
            	
				// 이벤트에 따른 폼 상태 처리
                $("#monthlyRevenueBtn").click(function() {
                	resetAll(); // 상태 초기화
                    $("#searchDate").show(); // 날짜 입력 폼 표시
                    $("#searchAccount").hide(); // 계정 입력 폼 숨김
                    $("#searchStats").hide(); // 통계 입력 폼 숨김
                    $("#searchDate").data("type", "monthlyRevenue"); // 검색 데이터 타입 설정
                    $("#result").empty(); // 검색 결과 초기화
                });
                
                // 가입구분 버튼 표시
                $("#type").change(function() {
                    if ($("#type").val() === "user") {
                        $("#userButtons").show();
                        $("#hosButtons").hide();
                    } else if ($("#type").val() === "hospital") {
                        $("#userButtons").hide();
                        $("#hosButtons").show(); 
                    }
                });
                
                $("#paymentsByAccountBtn").click(function() {
                	resetAll();
                    $("#searchAccount").show();
                    $("#searchDate").hide();
                    $("#searchStats").hide();
                    $("#searchAccount").data("type", "paymentsByAccount");
                    $("#result").empty();
                });
                
                $("#memberStatsBtn").click(function() {
                	resetAll();
                    $("#searchStats").show();
                    $("#searchDate").hide();
                    $("#searchAccount").hide();
                    $("#searchStats").data("type", "memberStats");
                    $("#result").empty();
                });
                
             	// 전체검색 시 입력 필드 숨기기
                $("#searchType").change(function() {
                    if ($("#searchType").val() === "all") {
                        $("#dateInput").hide();
                    } else {
                        $("#dateInput").show();
                        if ($("#searchType").val() === "month") {
                        	MonthOptions();
                        } else if ($("#searchType").val() === "year") {
                        	YearOptions();
                        }
                    }
                });
             	
             	// 날짜 입력값 선택 옵션
                function MonthOptions() {
                    $("#dateValue").empty();
                    for (let i = 1; i <= 12; i++) {
                        let month = i < 10 ? '0' + i : i;
                        $("#dateValue").append(new Option(month, month));
                    }
                }
             	
                function YearOptions() {
                    $("#dateValue").empty();
                    let currentYear = new Date().getFullYear();
                    for (let i = currentYear - 4; i <= currentYear; i++) {
                        $("#dateValue").append(new Option(i, i));
                    }
                }
                
             	// ajax 처리
             	// 수익 통계 조회
                $("#searchBtn").click(function() {
                    var type = $("#type").val();
                    var startDate = $("#startDate").val();
                    var endDate = $("#endDate").val();
                    
                    if ($("#searchDate").data("type") === "monthlyRevenue") { // monthlyRevenue 검색 요청이 들어왔을 때
                        if (revenueChart) {
                            revenueChart.destroy(); // 기존 차트 삭제
                        }
                        $.ajax('monthlyRevenue.do', {
                            method: 'get',
                            data: { // 서버 전송 데이터
                                startDate: startDate,
                                endDate: endDate,
                                type: type
                            },
                            success: function(data) {
                            	console.log(data);
                                $("#result").html(data);
                                if ($("#result table tr").length > 1) {
                                    drawChart();
                                    $("#revenueChart").show();
                                } else {
                                    $("#revenueChart").hide();
                                }
                            }
                        });    
                    }
                });
             	
             	// 계정별 결제 내역 조회
                $("#accountSearchBtn").click(function() {
                    var type = $("#accountType").val();
                    var account = $("#account").val();
                    
                    if ($("#searchAccount").data("type") === "paymentsByAccount") {
                        $.ajax('paymentsByAccount.do', {
                            method: 'get',
                            data: {
                                account: account,
                                type: type
                            },
                            success: function(data) {
                                $("#result").html(data);
                            }
                        });
                    }
                });
                
           		// 가입자 통계 조회
                $("#statsSearchBtn").click(function() {
                	var type = $("#statsType").val();
					var searchType = $("#searchType").val();
					var dateValue = $("#dateValue").val();
					
					if($("#searchStats").data("type") === "memberStats") {
						$.ajax('memberStats.do', {
							method: 'get',
							data: {
								type: type,
								searchType: searchType,
								dateValue: dateValue
							},
                            success: function(data) {
                                $("#result").html(data);
                                if ($("#result table tr").length > 1) {
                                    drawStatsChart();
                                    $("#statsChart").show();
                                } else {
                                    $("#statsChart").hide();
                                }
			                }
			            });
			        }
			    });
                
                // 계정 자동완성
                $("#account").autocomplete({
                    source: function(request, response) {
                        var accountType = $("#accountType").val();
                        var url = (accountType === "user") ? "getUserEmails.do" : "getHosIds.do";
                        
                        $.ajax({
                            url: url,
                            data: { term: request.term }, // 입력된 값 전달
                            success: function(data) {
                                response(data); // 자동완성 목록 표시
                            }
                        });
                    },
                    minLength: 1 // 최소 1글자 이상 입력
                });
                
                // 차트 그리기
                function drawChart() {
                    var labels = [];
                    var dataPoints = [];

                    $("#result table tr").each(function(index, element) { // 각 행을 반복
                        if (index > 0) { // 첫번째 행(헤더) 미포함
                            var cells = $(element).find("td"); // 행의 모든 셀 찾기
                            labels.push(cells.eq(0).text()); // 첫번째 셀 텍스트 배열에 추가
                            dataPoints.push(parseFloat(cells.eq(1).text().replace(/,/g, ''))); // 두번째 셀 텍스트 숫자로 변환(쉼표제거) 후 배열에 추가
                        }
                    });
                    
                    if (revenueChart) {
                        revenueChart.destroy(); // 기존 차트 삭제
                    }

                    var ctx = document.getElementById('revenueChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: '월별 수익',
                                data: dataPoints,
                                borderColor: '#2C307D',
                                backgroundColor: '#E0EAF5',
                                borderWidth: 1,
                                fill: false // 선 아래 색상 없음
                            }]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true // Y축 0부터 시작
                                }
                            }
                        }
                    });
                }
                
                function drawStatsChart() {
                    var labels = [];
                    var totalMembers = [];
                    var newMembers = [];
                    var growthRates = [];

                    $("#result table tr").each(function(index, element) {
                        if (index > 0) {
                            var cells = $(element).find("td");
                            labels.push(cells.eq(0).text());
                            totalMembers.push(parseInt(cells.eq(1).text().trim(), 10));
                            newMembers.push(parseInt(cells.eq(2).text().trim(), 10));
                            growthRates.push(parseFloat(cells.eq(3).text().replace('%', '').trim()));
                        }
                    });

                    if (statsChart) {
                        statsChart.destroy();
                    }

                    var ctx = document.getElementById('statsChart').getContext('2d');
                    statsChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [
                                {
                                    label: '총 가입자',
                                    data: totalMembers,
                                    backgroundColor: 'rgba(182, 229, 255, 0.5)',
                                    borderColor: 'rgba(46, 119, 174, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: '신규 가입자',
                                    data: newMembers,
                                    backgroundColor: 'rgba(255, 162, 23, 0.5)',
                                    borderColor: 'rgba(253, 111, 47, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: '증가율 (%)',
                                    data: growthRates,
                                    backgroundColor: 'rgba(44, 48, 125, 0.5)',
                                    borderColor: 'rgba(13, 33, 55, 1)',
                                    borderWidth: 1,
                                    yAxisID: 'y-axis-2'
                                }
                            ]
                        },
                        options: {
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return value + '명';
                                        }
                                    }
                                },
                                'y-axis-2': {
                                    type: 'linear',
                                    position: 'right',
                                    beginAtZero: true,
                                    ticks: {
                                        callback: function(value) {
                                            return value + '%';
                                        }
                                    }
                                }
                            }
                        }
                    });
                }
                
			});
		</script>
		<jsp:include page="dateButtons.jsp" />
	</div>

</body>
</html>