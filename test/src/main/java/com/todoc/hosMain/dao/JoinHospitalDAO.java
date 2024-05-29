package com.todoc.hosMain.dao;

import java.util.List;

import com.todoc.hosMain.JoinHospitalVO;

public interface JoinHospitalDAO {
	
	List<JoinHospitalVO> selectList();
	JoinHospitalVO selectOne(int hosIdx);
}
