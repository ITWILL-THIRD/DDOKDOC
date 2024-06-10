package com.todoc.view.hospital;

import java.util.List;

import javax.servlet.http.HttpSession;

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
		
		// 병원 오픈 시간, 마감 시간 데이터 포맷
		String formatOpenTime = hospital.getOpenTime().toString().substring(0, 5); // HH:mm 형식으로 변환
		String formatCloseTime = hospital.getCloseTime().toString().substring(0, 5); // HH:mm 형식으로 변환
		System.out.println(formatOpenTime);
		// 변환된 시간 값을 HospitalVO에 설정
		hospital.setFormatOpenTime(formatOpenTime);; // 예약 객체에 설정된 'hh:mm' 형식의 시간
		hospital.setFormatCloseTime(formatCloseTime);
		
		System.out.println(hospital);
		model.addAttribute("hospital", hospital);

		List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
		model.addAttribute("reviewList", reviewList);
		
		List<NoticeVO> noticeList = noticeService.getNoticeList(hosIdx);
		model.addAttribute("noticeList", noticeList);
		
		return "hospital/hosDetail";

	}
	
	// 리뷰 입력 + 별점 통계 업데이트
	@RequestMapping("/insertReview.do")
	public String insertReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model,  HttpSession session) {
		System.out.println(":: 병원 리뷰 작성");
		vo.setUserIdx(((UserVO) session.getAttribute("user")).getUserIdx());
		System.out.println("vo  : " + vo);
		
		model.addAttribute("hosIdx", hosIdx);
		
		hospitalService.insertReview(vo);
		
		//리뷰 별점 평균 업데이트
		
		String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		
		return add;
	}
	
	// 리뷰 수정 + 별점 통계 업데이트
	@RequestMapping("/updateReview.do")
	public String updateReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model,  HttpSession session) {
		System.out.println(":: 병원 리뷰 수정");
		vo.setUserIdx(((UserVO) session.getAttribute("user")).getUserIdx());
		System.out.println("vo  : " + vo);
		
		model.addAttribute("hosIdx", hosIdx);
		
		hospitalService.updateReview(vo);
		
		String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		
		return add;
	}
	
	// 리뷰 삭제
	@RequestMapping("/deleteReview.do")
	public String deleteReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model,  HttpSession session) {
		System.out.println(":: 병원 리뷰 삭제");
		vo.setUserIdx(((UserVO) session.getAttribute("user")).getUserIdx());
		System.out.println("vo  : " + vo);
		
		model.addAttribute("hosIdx", hosIdx);
		
		hospitalService.deleteReview(vo);
		
		String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		
		return add;
	}
	


}