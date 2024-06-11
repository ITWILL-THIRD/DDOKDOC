package com.todoc.stats.dao;

import java.util.List;
import java.util.Map;

import com.todoc.stats.HosStatsVO;

public interface StatsDAO {
	List<HosStatsVO> getStatsByDate(Map<String, String> params);
    List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params);
    List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params);
    List<HosStatsVO> getStatsById(String hosId);
	
}
