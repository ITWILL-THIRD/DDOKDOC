package com.todoc.view.admin.hosapproval;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.MediaType;

import com.google.gson.Gson;
import com.todoc.admin.hosapproval.HosApprovalService;
import com.todoc.admin.hosapproval.HosApprovalVO;
import com.todoc.common.Paging;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RequestMapping("/admin")
@Controller
public class HosApprovalController {
	@Autowired
	HosApprovalService hosApprovalService;
	@Autowired
	HospitalService hospitalService;
	
	//병원 전체 조회
	@RequestMapping("/getHosApprovalList.do")
	public String approvalMain(HosApprovalVO vo, HttpServletRequest request, Model model
					, @RequestParam(value = "beginDate", required = false) String beginDate
					, @RequestParam(value = "endDate", required = false) String endDate
					, @RequestParam(value = "searchCondition", required = false) String searchCondition
					) {
		System.out.println(">> HosHosApprovalController approvalMain() 실행");

		System.out.println("beginDate : " + beginDate);
		System.out.println("endDate : " + endDate);
		System.out.println("searchCondition : " + searchCondition);
		
		//병원 조건별 검색(승인전,승인완료,결제완료)
		if (searchCondition != null && !searchCondition.isEmpty()) {
			vo.setCondition(searchCondition);
		}
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		System.out.println("전체 게시물 수량 전 vo : " + vo);
		p.setTotalRecord(hosApprovalService.getAjaxTotCnt(vo));
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
		
		//병원승인 관리[getHosApprovalList.jsp] onload시, 병원 전체목록 조회
		List<HosApprovalVO> hosList = hosApprovalService.getHosListPage(vo, beginDate, endDate, searchCondition, begin, end);
		System.out.println(">> 병원 목록 조회 hosList : " + hosList);
		
		model.addAttribute("hosList", hosList);
		model.addAttribute("pagingVO", p);
		
		return "admin/getHosApprovalList";
	}
	
	//병원 동적 조회
	@RequestMapping(value = "/getHosApprovalSearch.do")
	public String getAjaxApprovalList(HosApprovalVO vo, HttpServletRequest request, Model model
					, @RequestParam(value = "beginDate", required = false) String beginDate
					, @RequestParam(value = "endDate", required = false) String endDate
//					, @RequestParam(value = "list", required = false) List<HosApprovalVO> list
					, @RequestParam(value = "searchCondition", required = false) String searchCondition
					) {
		System.out.println(">> HosHosApprovalController getAjaxApprovalList() 실행");
		System.out.println(">> HosApprovalVO vo : " + vo);
		System.out.println("beginDate : " + beginDate);
		System.out.println("endDate : " + endDate);
//		System.out.println("hosList : " + list);
		
		//회원가입 조건별
		if (beginDate != null && beginDate != null) {
			vo.setSearchCondition("date");
			vo.setBeginDate(beginDate);
			vo.setEndDate(endDate);
		} 
		//병원 조건별 검색(승인전,승인완료,결제완료)
		if (searchCondition != null) {
			switch (searchCondition) {
            case "before":
                vo.setSearchCondition("before");
                break;
            case "after":
                vo.setSearchCondition("after");
                break;
            case "payment":
                vo.setSearchCondition("payment");
                break;
            case "all":
                vo.setSearchCondition("all");
                break;
			}
		}
		System.out.println("searchCondition : " + searchCondition);
		System.out.println(">> 페이징 전 vo.getOpenTime() : " + vo.getOpenTime());
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		int totalRecord = hosApprovalService.getAjaxTotCnt(vo);
		System.out.println("::: totalRecord 전체 수 : " + totalRecord);
		p.setTotalRecord(totalRecord);
		p.setTotalPage();
		System.out.println("> Ajax 전체 게시글 수 : " + p.getTotalRecord());
		System.out.println("> Ajax 전체 페이지 수 : " + p.getTotalPage());
		
		//2. 현재 페이지 번호 구하기
		String cPage = request.getParameter("cPage");
		if (cPage != null) {
			p.setNowPage(Integer.parseInt(cPage));
			if (p.getTotalPage() < Integer.parseInt(cPage)) {
				System.out.println("p.getTotalPage() < cPage 경우");
				p.setNowPage(p.getTotalPage());
				System.out.println("> Ajax totalPage보다 cPage가 큰 경우 : " + p.getNowPage());
			}
		}
		System.out.println("> Ajax 최종 cPage : " + cPage);
		System.out.println("> Ajax Paging nowPage : " + p.getNowPage());
		
		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		System.out.println(">> Ajax 시작번호(begin) : " + p.getBegin());
		System.out.println(">> Ajax 끝번호(end) : " + p.getEnd());
		int begin = p.getBegin();
		int end = p.getEnd();
		
		//4. 블록(block) 계산하기
		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
		p.setNowBlock(nowBlock);
		p.setEndPage(nowBlock * p.getPagePerBlock());
		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
		System.out.println(">> Ajax nowBlock : " + p.getNowBlock());
		System.out.println(">> Ajax beginPage : " + p.getBeginPage());
		System.out.println(">> Ajax endPage : " + p.getEndPage());
		
		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
		// 끝페이지를 전체페이지 수로 변경 처리
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
			System.out.println(">> Ajax 정정 후 endPage : " + p.getEndPage());
		}
		
		//병원승인 동적 검색 전체 목록 + 페이징
		List<HosApprovalVO> hosList = hosApprovalService.getHosListPage(vo, beginDate, endDate, searchCondition, begin, end);
		System.out.println(">> getAjaxApprovalList - 병원목록조회 hosList : " + hosList);
		System.out.println("p : " + p);
		
		model.addAttribute("hosList", hosList);
		model.addAttribute("pagingVO", p);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		
		return "admin/getHosApprovalList";
	}
	
//	//병원 동적 조회 - ajax 파싱 오류
//	@RequestMapping(value = "/getHosApprovalSearch.do", method = RequestMethod.GET
//			, produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
//	public String getAjaxApprovalList(HosApprovalVO vo, HttpServletRequest request, Model model
//					, @RequestParam(value = "beginDate", required = false) String beginDate
//					, @RequestParam(value = "endDate", required = false) String endDate
//					, @RequestParam(value = "list", required = false) String list
//					, @RequestParam(value = "searchCondition", required = false) String searchCondition
//					) {
//		System.out.println(">> HosHosApprovalController getAjaxApprovalList() 실행");
//		System.out.println(">> HosApprovalVO vo : " + vo);
//		System.out.println("beginDate : " + beginDate);
//		System.out.println("endDate : " + endDate);
//		System.out.println("hosList : " + list);
//		
//		//회원가입 조건별
//		if (beginDate != null && beginDate != null) {
//			vo.setSearchCondition("date");
//			vo.setBeginDate(beginDate);
//			vo.setEndDate(endDate);
//		} 
//		//병원 조건별 검색(승인전,승인완료,결제완료)
//		if (searchCondition != null) {
//			switch (searchCondition) {
//            case "before":
//                vo.setSearchCondition("before");
//                break;
//            case "after":
//                vo.setSearchCondition("after");
//                break;
//            case "payment":
//                vo.setSearchCondition("payment");
//                break;
//            case "all":
//                vo.setSearchCondition("all");
//                break;
//			}
//		}
//		System.out.println("searchCondition : " + searchCondition);
//		System.out.println(">> 페이징 전 vo.getOpenTime() : " + vo.getOpenTime());
//		
//		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
//		Paging p = new Paging();
//		
//		//1. 전체 게시물 수량 구하기
//		int totalRecord = hosApprovalService.getAjaxTotCnt(vo);
//		System.out.println("::: totalRecord 전체 수 : " + totalRecord);
//		p.setTotalRecord(totalRecord);
//		p.setTotalPage();
//		System.out.println("> Ajax 전체 게시글 수 : " + p.getTotalRecord());
//		System.out.println("> Ajax 전체 페이지 수 : " + p.getTotalPage());
//		
//		//2. 현재 페이지 번호 구하기
//		String cPage = request.getParameter("cPage");
//		if (cPage != null) {
//			p.setNowPage(Integer.parseInt(cPage));
//			if (p.getTotalPage() < Integer.parseInt(cPage)) {
//				System.out.println("p.getTotalPage() < cPage 경우");
//				p.setNowPage(p.getTotalPage());
//				System.out.println("> Ajax totalPage보다 cPage가 큰 경우 : " + p.getNowPage());
//			}
//		}
//		System.out.println("> Ajax 최종 cPage : " + cPage);
//		System.out.println("> Ajax Paging nowPage : " + p.getNowPage());
//		
//		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
//		p.setEnd(p.getNowPage() * p.getNumPerPage());
//		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
//		System.out.println(">> Ajax 시작번호(begin) : " + p.getBegin());
//		System.out.println(">> Ajax 끝번호(end) : " + p.getEnd());
//		int begin = p.getBegin();
//		int end = p.getEnd();
//		
//		//4. 블록(block) 계산하기
//		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
//		int nowBlock = (p.getNowPage() - 1) / p.getPagePerBlock() + 1;
//		p.setNowBlock(nowBlock);
//		p.setEndPage(nowBlock * p.getPagePerBlock());
//		p.setBeginPage(p.getEndPage() - p.getPagePerBlock() + 1);
//		System.out.println(">> Ajax nowBlock : " + p.getNowBlock());
//		System.out.println(">> Ajax beginPage : " + p.getBeginPage());
//		System.out.println(">> Ajax endPage : " + p.getEndPage());
//		
//		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
//		// 끝페이지를 전체페이지 수로 변경 처리
//		if (p.getEndPage() > p.getTotalPage()) {
//			p.setEndPage(p.getTotalPage());
//			System.out.println(">> Ajax 정정 후 endPage : " + p.getEndPage());
//		}
//		
//		//병원승인 동적 검색 전체 목록 + 페이징
//		List<HosApprovalVO> hosList = hosApprovalService.getHosListPage(vo, beginDate, endDate, searchCondition, begin, end);
//		System.out.println(">> getAjaxApprovalList - 병원목록조회 hosList : " + hosList);
//		System.out.println("p : " + p);
//		
//		model.addAttribute("hosList", hosList);
//		model.addAttribute("pagingVO", p);
//		model.addAttribute("searchCondition", searchCondition);
//		model.addAttribute("beginDate", beginDate);
//		model.addAttribute("endDate", endDate);
//		
//		return "admin/getHosApprovalList";
//	}
	
	//병원 정보 및 사업자등록증 승인 버튼 클릭
	@RequestMapping("/approvalPro.do")
	public String aprrovalClick(HosApprovalVO hosptial, Model model) {
		System.out.println(">> approvalClick() 메소드 실행~~");
		System.out.println("hosptial : " + hosptial);
		
		int clickCnt = hosApprovalService.updateApproval(hosptial.getHosIdx());
		
		System.out.println("hosptial.getHosIdx() : " + hosptial.getHosIdx()
							+ ", clickCnt : " + clickCnt);
		
		if (clickCnt == 1) {
			System.out.println("승인 수락 완료!!");
		} else {
			System.out.println("이미 승인완료된 건입니다!!");
		}
		return "redirect:../admin/getHosApprovalList.do";
	}
	//병원 정보 및 사업자등록증 승인 버튼 클릭 - ajax 컨트롤러 파싱X
	@RequestMapping(value = "/approvalBtn.do", method = RequestMethod.GET, consumes = "application/json")
	@ResponseBody
	public String approvalAjax(@RequestBody HosApprovalVO hosptial, Model model) {
		System.out.println(">> approvalAjax() 메소드 실행~~");
		System.out.println("hosptial : " + hosptial);
		
		int clickCnt = hosApprovalService.updateApproval(hosptial.getHosIdx());
		
		if (clickCnt == 1) {
			System.out.println("승인 수락 완료!!");
		} else if (clickCnt == 0) {
			System.out.println("이미 승인완료된 건입니다!!");
		} else {
			System.out.println("승인 처리가 안됐습니다!");
		}
		
		// 승인 리스트를 JSON 형식으로 반환
		List<HospitalVO> approvalList = hospitalService.selectList();
		return new Gson().toJson(approvalList);
	}
}
