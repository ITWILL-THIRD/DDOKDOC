package com.todoc.view.reservation;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

@RequestMapping("reservation")
@RestController
public class ReservationAjaxController {
    @Autowired
    private HospitalService hospitalService;
    
    @Autowired
    private ReservationService reservationService;

    Time currentTime = null;
    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
    
    public ReservationAjaxController() {
        System.out.println("ReservationAjaxController 객체 생성");
    }

    @RequestMapping(value = "/getAvailableTimes.do", method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, List<String>> getAjaxTimeList(@RequestBody ReservationVO vo, String dayStr) {
        System.out.println("getAjaxTimeList() 실행");

        System.out.println("ajax ReservationVO : " + vo);
        System.out.println("ajax ReservationVO date : " + vo.getReserDate());
        int hosIdx = vo.getHosIdx();
        System.out.println("병원" + hosIdx + "운영시간");
        
        HospitalVO hospital = hospitalService.selectOne(hosIdx);

        //해당 날짜에 대한 예약 내역
        List<ReservationVO> reserList = reservationService.getDateReservationList(vo);
        System.out.println("해당날짜 예약내역" + reserList);
        
        Time openTime = null;
        Time closeTime = null;
        Time lunchTime = null;
        Time endLunchTime = null;
        
        List<String> availableTimes = new ArrayList<>();
        List<String> reservedTimes = new ArrayList<String>();
        
        //토요일
        if (vo.getDayStr().equals("6")) {
        	openTime = hospital.getSatOpenTime();
            closeTime = hospital.getSatCloseTime();
            lunchTime = hospital.getSatLunchTime();
            endLunchTime = hospital.getSatEndLunchTime();
            
            if (hospital.getSatLunchOff().equals("Y")) {
            	System.out.println("토요일 점심시간 없음");
            	availableTimes = noLunchtimeList(openTime, closeTime);
            } else {
            	System.out.println("토요일 점심시간 반영");
            	availableTimes = timeList(openTime, closeTime, lunchTime, endLunchTime);
            }
        //일요일
        }else if(vo.getDayStr().equals("0")) {
        	openTime = hospital.getSunOpenTime();
        	closeTime = hospital.getSunCloseTime();
        	lunchTime = hospital.getSunLunchTime();
        	endLunchTime = hospital.getSunEndLunchTime();
        	
        	if (hospital.getSunLunchOff().equals("Y")) {
            	System.out.println("일요일 점심시간 없음");
            	availableTimes = noLunchtimeList(openTime, closeTime);
            } else {
            	System.out.println("일요일 점심시간 반영");
            	availableTimes = timeList(openTime, closeTime, lunchTime, endLunchTime);
            }
        //평일
        } else {
        	openTime = hospital.getOpenTime();
        	closeTime = hospital.getCloseTime();
        	lunchTime = hospital.getLunchTime();
        	endLunchTime = hospital.getEndLunchTime();
        	
        	if (hospital.getLunchOff().equals("Y")) {
            	System.out.println("평일 점심시간 없음");
            	availableTimes = noLunchtimeList(openTime, closeTime);
            } else {
            	System.out.println("평일 점심시간 반영");
            	availableTimes = timeList(openTime, closeTime, lunchTime, endLunchTime);
            }
        }
        
        
        System.out.println(availableTimes);

        // 예약된 시간 목록 추가
        for (ReservationVO reser : reserList) {
            reservedTimes.add(sdf.format(reser.getReserTime()));
        }
        
       
        // 결과를 맵에 저장하여 반환
        Map<String, List<String>> response = new HashMap<>();
        response.put("availableTimes", availableTimes);
        response.put("reservedTimes", reservedTimes);
        
        return response;
    }

    //시간처리 메소드
    private List<String> timeList(Time openTime, Time closeTime, Time lunchTime, Time endLunchTime) {
    	List<String> availableTimes = new ArrayList<>();

        // 시간 계산 및 예약 가능한 시간 추가 로직
        currentTime = openTime;
        while (currentTime.before(closeTime)) {
            if (currentTime.compareTo(lunchTime) < 0 || currentTime.compareTo(endLunchTime) >= 0) {
                availableTimes.add(sdf.format(currentTime));
            }
            // 30분 간격 추가
            currentTime = addMinutes(currentTime, 30);
        }

       return availableTimes;
    }
    
    //점심시간 없을 때 시간처리 메소드
    private List<String> noLunchtimeList(Time openTime, Time closeTime) {
    	List<String> availableTimes = new ArrayList<>();

        // 시간 계산 및 예약 가능한 시간 추가 로직
        currentTime = openTime;
        while (currentTime.before(closeTime)) {
        	availableTimes.add(sdf.format(currentTime));
            // 30분 간격 추가
            currentTime = addMinutes(currentTime, 30);
        }

       return availableTimes;
    }
    
    // 분 단위로 시간을 더하는 메서드
    private Time addMinutes(Time time, int minutes) {
        long currentTimeMillis = time.getTime();
        long addedTimeMillis = currentTimeMillis + (minutes * 60 * 1000);
        return new Time(addedTimeMillis);
    }
}
