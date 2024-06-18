package com.todoc.hospital.dao;

import java.sql.Date;
import java.util.List;

import com.todoc.hospital.HolidayInsertParams;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalVO;
import com.todoc.membership.HosMembershipVO;
import com.todoc.reservation.ReservationVO;
import com.todoc.hospital.HosImgVO;

public interface HospitalDAO {
	
	//---------민지------------------------------
	//병원 전체 목록 조회
	List<HospitalVO> selectList();
	//병원 1개 조회
	HospitalVO selectOne(int hosIdx);
	//-----------------------------------------
	//지수
	List<HospitalVO> getHosSearch(HospitalVO vo);
	List<HosReviewVO> getHosReview(int hosIdx);
	// 사용자 예약 내역 조회
	//int getReserList(ReservationVO vo);
	//병원 리뷰 입력,수정,삭제
	void insertReview(HosReviewVO vo);
	void updateReview(HosReviewVO vo);
	void deleteReview(HosReviewVO vo);
	//병원 별점 업데이트(입력,수정,삭제 시)
	void updateAvgScore(HospitalVO vo);
	//병원 리뷰 입력,삭제 시 
	// 사용자 상태가 진료 완료처리된 목록 조회
	List<ReservationVO> getFinishList(ReservationVO vo);
	// 사용자 상태 업데이트 
	void updateCondition(HosReviewVO vo);
	//(개인)마이페이지 - 작성한 리뷰 목록
	List<HosReviewVO> getReviewList(int userIdx);
	//(개인)마이페이지 - 작성할 리뷰 목록
	List<HosReviewVO> getReviewToWrite(int userIdx);
	//(병원)마이페이지 - 작성된 리뷰 목록
	List<HosReviewVO> getHosReviewList(int hosIdx);
	//------주은 -------------
	HospitalVO getHos(HospitalVO ho);
	HospitalVO hoFindId(HospitalVO vo);
	int hoFindPwd(HospitalVO vo);
	void hoUpdateExPwd(HospitalVO vo);
	void updateHoUser(HospitalVO vo);
	void updateHosAddress(HospitalVO vo);
	void updateHosTime(HospitalVO vo);
	void updateHoPwd(HospitalVO vo);
	void deleteHos(int hosIdx);

	//관리자 리뷰리스트
	List<HosReviewVO> myReviewList(int userIdx);
	//----------------------

	int hosId(HospitalVO ho) throws Exception;
	//---------민지------------------------------
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
	//--------자은------------------------------
	//병원 휴무일 리스트
	List<Date> hosHoliday(HospitalVO vo); 
	//병원 휴무 입력
	void insertHolidays(HolidayInsertParams param);
	
	//병원 휴무 삭제
	void deleteHosHoliday(HolidayInsertParams param);
	//병원 멤버십 상태 확인 및 변경
	void updateHosCondition(HospitalVO vo);
	HosMembershipVO getHosMembershipByIdx(int hosIdx);
}

