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
	public void updateHospital(HospitalVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteHospital(HospitalVO vo) {
		// TODO Auto-generated method stub
		
	}

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
	
	@Override
	public HospitalVO getHos(HospitalVO ho) {
		return hospitalDAO.getHos(ho);
	}
	
	@Override
	public void insertHospital(HospitalVO vo) {
		hospitalDAO.insertHospital(vo);
	}
	//아이디 중복체크
	@Override
	public int hosId(HospitalVO ho) throws Exception {
		int cnt = hospitalDAO.hosId(ho);
		return cnt;
	}
	// 병원 아이디 찾기
	public HospitalVO hoFindId(HospitalVO vo) {
		return hospitalDAO.hoFindId(vo);
	}
	//병원 비번찾기
	public int hoFindPwd(HospitalVO vo) {
		return hospitalDAO.hoFindPwd(vo);
	}
	//병원 임시비번 업데이트
	public void hoUpdateExPwd(HospitalVO vo) {
		hospitalDAO.hoUpdateExPwd(vo);
	}
}
