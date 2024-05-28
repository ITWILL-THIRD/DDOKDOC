package com.todoc.biz.hospital.dao;

import java.util.List;

import com.todoc.biz.hospital.HospitalVO;

public interface HospitalDAO {
	void insertHospital(HospitalVO vo);
	void updateHospital(HospitalVO vo);
	void deleteHospital(HospitalVO vo);
	HospitalVO getHospital(HospitalVO vo);
	List<HospitalVO> getHospitalList(HospitalVO vo);
}
