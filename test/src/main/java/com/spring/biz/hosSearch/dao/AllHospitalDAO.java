package com.spring.biz.hosSearch.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.spring.biz.hosSearch.AllHospitalVO;

@Repository
public interface AllHospitalDAO {
	List<AllHospitalVO> getAllList(String category, String keyword);
}
