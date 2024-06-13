<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버십 통계</title>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
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
</style>
</head>
<body>
    <div id="container">
        <div>
            <button id="monthlyRevenueBtn">수익통계</button>
            <button id="paymentsByAccountBtn">계정별 결제내역</button>
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
                
                <div id="userButtons" class="buttonContainer">
                    <button id="monthBtn">1개월</button>
                    <button id="threeMonthsBtn">3개월</button>
                    <button id="sixMonthsBtn">6개월</button>
                </div>            
                <div id="hosButtons" class="buttonContainer" style="display:none;">
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
		
		<div id="result">
			<!-- 검색 결과 -->
		</div>
		
        <script>
            $(document).ready(function(){
                $("#monthlyRevenueBtn").click(function(){
                    $("#searchDate").show(); // 날짜 입력 폼 표시
                    $("#searchAccount").hide(); // 계정 입력 폼 숨김
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
                
                $("#paymentsByAccountBtn").click(function(){
                    $("#searchAccount").show();
                    $("#searchDate").hide();
                    $("#searchAccount").data("type", "paymentsByAccount");
                    $("#result").empty();
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

                $("#accountSearchBtn").click(function(){
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
			});
		</script>		
		<jsp:include page="dateButtons.jsp" />
	</div>

</body>
</html>