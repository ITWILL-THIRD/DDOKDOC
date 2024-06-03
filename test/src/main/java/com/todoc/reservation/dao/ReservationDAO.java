package com.todoc.reservation.dao;

import java.util.List;

import com.todoc.hospital.HospitalVO;
import com.todoc.reservation.ReservationVO;

public interface ReservationDAO {
	void insertReservation(ReservationVO vo);
	void updateReservation(ReservationVO vo);
	void deleteReservation(ReservationVO vo);
	ReservationVO getReservation(ReservationVO vo);
	List<ReservationVO> getReservationList(ReservationVO vo);
	List<ReservationVO> getDateReservationList(ReservationVO vo);
}
