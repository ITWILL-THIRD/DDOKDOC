package com.todoc.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.hospital.dao.HospitalDAO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService{
	@Autowired
	private HospitalDAO hospitalDAO;

	public HospitalServiceImpl() {
		System.out.println(">> HospitalServiceImpl() 객체 생성");
	}
	
	@Override
	public void insertHospital(HospitalVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateHospital(HospitalVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteHospital(HospitalVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public HospitalVO getHospital(HospitalVO vo) {
		return hospitalDAO.getHospital(vo);
	}

	@Override
	public List<HospitalVO> getHospitalList(HospitalVO vo) {
		// TODO Auto-generated method stub
		return null;

	//병원 상세 조회
	@Override
	public HospitalVO selectOne(int hosIdx) {
		return hospitalDAO.selectOne(hosIdx);
	}

	//병원 전체 조회
	@Override
	public List<HospitalVO> selectList() {
		return hospitalDAO.selectList();
	}

	@Override
	public List<HospitalVO> getHosSearch(HospitalVO vo) {
		return hospitalDAO.getHosSearch(vo);
	}
}
