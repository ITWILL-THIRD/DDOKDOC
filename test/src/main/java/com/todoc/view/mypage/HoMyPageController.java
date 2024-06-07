package com.todoc.view.mypage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.hospital.HospitalService;

@RequestMapping("/mypage")
@Controller
public class HoMyPageController {
	@Autowired
	private HospitalService hospitalService;
	
	@RequestMapping("/hoMyPage.do")
	 public String myPage() {
		return "mypage/hoMyPage";
	}

}
