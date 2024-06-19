package com.todoc.membership;

import com.todoc.user.UserVO;

public interface UserMembershipService {
	void insertUserMembership(UserMembershipVO vo);
	void updateUserCondition(UserVO uvo);
	UserMembershipVO getMembership(UserMembershipVO umo);
}
