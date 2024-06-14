package com.todoc.view.admin.usermanage;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

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
		conditionMap.put("닉네임", "NICKNAME");
		conditionMap.put("이름", "NAME");
		return conditionMap;
	}
	
	
	//회원관리 페이지 이동 (전체 회원 조회)
	@RequestMapping("/getUserList.do")
	public String getUserListView(@ModelAttribute("vo") UserVO vo, Model model) {
		List<UserVO> getUserList = userService.getUserList(vo);
		model.addAttribute("getUserList", getUserList);
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
	public String userReservPage(@RequestParam("userIdx") int userIdx, Model model) {
		//회원 예약 리스트 가져오기
    	List<ReservationVO> userReserList = reservationService.userReserList(userIdx);
    	//변환된 시간 추가
    	for (int i = 0; i < userReserList.size(); i++) {
    		String formattedTime = userReserList.get(i).getReserTime().toString().substring(0, 5);
    		userReserList.get(i).setFormattedTime(formattedTime);
    	}
    	System.out.println("userReserList : " + userReserList);
    	
    	model.addAttribute("userReserList", userReserList);

    	
    	return "admin/userReservPage";
	}
	

	

	
	
	

}
