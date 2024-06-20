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

		List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
		return reviewList;
	}
	
}
