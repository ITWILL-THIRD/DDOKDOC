package com.todoc.user.dao;

import java.util.List;

import com.todoc.user.UserVO;

public interface UserDAO {
	 UserVO getUser(UserVO vo);
	 void insertUser(UserVO vo);
//	 String email(String email);
	 int email(UserVO vo) throws Exception;
	 UserVO getUserByEmail(String email);
	 UserVO getUserInfo(int userIdx);
	 void updateUser(UserVO vo);
	 void updatePwd(UserVO vo);
	 void deleteUser(int userIdx);
	 UserVO findEmail(UserVO vo);
	 int findPwd(UserVO vo);
	 void updateExPwd(UserVO vo);
	 List<UserVO> getUserList(UserVO vo);
}
