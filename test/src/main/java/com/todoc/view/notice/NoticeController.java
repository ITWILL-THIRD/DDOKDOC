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
	@RequestMapping("/getNotice.do")
	public String hosNotice(@ModelAttribute("noticeIdx") int noticeIdx, Model model) {
		System.out.println(">> 병원 공지사항 상세 : hosNotice() 메소드");
		
		NoticeVO notice = noticeService.getNotice(noticeIdx);
		System.out.println("notice : " + notice);
		model.addAttribute("notice", notice);
		
		return "notice/getNotice";
	}
	//공지 작성 폼 전환
	@RequestMapping("/insertProNotice.do")
	public String insertProNotice(NoticeVO vo
								, @ModelAttribute("hosIdx") int hosIdx
								, Model model) {
		System.out.println(">> insertProNotice(NoticeVO) 메소드 실행");
		System.out.println("vo  : " + vo);
		
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
		String add = "redirect:../mypage/hosNoticeList.do?hosIdx=" + vo.getHosIdx();
		
		return add;
		//return "mypage/hosNoticeList";
	}
	//공지 수정폼 전환
	@PostMapping("/updateProNotice.do")
	public String updateProNotice(NoticeVO notice, Model model) {
		System.out.println(">> updateProNotice(NoticeVO) 메소드 실행~");
		System.out.println("입력 받아온 notice : " + notice);
		
		model.addAttribute("notice", notice);
		
		return "notice/updateProNotice";
	}
	//공지 수정
	@RequestMapping("/updateNotice.do")
	public String updateNotice(NoticeVO notice) {
		System.out.println(">> updateNotice(NoticeVO) 메소드 실행~");
		System.out.println("수정 할 notice : " + notice);
		
		noticeService.updateNotice(notice);
		
		String add = "redirect:getNotice.do?hosIdx=" + notice.getHosIdx() + "&noticeIdx=" + notice.getNoticeIdx();
		
		return add;
	}
	//공지 삭제
	@PostMapping("/deleteNotice.do")
	public String deleteNotice(NoticeVO vo, SessionStatus sessionStatus) {
		System.out.println(">> deleteNotice(vo) 메소드 실행");
		System.out.println("삭제 할 vo : " + vo);
		
		noticeService.deleteNotice(vo);
		sessionStatus.setComplete(); //@SessionAttributes 저장객체 삭제 처리
		
		String add = "redirect:../hospital/hosDetail.do?hosIdx=" + vo.getHosIdx();
		return add;
	}
	
}
