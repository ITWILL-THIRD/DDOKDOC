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
import com.todoc.reservation.ReservationVO;
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
	public String hosInfo(@ModelAttribute("hosIdx") int hosIdx, Model model, HttpSession session) {
		System.out.println(":: 병원 정보(예약,리뷰)");
		
		int userIdx = ((UserVO) session.getAttribute("user")).getUserIdx();
				
		ReservationVO reserVo = new ReservationVO();
		reserVo.setUserIdx(userIdx);
		reserVo.setHosIdx(hosIdx);
		
		model.addAttribute("hosIdx", hosIdx);
		
		// 병원 1개 조회
		HospitalVO hospital = hospitalService.selectOne(hosIdx);
		model.addAttribute("hospital", hospital);

		// 사용자 예약 내역 조회
		int reservCnt = hospitalService.getReserList(reserVo);
		model.addAttribute("reservCnt", reservCnt);
		
		// 리뷰 전체 조회
		List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
		model.addAttribute("reviewList", reviewList);
		
		// 공지사항 전체 조회
		List<NoticeVO> noticeList = noticeService.getNoticeList(hosIdx);
		model.addAttribute("noticeList", noticeList);
		
		return "hospital/hosDetail";
	}
	
	// 리뷰 입력 + 별점 통계 업데이트
	@RequestMapping("/insertReview.do")
	public String insertReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
	    System.out.println(":: 병원 리뷰 작성");
	    vo.setUserIdx(((UserVO) session.getAttribute("user")).getUserIdx());
	    System.out.println("vo  : " + vo);
	    
	    model.addAttribute("hosIdx", hosIdx);
	    
	    // 리뷰를 데이터베이스에 삽입
	    hospitalService.insertReview(vo);    

	    // 별점 평균 업데이트
	    updateAverageScore(hosIdx);
	    
	    String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
	    
	    return add;
	}

	
	@RequestMapping("/updateReview.do")
	public String updateReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
	    System.out.println(":: 병원 리뷰 수정");
	    vo.setUserIdx(((UserVO) session.getAttribute("user")).getUserIdx());
	    System.out.println("vo  : " + vo);

	    model.addAttribute("hosIdx", hosIdx);

	    hospitalService.updateReview(vo);

	    // 별점 평균 업데이트
	    updateAverageScore(hosIdx);

	    String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();

	    return add;
	}

	// 리뷰 삭제
	@RequestMapping("/deleteReview.do")
	public String deleteReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
	    System.out.println(":: 병원 리뷰 삭제");
	    vo.setUserIdx(((UserVO) session.getAttribute("user")).getUserIdx());
	    System.out.println("vo  : " + vo);

	    model.addAttribute("hosIdx", hosIdx);

	    hospitalService.deleteReview(vo);

	    // 별점 평균 업데이트
	    updateAverageScore(hosIdx);

	    String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();

	    return add;
	}

	// 별점 평균 업데이트 메소드
	private void updateAverageScore(int hosIdx) {
	    // 해당 병원의 모든 리뷰 가져오기
	    List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);

	    // 별점 합계 계산
	    double totalScore = 0.0;
	    for (HosReviewVO reviewVo : reviewList) {
	        totalScore += reviewVo.getScore();
	    }

	    // 별점 평균 계산
	    double avgScore = 0.0;
	    if (!reviewList.isEmpty()) {
	        avgScore = totalScore / reviewList.size();
	    }

	    // 병원의 별점 평균 업데이트
	    HospitalVO hosVo = new HospitalVO();
	    hosVo.setHosIdx(hosIdx);
	    hosVo.setScore(avgScore);

	    hospitalService.updateAvgScore(hosVo);
	}

}