package com.todoc.view.mypet;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.user.UserVO;

@Controller
public class MyPetController {
	@Autowired
	private MyPetService myPetService;
	
	@RequestMapping("/insertMyPetView.do")
	public String insertMyPetView() {
		System.out.println(">> 마이펫 등록페이지");
		return "mypet/insertMyPet";
	}
	
	@RequestMapping("/insertMyPet.do")
	public String insertMyPet(MyPetVO vo, HttpSession session, RedirectAttributes redirectAttr) {
		UserVO user = (UserVO) session.getAttribute("user");
		vo.setUserIdx(user.getUserIdx());
		myPetService.insertMyPet(vo);
		redirectAttr.addFlashAttribute("message", "등록이 완료되었습니다");
		return "redirect:myPage.do";
	}
	
}
