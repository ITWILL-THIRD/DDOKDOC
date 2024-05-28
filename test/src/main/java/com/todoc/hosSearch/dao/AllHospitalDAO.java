package com.todoc.hosSearch.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.todoc.hosSearch.AllHospitalVO;

@Repository
public interface AllHospitalDAO {
	List<AllHospitalVO> getHosList(String category, String keyword);
}
