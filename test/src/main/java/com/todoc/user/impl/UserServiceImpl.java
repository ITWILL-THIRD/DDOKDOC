package com.todoc.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	 //이메일 찾기
	 public UserVO findEmail(UserVO vo) {
		 return userDAO.findEmail(vo);
	 }
	 //비번찾기
	 public int findPwd(UserVO vo) {
		 return userDAO.findPwd(vo);
	 }
	 //임시비번 할당 후 업데이트
	 public void updateExPwd(UserVO vo) {
		 userDAO.updateExPwd(vo);
		 
	 }
	 //관리자 전체회원조회(건수포함)
	 public List<UserVO> getUserList(UserVO vo, String searchType, String searchKeyword, int begin, int end) {
		 
		 Map<String, Object> map = new HashMap<>();
		    map.put("vo", vo);
		    map.put("searchType", searchType);
		    map.put("searchKeyword", searchKeyword);
		    map.put("begin", begin);
		    map.put("end", end);
		    
		    
		    
		 List<UserVO> userList = userDAO.getUserList(map);
	        for (UserVO user : userList) {
	            int userIdx = user.getUserIdx();
	            user.setReserCount(userDAO.getReserCount(userIdx));
	            user.setFinishCount(userDAO.getFinishCount(userIdx));
	            user.setNoShowCount(userDAO.getNoShowCount(userIdx));
	            user.setReviewCount(userDAO.getReviewCount(userIdx));
	            user.setPostCount(userDAO.getPostCount(userIdx));
	            user.setCommentCount(userDAO.getCommentCount(userIdx));
	        }
	        return userList;
	 }
	 //관리자 제외 전체 유저 수
	 public int getTotCnt() {
		 return userDAO.getTotCnt();
	 }
//	//이메일 검색 유저수
//     public int getEmailTotCnt(String searchKeyword) {
//    	 return userDAO.getEmailTotCnt();
//     }
//     //이름 검색 유저수
//     public int getNameTotCnt(String searchKeyword) {
//    	 return userDAO.getNameTotCnt();
//     }
//     //전화번호 검색 유저수
//     public int getPhoneTotCnt(String searchKeyword) {
//    	 return userDAO.getPhoneTotCnt();
//     }
	 
	 public int getUserCountByCondition(String searchType, String searchKeyword) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("searchType", searchType);
	        params.put("searchKeyword", searchKeyword);

	        return userDAO.getTotalCountByCondition(params);
	    }

}
