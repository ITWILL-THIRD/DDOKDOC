package com.todoc.view.user;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
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

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private HospitalService hospitalService;;
	
	public UserController() {
		System.out.println("=======> UserController()객체생성");
	}

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
		
		
		if (user != null) {
			model.addAttribute("msg", "로그인 성공");
			System.out.println(">>로그인 성공");
			session.setAttribute("user", user);
			return "redirect:/index.jsp?msg=success";
			
		} else {
			model.addAttribute("msg", "로그인 실패");
			System.out.println(">>로그인 실패");
			return "redirect:login.do?msg=failure";
		}
	}
	
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
		HospitalVO user = hospitalService.getHos(ho);
		System.out.println("hoUser : " + user);
		
		if (user != null) {
			model.addAttribute("msg", "로그인 성공");
			session.setAttribute("hoUser", user);
			System.out.println(">>로그인 성공");
			
			return "redirect:/index.jsp?msg=success";
			
		} else {
			model.addAttribute("msg", "로그인 실패");
			System.out.println(">>로그인 실패");
			return "redirect:hoLogin.do?msg=failure";
		}
	}
	
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
			return "redirect:login.do?msg=success";
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
			model.addAttribute("msg", "회원가입 실패");
			return "redirect:userJoin.do";
		}
	}

	//기업회원가입 화면전환
	@RequestMapping("user/hoJoin.do")
	public String hoJoin(UserVO vo) {
		return "user/hoJoin";
	}
	//기업 회원가입 처리
	@PostMapping("user/hoJoin.do")
	public String hoJoinOk(HospitalVO vo) {
		hospitalService.insertHospital(vo);
		if (vo != null) {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 완료");
			return "redirect:hoLogin.do?msg=success";
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
			return "user/hoJoin";
		}
	}

	//로그인 화면 전환
	@RequestMapping("user/login.do")
	public String loginView(@ModelAttribute("user")UserVO vo) {
		System.out.println(">> 로그인화면이동");
		vo.setEmail(vo.getEmail());
		vo.setPassword(vo.getPassword());
		return "user/login";
	}

	//카카오 redirect
	@RequestMapping(value = "user/redirect.do", method = RequestMethod.GET)
	public String kakaoRedirect(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session, UserVO vo) {
		System.out.println(">> 카카오 로그인 리디렉션 처리 - code: " + code + ", state: " + state);
  
  // 여기에 카카오 API를 사용하여 access token을 요청하고 세션에 저장하는 코드를 추가하세요.
  // 이후, 사용자 정보를 요청하여 session에 저장하거나 적절한 처리를 할 수 있습니다.
 
		return "user/redirect"; 
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
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {

		System.out.println(">> 로그아웃 처리");
		session.invalidate();
		
		return "redirect:/index.jsp";
		
	}
	//개인 이메일찾기 화면전환
	@RequestMapping("user/findEmail.do")
	public String findEmailView() {
		return "user/findEmail";
	}
	
	//개인 이메일 찾기
	@PostMapping("user/findEmail.do")
	public String findEmail(UserVO vo, HttpServletRequest request, Model model,
			@RequestParam String name, @RequestParam String phone) {
		try {
			vo.setName(name);
			vo.setPhone(phone);
			UserVO email = userService.findEmail(vo);
			String findEmail = email.getEmail();
			model.addAttribute("findEmail", findEmail);
		}  catch (Exception e) {
			e.printStackTrace();
		}
		return "user/findEmailResult";
	}
	
	//개인 비번찾기 화면전환
	@RequestMapping("user/findPwd.do")
	public String findPwdView() {
		return "user/findPwd";
	}
	
	//개인 비번찾기
	@PostMapping("user/findPwd.do")
	public String findPwd(UserVO vo, HttpServletRequest request, Model model,
			@RequestParam String name, @RequestParam String email) {
		vo.setName(name);
		vo.setEmail(email);
		int search = userService.findPwd(vo);
		
		if (search == 0) {
			model.addAttribute("msg", "가입된 정보가 없습니다.");
			return "user/findPwd";
		}
		
		String newPwd = RandomStringUtils.randomAlphanumeric(10);
		vo.setPassword(newPwd);
		userService.updateExPwd(vo);
		//기능 넣기
		model.addAttribute("newPwd", newPwd);
		
		return "user/findPwdResult";
	}
	
	//병원 아이디 찾기 화면전환
	@RequestMapping("user/hoFindId.do")
	public String hoFindIdView() {
		return "user/hoFindId";
	}
	
	//병원 아이디 찾기
	@PostMapping("user/hoFindId.do")
	public String hoFindId(HospitalVO vo, HttpServletRequest request, Model model,
			@RequestParam String hosName, @RequestParam String hosPhone) {
		try {
			vo.setHosName(hosName);
			vo.setHosPhone(hosPhone);
			HospitalVO hosId = hospitalService.hoFindId(vo);
			String findHosId = hosId.getHosId();
			model.addAttribute("findHosId", findHosId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "user/hoFindIdResult";
	}
	
	//병원비번 찾기 화면전환
	@RequestMapping("user/hoFindPwd.do")
	public String hoFindPwdView() {
		return "user/hoFindPwd";
	}
	
	//병원 비번찾기 
	@PostMapping("user/hoFindPwd.do")
	public String hoFindPwd(HospitalVO vo, HttpServletRequest request, Model model,
			@RequestParam String hosName, @RequestParam String hosId) {
		vo.setHosName(hosName);
		vo.setHosId(hosId);
		int search = hospitalService.hoFindPwd(vo);
		
		if (search == 0) {
			model.addAttribute("msg", "가입된 정보가 없습니다.");
			return "user/hoFindPwd";
		}
		String newPwd = RandomStringUtils.randomAlphanumeric(10);
		vo.setHosPw(newPwd);
		hospitalService.hoUpdateExPwd(vo);
		model.addAttribute("newPwd", newPwd);
		
		return "user/hoFindPwdResult";
	}
	
	
}
