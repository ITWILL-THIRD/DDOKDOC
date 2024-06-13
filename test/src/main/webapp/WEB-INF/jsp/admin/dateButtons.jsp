<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
    $(document).ready(function(){
        // 날짜 버튼
        $("#monthBtn").click(function(){
            var today = new Date();
            var lastMonth = new Date(today.getFullYear(), today.getMonth(), 0); // 지난달 마지막 날 계산
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

        $("#oneYearBtn").click(function() {
            var today = new Date();
            var lastYear = new Date(today.getFullYear() - 1, today.getMonth(), today.getDate()); // 1년 전
            var todayStr = today.toISOString().split('T')[0];
            var lastYearStr = lastYear.toISOString().split('T')[0];
            $("#startDate").val(lastYearStr);
            $("#endDate").val(todayStr);
        });

        $("#threeYearsBtn").click(function() {
            var today = new Date();
            var threeYears = new Date(today.getFullYear() - 3, today.getMonth(), today.getDate()); // 3년 전
            var todayStr = today.toISOString().split('T')[0];
            var threeYearsStr = threeYears.toISOString().split('T')[0];
            $("#startDate").val(threeYearsStr);
            $("#endDate").val(todayStr);
        });

        $("#fiveYearsBtn").click(function() {
            var today = new Date();
            var threeYears = new Date(today.getFullYear() - 5, today.getMonth(), today.getDate()); // 5년 전
            var todayStr = today.toISOString().split('T')[0];
            var threeYearsStr = threeYears.toISOString().split('T')[0];
            $("#startDate").val(threeYearsStr);
            $("#endDate").val(todayStr);
        });
    });
</script>
