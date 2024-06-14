package com.todoc.view.mypage;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;

@RequestMapping("mypage")
@RestController
public class HosMypageAjaxController {
    @Autowired
    private HospitalService hospitalService;
    
    @Autowired
    private ReservationService reservationService;

    public HosMypageAjaxController() {
        System.out.println("HosMypageAjaxController 객체 생성");
    }

    @RequestMapping(value = "/getReseredTimes.do", method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, Object> getAjaxTimeList(@RequestBody ReservationVO vo, HttpSession session) {
        System.out.println("getAjaxTimeList() 실행");

        System.out.println("reserajax ReservationVO : " + vo);
        System.out.println("reserajax ReservationVO date : " + vo.getReserDate());
        HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
 		int hosIdx = 0;
 		if (hoUser != null) {
 		    hosIdx = hoUser.getHosIdx();
 		}
        System.out.println("병원" + hosIdx + "운영시간");
        
        HospitalVO hospital = hospitalService.selectOne(hosIdx);
        vo.setHosIdx(hosIdx);
        
        //해당 날짜에 대한 예약 내역
        List<ReservationVO> reserList = reservationService.getDateReservationList(vo);
        System.out.println("해당날짜 예약내역" + reserList);
        
        Time openTime = hospital.getOpenTime();
        Time closeTime = hospital.getCloseTime();
        Time lunchTime = hospital.getLunchTime();
        Time endLunchTime = hospital.getEndLunchTime();

        List<String> availableTimes = new ArrayList<>();
        List<String> reservedTimes = new ArrayList<String>();

        // 시간 계산 및 예약 가능한 시간 추가 로직
        Time currentTime = openTime;
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
        while (currentTime.before(closeTime)) {
            if (currentTime.compareTo(lunchTime) < 0 || currentTime.compareTo(endLunchTime) >= 0) {
                availableTimes.add(sdf.format(currentTime));
            }
            // 30분 간격 추가
            currentTime = addMinutes(currentTime, 30);
        }

        // 예약된 시간 목록 추가
        for (ReservationVO reser : reserList) {
            reservedTimes.add(sdf.format(reser.getReserTime()));
        }
        
       
        // 결과를 맵에 저장하여 반환
        Map<String, Object> response = new HashMap<>();
        response.put("availableTimes", availableTimes);
        response.put("reservedTimes", reservedTimes);
        response.put("reserList", reserList);
        
        return response;
    }
//    @RequestMapping(value = "/getReseredTimes.do", method = RequestMethod.POST,
//            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//    public Map<String, List<String>> getAjaxReservedTimeList(@RequestBody ReservationVO vo, HttpSession session) {
//        System.out.println("getAjaxReservedTimeList() 실행");
//
//        System.out.println("reserajax ReservationVO : " + vo);
//        System.out.println("reserajax ReservationVO date : " + vo.getReserDate());
//        HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
//        int hosIdx = 0;
//        if (hoUser != null) {
//            hosIdx = hoUser.getHosIdx();
//        }
//        System.out.println("병원" + hosIdx + "운영시간");
//
//        // 해당 날짜에 대한 예약 내역 조회
//        vo.setHosIdx(hosIdx);
//        List<ReservationVO> reserList = reservationService.getDateReservationList(vo);
//        System.out.println("해당날짜 예약내역" + reserList);
//
//        // 예약된 시간 목록 추출
//        List<String> reservedTimes = new ArrayList<>();
//        for (ReservationVO reser : reserList) {
//            reservedTimes.add(new SimpleDateFormat("HH:mm").format(reser.getReserTime()));
//        }
//
//        // 결과를 맵에 저장하여 반환
//        Map<String, List<String>> response = new HashMap<>();
//        response.put("reservedTimes", reservedTimes);
//
//        return response;
//    }

    // 분 단위로 시간을 더하는 메서드
    private Time addMinutes(Time time, int minutes) {
        long currentTimeMillis = time.getTime();
        long addedTimeMillis = currentTimeMillis + (minutes * 60 * 1000);
        return new Time(addedTimeMillis);
    }
}
