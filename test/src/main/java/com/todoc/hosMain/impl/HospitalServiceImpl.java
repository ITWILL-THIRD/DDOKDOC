package com.todoc.hosMain.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.hosMain.HospitalService;
import com.todoc.hosMain.HospitalVO;
import com.todoc.hosMain.dao.HospitalDAO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	private HospitalDAO hospitalDAO;
	

	@Override
	public HospitalVO selectOne(int hosIdx) {
		return hospitalDAO.selectOne(hosIdx);
	}

	@Override
	public List<HospitalVO> selectList() {
		return hospitalDAO.selectList();
	}

	

}
