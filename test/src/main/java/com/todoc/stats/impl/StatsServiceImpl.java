package com.todoc.stats.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.stats.HosStatsVO;
import com.todoc.stats.StatsService;
import com.todoc.stats.dao.StatsDAO;

@Service("statsServiceImpl")
public class StatsServiceImpl implements StatsService {
	@Autowired
	private StatsDAO statsDAO;

	@Override
	public List<HosStatsVO> getStatsByDate(Map<String, String> params) {
		// TODO Auto-generated method stub
		return statsDAO.getStatsByDate(params);
	}

	@Override
	public List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params) {
		return statsDAO.getHosMonthlyRevenue(params);
	}

	@Override
	public List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params) {
		return statsDAO.getUserMonthlyRevenue(params);
	}

	@Override
	public List<HosStatsVO> getStatsById(String hosId) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
