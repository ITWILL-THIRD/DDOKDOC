package com.todoc.membership.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.membership.UserMembershipService;
import com.todoc.membership.UserMembershipVO;
import com.todoc.membership.dao.UserMembershipDAO;


@Service("usermembershipService")
public class UserMembershipServiceImpl implements UserMembershipService {

	@Autowired
	private UserMembershipDAO userMembershipMapper;
	
	@Override
	public void insertUserMembership(UserMembershipVO vo) {
		userMembershipMapper.insertUserMembership(vo);
	}


}
