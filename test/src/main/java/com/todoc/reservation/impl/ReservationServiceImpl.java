package com.todoc.reservation.impl;

import java.util.List;

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

	

}
