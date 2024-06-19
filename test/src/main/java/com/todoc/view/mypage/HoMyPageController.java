package com.todoc.view.mypage;

import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;
import java.util.Map;
import java.sql.Time;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.ognl.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.todoc.hospital.HolidayInsertParams;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.hospital.dao.TimeMapper;
import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;
import com.todoc.user.UserVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;

import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

@RequestMapping("/mypage")
@Controller
public class HoMyPageController {
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private TimeMapper timeMapper;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private ReservationService reservationService;

	// 병원 마이페이지로 이동
	@RequestMapping("/hoMyPage.do")
	public String myPage() {
		return "mypage/hoMyPage";
	}

	// 병원정보수정페이지로 이동
	@GetMapping("/updateHoUser.do")
	public String updateHoUserView(@RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
	    System.out.println(">> 병원정보 수정페이지");
	    HospitalVO vo = hospitalService.selectOne(hosIdx);
	    session.setAttribute("hoUser", vo);
	    model.addAttribute("hoUser", vo);
	    return "mypage/updateHoUser";
	}

	// 병원정보 수정
	@PostMapping("/updateHoUser.do")
	public String updateHoUser(@ModelAttribute("hoUser") HospitalVO vo, HttpSession session, @RequestParam("hosIdx") int hosIdx,
	                           @RequestParam(value = "openTimeStr", required = false) String openTimeStr,
	                           @RequestParam(value = "closeTimeStr", required = false) String closeTimeStr,
	                           @RequestParam(value = "lunchTimeStr", required = false) String lunchTimeStr,
	                           @RequestParam(value = "endLunchTimeStr", required = false) String endLunchTimeStr,
	                           @RequestParam(value = "satOpenTimeStr", required = false) String satOpenTimeStr,
	                           @RequestParam(value = "satCloseTimeStr", required = false) String satCloseTimeStr,
	                           @RequestParam(value = "satLunchTimeStr", required = false) String satLunchTimeStr,
	                           @RequestParam(value = "satEndLunchTimeStr", required = false) String satEndLunchTimeStr,
	                           @RequestParam(value = "sunOpenTimeStr", required = false) String sunOpenTimeStr,
	                           @RequestParam(value = "sunCloseTimeStr", required = false) String sunCloseTimeStr,
	                           @RequestParam(value = "sunLunchTimeStr", required = false) String sunLunchTimeStr,
	                           @RequestParam(value = "sunEndLunchTimeStr", required = false) String sunEndLunchTimeStr,
	                           @RequestParam(value = "lunchOff", required = false) String lunchOff,
	                           @RequestParam(value = "satLunchOff", required = false) String satLunchOff,
	                           @RequestParam(value = "sunDayOff", required = false) String sunDayOff,
	                           @RequestParam(value = "sunLunchOff", required = false) String sunLunchOff) throws java.text.ParseException, ParseException {
	    HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
	    vo.setHosIdx(hoUser.getHosIdx());

	  
	 // null 체크 및 기본값 설정
	    if (closeTimeStr == null || closeTimeStr.equals("00:00")) {
	        closeTimeStr = "23:59";
	    }
	    if (satCloseTimeStr == null || satCloseTimeStr.equals("00:00")) {
	        satCloseTimeStr = "23:59";
	    }
	    if (sunCloseTimeStr.equals("00:00")) {
	        sunCloseTimeStr = "23:59";
	    }

	    openTimeStr = openTimeStr == null ? "00:00" : openTimeStr;
	    lunchTimeStr = lunchTimeStr == null ? "00:00" : lunchTimeStr;
	    endLunchTimeStr = endLunchTimeStr == null ? "00:00" : endLunchTimeStr;
	    satOpenTimeStr = satOpenTimeStr == null ? "00:00" : satOpenTimeStr;
	    satLunchTimeStr = satLunchTimeStr == null ? "00:00" : satLunchTimeStr;
	    satEndLunchTimeStr = satEndLunchTimeStr == null ? "00:00" : satEndLunchTimeStr;
	    sunOpenTimeStr = sunOpenTimeStr == null ? "00:00" : sunOpenTimeStr;
	    sunLunchTimeStr = sunLunchTimeStr == null ? "00:00" : sunLunchTimeStr;
	    sunEndLunchTimeStr = sunEndLunchTimeStr == null ? "00:00" : sunEndLunchTimeStr;

	  
	  		
	    // 시간 형식에서 ss(초) 문자열 추가
	    String fullOpenTimeStr = openTimeStr + ":00";
	    String fullCloseTimeStr = closeTimeStr + ":00";
	    String fullLunchTimeStr = lunchTimeStr + ":00";
	    String fullEndLunchTimeStr = endLunchTimeStr + ":00";
	    String fullSatOpenTimeStr = satOpenTimeStr + ":00";
	    String fullSatCloseTimeStr = satCloseTimeStr + ":00";
	    String fullSatLunchTimeStr = satLunchTimeStr + ":00";
	    String fullSatEndLunchTimeStr = satEndLunchTimeStr + ":00";
	    String fullSunOpenTimeStr = sunOpenTimeStr + ":00";
	    String fullSunCloseTimeStr =  sunCloseTimeStr + ":00";
	    String fullSunLunchTimeStr =  sunLunchTimeStr + ":00";
	    String fullSunEndLunchTimeStr = sunEndLunchTimeStr + ":00";

	    // 운영 시간에서 시각 0~23 유효성 검사 및 수정하는 메서드 호출
	    String validOpenTime = validateAndCorrectTime(fullOpenTimeStr);
	    String validCloseTime = validateAndCorrectTime(fullCloseTimeStr);
	    String validLunchTime = validateAndCorrectTime(fullLunchTimeStr);
	    String validEndLunchTime = validateAndCorrectTime(fullEndLunchTimeStr);
	    String validSatOpenTime = validateAndCorrectTime(fullSatOpenTimeStr);
	    String validSatCloseTime = validateAndCorrectTime(fullSatCloseTimeStr);
	    String validSatLunchTime = validateAndCorrectTime(fullSatLunchTimeStr);
	    String validSatEndLunchTime = validateAndCorrectTime(fullSatEndLunchTimeStr);
	    String validSunOpenTime = validateAndCorrectTime(fullSunOpenTimeStr);
	    String validSunCloseTime = validateAndCorrectTime(fullSunCloseTimeStr);
	    String validSunLunchTime = validateAndCorrectTime(fullSunLunchTimeStr);
	    String validSunEndLunchTime = validateAndCorrectTime(fullSunEndLunchTimeStr);

	    // 디버깅용 로그 추가
	    System.out.println("validOpenTime : " + validOpenTime);
	    System.out.println("validCloseTime : " + validCloseTime);
	    System.out.println("validLunchTime : " + validLunchTime);
	    System.out.println("validEndLunchTime : " + validEndLunchTime);
	    System.out.println("일요일마감 validSunCloseTime : " + validSunCloseTime);

	    // 문자열을 Time 객체로 변환
	    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
	    Time openTime = validOpenTime == null ? null : new Time(sdf.parse(validOpenTime).getTime());
	    Time closeTime = validCloseTime == null ? null : new Time(sdf.parse(validCloseTime).getTime());
	    Time lunchTime = validLunchTime == null ? null : new Time(sdf.parse(validLunchTime).getTime());
	    Time endLunchTime = validEndLunchTime == null ? null : new Time(sdf.parse(validEndLunchTime).getTime());
	    Time satOpenTime = validSatOpenTime == null ? null : new Time(sdf.parse(validSatOpenTime).getTime());
	    Time satCloseTime = validSatCloseTime == null ? null : new Time(sdf.parse(validSatCloseTime).getTime());
	    Time satLunchTime = validSatLunchTime == null ? null : new Time(sdf.parse(validSatLunchTime).getTime());
	    Time satEndLunchTime = validSatEndLunchTime == null ? null : new Time(sdf.parse(validSatEndLunchTime).getTime());
	    Time sunOpenTime = validSunOpenTime == null ? null : new Time(sdf.parse(validSunOpenTime).getTime());
	    Time sunCloseTime = validSunCloseTime == null ? null : new Time(sdf.parse(validSunCloseTime).getTime());
	    Time sunLunchTime = validSunLunchTime == null ? null : new Time(sdf.parse(validSunLunchTime).getTime());
	    Time sunEndLunchTime = validSunEndLunchTime == null ? null : new Time(sdf.parse(validSunEndLunchTime).getTime());

	    // Time 객체를 vo에 설정
	    vo.setOpenTime(openTime);
	    vo.setCloseTime(closeTime);
	    vo.setLunchTime(lunchTime);
	    vo.setEndLunchTime(endLunchTime);
	    vo.setSatOpenTime(satOpenTime);
	    vo.setSatCloseTime(satCloseTime);
	    vo.setSatLunchTime(satLunchTime);
	    vo.setSatEndLunchTime(satEndLunchTime);
	    vo.setSunOpenTime(sunOpenTime);
	    vo.setSunCloseTime(sunCloseTime);
	    vo.setSunLunchTime(sunLunchTime);
	    vo.setSunEndLunchTime(sunEndLunchTime);
	    System.out.println("병원정보 수정");
	    System.out.println("vo : " + vo);
	    hospitalService.updateHoUser(vo);
	    hospitalService.updateHosAddress(vo);
	    
	    timeMapper.updateHosTime(vo, hosIdx, validOpenTime, validCloseTime, validLunchTime, validEndLunchTime,
	                             validSatOpenTime, validSatCloseTime, validSatLunchTime, validSatEndLunchTime,
	                             validSunOpenTime, validSunCloseTime, validSunLunchTime, validSunEndLunchTime,
	                             lunchOff, satLunchOff, sunDayOff, sunLunchOff);

	    
	    System.out.println("vo.getTime : " + vo.getCloseTime());
	    System.out.println("수정 후 vo : " + vo);
	    session.setAttribute("hoUser", vo);
	    return "redirect:hoMyPage.do";
	}


	//유효성 검사 메소드(운영 시각 0~23만 사용 가능)
		private String validateAndCorrectTime(String timeStr) {
			String[] timeParts = timeStr.split(":");
	        int hour = Integer.parseInt(timeParts[0]);
	        int minute = Integer.parseInt(timeParts[1]);
	        int second = Integer.parseInt(timeParts[2]);

		// 시간 값이 0에서 23 사이인지 확인
		if (hour < 0 || hour > 23) {
			hour = hour % 24;
		}

		// 유효한 시간 값으로 반환
		return String.format("%02d:%02d:%02d", hour, minute, second);
	}

	// 병원비번 수정 페이지로 이동
	@RequestMapping("/updateHoPwd.do")
	public String updateHoPwdView() {
		return "mypage/updateHoPwd";
	}

	// 병원비번수정
	@PostMapping("/updateHoPwd.do")
	public String updateHoPwd(@RequestParam("hosIdx") int hosIdx,
			@RequestParam("currentPassword") String currentPassword, @RequestParam("hosPw") String newPassword,
			HttpSession session, Model model) {
		HospitalVO hoUser = hospitalService.selectOne(hosIdx);

		if (hoUser == null || !hoUser.getHosPw().equals(currentPassword)) {
			model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
			return "mypage/updateHoPwd";
		}

		hoUser.setHosPw(newPassword);
		hospitalService.updateHoPwd(hoUser);
		System.out.println("updateHoPwd : " + hoUser);
		session.setAttribute("hoUser", hoUser);

		return "redirect:updateHoUser.do?hosIdx=" + hosIdx;
	}


	//병원탈퇴
	@PostMapping("/deleteHos.do")
	public String deleteHos(@RequestParam("hosIdx") int hosIdx, HttpSession session) {
		hospitalService.deleteHos(hosIdx);
		session.invalidate();
		System.out.println(">> 병원탈퇴완료");
		return "redirect:/index.jsp?msg=deleteHos";
	}
	
	
	//병원 공지 리스트
	@RequestMapping("/hosNoticeList.do")
	public String hosNoticeList(Model model, HttpSession session) {
		// 병원 로그인 정보 가져오기
		HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
		// 공지사항 리스트 가져오기
		List<NoticeVO> hosNoticeList = noticeService.hosNoticeList(hoUser.getHosIdx());
		model.addAttribute("hosNoticeList", hosNoticeList);

		return "mypage/hosNoticeList";
	}
	//공지 상세
	@RequestMapping("/hoNoticeDetail.do")
	public String hoNoticeDetail(@ModelAttribute("noticeIdx") int noticeIdx, Model model) {
		NoticeVO notice = noticeService.getNotice(noticeIdx);
		System.out.println("notice : " + notice);
		model.addAttribute("notice", notice);
		
		return "mypage/hoNoticeDetail";
	}

	// 병원 휴무일 등록 페이지
	@RequestMapping("/insertHosHoliday.do")
	private String insertHosHolidayPage(Model model, HttpSession session) {
		// 기존 휴무일 넘기기
		// 휴무일 리스트
		HospitalVO vo = (HospitalVO) session.getAttribute("hoUser");

		List<Date> hosHolidayList = hospitalService.hosHoliday(vo);
		System.out.println("hosHolidayList : " + hosHolidayList);

		model.addAttribute("hosHolidayList", hosHolidayList);

		return "hospital/insertHosHoliday";
	}

	// 병원 휴무 DB 저장
	@PostMapping("/insertHosHoliday.do")
	private String insertHosHoliday(HolidayInsertParams param) {

		System.out.println("param : " + param);
		hospitalService.insertHolidays(param);

        return "redirect:/mypage/insertHosHoliday.do";
	}
	
	// 병원 리뷰 목록 조회
  	@RequestMapping("/hosReviewList.do")
  	public String hosReviewList(Model model, HttpSession session) {
 		System.out.println("::마이페이지-리뷰리스트");
 		HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
 		int hosIdx = 0;
 		if (hoUser != null) {
 		    hosIdx = hoUser.getHosIdx();
 		}
 		
 		model.addAttribute("hosIdx", hosIdx);
 		
	    // 병원 1개 조회
	    HospitalVO hospital = hospitalService.selectOne(hosIdx);
	    model.addAttribute("hospital", hospital);
		//작성된 리뷰 목록
		List<HosReviewVO> hosReviewList = hospitalService.getHosReviewList(hosIdx);
		model.addAttribute("hosReviewList", hosReviewList);

		return "mypage/hosReviewList";
	 }

	
	@PostMapping("/deleteHosHoliday.do")
	private String deleteHosHoliday(HolidayInsertParams param) {
		
		System.out.println("param : " + param);
		
		hospitalService.deleteHosHoliday(param);
		
		return "redirect:/mypage/insertHosHoliday.do";
	}

  	// 병원 예약 현황
  	@RequestMapping("/hosReserList.do")
  	public String hosReserList(Model model, HttpSession session) {
 		HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
 		int hosIdx = 0;
 		if (hoUser != null) {
 		    hosIdx = hoUser.getHosIdx();
 		}
 		
 		HospitalVO vo = new HospitalVO();
		vo.setHosIdx(hosIdx);
 		
 		model.addAttribute("hosIdx", hosIdx);
 		
		//병원 1개 조회
		HospitalVO hospital = hospitalService.selectOne(hosIdx);
		System.out.println("hospital : " + hospital);
		model.addAttribute("hospital", hospital);
 		
 		//병원 전체 예약 목록 
 		List<ReservationVO> hosResrList = reservationService.getHosReserList(hosIdx);
 		model.addAttribute("hosResrList", hosResrList);
 		System.out.println(hosResrList);
 		
 		//휴무일 리스트
		List<Date> hosHoliday = hospitalService.hosHoliday(vo);
		System.out.println("hosHoliday : " + hosHoliday);

		model.addAttribute("hosHoliday", hosHoliday);

 		return "mypage/hosReserList";
  	}

}
