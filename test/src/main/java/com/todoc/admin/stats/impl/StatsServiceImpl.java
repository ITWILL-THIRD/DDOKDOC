package com.todoc.admin.stats.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.admin.stats.HosStatsVO;
import com.todoc.admin.stats.StatsService;
import com.todoc.admin.stats.UserStatsVO;
import com.todoc.admin.stats.dao.StatsDAO;

@Service("statsServiceImpl")
public class StatsServiceImpl implements StatsService {
	@Autowired
	private StatsDAO statsDAO;

	@Override
	public List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params) {
		return statsDAO.getHosMonthlyRevenue(params);
	}

	@Override
	public List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params) {
		return statsDAO.getUserMonthlyRevenue(params);
	}

	@Override
	public List<HosStatsVO> getHosPaymentsByAccount(Map<String, String> params) {
		return statsDAO.getHosPaymentsByAccount(params);
	}

	@Override
	public List<UserStatsVO> getUserPaymentsByAccount(Map<String, String> params) {
		return statsDAO.getUserPaymentsByAccount(params);
	}

	@Override
	public List<Map<String, String>> getHosMemberStats(Map<String, String> params) {
		return statsDAO.getHosMemberStats(params);
	}

	@Override
	public List<Map<String, String>> getUserMemberStats(Map<String, String> params) {
		return statsDAO.getUserMemberStats(params);
	}

	@Override
	public List<String> getHosIds(String term) {
		return statsDAO.getHosIds(term);
	}
	
	@Override
	public List<String> getUserEmails(String term) {
		return statsDAO.getUserEmails(term);
	}

	@Override
	public Map<String, List<Map<String, String>>> getMonthlyRevenue(Map<String, String> params) {
		List<Map<String, String>> userRevenue = statsDAO.getUserMonthlyRevenue(params);
		List<Map<String, String>> hosRevenue = statsDAO.getHosMonthlyRevenue(params);
		
		Map<String, List<Map<String, String>>> monthlyRevenue = new HashMap<>();
		monthlyRevenue.put("user", userRevenue);
		monthlyRevenue.put("hospital", hosRevenue);
		return monthlyRevenue;
	}

	@Override
	public Map<String, List<Map<String, String>>> getMemberStats(Map<String, String> params) {
		List<Map<String, String>> userStats = statsDAO.getUserMemberStats(params);
		List<Map<String, String>> hosStats = statsDAO.getHosMemberStats(params);
		
		Map<String, List<Map<String, String>>> memberStats = new HashMap<>();
		memberStats.put("user", userStats);
		memberStats.put("hospital", hosStats);
		return memberStats;
	}
	
}
