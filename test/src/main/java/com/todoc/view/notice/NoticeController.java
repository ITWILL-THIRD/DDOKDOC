package com.todoc.view.notice;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;

@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	
	@RequestMapping("notice/getNotice.do")
	public String hosNotice(@ModelAttribute("noticeIdx") int noticeIdx, Model model) {
		System.out.println(">> 병원 공지사항 상세");
		
		NoticeVO notice = noticeService.getNotice(noticeIdx);
		System.out.println("notice : " + notice);
		model.addAttribute("notice", notice);
		
		return "notice/getNotice";
	}
	
	@RequestMapping("notice/insertProNotice.do")
	public String insertProNotice(NoticeVO vo
								, @ModelAttribute("hosIdx") int hosIdx
								, Model model) {
		System.out.println(">> insertProNotice(NoticeVO) 메소드 실행");
		System.out.println("vo  : " + vo);
		
		model.addAttribute("hosIdx", hosIdx);
		
		return "notice/insertNotice";
	}
	
	@PostMapping("notice/insertNotice.do")
	public String insertNotice(NoticeVO vo) {
		System.out.println(">> insertNotice(NoticeVO) 메소드 실행");
		System.out.println("vo  : " + vo);
		
		noticeService.insertNotice(vo);
		System.out.println("vo.getHosIdx() : " + vo.getHosIdx());
		
		String add = "redirect:/hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		
		return add;
	}
}
