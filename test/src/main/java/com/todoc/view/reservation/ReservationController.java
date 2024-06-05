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

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@RequestMapping("/reservation")
@Controller
@SessionAttributes("hospital")
public class ReservationController {
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private MyPetService myPetService;
	@Autowired
	private HospitalService hospitalService;
	
	//예약날짜,시간 선택화면
	@RequestMapping("/reservation.do")
	public String startReser(HospitalVO vo, Model model, HttpSession session) {
		System.out.println(">> 예약페이지");

		//로그인 user정보 가져오기
		UserVO user = (UserVO) session.getAttribute("user");
		int userIdx = user.getUserIdx();
		
		//마이펫 리스트 가져오기
		List<MyPetVO> myPetList = myPetService.getMyPetList(userIdx);
		System.out.println("myPetList : " + myPetList);
		
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
		model.addAttribute("myPetList", myPetList);
		
		return "reservation/startReser";
	}

	//예약조회
	@RequestMapping("/reservationDetail.do")
	public String getReservation(HttpSession session, Model model, @RequestParam String reserIdx) {
		System.out.println(">> 예약 조회");
		
		int idx = Integer.parseInt(reserIdx);
		System.out.println(idx);
		
		ReservationVO vo = new ReservationVO();
		vo.setReserIdx(idx);
		
		ReservationVO reservation = reservationService.getReservation(vo);
		System.out.println("reservation : " + reservation);
		
		// 예약에서 병원인덱스가져와서 병원vo
		HospitalVO hospital = hospitalService.selectOne(reservation.getHosIdx());
		System.out.println("hospital : " + hospital);
		
		// 예약에서 마이펫 인덱스 가져와서 마이펫vo
		MyPetVO myPet = myPetService.getMyPet(reservation.getPetIdx());
		System.out.println("myPet : " + myPet);
		
		// 세션에서 유저 가져오기
		UserVO user = (UserVO) session.getAttribute("user");
		
		model.addAttribute("reservation", reservation);
		model.addAttribute("hospital", hospital);
		model.addAttribute("myPet", myPet);
		model.addAttribute("user", user);
		
		return "reservation/reservationDetail";
	}
	
	//예약등록하기
	@PostMapping("/insertReservation.do")
	public String insertReser(@ModelAttribute("hospital") HospitalVO hospital, ReservationVO vo, String petIdxStr, String selectTime, Model model, HttpSession session) {
		System.out.println(">> 예약하기 예약 등록");
		System.out.println(vo);
		System.out.println(selectTime);
		System.out.println("petIdxStr : " + petIdxStr);

		//String 타입 selectTime을 형변환 해서 vo에 저장
		try {
	        LocalTime localTime = LocalTime.parse(selectTime);
	        // 분 단위까지만 저장
	        LocalTime minutePrecisionTime = localTime.withSecond(0).withNano(0);
	        Time sqlTime = Time.valueOf(minutePrecisionTime);
	        vo.setReserTime(sqlTime);
	        System.out.println(sqlTime);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
		
		UserVO user = (UserVO) session.getAttribute("user");
		int petIdx = Integer.parseInt(petIdxStr);
		vo.setHosIdx(hospital.getHosIdx());
		vo.setUserIdx(user.getUserIdx());
		vo.setPetIdx(petIdx);
		System.out.println(vo);
		
		reservationService.insertReservation(vo);
		int idx = vo.getReserIdx();
		
		System.out.println("idx : " + idx);
		System.out.println("작성완료");
		
        // 예약 등록 후 넘어가는 페이지로 이동시키기
        return "redirect:reservationDetail.do?reserIdx=" + idx;
	}
	
	//예약 취소
	@RequestMapping("/cancleReservation.do")
	public String cancleReservaion(@RequestParam("reserIdx") String reserIdx) {
		
		//System.out.println("reserIdx : " + reserIdx);
		int idx = Integer.parseInt(reserIdx);
		
		reservationService.cancleReservaion(idx);
		
		return "redirect:/myReserList.do";
	}
	
	//예약 변경 화면 띄우기
	@RequestMapping("/updateReservation.do")
	public String updateReservation(@RequestParam("reserIdx") String reserIdx, Model model) {
		System.out.println("reserIdx : " + reserIdx);
		
		ReservationVO vo = new ReservationVO();
		vo.setReserIdx(Integer.parseInt(reserIdx));
		
		ReservationVO reservationVO = reservationService.getReservation(vo);
		
		// 가져온 ReservationVO 객체에서 RESERTIME 값을 가져와서 'hh:mm' 형식으로 변환
		String formattedTime = reservationVO.getReserTime().toString().substring(0, 5); // HH:mm 형식으로 변환

		// 변환된 시간 값을 ReservationVO에 설정
		reservationVO.setFormattedTime(formattedTime); // 예약 객체에 설정된 'hh:mm' 형식의 시간
		
		System.out.println(reservationVO);
		
		List<MyPetVO> myPetList = myPetService.getMyPetList(reservationVO.getUserIdx());
		
		model.addAttribute("reservationVO", reservationVO);
		model.addAttribute("myPetList", myPetList);
		
		return "reservation/updateReservation";
	}
	
	//예약 변경하기
	@PostMapping("/updateReservation.do")
	public String updateReservation(@RequestParam("reserIdx") String reserIdx, ReservationVO reservation, String selectTime) {
		
		System.out.println("reserIdx : " + reserIdx);
		System.out.println("selectTime : " + selectTime);
		
		System.out.println(reservation);
		
		return "reservationDetail.do";
	}
}
