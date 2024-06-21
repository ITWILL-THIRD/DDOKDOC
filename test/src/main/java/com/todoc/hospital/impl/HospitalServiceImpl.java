package com.todoc.hospital.impl;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.todoc.hospital.HosImgVO;
import com.todoc.hospital.HolidayInsertParams;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.hospital.dao.HospitalDAO;
import com.todoc.hospital.dao.TimeMapper;
import com.todoc.membership.HosMembershipVO;
import com.todoc.reservation.ReservationVO;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService{
	@Autowired
	private HospitalDAO hospitalDAO;

	@Autowired
	private TimeMapper timeMapper;
	
	public HospitalServiceImpl() {
		System.out.println(">> HospitalServiceImpl() 객체 생성");
	}

	//병원 전체 조회
	@Override
	public List<HospitalVO> selectList() {
		return hospitalDAO.selectList();
	}
	//결제완료 병원 cnt
	public int paymentCnt() {
		return hospitalDAO.paymentCnt();
	}
	//병원 전체 조회 + 페이징
	@Override
	public List<HospitalVO> selectListPage(HospitalVO vo, int begin, int end) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("begin", begin);
		map.put("end", end);
		System.out.println("map : " + map);
		return hospitalDAO.selectListPage(map);
	}
	//병원 1개 조회
	@Override
	public HospitalVO selectOne(int hosIdx) {
		return hospitalDAO.selectOne(hosIdx);
	}
	//동적처리 + 결제완료된 병원 건수 cnt
	@Override
	public int ajaxPaymentCnt(HospitalVO vo) {
		return hospitalDAO.ajaxPaymentCnt(vo);
	}
	//병원 동적 검색 + 페이징
	@Override
	public List<HospitalVO> getHosSearchPage(HospitalVO vo, int begin, int end) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("searchCondition", vo.getSearchCondition());
		map.put("searchKeyword", vo.getSearchKeyword());
		map.put("sido", vo.getSido());
		map.put("sigungu", vo.getSigungu());
		map.put("sigungu", vo.getSigungu());
		map.put("closeTime", vo.getCloseTime());
		map.put("openTime", vo.getOpenTime());
		map.put("begin", begin);
		map.put("end", end);
		System.out.println("map : " + map);
		return hospitalDAO.getHosSearchPage(map);
	}
	//병원 동적 검색
	@Override
	public List<HospitalVO> getHosSearch(HospitalVO vo) {
		return hospitalDAO.getHosSearch(vo);
	}

	//병원 리뷰 조회
	@Override
	public HospitalVO getHos(HospitalVO ho) {
		return hospitalDAO.getHos(ho);
	}
	
	//아이디 중복체크
	@Override
	public int hosId(HospitalVO ho) throws Exception {
		int cnt = hospitalDAO.hosId(ho);
		return cnt;
	}
	// 병원 아이디 찾기
	public HospitalVO hoFindId(HospitalVO vo) {
		return hospitalDAO.hoFindId(vo);
	}
	//병원 비번찾기
	public int hoFindPwd(HospitalVO vo) {
		return hospitalDAO.hoFindPwd(vo);
	}
	//병원 임시비번 업데이트
	public void hoUpdateExPwd(HospitalVO vo) {
		hospitalDAO.hoUpdateExPwd(vo);
	}
	//병원 정보 수정(이름, 연락처)
	public void updateHoUser(HospitalVO vo) {
		hospitalDAO.updateHoUser(vo);
	}
	//병원정보수정(주소)
	public void updateHosAddress(HospitalVO vo) {
		hospitalDAO.updateHosAddress(vo);
	}
	//병원정보수정(시간)
	public void updateHosTime(HospitalVO vo) {
		hospitalDAO.updateHosTime(vo);
	}
	//병원사진수정
	public void updateHosImg(HospitalVO vo) {
		hospitalDAO.updateHosImg(vo);
	}
	//병원 비번 변경
	public void updateHoPwd(HospitalVO vo) {
		hospitalDAO.updateHoPwd(vo);
	}
	//병원탈퇴
	public void deleteHos(int hosIdx) {
		hospitalDAO.deleteHos(hosIdx);
	}
	//사진조회
	public HosImgVO hosImg(int hosIdx) {
		return hospitalDAO.hosImg(hosIdx);
	}
	//병원 리뷰 전체 조회
	@Override
	public List<HosReviewVO> getHosReview(int hosIdx) {
		return hospitalDAO.getHosReview(hosIdx);
	}
	//병원 리뷰 입력
	@Override
	public void insertReview(HosReviewVO vo) {
		hospitalDAO.insertReview(vo);
	}
	//병원 리뷰 수정
	@Override
	public void updateReview(HosReviewVO vo) {
		hospitalDAO.updateReview(vo);
	}
	//사용자 예약 내역 조회
//	@Override
//	public int getReserList(ReservationVO vo) {
//		return hospitalDAO.getReserList(vo);
//	}
	//병원 별점 업데이트(입력,수정,삭제 시)
	@Override
	public void updateAvgScore(HospitalVO vo) {
		hospitalDAO.updateAvgScore(vo);
	}
	//병원 리뷰 입력,삭제 시 사용자 상태 업데이트 
	@Override
	public void updateCondition(HosReviewVO vo) {
		hospitalDAO.updateCondition(vo);
	}
	// 사용자 상태가 진료 완료처리된 목록 조회
	@Override
	public List<ReservationVO> getFinishList(ReservationVO vo) {
		return hospitalDAO.getFinishList(vo);
	}
	//병원 리뷰 삭제
	@Override
	public void deleteReview(HosReviewVO vo) {
		hospitalDAO.deleteReview(vo);
	}
	//(개인)마이페이지 - 작성한 리뷰 목록
	@Override
	public List<HosReviewVO> getReviewList(int userIdx) {
		return hospitalDAO.getReviewList(userIdx);
	}
	//(개인)마이페이지 - 작성할 리뷰 목록
	@Override
	public List<HosReviewVO> getReviewToWrite(int userIdx) {
		return hospitalDAO.getReviewToWrite(userIdx);
	}
	//(병원)마이페이지 - 작성된 리뷰 목록
	@Override
	public List<HosReviewVO> getHosReviewList(int hosIdx) {
		return hospitalDAO.getHosReviewList(hosIdx);
	}
	
	//병원 휴무 리스트
	@Override
	public List<Date> hosHoliday(HospitalVO vo) {
		return hospitalDAO.hosHoliday(vo);
	}

	//병원 휴무 입력
	@Override
	public void insertHolidays(HolidayInsertParams param) {
		hospitalDAO.insertHolidays(param);
	}
	//병원 휴무 삭제
	@Override
	public void deleteHosHoliday(HolidayInsertParams param) {
		hospitalDAO.deleteHosHoliday(param);
	}


	//병원 hosIdx 조회
	@Override
	public int getHosIdx(HospitalVO vo) {
		int cnt = hospitalDAO.getHosIdx(vo);
		return cnt;
	}
	//병원 사진vo 조회
	@Override
	public List<HosImgVO> getHosImgList(int hosIdx) {
		return hospitalDAO.getHosImgList(hosIdx);
	}
	//병원 회원가입 - 트랜잭션 처리
	@Transactional
	public void HosJoin(HospitalVO vo, 
			String openTimeStr, String closeTimeStr, String lunchTimeStr, String endLunchTimeStr,
			String satOpenTimeStr, String satCloseTimeStr, String satLunchTimeStr, String satEndLunchTimeStr,
			String sunOpenTimeStr, String sunCloseTimeStr, String sunLunchTimeStr, String sunEndLunchTimeStr,
			String lunchOff, String satLunchOff, String sunDayOff, String sunLunchOff
			) {
		try {
			//병원 정보
			hospitalDAO.insertHospital(vo);
			//병원 파일(여러장)
			hospitalDAO.insertHosImg(vo);
			//병원 주소
			hospitalDAO.insertHosAddress(vo);
			//병원 시간
			timeMapper.insertTime(vo.getHosIdx(), openTimeStr, closeTimeStr, lunchTimeStr, endLunchTimeStr
					, satOpenTimeStr, satCloseTimeStr, satLunchTimeStr, satEndLunchTimeStr
					, sunOpenTimeStr, sunCloseTimeStr, sunLunchTimeStr, sunEndLunchTimeStr
					, lunchOff, satLunchOff, sunDayOff, sunLunchOff);
		} catch (Exception e) {
			// 에러 처리 로직
            throw new RuntimeException("데이터 삽입 중 에러 발생", e);
		}
	}
	//병원 정보 입력
	@Override
	public int insertHospital(HospitalVO vo) {
		int cnt = hospitalDAO.insertHospital(vo);
		return cnt;
	}
	//병원 파일 여러장 입력
	@Override
	public int insertHosImg(HospitalVO vo) {
		int cnt = hospitalDAO.insertHosImg(vo);
		return cnt;
	}
	//병원 주소 입력
	@Override
	public int insertHosAddress(HospitalVO vo) {
		int cnt = hospitalDAO.insertHosAddress(vo);
		return cnt;
	}
	//관리자 리뷰리스트 - 주은
	@Override
	public List<HosReviewVO> myReviewList(int userIdx) {
		return hospitalDAO.myReviewList(userIdx);
	}
	//병원 멤버십 상태 확인 및 변경
	@Override
	public void updateHosCondition(HospitalVO vo) {
		hospitalDAO.updateHosCondition(vo);
	}

	@Override
	public HosMembershipVO getHosMembershipByIdx(int hosIdx) {
		return hospitalDAO.getHosMembershipByIdx(hosIdx);
	}
}