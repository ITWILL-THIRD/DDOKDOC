package com.todoc.hospital;

import java.util.List;

public interface HospitalService {
	void insertHospital(HospitalVO vo);
	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	//병원 전체 조회
	List<HospitalVO> selectList();
	//병원 1개 조회
	HospitalVO selectOne(int hosIdx);
	//병원 동적 검색
	List<HospitalVO> getHosSearch(HospitalVO vo);
}