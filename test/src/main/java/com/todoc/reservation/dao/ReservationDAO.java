package com.todoc.reservation.dao;

import java.util.List;

import com.todoc.reservation.ReservationVO;

public interface ReservationDAO {
	void insertReservaion(ReservationVO vo);
	void updateReservaion(ReservationVO vo);
	void deleteReservaion(ReservationVO vo);
	ReservationVO getReservation(ReservationVO vo);
	List<ReservationVO> getReservationlList(ReservationVO vo);
}
