package com.todoc.view.mypage;

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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.todoc.hospital.HolidayInsertParams;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

@RequestMapping("/mypage")
@Controller
public class HoMyPageController {
	@Autowired
	private HospitalService hospitalService;
	
	@RequestMapping("/hoMyPage.do")
	 public String myPage() {
		return "mypage/hoMyPage";
	}
	
	@GetMapping("/updateHoUser.do")
	public String updateHoUserView() {
		return "mypage/updateHoUser";
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
