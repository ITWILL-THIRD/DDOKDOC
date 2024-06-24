<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                    $(".dateBtn").removeClass("active");
                    $("#initAccount").hide(); // 계정 초기 메시지 숨기기
                }
				
                // 버튼이 클릭되면 active 클래스 지정
                $(".btn").click(function() {
                	$(".btn").removeClass("active"); // active 클래스 제거
                	$(this).addClass("active"); // 클릭된 버튼 active 클래스 추가
                });
                
                $(".dateBtn").click(function() {
                    $(".dateBtn").removeClass("active");
                    $(this).addClass("active");
                });

				// 이벤트에 따른 폼 상태 처리
                $("#monthlyRevenueBtn").click(function() {
                	resetAll(); // 상태 초기화
                    $("#searchDate").show(); // 날짜 입력 폼 표시
                    $("#searchAccount").hide(); // 계정 입력 폼 숨김
                    $("#searchStats").hide(); // 통계 입력 폼 숨김
                    $("#searchDate").data("type", "monthlyRevenue"); // 검색 데이터 타입 설정
                    $("#result").empty(); // 검색 결과 초기화
                    initMonthlyRevenue(); // 초기 데이터 로드
                    $(this).addClass("active");
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
                    $("#initAccount").show();	
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
                    initMemberStats();
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
             	// 초기 데이터 로드
			    function initMonthlyRevenue() {
			        if (revenueChart) {
			            revenueChart.destroy();
			        }
			
			        $.ajax({
			            url: 'initMonthlyRevenue.do',
			            method: 'get',
			            success: function(data) {
			                drawRevenueChart(data.user, data.hospital); // 차트 데이터 그리기
			                $("#revenueChart").show();
			            }
			        });
			    }
             	
			    function initMemberStats() {
			        if (statsChart) {
			            statsChart.destroy();
			        }

			        $.ajax({
			            url: 'initMemberStats.do',
			            method: 'get',
			            success: function(data) {
			                drawMemberStatsChart(data.user, data.hospital);
			                $("#statsChart").show();
			            }
			        });
			    }
             	
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
                    $("#initAccount").hide();
                    
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
			    function drawRevenueChart(userData, hosData) {
			        var userLabels = [], userPoints = [];
			        var hosLabels = [], hosPoints = [];
			
			        userData.forEach(function(item) {
			            userLabels.push(item.MONTH);
			            userPoints.push(parseFloat(item.TOTAL_PAY));
			        });
			
			        hosData.forEach(function(item) {
			            hosLabels.push(item.MONTH);
			            hosPoints.push(parseFloat(item.TOTAL_PAY));
			        });
			
			        if (revenueChart) {
			            revenueChart.destroy(); // 기존 차트 삭제
			        }
			
			        var ctx = document.getElementById('revenueChart').getContext('2d');
			        revenueChart = new Chart(ctx, {
			            type: 'line',
			            data: {
			                labels: userLabels.length > hosLabels.length ? userLabels : hosLabels, // 데이터가 더 많은 배열 x축에 표시
			                datasets: [
			                    {
			                        label: '개인 월별 수익',
			                        data: userPoints,
			                        borderColor: '#2C307D',
			                        backgroundColor: '#E0EAF5',
			                        borderWidth: 1,
			                        fill: false,
			                        yAxisID: 'y-axis-user'
			                    },
			                    {
			                        label: '병원 월별 수익',
			                        data: hosPoints,
			                        borderColor: '#FF5733',
			                        backgroundColor: '#FFCCCB',
			                        borderWidth: 1,
			                        fill: false,
			                        yAxisID: 'y-axis-hospital'
			                    }
			                ]
			            },
			            options: {
			                scales: {
			                    yAxes: [
			                        {
			                            id: 'y-axis-user',
			                            type: 'linear',
			                            position: 'left',
			                            ticks: {
			                                beginAtZero: true,
			                            },
			                            scaleLabel: {
			                                display: true,
			                                labelString: '개인 월별 수익'
			                            }
			                        },
			                        {
			                            id: 'y-axis-hospital',
			                            type: 'linear',
			                            position: 'right',
			                            ticks: {
			                                beginAtZero: true,
			                            },
			                            scaleLabel: {
			                                display: true,
			                                labelString: '병원 월별 수익'
			                            }
			                        }
			                    ],
			                    x: {
			                        beginAtZero: true
			                    }
			                }
			            }
			        });
			    }

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
                
                function drawMemberStatsChart(userStats, hosStats) {
                    var userLabels = [], userTotal = [], userNew = [], userGrowth = [];
                    var hosLabels = [], hosTotal = [], hosNew = [], hosGrowth = [];

                    userStats.forEach(function(item) {
                        userLabels.push(item.PERIOD);
                        userTotal.push(parseInt(item.TOTALUSERS));
                        userNew.push(parseInt(item.NEWUSERS));
                        userGrowth.push(parseFloat(item.GROWTHRATE));
                    });

                    hosStats.forEach(function(item) {
                        hosLabels.push(item.PERIOD);
                        hosTotal.push(parseInt(item.TOTALHOS));
                        hosNew.push(parseInt(item.NEWHOS));
                        hosGrowth.push(parseFloat(item.GROWTHRATE));
                    });

                    if (statsChart) {
                        statsChart.destroy();
                    }

                    var ctx = document.getElementById('statsChart').getContext('2d');
                    statsChart = new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: userLabels.length > hosLabels.length ? userLabels : hosLabels,
                            datasets: [
                                {
                                    label: '개인 총 가입자',
                                    data: userTotal,
                                    backgroundColor: 'rgba(182, 229, 255, 0.5)',
                                    borderColor: 'rgba(155, 200, 230, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: '개인 신규 가입자',
                                    data: userNew,
                                    backgroundColor: 'rgba(255, 162, 23, 0.5)',
                                    borderColor: 'rgba(255, 162, 23, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: '병원 총 가입자',
                                    data: hosTotal,
                                    backgroundColor: 'rgba(46, 119, 174, 0.5)',
                                    borderColor: 'rgba(46, 119, 174, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: '병원 신규 가입자',
                                    data: hosNew,
                                    backgroundColor: 'rgba(253, 111, 47, 0.5)',
                                    borderColor: 'rgba(253, 111, 47, 1)',
                                    borderWidth: 1
                                },
                                {
                                    label: '개인 증가율 (%)',
                                    data: userGrowth,
                                    backgroundColor: 'rgba(44, 48, 125, 0.5)',
                                    borderColor: 'rgba(44, 48, 125, 1)',
                                    borderWidth: 1,
                                    yAxisID: 'y-axis-2'
                                },
                                {
                                    label: '병원 증가율 (%)',
                                    data: hosGrowth,
                                    backgroundColor: 'rgba(31, 82, 107, 0.5)',
                                    borderColor: 'rgba(31, 82, 107, 1)',
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
                                },
                                x: {
                                    beginAtZero: true
                                }
                            }
                        }
                    });
                }
                $("#monthlyRevenueBtn").trigger("click"); //페이지 로드 시 수익통계 화면 보이기
			});
		</script>