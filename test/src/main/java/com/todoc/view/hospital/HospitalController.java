package com.todoc.view.hospital;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@SessionAttributes(value = {"hospital"})
@Controller
public class HospitalController {
	@Autowired
	private HospitalService hospitalService;
	
	//병원목록
	@RequestMapping("/getHospitalList.do")
	public String getHospitalList(HospitalVO vo, Model model) {
		System.out.println(">> 병원 목록");
		
		List<HospitalVO> hospitalList = hospitalService.getHospitalList(vo);
		
		model.addAttribute("hospitalList", hospitalList);
		
		return "hospital/getHospitalList";
	}

	//병원상세
	@RequestMapping("/getHospital.do")
	public String getHospital(HospitalVO vo, Model model) {
		System.out.println(">> 병원 상세");
		System.out.println(vo);
		
		HospitalVO hospital = hospitalService.getHospital(vo);
		System.out.println("hospital : " + hospital);
		
		model.addAttribute("hospital", hospital);
		
		return "hospital/getHospital";
	}
}
