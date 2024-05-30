package com.todoc.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.user.HosService;
import com.todoc.user.HospitalVO;
import com.todoc.user.dao.HosDAO;
@Service(value = "hosService")
public class HosServiceImpl implements HosService {
	@Autowired
	private HosDAO hosDAO;
	@Autowired
	public HosServiceImpl(HosDAO hosDAO) {
		this.hosDAO = hosDAO;
	}
	@Override
	public HospitalVO getHos(HospitalVO ho) {
		return hosDAO.getHos(ho);
	}
	
	public void insertHos(HospitalVO vo) {
		hosDAO.insertHos(vo);
	}

}
