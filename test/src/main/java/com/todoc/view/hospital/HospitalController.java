package com.todoc.view.hospital;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;

//@SessionAttributes : 같은 컨트롤러에서 모델객체 공유해서 사용하려는 경우에 사용
//데이터 사용후 SessionStatus 객체의 setComplete() 메소드 사용 해제
@SessionAttributes(value = { "hospital" })
@Controller
public class HospitalController {
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private NoticeService noticeService;
	
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

	@RequestMapping("/hosMain.do")
	public String hosRevMain(HospitalVO vo, Model model) {
		System.out.println(":: 병원 목록 전체보기");
		System.out.println("vo: " + vo);
		//DB 연동하여 selectList
		List<HospitalVO> hosList = hospitalService.selectList();

		model.addAttribute("hosList", hosList);

		return "hospital/hosMain";
	}

	@RequestMapping("/hosDetail.do")
	public String hosInfo(@ModelAttribute("hosIdx") int hosIdx, Model model) {
		System.out.println(":: 병원 정보(예약,리뷰)");
		
		HospitalVO hospital = hospitalService.selectOne(hosIdx);
		model.addAttribute("hospital", hospital);

		List<NoticeVO> noticeList = noticeService.getNoticeList(hosIdx);
		model.addAttribute("noticeList", noticeList);
		
		return "hospital/hosDetail";

	}

}
