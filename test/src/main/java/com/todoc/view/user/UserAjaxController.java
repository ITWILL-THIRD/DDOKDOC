package com.todoc.view.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.user.UserService;
import com.todoc.user.UserVO;
@RestController
public class UserAjaxController {
	@Autowired
	private UserService userService;
	
	public UserAjaxController() {
		System.out.println("=======> UserAjaxController()객체생성");
	}
	
	//이메일 중복체크 ajax
		@ResponseBody
		@RequestMapping(value = "/email.do",  method = RequestMethod.POST,
		produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
		public int email(UserVO vo) throws Exception {
			System.out.println("email 메소드 실행 ");
			int cnt = userService.email(vo);
			
			return cnt;
		}

}
