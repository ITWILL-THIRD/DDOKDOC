package com.todoc.view.admin.hosapproval;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RequestMapping("/admin")
@Controller
public class HosApprovalController {
	@Autowired
	HospitalService hospitalService;
	
	//병원 전체 조회
	@RequestMapping("/getHosApprovalList.do")
	public String approvalMain(Model model) {
		System.out.println(">> HosHosApprovalController getHos 메소드 실행~~");
		List<HospitalVO> hosList = hospitalService.selectList();
		System.out.println("병원 목록 hosList : " + hosList);
		model.addAttribute("hosList", hosList);
		return "admin/getHosApprovalList";
	}
	
	//병원 정보 및 사업자등록증 승인 버튼 클릭
	@RequestMapping("/approvalBtn.do")
	public String approvalClick(@ModelAttribute("hosIdx") int hosIdx, HospitalVO vo, Model model) {
		System.out.println(">> approvalClick() 메소드 실행~~");
		System.out.println("hosIdx : " + hosIdx);
		
		int clickCnt = hospitalService.updateHospital(vo);
		System.out.println("clickCnt 승인 수락 : " + clickCnt);
		System.out.println("vo.getCondition() : " + vo.getCondition());
		
		if (clickCnt == 1) {
			System.out.println("승인 수락 완료!!");
			model.addAttribute("condition", vo.getCondition());
			return "admin/approvalPro";
		} else {
			System.out.println("승인 수락 실패!!");
			model.addAttribute("approvalFail", "승인 수락을 실패했습니다.");
			return "admin/getHosApprovalList";
		}
	}
}
