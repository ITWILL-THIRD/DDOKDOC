package com.todoc.view.mypet;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String insertMyPet(MyPetVO vo, Model model, HttpSession session) {
		UserVO user = (UserVO) session.getAttribute("user");
		vo.setUserIdx(user.getUserIdx());
		myPetService.insertMyPet(vo);
		return "redirect:myPage.do";
	}

	@GetMapping("/updateMyPetView.do")
	public String updateMyPetView(@RequestParam("petIdx") int petIdx, Model model) {
		System.out.println(">> 마이펫 수정페이지");
		MyPetVO pet = myPetService.getMyPet(petIdx);
		System.out.println("pet: " + pet);
		model.addAttribute("pet", pet);
	    return "mypet/updateMyPet";
	}

	@PostMapping("/updateMyPet.do")
	public String updateMyPet(MyPetVO vo, Model model) {
		myPetService.updateMyPet(vo);
		return "redirect:myPage.do";
	}
	
	@PostMapping("/deleteMyPet.do")
	public String deleteMyPet(@RequestParam("petIdx") int petIdx, Model model) {
	    myPetService.deleteMyPet(petIdx);
	    return "redirect:/myPage.do"; 
	}
	
}
