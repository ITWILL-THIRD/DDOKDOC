package com.todoc.admin.stats.dao;

import java.util.List;
import java.util.Map;

import com.todoc.admin.stats.HosStatsVO;
import com.todoc.admin.stats.UserStatsVO;

public interface StatsDAO {
    List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params);
    List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params);
    List<HosStatsVO> getHosPaymentsByAccount(Map<String, String> params);
    List<UserStatsVO> getUserPaymentsByAccount(Map<String, String> params);
    List<Map<String, String>> getHosMemberStats(Map<String, String> params);
    List<Map<String, String>> getUserMemberStats(Map<String, String> params);
    List<String> getHosIds(String term);
    List<String> getUserEmails(String term);
    Map<String, List<Map<String, String>>> getMonthlyRevenue(Map<String, String> params);
    Map<String, List<Map<String, String>>> getMemberStats(Map<String, String> params);
}
