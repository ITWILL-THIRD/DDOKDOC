package com.todoc.view.hospital;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.todoc.common.Paging;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RestController
public class HospitalAjaxController {
	@Autowired
	private HospitalService hospitalService;

	public HospitalAjaxController(HospitalService hospitalService) {
		System.out.println("===> HospitalSearchController(HospitalService) 객체 생성!!");
		System.out.println(">> HospitalService hospitalService : " + hospitalService);
		this.hospitalService = hospitalService;
	}

	//병원 동적 조회
	@RequestMapping(value = "hospital/getHosSearch.do", method = RequestMethod.GET, 
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public Map<String, Object> getAjaxHosList(HospitalVO vo, HttpServletRequest request) {
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		System.out.println("전체 게시물 수량 전 vo : " + vo);
		p.setTotalRecord(hospitalService.ajaxPaymentCnt(vo));
		p.setTotalPage();
		System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
		System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
		
		//2. 현재 페이지 번호 구하기
		String cPage = request.getParameter("cPage");
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
		}
		System.out.println("> cPage : " + cPage);
		System.out.println("> Paging nowPage : " + p.getNowPage());
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		System.out.println(">> 시작번호(begin) : " + p.getBegin());
		System.out.println(">> 끝번호(end) : " + p.getEnd());
		int begin = p.getBegin();
		int end = p.getEnd();
		
		//4. 블록(block) 계산하기
		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		p.setNowBlock(nowBlock);
		p.setEndPage(nowBlock * p.getPagePerBlock());
		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		System.out.println(">> nowBlock : " + p.getNowBlock());
		System.out.println(">> beginPage : " + p.getBeginPage());
		System.out.println(">> endPage : " + p.getEndPage());
		
		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
			System.out.println(">> 정정 후 endPage : " + p.getEndPage());
		}
		
		List<HospitalVO> hospitalList = hospitalService.getHosSearchPage(vo, begin, end);
		
		Map<String, Object> response = new HashMap<String, Object>();
	    response.put("hospitalList", hospitalList);
	    response.put("paging", p);
	    
	    return response;
	}
	
	//리뷰 동적 조회
	@RequestMapping(value = "hospital/getHosReview.do", method = RequestMethod.GET, 
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public List<HosReviewVO> getHosReview(int hosIdx) {
		System.out.println("==== HospitalSearchAjaxController.getHosReview() 실행");

		List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
		return reviewList;
	}
	
}
