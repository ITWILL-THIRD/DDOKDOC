package com.todoc.membership.dao;

import com.todoc.hospital.HospitalVO;
import com.todoc.membership.HosMembershipVO;

public interface HosMembershipDAO {
	void insertHosMembership(HosMembershipVO vo);
	void updateHosCondition(HospitalVO vo);
	HosMembershipVO getHosMembership(HosMembershipVO hmo);
}
