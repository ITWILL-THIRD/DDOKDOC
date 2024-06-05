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
	void insertHospital(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
	HospitalVO hoFindId(HospitalVO vo);
	int hoFindPwd(HospitalVO vo);
	void hoUpdateExPwd(HospitalVO vo);
}

