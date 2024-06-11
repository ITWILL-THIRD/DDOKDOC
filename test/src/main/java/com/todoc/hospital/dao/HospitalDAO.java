package com.todoc.hospital.dao;

import java.sql.Date;
import java.util.List;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalVO;
import com.todoc.hospital.HosImgVO;

public interface HospitalDAO {

	void updateHospital(HospitalVO vo);
	//민지
	//병원 전체 목록 조회
	List<HospitalVO> selectList();
	
	HospitalVO selectOne(int hosIdx);
	//지수
	List<HospitalVO> getHosSearch(HospitalVO vo);
	List<HosReviewVO> getHosReview(int hosIdx);
	void insertReview(HosReviewVO vo);
	void updateReview(HosReviewVO vo);
	//void deleteReview(HosReviewVO vo);
	//주은 
	HospitalVO getHos(HospitalVO ho);
	HospitalVO hoFindId(HospitalVO vo);
	int hoFindPwd(HospitalVO vo);
	void hoUpdateExPwd(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
	//민지
	//병원 hosIdx 조회
	int getHosIdx(HospitalVO vo);
	//병원 사진vo 조회
	List<HosImgVO> getHosImgList(int hosIdx);
	//병원 정보 입력
	int insertHospital(HospitalVO vo);
	//병원 파일 여러장 입력
	int insertHosImg(HospitalVO vo);
	//병원 주소 입력
	int insertHosAddress(HospitalVO vo);

	//병원 휴무일 리스트
	List<Date> hosHoliday(HospitalVO vo); 

}

