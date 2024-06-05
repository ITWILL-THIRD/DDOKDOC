package com.todoc.view.mypage;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@Controller
public class MyPageController {
	@Autowired
	private UserService userService;
	
	@Autowired
	private MyPetService myPetService;
	@Autowired
	private ReservationService reservationService;
	
	@GetMapping("/updateUser.do")
	public String updateUserView(@RequestParam("userIdx") int userIdx, Model model, HttpSession session) {
		System.out.println(">> 내 정보 수정페이지");
	    UserVO vo = userService.getUserInfo(userIdx);
	    session.setAttribute("user", vo); 
	    model.addAttribute("user", vo); 
	    return "mypage/updateUser";
	}
	//정보수정
	@PostMapping("/updateUser.do")
	public String updateUser(@ModelAttribute("user") UserVO vo, HttpSession session) {
	    System.out.println("내 정보 수정");
	    System.out.println("vo : " + vo);
	    userService.updateUser(vo);
	    session.setAttribute("user", vo); 
	    return "redirect:myPage.do";
	}
	
	@RequestMapping("/updatePwd.do")
	public String updatePwdView(@RequestParam("userIdx") int userIdx, Model model) {
		System.out.println(">>비밀번호 수정 페이지");
		UserVO vo = userService.getUserInfo(userIdx);
	    model.addAttribute("vo", vo);
	    return "mypage/updatePwd";
	}

	//비번수정
	@PostMapping("/updatePwd.do")
	public String updatePwd(@RequestParam("userIdx") int userIdx, 
	                        @RequestParam("currentPassword") String currentPassword,
	                        @RequestParam("password") String newPassword, 
	                        HttpSession session, Model model) {
	    UserVO user = userService.getUserInfo(userIdx);

	    if (user == null || !user.getPassword().equals(currentPassword)) {
	        model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
	        return "mypage/updatePwd";
	    }

	    user.setPassword(newPassword);
	    userService.updatePwd(user);
	    System.out.println("updatePwd : " + user);
	    session.setAttribute("user", user); 

	    return "redirect:updateUser.do?userIdx=" + userIdx; 
	}
	//회원탈퇴
	@PostMapping("/deleteUser.do")
	public String deleteUser(@RequestParam("userIdx") int userIdx, HttpSession session) {
		userService.deleteUser(userIdx);
		session.invalidate();
		System.out.println(">> 탈퇴 완료");
		return "redirect:/index.jsp?msg=delete";
	}
	
	
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
