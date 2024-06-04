package com.todoc.user.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.user.UserService;
import com.todoc.user.UserVO;
import com.todoc.user.dao.UserDAO;
@Service(value = "userService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	public UserServiceImpl(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	@Override
	public UserVO getUser(UserVO vo) {
		return userDAO.getUser(vo);
	}
	public void insertUser(UserVO vo) {
		userDAO.insertUser(vo);
	}
	//이메일 중복 체크
	@Override
	public int email(UserVO vo) throws Exception {
		int cnt = userDAO.email(vo);
		return cnt;
	}
	//카카오 이메일 있나 확인
	 public UserVO getUserByEmail(String email) {
	        return userDAO.getUserByEmail(email);
	 }
	 @Override
	 //내 정보 조회(마이페이지)
	 public UserVO getUserInfo(int userIdx) {
		 return userDAO.getUserInfo(userIdx);
	 }
	 //내 정보 수정(마이페이지)
	 public void updateUser(UserVO vo) {
		 userDAO.updateUser(vo);
	 }
	 //비밀번호 수정(마이페이지)
	 public void updatePwd(UserVO vo) {
		 userDAO.updatePwd(vo);
	 }
	 //회원탈퇴(마이페이지)
	 public void deleteUser(int userIdx) {
		 userDAO.deleteUser(userIdx);
	 }

}
