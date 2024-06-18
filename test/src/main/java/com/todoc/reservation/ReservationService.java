package com.todoc.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.todoc.hospital.HospitalVO;

public interface ReservationService {
	void insertReservation(ReservationVO vo);
	void updateReservation(ReservationVO vo);
	void deleteReservation(ReservationVO vo);
	void cancleReservaion(int reserIdx);
	ReservationVO getReservation(ReservationVO vo);
	List<ReservationVO> getReservationList(ReservationVO vo);
	List<ReservationVO> getDateReservationList(ReservationVO vo);
	List<ReservationVO> myReserList(int useridx);
	List<ReservationVO> myOldReserList(int userIdx);
	List<ReservationVO> myCancleReserList(int userIdx);
	//주은 ==================
	ReservationVO getReservation(int reserIdx);
	List<ReservationVO> userReserList(Map<String, Object> params);
	//병원 예약 현황
	List<ReservationVO> getHosReserList(int hosIdx);
}
