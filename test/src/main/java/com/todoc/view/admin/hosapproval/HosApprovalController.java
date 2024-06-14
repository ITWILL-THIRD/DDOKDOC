package com.todoc.view.admin.hosapproval;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.admin.hosapproval.HosApprovalService;
import com.todoc.common.Paging;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;

@RequestMapping("/admin")
@Controller
public class HosApprovalController {
	@Autowired
	HosApprovalService hosApprovalService;
//	@Autowired
//	HospitalService hospitalService;
	
	//병원 전체 조회
	@RequestMapping("/getHosApprovalList.do")
	public String approvalMain(HospitalVO vo, HttpServletRequest request, Model model
					, @RequestParam(value = "beginDate", required = false) String beginDate
					, @RequestParam(value = "endDate", required = false) String endDate
					, @RequestParam(value = "condition", required = false) String condition
					) {
		System.out.println(">> HosHosApprovalController approvalMain() 실행");

		System.out.println("beginDate : " + beginDate);
		System.out.println("endDate : " + endDate);
		System.out.println("condition : " + condition);
		
		//병원 조건별 검색(승인전,승인완료,결제완료)
		if (condition != null && !condition.isEmpty()) {
			vo.setCondition(condition);
		}
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		p.setTotalRecord(hosApprovalService.getTotCnt());
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
		List<HospitalVO> hosList = hosApprovalService.getHosListPage(vo, beginDate, endDate, condition, begin, end);
		System.out.println(">> 병원 목록 조회 hosList : " + hosList);
		
		model.addAttribute("hosList", hosList);
		model.addAttribute("pagingVO", p);
		model.addAttribute("beginDate", beginDate);
		model.addAttribute("endDate", endDate);
		model.addAttribute("condition", condition);
		
//		//병원승인 동적 검색 전체 목록 + 페이징
//		List<HospitalVO> hosList = hosApprovalService.getHospitalListPage(vo, begin, end);
//		System.out.println(">> 병원 목록 조회 hosList : " + hosList);
//		
//		model.addAttribute("hosList", hosList);
//		model.addAttribute("pagingVO", p);
//		
		return "admin/getHosApprovalList";
	}
	
	//병원 정보 및 사업자등록증 승인 버튼 클릭
	@RequestMapping("/approvalBtn.do")
	public String approvalClick(@ModelAttribute("hosIdx") int hosIdx, HospitalVO vo, Model model) {
		System.out.println(">> approvalClick() 메소드 실행~~");
		System.out.println("hosIdx : " + hosIdx);
		
		int clickCnt = hosApprovalService.updateHospital(vo);
		System.out.println("clickCnt 승인 수락 : " + clickCnt);
		System.out.println("vo.getCondition() : " + vo.getCondition());
		
		if (clickCnt == 1) {
			System.out.println("승인 수락 완료!!");
			model.addAttribute("condition", vo.getCondition());
			return "admin/approvalPro";
		} else {
			System.out.println("승인 수락 실패!!");
			model.addAttribute("approvalFail", "승인 수락을 실패했습니다.");
			return "admin/getHosApprovalList";
		}
	}
}
