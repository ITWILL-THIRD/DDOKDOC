package com.todoc.hospital;

import java.sql.Date;
import java.util.HashMap;
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
	//병원 리뷰 조회
	List<HosReviewVO> getHosReview(int hosIdx);
	//병원 리뷰 입력,수정,삭제
	void insertReview(HosReviewVO vo);
	void updateReview(HosReviewVO vo);
	//주은
	HospitalVO getHos(HospitalVO ho);
	HospitalVO hoFindId(HospitalVO vo);
	int hoFindPwd(HospitalVO vo);
	void hoUpdateExPwd(HospitalVO vo);
	//기업(병원) 회원가입 시,
	//병원 정보 입력
	int insertHospital(HospitalVO vo);
	//병원 주소 입력
	int insertHosAddress(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
	
	//병원 휴무일 리스트
	List<Date> hosHoliday(HospitalVO vo);
	//병원 휴무 입력
	void insertHolidays(HolidayInsertParams param);
}
