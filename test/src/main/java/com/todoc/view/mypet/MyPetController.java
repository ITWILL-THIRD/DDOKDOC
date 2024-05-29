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
/*	
	public String insertMyPet(MyPetVO vo, HttpSession ss, RedirectAttributes redi) {
		// 임시 데이터 저장용
		int userIdx = ((UserVO) ss.getAttribute("user")).getUserIdx();
		
	}
*/	
	
}
