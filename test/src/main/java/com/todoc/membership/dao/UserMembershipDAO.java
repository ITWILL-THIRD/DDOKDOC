package com.todoc.membership.dao;

import com.todoc.membership.UserMembershipVO;
import com.todoc.user.UserVO;

public interface UserMembershipDAO {
	void insertUserMembership(UserMembershipVO vo);
	void updateUserCondition(UserVO uvo);
	UserMembershipVO getMembership(UserMembershipVO umo);
}
