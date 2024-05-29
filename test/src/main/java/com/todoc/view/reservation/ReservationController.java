package com.todoc.view.reservation;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.hospital.HospitalVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;

@Controller
public class ReservationController {
	@Autowired
	private ReservationService reservationService;
	
	//예약진행
	@RequestMapping("/reservation.do")
	public String startReser(Model model) {
		System.out.println(">> 예약페이지");

		//병원 정보 넘기기
		
		return "reservation/startReser";
	}
	
	//예약하기
	@RequestMapping("/insertReservation.do")
	public String insertReser(@RequestParam("dateStr") String dateStr, Model model) {
		System.out.println(">> 예약 등록");
		System.out.println(dateStr);
		
		//reservationService.insertReservaion(vo);
		
		
		//예약 등록 후 넘어가는 페이지로 이동시키기
		return "hospital/getHospital";
	}
	
}
