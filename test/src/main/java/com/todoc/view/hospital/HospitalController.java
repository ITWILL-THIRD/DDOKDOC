package com.todoc.view.hospital;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;
import com.todoc.user.UserVO;

//@SessionAttributes : 같은 컨트롤러에서 모델객체 공유해서 사용하려는 경우에 사용
//데이터 사용후 SessionStatus 객체의 setComplete() 메소드 사용 해제
@SessionAttributes(value = { "hospital" })
@RequestMapping("/hospital")
@Controller
public class HospitalController {
	@Autowired
	private HospitalService hospitalService;
	@Autowired
	private NoticeService noticeService;
	//병원예약 페이지 onload되면 전체 목록 조회
	@RequestMapping("/hosMain.do")
	public String hosRevMain(HospitalVO vo, Model model) {
		System.out.println(":: 병원 목록 전체보기");
		System.out.println("vo: " + vo);
		//DB 연동하여 selectList
		List<HospitalVO> hosList = hospitalService.selectList();

		model.addAttribute("hosList", hosList);

		return "hospital/hosMain";
	}
	//1개 병원 상세 조회
	@RequestMapping("/hosDetail.do")
	public String hosInfo(@ModelAttribute("hosIdx") int hosIdx, Model model) {
		System.out.println(":: 병원 정보(예약,리뷰)");
		
		model.addAttribute("hosIdx", hosIdx);
		
		HospitalVO hospital = hospitalService.selectOne(hosIdx);
		model.addAttribute("hospital", hospital);

		List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
		model.addAttribute("reviewList", reviewList);
		
		List<NoticeVO> noticeList = noticeService.getNoticeList(hosIdx);
		model.addAttribute("noticeList", noticeList);
		
		return "hospital/hosDetail";

	}
	
	@RequestMapping("/insertReview.do")
	public String insertReview(@ModelAttribute("UserVO") UserVO userVo, HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model) {
		System.out.println(":: 병원 리뷰 작성");
		
		System.out.println("vo  : " + vo);
		
		model.addAttribute("hosIdx", hosIdx);
		
		hospitalService.insertReview(vo);
		
		//리뷰 별점 평균 업데이트
		
		String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		
		return add;
	}
	


}