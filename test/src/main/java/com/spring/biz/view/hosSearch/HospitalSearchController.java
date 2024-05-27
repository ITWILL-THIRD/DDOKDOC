package com.spring.biz.view.hosSearch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.biz.hosSearch.AllHospitalVO;
import com.spring.biz.hosSearch.HospitalService;

@Controller
public class HospitalSearchController {
	private HospitalService hospitalService;
	
	@Autowired
	public HospitalSearchController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}
	
	@RequestMapping("/hosSearch.do")
	public String hosSearchMap(String category, String keyword, Model model) {
		System.out.println("=====> Map hosSearchMap() 실행~~");
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("category", category);
		conditionMap.put("keyword", keyword);
		System.out.println("category : " + category + ", keyword : " + keyword);
		
		List<AllHospitalVO> hospitalList = hospitalService.getAllList(category, keyword);
		
		model.addAttribute("hospitalList", hospitalList);
		
		return "hospital/hosSearch";
	}
	
	
}
