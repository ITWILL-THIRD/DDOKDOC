package com.todoc.hosSearch.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.hosSearch.AllHospitalVO;
import com.todoc.hosSearch.HospitalService;
import com.todoc.hosSearch.dao.AllHospitalDAO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	private AllHospitalDAO allHospitalDAO;
	
	public HospitalServiceImpl(AllHospitalDAO allHospitalDAO) {
		System.out.println(">> HospitalServiceImpl(AllHospitalDAO) 객체생성");
	}
	
	@Override
	public List<AllHospitalVO> getAllList(String category, String keyword) {
		System.out.println("category : " + category + ", keyword : " + keyword);
		return allHospitalDAO.getHosList(category, keyword);
	}

}
