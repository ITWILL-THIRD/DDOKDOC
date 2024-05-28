package com.todoc.view.hosMain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.hosMain.HospitalService;

@RestController
public class HospitalSearchAjaxController {
	@Autowired
	private HospitalService hospitalService;
	
	public HospitalSearchAjaxController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}
	
//	@RequestMapping(value = "/getHosSearch.do", method = RequestMethod.POST
//				  , produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public List<AllHospitalVO> getAjaxHosList(
//							   @RequestParam(defaultValue = "선택", required = false)
//							   String searchCondition, 
//							   @RequestParam(defaultValue = "", required = false)
//							   String searchKeyword) {
//		System.out.println("==== HospitalSearchAjaxController.getAjaxHosList() 실행");
//		System.out.println("searchCondition : " + searchCondition + ", searchKeyword : " + searchKeyword);
//		
//		List<AllHospitalVO> hospitalList = hospitalService.getHosList(searchCondition, searchKeyword);
//		
//		return hospitalList;
//	}
	
	
}
