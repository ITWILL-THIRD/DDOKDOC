package com.todoc.view.reservation;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
	public String startReser(HospitalVO vo, Model model) {
		System.out.println(">> 예약페이지");

		//예약리스트 뽑기
		System.out.println("예약할 병원 : " + vo);
		ReservationVO reser = new ReservationVO();
		reser.setHosIdx(vo.getHosIdx());
		String reserDate = "2024-05-31";
		try {
            // DateTimeFormatter를 사용하여 문자열을 LocalDate로 변환
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            LocalDate date = LocalDate.parse(reserDate, formatter);

            // 변환된 날짜 출력
            System.out.println("Converted date: " + date);
        } catch (DateTimeParseException e) {
            System.out.println("Invalid date format: " + reserDate);
        }
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println(formatter);
		
		List<ReservationVO> reservationList = reservationService.getReservationList(reser);
		System.out.println("reservationList : " + reservationList);
		model.addAttribute("reservationList", reservationList);
		
		return "reservation/startReser";
	}

	
	//예약하기
	@PostMapping("/insertReservation.do")
	public String insertReser(ReservationVO vo, String selectTime, Model model) {
		System.out.println(">> 예약하기 예약 등록");
		System.out.println(vo);
		System.out.println(selectTime);
		
		//reservationService.insertReservaion(vo);
		
		
		//예약 등록 후 넘어가는 페이지로 이동시키기
		//경로에 int값들어갈수 없음. String으로 들어가거나 변수에 넣어서 들어가야함.
		
		return "redirect:/getHospital.do?hosIdx=1";
	}
	
}
