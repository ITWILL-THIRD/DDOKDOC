package com.todoc.view.user;

import java.util.Collections;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;
@RestController
public class UserAjaxController {
	@Autowired
	private UserService userService;
	@Autowired
	private HospitalService hospitalService;
	
	public UserAjaxController() {
		System.out.println("=======> UserAjaxController()객체생성");
	}
	
	//이메일 중복체크 ajax
	@ResponseBody
	@RequestMapping(value = "user/email.do",  method = RequestMethod.POST)
	public int email(@RequestBody UserVO vo) throws Exception {
		System.out.println("email 메소드 실행 ");
		int cnt = userService.email(vo);
		System.out.println("cnt : " + cnt);
		return cnt;
	}
	
	//병원 아이디 중복체크 ajax
	@ResponseBody
	@RequestMapping(value = "user/hosId.do",  method = RequestMethod.POST)
	public int email(@RequestBody HospitalVO ho) throws Exception {
		System.out.println("hosId 메소드 실행 ");
		int cnt = hospitalService.hosId(ho);
		System.out.println("cnt : " + cnt);
		return cnt;
	}
	//카카오 로그인 사용자 정보 받아 세션에 저장
	@PostMapping("user/saveUserInfo.do")
	 public ResponseEntity<?> saveUserInfo(@RequestBody UserVO user, HttpSession session) {
        try {
            // 사용자 정보를 세션에 저장
            session.setAttribute("user", user);
            return ResponseEntity.ok(Collections.singletonMap("success", true));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Collections.singletonMap("success", false));
        }
    }
		

}
