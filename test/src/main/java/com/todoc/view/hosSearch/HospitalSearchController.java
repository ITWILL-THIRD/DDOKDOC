package com.todoc.view.hosSearch;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.hosSearch.AllHospitalVO;
import com.todoc.hosSearch.HospitalService;

@Controller
public class HospitalSearchController {
	private HospitalService hospitalService;
	
	@Autowired
	public HospitalSearchController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}
	
	//@RequestMapping("/hosSearch.do")
	public String hosSearchMap(Model model,
							   @RequestParam(value = "searchCondition", defaultValue = "HOSNAME", required = false)
							   String category, 
							   @RequestParam(value = "keyword", defaultValue = "", required = false)
							   String keyword) {
		
		System.out.println("category : " + category + ", keyword : " + keyword);
		
		List<AllHospitalVO> hospitalList = hospitalService.getAllList(category, keyword);
		System.out.println("hospitalList : " + hospitalList);
		
		model.addAttribute("hospitalList", hospitalList);
		
		return "hospital/hosSearch.jsp";
	}
	
	
}
