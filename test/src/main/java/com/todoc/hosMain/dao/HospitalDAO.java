package com.todoc.hosMain.dao;

import java.util.List;

import com.todoc.hosMain.HospitalVO;

public interface HospitalDAO {
	
	List<HospitalVO> selectList();
	HospitalVO selectOne(int hosIdx);
}
