package com.todoc.hospital.dao;

import java.util.List;

import com.todoc.hospital.HospitalVO;

public interface HospitalDAO {
	
	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	//민지
	List<HospitalVO> selectList();
	HospitalVO selectOne(int hosIdx);
	//지수
	List<HospitalVO> getHosSearch(HospitalVO vo);
	//주은 
	HospitalVO getHos(HospitalVO ho);
	//병원 정보 입력
	void insertHospital(HospitalVO vo);
	//병원 주소 입력
	void insertHosAddress(HospitalVO vo);
	//병원 운영시간 입력
	void insertHosTime(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
}

