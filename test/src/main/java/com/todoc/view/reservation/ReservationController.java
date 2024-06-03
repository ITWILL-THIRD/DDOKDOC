package com.todoc.view.reservation;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.todoc.hospital.HospitalVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.user.UserVO;

@RequestMapping("/reservation")
@Controller
@SessionAttributes("hospital")
public class ReservationController {
	@Autowired
	private ReservationService reservationService;
	
	//예약날짜,시간 선택화면
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

	//예약조회
	@RequestMapping("/reservationDetail.do")
	public String getReservation(HttpSession session, Model model) {
		System.out.println(">> 예약 조회");
		
		int idx = (int) session.getAttribute("idx");
		System.out.println(idx);
		// 세션에서 예약 ID를 제거
        session.removeAttribute("idx");
		
		ReservationVO vo = new ReservationVO();
		vo.setReserIdx(idx);
		
		ReservationVO reservation = reservationService.getReservation(vo);
		System.out.println("reservation : " + reservation);
		
		model.addAttribute("reservation", reservation);
		
		return "reservation/reservationDetail";
	}
	
	//예약등록하기
	@PostMapping("/insertReservation.do")
	public String insertReser(@ModelAttribute("hospital") HospitalVO hospital, ReservationVO vo, String selectTime, Model model, HttpSession session) {
		System.out.println(">> 예약하기 예약 등록");
		System.out.println(vo);
		System.out.println(selectTime);

		//String 타입 selectTime을 형변환 해서 vo에 저장
		try {
	        LocalTime localTime = LocalTime.parse(selectTime);
	        Time sqlTime = Time.valueOf(localTime);
	        vo.setReserTime(sqlTime);
	        System.out.println(sqlTime);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		vo.setHosIdx(hospital.getHosIdx());
		UserVO user = (UserVO) session.getAttribute("user");
		vo.setUserIdx(user.getUserIdx());
		//vo.setPetIdx(//펫 정보 넣기);
		vo.setPetIdx(1);
		System.out.println(vo);
		
		reservationService.insertReservation(vo);
		int idx = vo.getReserIdx();
		
		System.out.println("idx : " + idx);
		System.out.println("작성완료");
		
		 // 예약 ID를 세션에 저장
        session.setAttribute("idx", idx);

        // 예약 등록 후 넘어가는 페이지로 이동시키기
        return "redirect:reservationDetail.do";
	}
	
}
