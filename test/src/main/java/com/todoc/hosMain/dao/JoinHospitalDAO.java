package com.todoc.hosMain.dao;

import java.util.List;

import com.todoc.hosMain.JoinHospitalVO;
import com.todoc.hosMain.hospitalVO;

public interface JoinHospitalDAO {
	
	JoinHospitalVO selectOne(hospitalVO vo);
	List<JoinHospitalVO> selectList();
}
