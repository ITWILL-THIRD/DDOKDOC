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
import org.springframework.http.ResponseEntity;
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

        HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
 		int hosIdx = 0;
 		if (hoUser != null) {
 		    hosIdx = hoUser.getHosIdx();
 		}
        
        HospitalVO hospital = hospitalService.selectOne(hosIdx);
        vo.setHosIdx(hosIdx);
        System.out.println(hospital);
        //해당 날짜에 대한 예약 내역
        //List<ReservationVO> reserList = reservationService.getDateReservationList(vo);
        List<ReservationVO> petReserList = reservationService.getDatePetReserList(vo);
        System.out.println("해당날짜 예약내역" + petReserList);
        Time openTime = hospital.getOpenTime();
        Time closeTime = hospital.getCloseTime();
        Time lunchTime = hospital.getLunchTime();
        Time endLunchTime = hospital.getEndLunchTime();
        //System.out.println(openTime + " " + closeTime + " " + lunchTime + " " + endLunchTime);
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
        for (ReservationVO reser : petReserList) {
            reservedTimes.add(sdf.format(reser.getReserTime()));
        }
        System.out.println("availableTimes : " + availableTimes);
        System.out.println("reservedTimes : " + reservedTimes);

        // 결과를 맵에 저장하여 반환
        Map<String, Object> response = new HashMap<>();
        response.put("availableTimes", availableTimes);
        response.put("reservedTimes", reservedTimes);
        response.put("petReserList", petReserList);
        
        return response;
    }
    
    //진료완료 처리
    @RequestMapping(value = "/updateComplete.do", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<Map<String, Object>> updateFinish(@RequestBody ReservationVO vo, HttpSession session) {
        System.out.println("updateFinish() 실행");
        int reserIdx = vo.getReserIdx();  // ReservationVO 객체에서 reserIdx 추출
        System.out.println("reserIdx : " + reserIdx);
        reservationService.updateComplete(reserIdx);

        System.out.println("updateComplete 완료");

        // 응답 데이터를 생성
        Map<String, Object> response = new HashMap<>();
        response.put("status", "success");
        response.put("message", "Reservation updated successfully");

        return ResponseEntity.ok(response);
    }

    // 분 단위로 시간을 더하는 메서드
    private Time addMinutes(Time time, int minutes) {
        long currentTimeMillis = time.getTime();
        long addedTimeMillis = currentTimeMillis + (minutes * 60 * 1000);
        return new Time(addedTimeMillis);
    }

}
