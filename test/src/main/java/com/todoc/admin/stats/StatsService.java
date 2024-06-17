package com.todoc.admin.stats;

import java.util.List;
import java.util.Map;

public interface StatsService {
    // 월별 수익 통계
    List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params);
    List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params);
    // 계정별 결제내역
    List<HosStatsVO> getHosPaymentsByAccount(Map<String, String> params);
    List<UserStatsVO> getUserPaymentsByAccount(Map<String, String> params);
    // 가입자 통계
    List<Map<String, String>> getHosMemberStats(Map<String, String> params);
    List<Map<String, String>> getUserMemberStats(Map<String, String> params);
    // 검색 자동완성
    List<String> getHosIds(String term);
    List<String> getUserEmails(String term);
}
