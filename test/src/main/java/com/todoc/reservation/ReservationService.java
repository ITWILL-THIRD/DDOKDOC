package com.todoc.reservation;

import java.util.HashMap;
import java.util.List;

import com.todoc.hospital.HospitalVO;

public interface ReservationService {
	void insertReservaion(ReservationVO vo);
	void updateReservaion(ReservationVO vo);
	void deleteReservaion(ReservationVO vo);
	ReservationVO getReservation(ReservationVO vo);
	List<ReservationVO> getReservationList(ReservationVO vo);
	List<ReservationVO> getDateReservationList(ReservationVO vo);
}
