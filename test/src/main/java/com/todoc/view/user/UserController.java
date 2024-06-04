package com.todoc.view.user;

import java.sql.Date;
import java.sql.Time;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private HospitalService hospitalService;
	
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
//			return "user/login";
			return "redirect:/index.jsp";
			
		} else {
			model.addAttribute("msg", "로그인 실패");
			System.out.println(">>로그인 실패");
			return "user/login";
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
			session.setAttribute("user", user);
			System.out.println(">>로그인 성공");
			
			return "redirect:/index.jsp";
			
		} else {
			model.addAttribute("msg", "로그인 실패");
			System.out.println(">>로그인 실패");
			return "user/hoLogin";
		}
		
	}
	
	
	
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
//			return "user/userJoin";
			return "user/login";
			//return "../index";
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
			model.addAttribute("msg", "회원가입 실패");
			return "user/userJoin";
		}
	
	}
	
	//기업회원가입 화면전환
	@RequestMapping("user/hoJoin.do")
	public String hoJoin(UserVO vo) {
		return "user/hoJoin";
	}
	//기업 회원가입 처리
	@PostMapping("user/hoJoin.do")
	public String hoJoinOk(HospitalVO vo, String openTimeStr, String closeTimeStr
						, String lunchTimeStr, String endLunchTimeStr
						, String satOpenTimeStr, String satCloseTimeStr
						, String satLunchTimeStr, String satEndLunchTimeStr) {
		if (vo != null) {
	        System.out.println("openTimeStr : " + openTimeStr);
	        System.out.println("closeTimeStr : " + closeTimeStr);
	        System.out.println("lunchTimeStr : " + lunchTimeStr);
	        System.out.println("endLunchTimeStr : " + endLunchTimeStr);
	        System.out.println("satOpenTimeStr : " + satOpenTimeStr);
	        System.out.println("satCloseTimeStr : " + satCloseTimeStr);
	        System.out.println("satLunchTimeStr : " + satLunchTimeStr);
	        System.out.println("satEndLunchTimeStr : " + satEndLunchTimeStr);
			// 기본 형식으로 변환
	        LocalTime openTime = LocalTime.parse(openTimeStr);
	        LocalTime closeTime = LocalTime.parse(closeTimeStr);
	        LocalTime lunchTime = LocalTime.parse(lunchTimeStr);
	        LocalTime endLunchTime = LocalTime.parse(endLunchTimeStr);
	        LocalTime satOpenTime = LocalTime.parse(satOpenTimeStr);
	        LocalTime satCloseTime = LocalTime.parse(satCloseTimeStr);
	        LocalTime satLunchTime = LocalTime.parse(satLunchTimeStr);
	        LocalTime satEndLunchTime = LocalTime.parse(satEndLunchTimeStr);
	        System.out.println("Formatted openTime: " + openTime + closeTime + lunchTime + endLunchTime
	        		+ satOpenTime + satCloseTime + satLunchTime + satEndLunchTime);
	        // 특정 형식으로 변환
//	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm:ss");
//	        LocalTime openTime = LocalTime.parse(openTimeStr, formatter);
//	        LocalTime closeTime = LocalTime.parse(closeTimeStr, formatter);
//	        LocalTime lunchTime = LocalTime.parse(lunchTimeStr, formatter);
//	        LocalTime endLunchTime = LocalTime.parse(endLunchTimeStr, formatter);
//	        LocalTime satOpenTime = LocalTime.parse(satOpenTimeStr, formatter);
//	        LocalTime satCloseTime = LocalTime.parse(satCloseTimeStr, formatter);
//	        LocalTime satLunchTime = LocalTime.parse(satLunchTimeStr, formatter);
//	        LocalTime satEndLunchTime = LocalTime.parse(satEndLunchTimeStr, formatter);
//	        System.out.println("Formatted openTime: " + openTime + closeTime + lunchTime + endLunchTime
//	        		+ satOpenTime + satCloseTime + satLunchTime + satEndLunchTime);
	        vo.setOpenTime(openTime);
	        vo.setCloseTime(closeTime);
	        vo.setLunchTime(lunchTime);
	        vo.setEndLunchTime(endLunchTime);
	        vo.setSatOpenTime(satOpenTime);
	        vo.setSatCloseTime(satCloseTime);
	        vo.setSatLunchTime(satLunchTime);
	        vo.setSatEndLunchTime(satEndLunchTime);
	//        try {
	//            SimpleDateFormat sdf = new SimpleDateFormat("HH:mm"); // 입력 형식
	//            java.util.Date dateOpenTime = sdf.parse(openTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateCloseTime = sdf.parse(closeTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateLunchTime = sdf.parse(lunchTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateEndLunchTime = sdf.parse(endLunchTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateSatOpenTime = sdf.parse(satOpenTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateSatCloseTime = sdf.parse(satCloseTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateSatLunchTime = sdf.parse(satLunchTimeStr); // 문자열을  Date 객체로 파싱
	//            java.util.Date dateSatEndLunchTime = sdf.parse(satEndLunchTimeStr); // 문자열을  Date 객체로 파싱
	//            Time openTime = new Time(dateOpenTime.getTime()); // Date를 Time으로 변환
	//            Time closeTime = new Time(dateCloseTime.getTime()); // Date를 Time으로 변환
	//            Time lunchTime = new Time(dateLunchTime.getTime()); // Date를 Time으로 변환
	//            Time endLunchTime = new Time(dateEndLunchTime.getTime()); // Date를 Time으로 변환
	//            Time satOpenTime = new Time(dateSatOpenTime.getTime()); // Date를 Time으로 변환
	//            Time satCloseTime = new Time(dateSatCloseTime.getTime()); // Date를 Time으로 변환
	//            Time satLunchTime = new Time(dateSatLunchTime.getTime()); // Date를 Time으로 변환
	//            Time satEndLunchTime = new Time(dateSatEndLunchTime.getTime()); // Date를 Time으로 변환
	//            
	//            vo.setOpenTime(openTime);
	//            vo.setCloseTime(closeTime);
	//            vo.setLunchTime(lunchTime);
	//            vo.setEndLunchTime(endLunchTime);
	//            vo.setSatOpenTime(satOpenTime);
	//            vo.setSatCloseTime(satCloseTime);
	//            vo.setSatLunchTime(satLunchTime);
	//            vo.setSatEndLunchTime(satEndLunchTime);
	//        } catch (Exception e) {
	//            e.printStackTrace();
	//        }
			System.out.println(vo.getOpenTime());
			System.out.println(vo.getCloseTime());
			System.out.println("hoJoinOk 메소드 실행~~");
			//hospital 테이블 입력
			hospitalService.insertHospital(vo);
			//hosaddress 테이블 입력
			hospitalService.insertHosAddress(vo);
			//hostime 테이블 입력
			hospitalService.insertHosTime(vo);
		
			System.out.println(">>회원가입 완료");
			return "user/login";
			
		} else {
			System.out.println("vo : " + vo);
			System.out.println(">>회원가입 실패");
			return "user/hoJoin";
		}
	}
	//병원 운영시간 임시 테스트용
	@PostMapping("/test.do")
	public String testTime(HospitalVO vo, @ModelAttribute("openTime") Time openTime) {
		System.out.println(">> testTime() 메소드 실행~~");
		String time = openTime.toString();
		System.out.println("time : " + time);
		System.out.println("vo : " + vo);
		
		//hospitalService.insertHosTime(vo);
		return "user/hoJoin";
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
	@RequestMapping("logout.do")
	public String logout(HttpSession session) {

		System.out.println(">> 로그아웃 처리");
		session.invalidate();
		
		return "redirect:/index.jsp";
		
	}
	
	
	
	
	

}
