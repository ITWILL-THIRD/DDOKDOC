
package com.todoc.hospital.dao;

import java.util.List;

import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalVO;
import com.todoc.reservation.ReservationVO;

public interface HospitalDAO {

	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	//민지
	//병원 전체 목록 조회
	List<HospitalVO> selectList();
	
	HospitalVO selectOne(int hosIdx);
	//지수
	List<HospitalVO> getHosSearch(HospitalVO vo);
	List<HosReviewVO> getHosReview(int hosIdx);
	// 사용자 예약 내역 조회
	int getReserList(ReservationVO vo);
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
	//주은 
	HospitalVO getHos(HospitalVO ho);
	HospitalVO hoFindId(HospitalVO vo);
	int hoFindPwd(HospitalVO vo);
	void hoUpdateExPwd(HospitalVO vo);
	//민지
	//병원 정보 입력
	void insertHospital(HospitalVO vo);
	//병원 주소 입력
	void insertHosAddress(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
}

