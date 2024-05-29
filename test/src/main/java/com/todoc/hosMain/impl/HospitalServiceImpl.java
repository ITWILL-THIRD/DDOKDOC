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
	
	public HospitalServiceImpl(JoinHospitalDAO joinHospitalDAO) {
		System.out.println(">> HospitalServiceImpl(joinHospitalDAO) 객체 생성");
	}

	@Override
	public JoinHospitalVO selectOne(JoinHospitalVO vo) {
		return joinHospitalDAO.selectOne(vo);
	}

	@Override
	public List<JoinHospitalVO> selectList() {
		return joinHospitalDAO.selectList();
	}

	

}
