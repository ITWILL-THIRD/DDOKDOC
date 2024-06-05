package com.todoc.hospital.dao;

import java.util.List;

import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalVO;

public interface HospitalDAO {
	
	List<HospitalVO> selectList();
	HospitalVO selectOne(int hosIdx);
	List<HospitalVO> getHosSearch(HospitalVO vo);
	
	List<HosReviewVO> getHosReview(int hosIdx);
	void insertReview(HosReviewVO vo);
	void updateReview(HosReviewVO vo);
	//void deleteReview(HosReviewVO vo);
}