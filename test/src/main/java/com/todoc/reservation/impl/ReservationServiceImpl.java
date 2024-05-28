package com.todoc.reservation.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.reservation.dao.ReservationDAO;

@Service("reservaionService")
public class ReservationServiceImpl implements ReservationService{
	@Autowired
	private ReservationDAO reservationDAO;
	
	public ReservationServiceImpl() {
		System.out.println(">> ReservationServiceImpl() 객체 생성");
	}
	
	@Override
	public void insertReservaion(ReservationVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateReservaion(ReservationVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReservaion(ReservationVO vo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ReservationVO getReservation(ReservationVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ReservationVO> getReservationlList(ReservationVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

}
