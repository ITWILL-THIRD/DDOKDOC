package com.todoc.hospital;

import java.util.List;

public interface HospitalService {
	void insertHospital(HospitalVO vo);
	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	HospitalVO getHospital(HospitalVO vo);
	List<HospitalVO> getHospitalList(HospitalVO vo);
}
