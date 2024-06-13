package com.todoc.admin.stats.dao;

import java.util.List;
import java.util.Map;

import com.todoc.admin.stats.HosStatsVO;
import com.todoc.admin.stats.UserStatsVO;

public interface StatsDAO {
    List<HosStatsVO> getHosStatsByDate(Map<String, String> params);
    List<UserStatsVO> getUserStatsByDate(Map<String, String> params);
    List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params);
    List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params);
    List<HosStatsVO> getHosPaymentsByAccount(Map<String, String> params);
    List<UserStatsVO> getUserPaymentsByAccount(Map<String, String> params);
}
