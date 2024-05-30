package com.todoc.hosMain;

import java.util.List;

public interface HospitalService {
	//병원 동적 검색(조회)
	
	//병원 전체 조회
	List<HospitalVO> selectList();
	
	//병원 1개 조회
	HospitalVO selectOne(int hosIdx);
	
	//병원 정보 수정
	
	
	//병원 측, 예약 내역 조회
}
