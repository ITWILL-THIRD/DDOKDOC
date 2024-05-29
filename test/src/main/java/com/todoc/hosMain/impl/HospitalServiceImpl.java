package com.todoc.hosMain.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.hosMain.HospitalService;
import com.todoc.hosMain.JoinHospitalVO;
import com.todoc.hosMain.dao.JoinHospitalDAO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	private JoinHospitalDAO joinHospitalDAO;
	

	@Override
	public JoinHospitalVO selectOne(int hosIdx) {
		return joinHospitalDAO.selectOne(hosIdx);
	}

	@Override
	public List<JoinHospitalVO> selectList() {
		return joinHospitalDAO.selectList();
	}

	

}
