package com.todoc.hospital.dao;

import java.util.List;

import com.todoc.hospital.HospitalVO;

public interface HospitalDAO {
	
	List<HospitalVO> selectList();
	HospitalVO selectOne(int hosIdx);
	List<HospitalVO> getHosSearch(HospitalVO vo);
}