package com.todoc.admin.hosapproval.dao;

import java.util.List;
import java.util.Map;

import com.todoc.hospital.HospitalVO;

public interface HosApprovalDAO {
	
	//전체 병원 건수 cnt 조회
	int getTotCnt();
	//병원승인 동적 검색 전체 목록 + 페이징
	List<HospitalVO> getHosSearchPage(Map<String, Object> map);
	//병원승인 전체목록 + 페이징 처리
	List<HospitalVO> getHosListPage(Map<String, Integer> map);
	//병원 승인(승인완료)
	int updateHospital(HospitalVO vo);
	
	
}

