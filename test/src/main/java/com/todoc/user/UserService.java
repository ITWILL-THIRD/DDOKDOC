package com.todoc.user;

import java.util.List;

import com.todoc.membership.UserMembershipVO;

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
	UserVO findEmail(UserVO vo);
	int findPwd(UserVO vo);
	void updateExPwd(UserVO vo);
	List<UserVO> getUserList(UserVO vo, String searchType, String searchKeyword, int begin, int end);
	int getTotCnt();
//	//이메일 검색 유저수
//    int getEmailTotCnt(String searchKeyword);
//    //이름 검색 유저수
//    int getNameTotCnt(String searchKeyword);
//    //전화번호 검색 유저수
//    int getPhoneTotCnt(String searchKeyword);
	int getUserCountByCondition(String searchType, String searchKeyword);
	void updateUserCondition(UserVO user);
	UserMembershipVO getUserMembershipByIdx(int userIdx);
	
	
	
}
