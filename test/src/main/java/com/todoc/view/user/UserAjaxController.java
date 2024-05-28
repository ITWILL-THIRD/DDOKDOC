package com.todoc.view.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.user.UserService;
@RestController
public class UserAjaxController {
	@Autowired
	private UserService userService;
	
	public UserAjaxController() {
		System.out.println("=======> UserAjaxController()객체생성");
	}
	
	//이메일 중복체크 ajax
		@RequestMapping(value = "/getJsonUserJoin.do",  method = RequestMethod.POST)
		@ResponseBody
		public int email(@RequestParam("email") String email) {
			int cnt = userService.email(email);
			return cnt;
		}

}
