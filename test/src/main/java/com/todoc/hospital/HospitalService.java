package com.todoc.hospital;

import java.util.List;


public interface HospitalService {
	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	//병원 전체 조회
	List<HospitalVO> selectList();
	//병원 1개 조회
	HospitalVO selectOne(int hosIdx);
	//병원 동적 검색
	List<HospitalVO> getHosSearch(HospitalVO vo);
	//주은
	HospitalVO getHos(HospitalVO ho);
	//기업(병원) 회원가입 시,
	//병원 정보 입력
	void insertHospital(HospitalVO vo);
	//병원 주소 입력
	void insertHosAddress(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
}
