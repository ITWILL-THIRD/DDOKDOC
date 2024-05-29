package com.todoc.view.hosMain;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.todoc.hosMain.HospitalService;
import com.todoc.hosMain.JoinHospitalVO;

//@SessionAttributes : 같은 컨트롤러에서 모델객체 공유해서 사용하려는 경우에 사용
//데이터 사용후 SessionStatus 객체의 setComplete() 메소드 사용 해제
@SessionAttributes(value = {"hospital"})
@Controller
public class HospitalMainController {
	private HospitalService hospitalService;
	
	@Autowired
	public HospitalMainController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}
	
	@RequestMapping("hospital/hosMain.do")
	public String hosRevMain(JoinHospitalVO joinVo, Model model) {
		System.out.println(":: 병원 목록 전체보기");
		System.out.println("joinVo: " + joinVo);
		//DB 연동하여 selectList
		List<JoinHospitalVO> hosList = hospitalService.selectList();
		
		model.addAttribute("hosList", hosList);
		
		return "hospital/hosMain";
	}
	
	@RequestMapping("hospital/hosDetail.do")
	public String hosInfo(@ModelAttribute("hosIdx") int hosIdx, Model model) {
		System.out.println(":: 병원 정보(예약,리뷰)");
		
		JoinHospitalVO hospital = hospitalService.selectOne(hosIdx);
		System.out.println("hospital : " + hospital);
		
		model.addAttribute("hospital", hospital);
		
		return "hospital/hosDetail";
	}
	
}
