package com.todoc.view.admin.approval;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RequestMapping("/admin")
@Controller
public class ApprovalController {
	@Autowired
	HospitalService hospitalService;
	
	//병원 전체 조회
	@RequestMapping("/getApprovalList.do")
	public String approvalMain(Model model) {
		System.out.println(">> ApprovalController getHos 메소드 실행~~");
		List<HospitalVO> hosList = hospitalService.selectList();
		System.out.println("병원 목록 hosList : " + hosList);
		model.addAttribute("hosList", hosList);
		return "admin/getApprovalList";
	}
	
	//병원 정보 및 사업자등록증 승인 버튼 클릭
	@PostMapping("/approvalBtn.do")
	public String getHos(HospitalVO vo) {
		return null;
	}
}
