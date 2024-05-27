package com.spring.biz.hosSearch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.biz.hosSearch.AllHospitalVO;
import com.spring.biz.hosSearch.HospitalService;
import com.spring.biz.hosSearch.dao.AllHospitalDAO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	private AllHospitalDAO allHospitalDAO;
	
	public HospitalServiceImpl(AllHospitalDAO allHospitalDAO) {
		System.out.println(">> HospitalServiceImpl(AllHospitalDAO) 객체생성");
	}
	
	@Override
	public List<AllHospitalVO> getAllList(String category, String keyword) {
		return allHospitalDAO.getAllList(category, keyword);
	}

}
