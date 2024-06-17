package com.todoc.admin.hosapproval.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.admin.hosapproval.HosApprovalService;
import com.todoc.admin.hosapproval.dao.HosApprovalDAO;
import com.todoc.hospital.HospitalVO;

@Service("hosApprovalService")
public class HosApprovalServiceImpl implements HosApprovalService{
	@Autowired
	private HosApprovalDAO hosApprovalDAO;
	
	public HosApprovalServiceImpl() {
		System.out.println(">> HosApprovalServiceImpl() 객체 생성");
	}
	
	//전체 병원 건수 cnt 조회
	@Override
	public int getTotCnt() {
		return hosApprovalDAO.getTotCnt();
	}
	//병원승인 동적 검색 전체 목록 + 페이징
	@Override
	public List<HospitalVO> getHosListPage(HospitalVO vo
				, String beginDate, String endDate, String condition
				,  int begin, int end) {
		if (beginDate != null && endDate != null) {
			//동적 검색(가입일자별) + 페이징 적용
			System.out.println(":: hosApprovalDAO.getHosSearchPage(map)-날짜 검색");
			Map<String, Object> map = new HashMap<String, Object>();
			String yearBegin = beginDate.substring(0, 4);
			String monthBegin = beginDate.substring(5, 7);
			String dayBegin = beginDate.substring(8);
			String beginDateStr = yearBegin + monthBegin + dayBegin;
			String yearEnd = endDate.substring(0, 4);
			String monthEnd = endDate.substring(5, 7);
			String dayEnd = endDate.substring(8);
			String endDateStr = yearEnd + monthEnd + dayEnd;
			map.put("beginDate", beginDateStr);
			map.put("endDate", endDateStr);
			map.put("begin", begin);
			map.put("end", end);
			System.out.println("map : " + map);
			
			return hosApprovalDAO.getHosSearchPage(map);
			
		} else if (condition != null) { 
			//동적 검색(병원 상태별) + 페이징 적용
			System.out.println(":: hosApprovalDAO.getHosSearchPage(map)-상태 검색");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("condition", condition);
			map.put("begin", begin);
			map.put("end", end);
			System.out.println("map : " + map);
			
			return hosApprovalDAO.getHosSearchPage(map);
			
		} else {
			//페이징만 적용
			System.out.println(":: hosApprovalDAO.getHosListPage(map)-페이징");
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("begin", begin);
			map.put("end", end);
			System.out.println("map : " + map);
			return hosApprovalDAO.getHosListPage(map);
		}
	}
//	//병원승인 동적 검색 전체 목록 + 페이징
//	@Override
//	public List<HospitalVO> getHosListPage(HospitalVO vo, int begin, int end) {
//		return hosApprovalDAO.getHosListPage(vo, begin, end);
//	}
//	//병원승인 동적 검색 전체 목록 + 페이징
//	@Override
//	public List<HospitalVO> getHosSearchPage(HospitalVO vo, int begin, int end) {
//		return hosApprovalDAO.getHosSearchPage(vo, begin, end);
//	}
	//병원 승인(승인완료)
	@Override
	public int updateHospital(HospitalVO vo) {
		return hosApprovalDAO.updateHospital(vo);
	}

	
}