package com.todoc.admin.hosapproval.dao;

import java.util.List;
import java.util.Map;

import com.todoc.admin.hosapproval.HosApprovalVO;
import com.todoc.hospital.HospitalVO;

public interface HosApprovalDAO {
	
	//병원 승인(승인완료)
	int updateApproval(int hosIdx);
	//전체 병원 건수 cnt 조회
	int getTotCnt();
	//(동적처리 조건별)전체 병원 건수 cnt 조회
	int getAjaxTotCnt(HosApprovalVO vo);
	//병원승인 동적 검색 전체 목록 + 페이징
	List<HosApprovalVO> getHosSearchPage(Map<String, Object> map);
	//병원승인 전체목록 + 페이징 처리
	List<HosApprovalVO> getHosListPage(Map<String, Integer> map);
	
	
}

