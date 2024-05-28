package com.todoc.hosSearch;

import java.util.List;

public interface HospitalService {
	//병원 검색
	List<AllHospitalVO> getAllList(String category, String keyword);
	
	//병원 정보 수정
	
	
	//병원 측, 예약 내역 조회
}
