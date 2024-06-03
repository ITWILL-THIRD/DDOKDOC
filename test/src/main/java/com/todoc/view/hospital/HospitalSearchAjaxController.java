package com.todoc.view.hospital;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RestController
public class HospitalSearchAjaxController {
	@Autowired
	private HospitalService hospitalService;

	public HospitalSearchAjaxController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}

	@RequestMapping(value = "hospital/getHosSearch.do", method = RequestMethod.GET, 
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<HospitalVO> getAjaxHosList(HospitalVO vo) {
		System.out.println("==== HospitalSearchAjaxController.getAjaxHosList() 실행");
		System.out.println("(getAjaxHosList)vo : " + vo);

		List<HospitalVO> hospitalList = hospitalService.getHosSearch(vo);
		System.out.println(hospitalList);
		return hospitalList;
	}

}
