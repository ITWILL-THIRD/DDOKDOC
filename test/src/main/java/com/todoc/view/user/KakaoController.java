//package com.todoc.view.user;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.servlet.ModelAndView;
//
//import com.todoc.user.KakaoLoginService;
//import com.todoc.user.UserService;
//
//@RequestMapping(value = "/redirect", method = RequestMethod.GET)
//public String kakaoRedirect(@RequestParam("code") String code, @RequestParam("state") String state, HttpSession session) {
//  System.out.println(">> 카카오 로그인 리디렉션 처리 - code: " + code + ", state: " + state);
//
//  // 여기에 카카오 API를 사용하여 access token을 요청하고 세션에 저장하는 코드를 추가하세요.
//  // 이후, 사용자 정보를 요청하여 session에 저장하거나 적절한 처리를 할 수 있습니다.
//
//  return "user/redirect"; // /WEB-INF/jsp/ + user/redirect + .jsp
//}

