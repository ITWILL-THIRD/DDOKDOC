package com.todoc.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	public UserController() {
		System.out.println("=======> UserController()객체생성");
	}
	
	@PostMapping("user/login.do")
	public String login(UserVO vo) {
		System.out.println(">> 로그인 처리");
		System.out.println("vo : " + vo);
		
		
		if (vo.getEmail() == null || vo.getEmail().equals("")) {
			//alert창 띄우기
			System.out.println("아이디를 입력하세요");
		}
		if (vo.getPassword() == null || vo.getPassword().equals("")) {
			System.out.println("비번입력하세요");
		}
		
		UserVO user = userService.getUser(vo);
		System.out.println("user : " + user);

		if (user != null) {
			System.out.println(">>로그인 성공");
			return "user/login";
		} else {
			System.out.println(">>로그인 실패");
			return "user/login";
		}
	}
	
	
	
	//======카카오로그인============
	
	
	
	
	
	
	@RequestMapping("user/userJoin.do")
	public String userJoin(UserVO vo) {
		return "user/userJoin";
	}
	
	@PostMapping("user/userJoin.do")
	public String userJoinOk(UserVO vo) {
		userService.insertUser(vo);
		if (vo != null) {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 완료");
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
		}
		return "user/userJoin";
		
		
	}
	
	
	@RequestMapping("user/hoJoin.do")
	public String hoJoin(UserVO vo) {
		return "user/hoJoin";
	}

	
	@GetMapping("user/login.do")
	public String loginView(@ModelAttribute("user")UserVO vo) {
		System.out.println(">> 로그인화면이동");
		vo.setEmail(vo.getEmail());
		vo.setPassword(vo.getPassword());
		return "user/login";
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {

		System.out.println(">> 로그아웃 처리");
		session.invalidate();
		
		return "login.jsp";
		
	}
	
	
	
	
	

}
