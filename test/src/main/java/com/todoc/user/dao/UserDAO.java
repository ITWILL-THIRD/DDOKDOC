package com.todoc.user.dao;

import java.util.List;
import java.util.Map;

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
	 List<UserVO> getUserList(Map<String, Object> map);
	 int getReserCount(int userIdx);
	 int getFinishCount(int userIdx);
	 int getNoShowCount(int userIdx);
	 int getReviewCount(int userIdx);
     int getPostCount(int userIdx);
     int getCommentCount(int userIdx);
     //전체 유저 수 조회
     int getTotCnt();
//     //이메일 검색 유저수
//     int getEmailTotCnt();
//     //이름 검색 유저수
//     int getNameTotCnt();
//     //전화번호 검색 유저수
//     int getPhoneTotCnt();
//     int getTotalCountByCondition(String searchType, String searchKeyword, int begin, int end);
	int getTotalCountByCondition( Map<String, Object> params);
}
