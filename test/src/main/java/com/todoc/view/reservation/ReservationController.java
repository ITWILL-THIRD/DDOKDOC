package com.todoc.view.reservation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.hospital.HospitalVO;
import com.todoc.reservation.ReservationService;

@Controller
public class ReservationController {
	@Autowired
	private ReservationService reservationService;
	
	//예약진행
	@RequestMapping("/reservation.do")
	public String startReser(Model model) {
		System.out.println(">> 예약페이지");

		return "reservation/startReser";
	}
	
}
