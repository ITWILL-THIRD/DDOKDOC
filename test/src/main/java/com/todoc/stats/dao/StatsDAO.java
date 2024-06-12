package com.todoc.stats.dao;

import java.util.List;
import java.util.Map;

import com.todoc.stats.HosStatsVO;
import com.todoc.stats.UserStatsVO;

public interface StatsDAO {
    List<HosStatsVO> getHosStatsByDate(Map<String, String> params);
    List<UserStatsVO> getUserStatsByDate(Map<String, String> params);
    List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params);
    List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params);
	
}
