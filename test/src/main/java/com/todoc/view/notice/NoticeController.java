package com.todoc.view.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;

@SessionAttributes(value = {"notice"})
@Controller
@RequestMapping("/notice")
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	
	//병원 공지사항 목록 조회
	/*
	 * @RequestMapping("/getNotice.do") public String
	 * hosNotice(@ModelAttribute("noticeIdx") int noticeIdx, Model model) {
	 * System.out.println(">> 병원 공지사항 상세 : hosNotice() 메소드");
	 * 
	 * NoticeVO notice = noticeService.getNotice(noticeIdx);
	 * System.out.println("notice : " + notice); model.addAttribute("notice",
	 * notice);
	 * 
	 * return "notice/getNotice"; }
	 */
	//공지 작성 폼 전환
	@RequestMapping("/insertProNotice.do")
	public String insertProNotice(NoticeVO vo
								, @ModelAttribute("hosIdx") int hosIdx
								, Model model) {
		System.out.println(">> insertProNotice(NoticeVO) 메소드 실행");
		System.out.println("vo  : " + vo);
		
		NoticeVO notice = noticeService.getNotice(hosIdx);
		
		model.addAttribute("hosIdx", hosIdx);
		
		return "notice/insertNotice";
	}
	//공지 작성
	@PostMapping("/insertNotice.do")
	public String insertNotice(NoticeVO vo) {
		System.out.println(">> insertNotice(NoticeVO) 메소드 실행");
		System.out.println("입력한 vo  : " + vo);
		
		noticeService.insertNotice(vo);
		System.out.println("vo.getHosIdx() : " + vo.getHosIdx());
		
		//String add = "redirect:../hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		String add = "redirect:../mypage/hosNotice.do?hosIdx=" + vo.getHosIdx();
		
		return add;
		//return "mypage/hosNoticeList";
	}

	// 공지 수정 폼 전환
	@RequestMapping("/updateProNotice.do")
	public String updateProNotice(int hosIdx, Model model) {
		System.out.println(">> updateProNotice(NoticeVO) 메소드 실행~");
		System.out.println("입력 받아온 hosIdx : " + hosIdx);
		
		NoticeVO notice = noticeService.getNotice(hosIdx);
		model.addAttribute("notice", notice);
		model.addAttribute("hosIdx", hosIdx);
		
		return "notice/updateNotice";
	}
	
	//공지 db수정
	@PostMapping("/updateNotice.do")
	public String updateNotice(NoticeVO notice) {
		System.out.println(">> updateNotice(NoticeVO) 메소드 실행~");
		System.out.println("수정 할 notice : " + notice);
		
		noticeService.updateNotice(notice);
		
		String add = "redirect:../mypage/hosNotice.do?hosIdx=" + notice.getHosIdx();
		
		return add;
	}
	
	//공지 삭제
	@PostMapping("/deleteNotice.do")
	public String deleteNotice(String hosIdx) {
		System.out.println(">> deleteNotice(vo) 메소드 실행");
		System.out.println("삭제 할 hosIdx : " + hosIdx);
		int hosIdxInt = Integer.parseInt(hosIdx);
		
		noticeService.deleteNotice(hosIdxInt);
		String add = "redirect:../mypage/hosNotice.do?hosIdx=" + hosIdxInt;
		return add;
	}
	
}
