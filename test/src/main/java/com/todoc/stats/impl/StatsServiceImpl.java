package com.todoc.stats.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.stats.HosStatsVO;
import com.todoc.stats.StatsService;
import com.todoc.stats.UserStatsVO;
import com.todoc.stats.dao.StatsDAO;

@Service("statsServiceImpl")
public class StatsServiceImpl implements StatsService {
	@Autowired
	private StatsDAO statsDAO;

	@Override
	public List<HosStatsVO> getHosStatsByDate(Map<String, String> params) {
		// TODO Auto-generated method stub
		return statsDAO.getHosStatsByDate(params);
	}

	@Override
	public List<UserStatsVO> getUserStatsByDate(Map<String, String> params) {
		// TODO Auto-generated method stub
		return statsDAO.getUserStatsByDate(params);
	}

	@Override
	public List<Map<String, String>> getHosMonthlyRevenue(Map<String, String> params) {
		// TODO Auto-generated method stub
		return statsDAO.getHosMonthlyRevenue(params);
	}

	@Override
	public List<Map<String, String>> getUserMonthlyRevenue(Map<String, String> params) {
		// TODO Auto-generated method stub
		return statsDAO.getUserMonthlyRevenue(params);
	}



	
}
