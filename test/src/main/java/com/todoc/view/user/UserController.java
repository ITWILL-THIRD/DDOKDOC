package com.todoc.view.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.todoc.user.HosService;
import com.todoc.user.HospitalVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@Controller
//@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private HosService hosService;
	
	public UserController() {
		System.out.println("=======> UserController()객체생성");
	}
//	@ModelAttribute("user")
	@PostMapping("/user/login.do")
	public String login(UserVO vo, Model model, HttpSession session ) {
		System.out.println(">> 로그인 처리");
		System.out.println("vo : " + vo);
		
		if (vo.getEmail() == null || vo.getEmail().equals("")) {
			System.out.println("아이디를 입력하세요");
			
		}
		if (vo.getPassword() == null || vo.getPassword().equals("")) {
			System.out.println("비번입력하세요");
		}
		
		UserVO user = userService.getUser(vo);
		System.out.println("user : " + user);
		
		
		//(나중에 main화면으로 return 변경)
		if (user != null) {
			model.addAttribute("msg", "로그인 성공");
			System.out.println(">>로그인 성공");
			session.setAttribute("user", user);
			return "user/login";
//			return "../../index";
			
		} else {
			model.addAttribute("msg", "로그인 실패");
			System.out.println(">>로그인 실패");
			return "user/login";
		}
	}
	
//	@RequestMapping("/main.do")
//	public String main() {
//		return "../../index";
//	}
	
	
	//병원로그인======
	@PostMapping("/user/hoLogin.do")
	public String hoLogin(HospitalVO ho, Model model, HttpSession session) {
		System.out.println(">> 병원로그인 처리");
		System.out.println("ho : " + ho);
		
		if (ho.getHosId() == null || ho.getHosId().equals("")) {
			System.out.println("아이디를 입력하세요");
			
		}
		if (ho.getHosPw() == null || ho.getHosPw().equals("")) {
			System.out.println("비번입력하세요");
		}
		HospitalVO user = hosService.getHos(ho);
		System.out.println("hoUser : " + user);
		
		if (user != null) {
			model.addAttribute("msg", "로그인 성공");
			System.out.println(">>로그인 성공");
			
			return "user/hoLogin";
//			return "../../index";
			
		} else {
			model.addAttribute("msg", "로그인 실패");
			System.out.println(">>로그인 실패");
			return "user/hoLogin";
		}
		
	}
	
	
	//이메일 중복체크
	
	
	
	
//	//======카카오로그인============
//	
//	// 1번 카카오톡에 사용자 코드 받기(jsp의 a태그 href에 경로 있음)
//		@RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET)
//		public ModelAndView kakaoLogin(@RequestParam(value = "code", required = false) String code) throws Throwable {
//
//			// 1번
//			System.out.println("code:" + code);
//			return null;	
//			// return에 페이지를 해도 되고, 여기서는 코드가 넘어오는지만 확인할거기 때문에 따로 return 값을 두지는 않았음
//
//		}

	
	
	
//===================
	
	
	//개인 회원가입으로 화면전환
	@RequestMapping("user/userJoin.do")
	public String userJoin(UserVO vo) {
		return "user/userJoin";
	}
	//개인 회원가입 처리
	@PostMapping("user/userJoin.do")
	public String userJoinOk(UserVO vo, Model model) throws Exception {
		int cnt = userService.email(vo);
		
		
		if (cnt == 0) {
			userService.insertUser(vo);
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 완료");
			model.addAttribute("msg", "회원가입 완료");
			return "user/userJoin";
			//return "../index";
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
			model.addAttribute("msg", "회원가입 실패");
			return "user/userJoin";
		}
	
	}
	
	//기업회원가입
	@RequestMapping("user/hoJoin.do")
	public String hoJoin(UserVO vo) {
		return "user/hoJoin";
	}
//	//기업 회원가입 처리
	@PostMapping("user/hoJoin.do")
	public String hoJoinOk(HospitalVO vo) {
		hosService.insertHos(vo);
		if (vo != null) {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 완료");
			return "user/login";
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
			return "user/hoJoin";
		}
//		return "user/hoJoin";
		
		
	}

//	//로그인 화면 전환
	@RequestMapping("user/login.do")
	public String loginView(@ModelAttribute("user")UserVO vo) {
		System.out.println(">> 로그인화면이동");
		vo.setEmail(vo.getEmail());
		vo.setPassword(vo.getPassword());
		return "user/login";
	}
	
	//로그인 후 메인페이지로 화면 전환
	
	
	
	//카카오 redirect
	@RequestMapping(value = "user/redirect.do", method = RequestMethod.GET)
	public String kakaoRedirect(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session, UserVO vo) {
  System.out.println(">> 카카오 로그인 리디렉션 처리 - code: " + code + ", state: " + state);
  
  // 여기에 카카오 API를 사용하여 access token을 요청하고 세션에 저장하는 코드를 추가하세요.
  // 이후, 사용자 정보를 요청하여 session에 저장하거나 적절한 처리를 할 수 있습니다.
  
  
  
  return "user/redirect"; // /WEB-INF/jsp/ + user/redirect + .jsp
}
	
	//병원로그인 화면전환
	@GetMapping("user/hoLogin.do")
	public String hoLoginView(HospitalVO ho) {
		System.out.println(">>병원로그인화면이동");
		ho.setHosId(ho.getHosId());
		ho.setHosPw(ho.getHosPw());
		return "user/hoLogin";
	}
	
	//로그아웃
	@RequestMapping("user/logout.do")
	public String logout(HttpSession session) {

		System.out.println(">> 로그아웃 처리");
		session.invalidate();
		
		return "user/login";
		
	}
	
	
	
	
	

}
