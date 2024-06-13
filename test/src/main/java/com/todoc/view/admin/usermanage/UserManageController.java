package com.todoc.view.admin.usermanage;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.hospital.HospitalService;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@RequestMapping("/admin")
@Controller
public class UserManageController {
	@Autowired
	UserService userService;
	@Autowired
	HospitalService hospitalService;
	
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		System.out.println(">>conditionMap 실행");
		Map<String, String> conditionMap =  new LinkedHashMap<>();
		conditionMap.put("이메일", "EMAIL");
		conditionMap.put("닉네임", "NICKNAME");
		conditionMap.put("이름", "NAME");
		return conditionMap;
	}
	
	
	//회원관리 페이지 이동 (전체 회원 조회)
	@RequestMapping("/getUserList.do")
	public String getUserListView(@ModelAttribute("vo") UserVO vo, Model model) {
		List<UserVO> getUserList = userService.getUserList(vo);
		model.addAttribute("getUserList", getUserList);
		return "admin/getUserList";
	}
	
	

}
