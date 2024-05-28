package com.todoc.hospital.dao;

import java.util.List;

import com.todoc.hospital.HospitalVO;

public interface HospitalDAO {
	void insertHospital(HospitalVO vo);
	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	HospitalVO getHospital(HospitalVO vo);
	List<HospitalVO> getHospitalList(HospitalVO vo);
}
