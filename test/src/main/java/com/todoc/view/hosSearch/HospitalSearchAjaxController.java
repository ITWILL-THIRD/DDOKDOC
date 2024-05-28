package com.todoc.view.hosSearch;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.hosSearch.AllHospitalVO;
import com.todoc.hosSearch.HospitalService;

@RestController
public class HospitalSearchAjaxController {
	private HospitalService hospitalService;
	
	@Autowired
	public HospitalSearchAjaxController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}
	
	@RequestMapping("/hosSearch.do")
	public List<AllHospitalVO> getAjaxHosList(
							   @RequestParam(value = "searchCondition", defaultValue = "HOSNAME", required = false)
							   String category, 
							   @RequestParam(value = "keyword", defaultValue = "", required = false)
							   String keyword) {
		System.out.println("==== HospitalSearchAjaxController.getAjaxHosList() 실행");
		System.out.println("category : " + category + ", keyword : " + keyword);
		
		List<AllHospitalVO> hospitalList = hospitalService.getAllList(category, keyword);
		
		return hospitalList;
	}
	
	
}
