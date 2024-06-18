package com.todoc.admin.hosapproval;

import java.util.List;

import com.todoc.hospital.HospitalVO;

public interface HosApprovalService {
	
	//병원 승인(승인완료)
	int updateApproval(int hosIdx);
	//병원 승인 취소(승인전)
	int updateBeforeApproval(int hosIdx);
	//전체 병원 건수 cnt 조회
	int getTotCnt();
	//(동적처리 조건별)전체 병원 건수 cnt 조회
	int getAjaxTotCnt(HosApprovalVO vo);
	//병원승인 전체목록 + 페이징 처리
	List<HosApprovalVO> getHosListPage(HosApprovalVO vo
			, String beginDate, String endDate, String searchCondition
			, int begin, int end);
//	//병원승인 동적 검색 전체 목록 + 페이징
//	List<HospitalVO> getHosSearchPage(HospitalVO vo, int begin, int end);
}
