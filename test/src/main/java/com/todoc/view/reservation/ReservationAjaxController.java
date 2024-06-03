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

@RestController
public class ReservationAjaxController {
    @Autowired
    private HospitalService hospitalService;
    
    @Autowired
    private ReservationService reservationService;

    public ReservationAjaxController() {
        System.out.println("ReservationAjaxController 객체 생성");
    }

    @RequestMapping(value = "/getAvailableTimes.do", method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Map<String, List<String>> getAjaxTimeList(@RequestBody ReservationVO vo) {
        System.out.println("getAjaxTimeList() 실행");

        System.out.println("ajax ReservationVO : " + vo);
        System.out.println("ajax ReservationVO date : " + vo.getReserDate());
        int hosIdx = vo.getHosIdx();
        
        HospitalVO idxHos = new HospitalVO();
        idxHos.setHosIdx(hosIdx);
        
        HospitalVO hospital = hospitalService.getHospital(idxHos);

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
            if (currentTime.compareTo(lunchTime) < 0 || currentTime.compareTo(endLunchTime) > 0) {
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
        Map<String, List<String>> response = new HashMap<>();
        response.put("availableTimes", availableTimes);
        response.put("reservedTimes", reservedTimes);
        
        return response;
    }

    // 분 단위로 시간을 더하는 메서드
    private Time addMinutes(Time time, int minutes) {
        long currentTimeMillis = time.getTime();
        long addedTimeMillis = currentTimeMillis + (minutes * 60 * 1000);
        return new Time(addedTimeMillis);
    }
}
