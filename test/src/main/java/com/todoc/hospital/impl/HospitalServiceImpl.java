package com.todoc.hospital.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.hospital.HosImgVO;
import com.todoc.hospital.dao.HospitalDAO;
import com.todoc.hospital.dao.TimeMapper;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService{
	@Autowired
	private HospitalDAO hospitalDAO;
	@Autowired
	private TimeMapper timeMapper;

	public HospitalServiceImpl() {
		System.out.println(">> HospitalServiceImpl() 객체 생성");
	}

	@Override
	public void updateHospital(HospitalVO vo) {
		// TODO Auto-generated method stub
	}
	//병원 전체 조회
	@Override
	public List<HospitalVO> selectList() {
		return hospitalDAO.selectList();
	}
	//병원 1개 조회
	@Override
	public HospitalVO selectOne(int hosIdx) {
		return hospitalDAO.selectOne(hosIdx);
	}
	//병원 동적 검색
	@Override
	public List<HospitalVO> getHosSearch(HospitalVO vo) {
		return hospitalDAO.getHosSearch(vo);
	}
	//병원 리뷰 조회
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
	//아이디 중복체크
	@Override
	public int hosId(HospitalVO ho) throws Exception {
		int cnt = hospitalDAO.hosId(ho);
		return cnt;
	}
	@Override
	public HospitalVO getHos(HospitalVO ho) {
		return hospitalDAO.getHos(ho);
	}
	//병원 아이디 찾기
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
	public int HosJoin(HospitalVO vo, 
			String openTimeStr, String closeTimeStr, String lunchTimeStr, String endLunchTimeStr,
			String satOpenTimeStr, String satCloseTimeStr, String satLunchTimeStr, String satEndLunchTimeStr,
			String sunOpenTimeStr, String sunCloseTimeStr, String sunLunchTimeStr, String sunEndLunchTimeStr,
			String lunchOff, String satLunchOff, String sunDayOff
			) {
		try {
			//병원 정보
			hospitalDAO.insertHospital(vo);
			//병원 파일(여러장)
			hospitalDAO.insertHosImg(vo);
			//병원 주소
			hospitalDAO.insertHosAddress(vo);
			//병원 시간
			timeMapper.insertTime(vo, openTimeStr, closeTimeStr, lunchTimeStr, endLunchTimeStr
					, satOpenTimeStr, satCloseTimeStr, satLunchTimeStr, satEndLunchTimeStr
					, sunOpenTimeStr, sunCloseTimeStr, sunLunchTimeStr, sunEndLunchTimeStr
					, lunchOff, satLunchOff, sunDayOff);
		} catch (Exception e) {
			// 에러 처리 로직
            throw new RuntimeException("데이터 삽입 중 에러 발생", e);
		}
		return 1;
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
}
