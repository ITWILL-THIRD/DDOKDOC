package com.todoc.reservation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.reservation.dao.ReservationDAO;

@Service("reservationService")
public class ReservationServiceImpl implements ReservationService{
	@Autowired
	private ReservationDAO reservationDAO;
	
	public ReservationServiceImpl() {
		System.out.println(">> ReservationServiceImpl() 객체 생성");
	}
	
	@Override
	public void insertReservation(ReservationVO vo) {
		System.out.println(">> insertReservation 실행");
		reservationDAO.insertReservation(vo);
	}

	@Override
	public void updateReservation(ReservationVO vo) {
		reservationDAO.updateReservation(vo);
	}

	@Override
	public void deleteReservation(ReservationVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ReservationVO getReservation(ReservationVO vo) {
		return reservationDAO.getReservation(vo);
	}

	@Override
	public List<ReservationVO> getReservationList(ReservationVO vo) {
		return reservationDAO.getReservationList(vo);
	}

	@Override
	public List<ReservationVO> getDateReservationList(ReservationVO vo) {
		return reservationDAO.getDateReservationList(vo);
	}

	@Override
	public List<ReservationVO> myReserList(int useridx) {
		return reservationDAO.myReserList(useridx);
	}

	@Override
	public void cancleReservaion(int reserIdx) {
		reservationDAO.cancleReservaion(reserIdx);
	}

	@Override
	public List<ReservationVO> myOldReserList(int userIdx) {
		return reservationDAO.myOldReserList(userIdx);
	}

	@Override
	public List<ReservationVO> myCancleReserList(int userIdx) {
		return reservationDAO.myCancleReserList(userIdx);
	}
	
	//주은 ==================
	@Override
	public ReservationVO getReservation(int reserIdx) {
		return reservationDAO.getReservation(reserIdx);
	}
	
	@Override
	public List<ReservationVO> userReserList(ReservationVO vo, int userIdx, String condition, int begin, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("vo", vo);
		map.put("userIdx", userIdx);
		map.put("condition", condition);
		map.put("begin", begin);
	    map.put("end", end);
		
		return reservationDAO.userReserList(map);
	}
	@Override
	public int getResTotCnt(int userIdx) {
		return reservationDAO.getResTotCnt(userIdx);
	}
	@Override
	public int getResTotCntByCondition(int userIdx, String condition) {
		 Map<String, Object> params = new HashMap<>();
		 params.put("condition", condition);
		 params.put("userIdx", userIdx);
		return reservationDAO.getResTotCntByCondition(params);
	}
	//=====================

	@Override
	public List<ReservationVO> getHosReserList(int hosIdx) {
		return reservationDAO.getHosReserList(hosIdx);
	}

	@Override
	public List<ReservationVO> getDatePetReserList(ReservationVO vo) {
		return reservationDAO.getDatePetReserList(vo);
	}

	@Override
	public void updateComplete(int reserIdx) {
		reservationDAO.updateComplete(reserIdx);
	}
	
	

}