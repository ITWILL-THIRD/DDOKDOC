package com.todoc.view.admin.usermanage;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.todoc.board.BoardService;
import com.todoc.board.BoardVO;
import com.todoc.board.CommentVO;
import com.todoc.common.Paging;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@RequestMapping("/admin")
@Controller
public class UserManageController {
	@Autowired
	UserService userService;
	@Autowired
	HospitalService hospitalService;
	@Autowired
	BoardService boardService;
	@Autowired
	private MyPetService myPetService;
	@Autowired
	private ReservationService reservationService;
	
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		System.out.println(">>conditionMap 실행");
		Map<String, String> conditionMap =  new LinkedHashMap<>();
		conditionMap.put("이메일", "EMAIL");
		conditionMap.put("이름", "NAME");
		conditionMap.put("전화번호", "PHONE");
		return conditionMap;
	}
	
	
	//회원관리 페이지 이동 (전체 회원 조회)
	@RequestMapping("/getUserList.do")
	public String getUserListView(@ModelAttribute("vo") UserVO vo, 
            @RequestParam(value="searchType", required = false) String searchType,
            @RequestParam(value="searchKeyword", required = false) String searchKeyword, 
            Model model, 
            HttpServletRequest request) {
		Paging p = new Paging();
		
		 // 검색 조건을 포함하여 전체 회원 수를 가져옴
	    p.setTotalRecord(userService.getUserCountByCondition(searchType, searchKeyword));
		
//		p.setTotalRecord(userService.getTotCnt());
		p.setTotalPage();
		System.out.println(">전체 게시글 수 : " + p.getTotalRecord());
		System.out.println(">전체 페이지 수 : " + p.getTotalPage());
		
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
		
		List<UserVO> getUserList = userService.getUserList(vo, searchType, searchKeyword, begin, end);
		model.addAttribute("getUserList", getUserList);
		model.addAttribute("pagingVO", p);
		return "admin/getUserList";
	}
	
	@RequestMapping("/userReviewList.do")
	public String userReviewList(@RequestParam("userIdx") int userIdx, Model model, HttpSession session) {
		//리뷰 리스트 가져오기
		List<HosReviewVO> userReviewList = hospitalService.myReviewList(userIdx);
		model.addAttribute("userReviewList", userReviewList);
		return "admin/userReviewList";
	}
		
	@RequestMapping("/userPostList.do")
	public String userPostList(@RequestParam("userIdx") int userIdx, Model model, HttpSession session) {
		
		//게시물 리스트 가져오기
    	List<BoardVO> userPostList = boardService.myPostList(userIdx);
    	
    	 // 날짜 변환
        SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (BoardVO board : userPostList) {
	        String formattedDate = targetFormat.format(board.getPostdate());
	        board.setFormattedDate(formattedDate);
	    }
    	
    	model.addAttribute("userPostList", userPostList);
		
		return "admin/userPostList";
	}
	@RequestMapping("/userPostDetail.do")
	public String userPostDetail(BoardVO vo, CommentVO co,  Model model) {
		// 게시글 상세 조회
        BoardVO board = boardService.getBoard(vo);
        List<CommentVO> comments = boardService.getCommentList(co);
        co.setPostidx(vo.getPostidx());
        
     // 날짜 변환
        SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");

        String formattedDate = targetFormat.format(board.getPostdate());
        board.setFormattedDate(formattedDate);
        
        // 댓글 날짜 변환
        for (CommentVO comment : comments) {
            String formattedCommentDate = targetFormat.format(comment.getCommentdate());
            comment.setFormattedCommentDate(formattedCommentDate);
        }
        
        model.addAttribute("board", board); // Model에 데이터 저장
        model.addAttribute("comments", comments);
        
		return "admin/userPostDetail";
	}
	
	@RequestMapping("/userCommentList.do")
	public String userCommentList(CommentVO co, @RequestParam("userIdx") int userIdx, Model model, HttpSession session) {
		
		//댓글 리스트 가져오기
		List<CommentVO> userCommentList = boardService.myCommentList(userIdx);
		
		 // 날짜 변환
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");

        // 댓글 날짜 변환
        for (CommentVO comment : userCommentList) {
            String formattedCommentDate = targetFormat.format(comment.getCommentdate());
            comment.setFormattedCommentDate(formattedCommentDate);
        }
		
		model.addAttribute("userCommentList", userCommentList);
		return "admin/userCommentList";
	}
	
	@RequestMapping("/userMypage.do")
	public String userMypage(@RequestParam("userIdx") int userIdx, Model model) {
		//회원정보 가져오기
		UserVO userMypage = userService.getUserInfo(userIdx);
		model.addAttribute("user", userMypage);
		//회원 마이펫 정보 가져오기
		List<MyPetVO> pets = myPetService.getMyPetList(userIdx);
    	model.addAttribute("pets", pets);
		return "admin/userMypage";
	}
	
	@RequestMapping("/userReservPage.do")
	public String userReservPage(@ModelAttribute("vo") ReservationVO vo,@RequestParam(name = "userIdx", required = true) int userIdx, 
            @RequestParam(value = "condition", required = false) String condition, 
            Model model, HttpServletRequest request) {
		Paging p = new Paging();
		
		//카테고리 조건 포함하여 전체 예약 가져옴
		p.setTotalRecord(reservationService.getResTotCntByCondition(userIdx, condition));
		p.setTotalPage();
		System.out.println(">전체 게시글 수 : " + p.getTotalRecord());
		System.out.println(">전체 페이지 수 : " + p.getTotalPage());

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
		
//	    // 파라미터를 Map에 담아 전달
//	    Map<String, Object> params = new HashMap<>();
//	    params.put("condition", condition);
//	    params.put("begin", begin);
//	    params.put("end", end);
	   
		//회원 예약 리스트 가져오기
    	List<ReservationVO> userReserList = reservationService.userReserList(vo, userIdx, condition, begin, end);
    	//변환된 시간 추가
    	for (int i = 0; i < userReserList.size(); i++) {
    		String formattedTime = userReserList.get(i).getReserTime().toString().substring(0, 5);
    		userReserList.get(i).setFormattedTime(formattedTime);
    	}
    	System.out.println("userReserList : " + userReserList);
    	
    	model.addAttribute("userReserList", userReserList);
    	model.addAttribute("userIdx", userIdx);
    	model.addAttribute("pagingVO", p);
    	model.addAttribute("condition", condition);
    	
    	return "admin/userReservPage";
	}
	


	
	
	

}
