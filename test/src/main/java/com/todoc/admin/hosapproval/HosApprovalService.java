package com.todoc.admin.hosapproval;

import java.util.List;

import com.todoc.hospital.HospitalVO;

public interface HosApprovalService {
	
	//전체 병원 건수 cnt 조회
	int getTotCnt();
	//병원승인 전체목록 + 페이징 처리
	List<HospitalVO> getHosListPage(HospitalVO vo
			, String beginDate, String endDate,  String condition
			,  int begin, int end);
//	//병원승인 동적 검색 전체 목록 + 페이징
//	List<HospitalVO> getHosSearchPage(HospitalVO vo, int begin, int end);
	//병원 승인(승인완료)
	int updateHospital(HospitalVO vo);
}
