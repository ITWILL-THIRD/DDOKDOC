package com.todoc.user;

public interface UserService {
	UserVO getUser(UserVO vo);
	void insertUser(UserVO vo);
//	int email(String email);
	int email(UserVO vo) throws Exception;
	UserVO getUserByEmail(String email);
	UserVO getUserInfo(int userIdx);
	void updateUser(UserVO vo);
	void updatePwd(UserVO vo);
	void deleteUser(int userIdx);
	
	
}
