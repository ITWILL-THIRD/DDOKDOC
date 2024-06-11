<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 통계</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
	<div id="container">
		<div>
			<button id="monthlyRevenueBtn">수익통계</button>
		</div>
		
		<div id="searchDate" style="display:none;">
			<label for="type">가입구분:</label>
			<select id="type" name="type">
				<option value="user">개인</option>
				<option value="hospital">병원</option>
			</select>
			<label for="startDate">가입일:</label>
			<input type="date" id="startDate" name="startDate">
			<label for="endDate">종료일:</label>
			<input type="date" id="endDate" name="endDate">
            <button id="monthBtn">1개월</button>
            <button id="threeMonthsBtn">3개월</button>
            <button id="sixMonthsBtn">6개월</button>
  			<button id="yearBtn">1년</button>
			<button id="searchBtn">검색</button>
		</div>
		
		<div id="result">
			<!-- 검색 결과 -->
		</div>
		
		<script>
			$(document).ready(function(){
				$("#monthlyRevenueBtn").click(function(){
					$("#searchDate").show(); // 입력 폼 표시
					$("#searchDate").data("type", "monthlyRevenue"); // 검색 데이터 타입 설정
				});
				
				$("#searchBtn").click(function(){
					var type = $("#type").val();
					var startDate = $("#startDate").val();
					var endDate = $("#endDate").val();
					
					if ($("#searchDate").data("type") === "monthlyRevenue") { // monthlyRevenue 검색 요청이 들어왔을 때
						$.ajax('monthlyRevenue.do', {
							method: 'get',
							data: { // 서버 전송 데이터
								startDate: startDate,
								endDate: endDate,
								type: type
							},
							success: function(data) {
								$("#result").html(data);
							}
						});	
					}
				});
				
				// 날짜 버튼
		        $("#monthBtn").click(function(){
		            var today = new Date();
		            var lastMonth = new Date(today.getFullYear(), today.getMonth(), 0); //지난달 마지막 날 계산
		            var firstDayOfMonth = new Date(today.getFullYear(), today.getMonth() - 1, 1); // 지난달 첫 날 
		            var lastDayOfMonth = new Date(today.getFullYear(), today.getMonth() - 1, lastMonth.getDate()); // 지난달 마지막 날
		            var firstDayOfMonthStr = firstDayOfMonth.toISOString().split('T')[0]; // IOS 형식으로 변환
		            var lastDayOfMonthStr = lastDayOfMonth.toISOString().split('T')[0];
		            $("#startDate").val(firstDayOfMonthStr);
		            $("#endDate").val(lastDayOfMonthStr);
		        });
				
		        $("#threeMonthsBtn").click(function(){
		            var today = new Date();
		            var lastThreeMonths = new Date(today.getFullYear(), today.getMonth() - 3, today.getDate()); // 3개월 전
		            var todayStr = today.toISOString().split('T')[0];
		            var lastThreeMonthsStr = lastThreeMonths.toISOString().split('T')[0];
		            $("#startDate").val(lastThreeMonthsStr);
		            $("#endDate").val(todayStr);
		        });
				
		        $("#sixMonthsBtn").click(function(){
		        	var today = new Date();
		        	var lastSixMonths = new Date(today.getFullYear(), today.getMonth() - 6, today.getDate()); // 6개월 전
		        	var todayStr = today.toISOString().split('T')[0];
		        	var lastSixMonthsStr = lastSixMonths.toISOString().split('T')[0];
		        	$("#startDate").val(lastSixMonthsStr);
		            $("#endDate").val(todayStr);
		        });

		        $("#yearBtn").click(function() {
		            var today = new Date();
		            var lastYear = new Date(today.getFullYear() - 1, today.getMonth(), today.getDate()); // 1년 전
		            var todayStr = today.toISOString().split('T')[0];
		            var lastYearStr = lastYear.toISOString().split('T')[0];
		            $("#startDate").val(lastYearStr);
		            $("#endDate").val(todayStr);
		        });
		        
			});
		</script>		
		
	
	</div>

</body>
</html>