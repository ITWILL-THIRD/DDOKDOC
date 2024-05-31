package com.todoc.user.dao;

import com.todoc.user.HospitalVO;

public interface HosDAO {
	HospitalVO getHos(HospitalVO ho);
	void insertHos(HospitalVO vo);
	int hosId(HospitalVO ho) throws Exception;
}
