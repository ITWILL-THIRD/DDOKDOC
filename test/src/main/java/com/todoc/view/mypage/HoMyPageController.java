package com.todoc.view.mypage;

import javax.servlet.http.HttpSession;

import java.sql.Date;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.hospital.dao.TimeMapper;
import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;

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
	
	//병원 마이페이지로 이동
	@RequestMapping("/hoMyPage.do")
	 public String myPage() {
		return "mypage/hoMyPage";
	}
	//병원정보수정페이지로 이동
	@GetMapping("/updateHoUser.do")
	public String updateHoUserView(@RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
		System.out.println(">> 병원정보 수정페이지");
		HospitalVO vo = hospitalService.selectOne(hosIdx);
		session.setAttribute("hoUser", vo);
		model.addAttribute("hoUser", vo);
		return "mypage/updateHoUser";
	}
	//병원정보 수정
	@PostMapping("/updateHoUser.do")
	public String updateHoUser(@ModelAttribute("hoUser") HospitalVO vo, HttpSession session, @RequestParam("hosIdx") int hosIdx,
			@RequestParam("openTimeStr") String openTimeStr,
            @RequestParam("closeTimeStr") String closeTimeStr,
            @RequestParam("lunchTimeStr") String lunchTimeStr,
            @RequestParam("endLunchTimeStr") String endLunchTimeStr,
            @RequestParam("satOpenTimeStr") String satOpenTimeStr,
            @RequestParam("satCloseTimeStr") String satCloseTimeStr,
            @RequestParam("satLunchTimeStr") String satLunchTimeStr,
            @RequestParam("satEndLunchTimeStr") String satEndLunchTimeStr,
            @RequestParam("sunOpenTimeStr") String sunOpenTimeStr,
            @RequestParam("sunCloseTimeStr") String sunCloseTimeStr,
            @RequestParam("sunLunchTimeStr") String sunLunchTimeStr,
            @RequestParam("sunEndLunchTimeStr") String sunEndLunchTimeStr
			) {
		
		
		System.out.println("병원정보 수정");
		System.out.println("vo : " + vo);
		hospitalService.updateHoUser(vo);
		hospitalService.updateHosAddress(vo);
		
		
		//시간 형식에서 ss(초) 문자열 추가
		System.out.println("openTimeStr : " + openTimeStr);
		String fullOpenTimeStr = openTimeStr + ":00";
		String fullCloseTimeStr = closeTimeStr + ":00";
		String fullLunchTimeStr = lunchTimeStr + ":00";
		String fullEndLunchTimeStr = endLunchTimeStr + ":00";
		String fullSatOpenTimeStr = satOpenTimeStr + ":00";
		String fullSatCloseTimeStr = satCloseTimeStr + ":00";
		String fullSatLunchTimeStr = satLunchTimeStr + ":00";
		String fullsatEndLunchTimeStr = satEndLunchTimeStr + ":00";
		String fullSunOpenTimeStr = sunOpenTimeStr + ":00";
		String fullSunCloseTimeStr = sunCloseTimeStr + ":00";
		String fullSunLunchTimeStr = sunLunchTimeStr + ":00";
		String fullSunEndLunchTimeStr = sunEndLunchTimeStr + ":00";

		
		//운영 시간에서 시각 0~23 유효성 검사 및 수정하는 메서드 호출
		String validOpenTime = validateAndCorrectTime(fullOpenTimeStr);
		String validCloseTime = validateAndCorrectTime(fullCloseTimeStr);
		String validLunchTime = validateAndCorrectTime(fullLunchTimeStr);
		String validEndLunchTime = validateAndCorrectTime(fullEndLunchTimeStr);
		String validSatOpenTime = validateAndCorrectTime(fullSatOpenTimeStr);
		String validSatCloseTime = validateAndCorrectTime(fullSatCloseTimeStr);
		String validSatLunchTime = validateAndCorrectTime(fullSatLunchTimeStr);
		String validSatEndLunchTime = validateAndCorrectTime(fullsatEndLunchTimeStr);
		String validSunOpenTime = validateAndCorrectTime(fullSunOpenTimeStr);
		String validSunCloseTime = validateAndCorrectTime(fullSunCloseTimeStr);
		String validSunLunchTime = validateAndCorrectTime(fullSunLunchTimeStr);
		String validSunEndLunchTime = validateAndCorrectTime(fullSunEndLunchTimeStr);
		System.out.println("validOpenTime : " + validOpenTime);
		System.out.println("validCloseTime : " + validCloseTime);
		System.out.println("validLunchTime : " + validLunchTime);
		System.out.println("validEndLunchTime : " + validEndLunchTime);
		
		timeMapper.updateHosTime(vo, hosIdx, validOpenTime, validCloseTime, validLunchTime, validEndLunchTime
				, validSatOpenTime, validSatCloseTime, validSatLunchTime, validSatEndLunchTime
				, validSunOpenTime, validSunCloseTime, validSunLunchTime, validSunEndLunchTime);
		System.out.println("vo.getTime : " + vo.getCloseTime());
//		session.setAttribute("hoUser", vo);
		System.out.println("수정 후 vo : " + vo);
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

	
	
	
	//병원비번 수정 페이지로 이동
	@RequestMapping("/updateHoPwd.do")
	public String updateHoPwdView() {
		return "mypage/updateHoPwd";
	}
	
	//병원비번수정
	@PostMapping("/updateHoPwd.do")
	public String updateHoPwd(@RequestParam("hosIdx") int hosIdx,
			@RequestParam("currentPassword") String currentPassword,
			@RequestParam("hosPw") String newPassword,
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
	
	//병원 공지 리스트
	@RequestMapping("/hosNoticeList.do")
	public String hosNoticeList(Model model, HttpSession session) {
		//병원 로그인 정보 가져오기
		HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
		//공지사항 리스트 가져오기
		List<NoticeVO> hosNoticeList = noticeService.hosNoticeList(hoUser.getHosIdx());
		model.addAttribute("hosNoticeList", hosNoticeList);
		
		return "mypage/hosNoticeList";
	}
	
	
	//병원 휴무일 등록 페이지
	@RequestMapping("/insertHosHoliday.do")
	private String insertHosHolidayPage(Model model, HttpSession session) {
		//기존 휴무일 넘기기
		//휴무일 리스트
		HospitalVO vo = (HospitalVO) session.getAttribute("hoUser");
		
		List<Date> hosHolidayList = hospitalService.hosHoliday(vo);
		System.out.println("hosHolidayList : " + hosHolidayList);
		
		model.addAttribute("hosHolidayList", hosHolidayList);
		
		return "hospital/insertHosHoliday";
	}

	/*
	 * //병원 휴무 등록
	 * 
	 * @PostMapping("/insertHosHoliday.do") private String
	 * insertHosHoliday(@RequestParam("holidays") String holidaysJson, String
	 * hosIdx) {
	 * 
	 * ObjectMapper objectMapper = new ObjectMapper();
	 * 
	 * try { // JSON 문자열을 List<String>으로 변환 List<String> holidays =
	 * objectMapper.readValue(holidaysJson, new TypeReference<List<String>>() {});
	 * 
	 * // List<String>을 List<java.sql.Date>으로 변환 List<Date> holidayDates =
	 * holidays.stream() .map(LocalDate::parse) .map(java.sql.Date::valueOf)
	 * .collect(Collectors.toList());
	 * 
	 * // hospitalService를 통해 휴무일 날짜 DB에 저장 for (Date holiDate : holidayDates) {
	 * 
	 * HolidayInsertParams param = new HolidayInsertParams();
	 * param.setHosIdx(Integer.parseInt(hosIdx)); param.setHoliDate(holiDate);
	 * 
	 * hospitalService.insertHolidays(param); }
	 * 
	 * } catch (Exception e) { e.printStackTrace(); return "오류 발생"; }
	 * 
	 * return "redirect:insertHosHoliday.do"; }
	 */
	@PostMapping("/insertHosHoliday.do")
    public ResponseEntity<?> insertHosHoliday(@RequestBody Map<String, Object> params, HttpSession session) {
        ObjectMapper objectMapper = new ObjectMapper();

        try {
            // JSON 문자열을 List<String>으로 변환
            List<String> holidays = objectMapper.readValue((String) params.get("holidays"), new TypeReference<List<String>>() {});

            // List<String>을 List<java.sql.Date>으로 변환
            List<Date> holidayDates = holidays.stream()
                                               .map(LocalDate::parse)
                                               .map(java.sql.Date::valueOf)
                                               .collect(Collectors.toList());

            // hospitalService를 통해 휴무일 날짜 DB에 저장
            for (Date holiDate : holidayDates) {
                HolidayInsertParams param = new HolidayInsertParams();
                param.setHosIdx(Integer.parseInt((String) params.get("hosIdx")));
                param.setHoliDate(holiDate);

                hospitalService.insertHolidays(param);
            }
            
            // 저장된 모든 휴무일 목록을 가져오기
            List<Date> hosHolidayList = hospitalService.hosHoliday((HospitalVO)session.getAttribute("hoser"));
            List<String> formattedHolidayList = hosHolidayList.stream()
                                                              .map(date -> date.toString())
                                                              .collect(Collectors.toList());

            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("holidays", formattedHolidayList);

            return ResponseEntity.ok().body(Collections.singletonMap("success", true));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("success", false));
        }
    }
}
