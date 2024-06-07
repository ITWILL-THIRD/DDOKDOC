package com.todoc.view.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RequestMapping("/admin")
@Controller
public class AdminController {
	@Autowired
	HospitalService hospitalService;
	
	//임시 작성
	@RequestMapping("/admin.do")
	public String adminMain(HospitalVO vo) {
		return null;
	}
	
	@RequestMapping("/")
	//병원 정보 및 사업자등록증 승인 처리
	public String hosChk(HospitalVO vo) {
		return null;
	}
}
