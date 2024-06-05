package com.todoc.hospital;

import java.util.List;


public interface HospitalService {

	//병원 전체 조회
	List<HospitalVO> selectList();
	
	//병원 1개 조회
	HospitalVO selectOne(int hosIdx);
	
	//병원 동적 검색
	List<HospitalVO> getHosSearch(HospitalVO vo);
	
	//병원 리뷰 조회
	List<HosReviewVO> getHosReview(int hosIdx);
	
	//병원 리뷰 입력,수정,삭제
	void insertReview(HosReviewVO vo);
	void updateReview(HosReviewVO vo);

	//병원 정보 수정
	
	
	//병원 측, 예약 내역 조회
}
