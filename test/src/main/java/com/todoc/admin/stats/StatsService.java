package com.todoc.admin.stats;

import java.util.List;
import java.util.Map;

public interface StatsService {
    // 날짜별 조회 -> 전체 데이터 통계
    List<HosStatsVO> getHosStatsByDate(Map<String, String> params);
    List<UserStatsVO> getUserStatsByDate(Map<String, String> params);
    // 월별 수익 통계
    List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params);
    List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params);
    // 계정별 결제내역
    List<HosStatsVO> getHosPaymentsByAccount(Map<String, String> params);
    List<UserStatsVO> getUserPaymentsByAccount(Map<String, String> params);

    // 병원 가입자 수
    
    // 유저 가입자 수

    

    
}
