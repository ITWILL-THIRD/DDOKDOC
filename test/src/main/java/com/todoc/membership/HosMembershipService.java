package com.todoc.membership;

import com.todoc.hospital.HospitalVO;

public interface HosMembershipService {
	void insertHosMembership(HosMembershipVO vo);
	void updateHosCondition(HospitalVO vo);
	HosMembershipVO getHosMembership(HosMembershipVO hmo);
}
