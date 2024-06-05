package com.todoc.view.mypage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.user.UserVO;

@Controller
public class MyPageController {
	@Autowired
	private MyPetService myPetService;
	@Autowired
	private ReservationService reservationService;
	
    @RequestMapping("/myPage.do")
    public String myPage(Model model, HttpSession session) {
    	UserVO user = (UserVO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:/index.jsp"; // 로그인 정보가 없으면 로그인 페이지로 리다이렉트 처리
    	}
    	List<MyPetVO> pets = myPetService.getMyPetList(user.getUserIdx());
    	model.addAttribute("pets", pets);
        return "mypage/myPage";
    }
    
    @RequestMapping("/myReserList.do")
    public String myReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	List<ReservationVO> myReserList = reservationService.myReserList(user.getUserIdx());
    	
    	model.addAttribute("myReserList", myReserList);
    	
    	return "mypage/myReserList";
    }
    
    @RequestMapping("/myOldReserList.do")
    public String myOldReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	List<ReservationVO> myOldReserList = reservationService.myOldReserList(user.getUserIdx());
    	
    	model.addAttribute("myOldReserList", myOldReserList);
    	
    	return "mypage/myOldReserList";
    }
    
    @RequestMapping("/myCancleReserList.do")
    public String myCancleReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	List<ReservationVO> myCancleReserList = reservationService.myCancleReserList(user.getUserIdx());
    	
    	model.addAttribute("myCancleReserList", myCancleReserList);
    	
    	return "mypage/myCancleReserList";
    }

}
