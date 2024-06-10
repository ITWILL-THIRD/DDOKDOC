package com.todoc.view.hospital;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RestController
public class HospitalAjaxController {
	@Autowired
	private HospitalService hospitalService;

	public HospitalAjaxController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}

	//병원 동적 조회
	@RequestMapping(value = "hospital/getHosSearch.do", method = RequestMethod.GET, 
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<HospitalVO> getAjaxHosList(HospitalVO vo) {
		List<HospitalVO> hospitalList = hospitalService.getHosSearch(vo);
		return hospitalList;
	}
	
	//리뷰 동적 조회
	@RequestMapping(value = "hospital/getHosReview.do", method = RequestMethod.GET, 
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<HosReviewVO> getHosReview(int hosIdx) {
		System.out.println("==== HospitalSearchAjaxController.getHosReview() 실행");

		List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
		return reviewList;
	}
	
	//리뷰 동적 수정
//	@RequestMapping(value = "hospital/updateReview.do", method = RequestMethod.POST,
//			produces = "application/json; charset=utf-8")
//	@ResponseBody
//	public Map<String, String> updateReview(@RequestParam("userIdx") int userIdx, @RequestBody HosReviewVO vo) {
//	    System.out.println(":: 병원 리뷰 update");
//	    vo.setUserIdx(userIdx);
//	    System.out.println("vo : " + vo);
//	   
//	    hospitalService.updateReview(vo);
//	    System.out.println("update");
//	    
//	    Map<String, String> response = new HashMap<>();
//	    response.put("redirect", "/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx());
//	    return response;
//	}
}
