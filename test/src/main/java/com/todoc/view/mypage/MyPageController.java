package com.todoc.view.mypage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.user.UserVO;

@Controller
public class MyPageController {
	@Autowired
	private MyPetService myPetService;
	
    @RequestMapping("/myPage.do")
    public String myPage(Model model, HttpSession session) {
    	UserVO user = (UserVO) session.getAttribute("user");
    	if (user == null) {
    		return "index"; // 로그인 정보가 없으면 로그인 페이지로 리다이렉트 처리
    	}
    	List<MyPetVO> pets = myPetService.getMyPetList(user.getUserIdx());
    	model.addAttribute("pets", pets);
        return "mypage/myPage";
    }

}
