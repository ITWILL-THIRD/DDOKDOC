package com.todoc.membership.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.hospital.HospitalVO;
import com.todoc.membership.HosMembershipService;
import com.todoc.membership.HosMembershipVO;
import com.todoc.membership.dao.HosMembershipDAO;

@Service("hosmembershipService")
public class HosMembershipServiceImpl  implements HosMembershipService{
	@Autowired
	private HosMembershipDAO hosMembershipMapper;
	
	public HosMembershipServiceImpl() {
		System.out.println(">> HosMembershipServiceImpl() 객체생성");
	}
	@Override
	public void insertHosMembership(HosMembershipVO vo) {
		hosMembershipMapper.insertHosMembership(vo);
	}
	@Override
	public void updateHosCondition(HospitalVO vo) {
		hosMembershipMapper.updateHosCondition(vo);
	}
}
