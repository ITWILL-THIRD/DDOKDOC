package com.todoc.view.mypage;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.todoc.board.BoardService;
import com.todoc.board.BoardVO;
import com.todoc.board.CommentVO;
import com.todoc.common.Paging;
import com.todoc.googlecloudstorage.GCSService;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
import com.todoc.membership.UserMembershipService;
import com.todoc.membership.UserMembershipVO;
import com.todoc.mypet.MyPetService;
import com.todoc.mypet.MyPetVO;
import com.todoc.reservation.ReservationService;
import com.todoc.reservation.ReservationVO;
import com.todoc.user.UserService;
import com.todoc.user.UserVO;

@RequestMapping("/mypage")
@Controller
public class MyPageController {
	@Autowired
	private UserService userService;
	@Autowired
	@Qualifier("hospitalService")
	private HospitalService hospitalService;
	@Autowired
    @Qualifier("gcsService")
    private GCSService gcsService;
	@Autowired
	private MyPetService myPetService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private UserMembershipService userMembershipService;
	
	
	
	@GetMapping("/updateUser.do")
	public String updateUserView(@RequestParam("userIdx") int userIdx, Model model, HttpSession session) {
		System.out.println(">> 내 정보 수정페이지");
	    UserVO vo = userService.getUserInfo(userIdx);
	    session.setAttribute("user", vo);
		
	    model.addAttribute("user", vo); 
	   
	    return "mypage/updateUser";
	}
	//정보수정
	@PostMapping("/updateUser.do")
	public String updateUser(@RequestParam("file") MultipartFile file, @ModelAttribute("user") UserVO vo, HttpSession session) {
	    try {
	    	UserVO user = (UserVO) session.getAttribute("user");
	    	vo.setUserIdx(user.getUserIdx());
	    	if (!file.isEmpty()) {
	    		String userImg = gcsService.uploadFile(file);
	    		vo.setUserImg(userImg);
	    	} else {
	    		vo.setUserImg(user.getUserImg()); // 기존 이미지 유지
	    	}
	    	vo.setCondition(user.getCondition());
            System.out.println("내 정보 수정");
            System.out.println("vo : " + vo);
            userService.updateUser(vo);
            vo.setRole("user");
            session.setAttribute("user", vo); 
            return "redirect:myPage.do";
	    } catch (IOException e) {
            e.printStackTrace();
            return "mypage/updateUser";
        }
	}
	
	@RequestMapping("/updatePwd.do")
	public String updatePwdView(@RequestParam("userIdx") int userIdx, Model model) {
		System.out.println(">>비밀번호 수정 페이지");
		UserVO vo = userService.getUserInfo(userIdx);
	    model.addAttribute("vo", vo);
	    return "mypage/updatePwd";
	}

	//비번수정
	@PostMapping("/updatePwd.do")
	public String updatePwd(@RequestParam("userIdx") int userIdx, 
	                        @RequestParam("currentPassword") String currentPassword,
	                        @RequestParam("password") String newPassword, 
	                        HttpSession session, Model model) {
	    UserVO user = userService.getUserInfo(userIdx);

	    if (user == null || !user.getPassword().equals(currentPassword)) {
	        model.addAttribute("error", "현재 비밀번호가 일치하지 않습니다.");
	        return "mypage/updatePwd";
	    }

	    user.setPassword(newPassword);
	    userService.updatePwd(user);
	    System.out.println("updatePwd : " + user);
	    session.setAttribute("user", user); 

	    return "redirect:updateUser.do?userIdx=" + userIdx; 
	}
	//회원탈퇴
	@PostMapping("/deleteUser.do")
	public String deleteUser(@RequestParam("userIdx") int userIdx, HttpSession session) {
		userService.deleteUser(userIdx);
		session.invalidate();
		System.out.println(">> 탈퇴 완료");
		return "redirect:/index.jsp?msg=delete";
	}
	//메인페이지로 이동
	@RequestMapping("/index.do")
	public String index() {
		return "redirect:/index.jsp";
	}
	
	//마이페이지
    @RequestMapping("/myPage.do")
    public String myPage(Model model, HttpSession session) {
    	UserVO user = (UserVO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:/index.jsp"; // 로그인 정보가 없으면 로그인 페이지로 리다이렉트 처리
    	}
    	UserMembershipVO umo = new UserMembershipVO();
	    umo.setUserIdx(user.getUserIdx()); // 세션에서 가져온 user의 userIdx를 설정
	    umo = userMembershipService.getMembership(umo);
	    
	    // 마이펫 조회
	    List<MyPetVO> pets = myPetService.getMyPetList(user.getUserIdx());
	    model.addAttribute("pets", pets);
	    model.addAttribute("umo", umo);
	    model.addAttribute("user", user);
	    
	    // 멤버십 정보가 없을 경우 처리
	    if (umo == null) {
	        return "mypage/myPage"; // 멤버십 정보가 없을 때의 페이지로 이동
	    }
	    // 날짜 변환
	    SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd ");

	    String startFormattedDate = targetFormat.format(umo.getMemstart());
	    String endFormattedDate = targetFormat.format(umo.getMemend());
	    umo.setStartformattedDate(startFormattedDate);
	    umo.setEndformattedDate(endFormattedDate);

        return "mypage/myPage";
    }
    
    //예약 리스트
    @RequestMapping("/myReserList.do")
    public String myReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	System.out.println(user.getUserIdx());
    	List<ReservationVO> myReserList = reservationService.myReserList(user.getUserIdx());
    	System.out.println(myReserList);

    	//변환된 시간 추가
    	for (int i = 0; i < myReserList.size(); i++) {
    		String formattedTime = myReserList.get(i).getReserTime().toString().substring(0, 5);
    		ReservationVO rvo = myReserList.get(i);
    		rvo.setFormattedTime(formattedTime);
    		System.out.println(formattedTime);
    		myReserList.set(i, rvo);
    		System.out.println("myReserList : " + myReserList);
    		
    	}
    	
    	System.out.println("myReserList : " + myReserList);
    	model.addAttribute("myReserList", myReserList);
    	
    	return "mypage/myReserList";
    }
    
    //지난예약리스트
    @RequestMapping("/myOldReserList.do")
    public String myOldReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	List<ReservationVO> myOldReserList = reservationService.myOldReserList(user.getUserIdx());
    	
    	//변환된 시간 추가
    	for (int i = 0; i < myOldReserList.size(); i++) {
    		String formattedTime = myOldReserList.get(i).getReserTime().toString().substring(0, 5);
    		myOldReserList.get(i).setFormattedTime(formattedTime);
    	}
    	
    	model.addAttribute("myOldReserList", myOldReserList);
    	
    	return "mypage/myOldReserList";
    }
    
    //취소한 예약 리스트
    @RequestMapping("/myCancleReserList.do")
    public String myCancleReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	List<ReservationVO> myCancleReserList = reservationService.myCancleReserList(user.getUserIdx());
    	
    	//변환된 시간 추가
    	for (int i = 0; i < myCancleReserList.size(); i++) {
    		String formattedTime = myCancleReserList.get(i).getReserTime().toString().substring(0, 5);
    		myCancleReserList.get(i).setFormattedTime(formattedTime);
    	}
    	
    	model.addAttribute("myCancleReserList", myCancleReserList);
    	
    	return "mypage/myCancleReserList";
    }
    
    //내 작성 게시물 리스트
    @RequestMapping("/myPostList.do")
    public String myPostList(BoardVO vo, @RequestParam(value = "category", required = false) String category, Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//게시물 리스트 가져오기
    	List<BoardVO> myPostList = boardService.myPostList(user.getUserIdx());
    	
    	 // 날짜 변환
        SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (BoardVO board : myPostList) {
	        String formattedDate = targetFormat.format(board.getPostdate());
	        board.setFormattedDate(formattedDate);
	    }
    	
    	model.addAttribute("myPostList", myPostList);
    	
    	return "mypage/myPostList";
    }
    @RequestMapping("/myPostDetail.do")
    public String myPostDetail(BoardVO vo, CommentVO co,  Model model) {
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
    	return "mypage/myPostDetail";
    }
    
    // (개인)리뷰 목록 조회
 	@RequestMapping("/myReviewList.do")
 	public String myReviewList(Model model, HttpSession session) {
		System.out.println("::마이페이지-리뷰리스트");
		UserVO user = (UserVO) session.getAttribute("user");
		int userIdx = 0;
		if (user != null) {
		    userIdx = user.getUserIdx();
		}
		
		model.addAttribute("userIdx", userIdx);
		
		
		//작성할 리뷰 목록
		List<HosReviewVO> reviewToWrite = hospitalService.getReviewToWrite(userIdx);
		model.addAttribute("reviewToWrite",reviewToWrite);
		
		//작성한 리뷰 목록
		List<HosReviewVO> myReviewList = hospitalService.getReviewList(userIdx);
		model.addAttribute("myReviewList", myReviewList);
		
		return "mypage/myReviewList";
 	}
 	
 	// (개인)리뷰 목록 조회 페이징 처리할 것
// 	@RequestMapping("/myReviewList.do")
//	public String getBoardList(HttpSession session, HttpServletRequest request, Model model) {
// 		System.out.println("::마이페이지-리뷰리스트");
//		UserVO user = (UserVO) session.getAttribute("user");
//		
//		int userIdx = 0;
//		if (user != null) {
//		    userIdx = user.getUserIdx();
//		}
//		model.addAttribute("userIdx", userIdx);
//		
//		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
//		Paging pvo = new Paging();
//
//		//1. 전체 게시물 수량 구하기
////		System.out.println("전체 게시물 수량 전 vo : " + vo);
////		pvo.setTotalRecord(boardService.getAjaxTotCnt(vo));
////		pvo.setTotalPage();
////		System.out.println("> 전체 게시글 수 : " + p.getTotalRecord());
////		System.out.println("> 전체 페이지 수 : " + p.getTotalPage());
////		
//		//2. 현재 페이지 번호 구하기
//		String cPage = request.getParameter("cPage");
//		if (cPage != null) {
//			pvo.setNowPage(Integer.parseInt(cPage));
//		}
//		System.out.println("> cPage : " + cPage);
//		System.out.println("> Paging nowPage : " + pvo.getNowPage());
//		
//		//3. 현재 페이지에 표시할 게시글 시작번호(begin), 끝번호(end) 구하기
//		pvo.setEnd(pvo.getNowPage() * pvo.getNumPerPage());
//		pvo.setBegin(pvo.getEnd() - pvo.getNumPerPage() + 1);
//		System.out.println(">> 시작번호(begin) : " + pvo.getBegin());
//		System.out.println(">> 끝번호(end) : " + pvo.getEnd());
//		int begin = pvo.getBegin();
//		int end = pvo.getEnd();
//		
//		//4. 블록(block) 계산하기
//		//블록 시작페이지(beginPage), 끝페이지(endPage) - 현재페이지 번호 사용
//		int nowBlock = (pvo.getNowPage() - 1) / pvo.getPagePerBlock() + 1;
//		pvo.setNowBlock(nowBlock);
//		pvo.setEndPage(nowBlock * pvo.getPagePerBlock());
//		pvo.setBeginPage(pvo.getEndPage() - pvo.getPagePerBlock() + 1);
//		System.out.println(">> nowBlock : " + pvo.getNowBlock());
//		System.out.println(">> beginPage : " + pvo.getBeginPage());
//		System.out.println(">> endPage : " + pvo.getEndPage());
//		
//		// 끝페이지(endPage)가 전체페이지 수(totalPage) 보다 크면
//		// 끝페이지를 전체페이지 수로 변경 처리
//		if (pvo.getEndPage() > pvo.getTotalPage()) {
//			pvo.setEndPage(pvo.getTotalPage());
//			System.out.println(">> 정정 후 endPage : " + pvo.getEndPage());
//		}
//        
//		//List<BoardVO> boardList = boardService.getBoardList(vo);
//		List<BoardVO> boardList = boardService.getListPage(vo, begin, end);
//		
////		SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MM dd HH:mm:ss z yyyy");
////	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
////	    
////	    for (BoardVO board : boardList) {
////	        String formattedDate = targetFormat.format(board.getPostdate());
////	        board.setFormattedDate(formattedDate);
////	    }
//	   
//		model.addAttribute("boardList", boardList); // Model에 데이터 저장
//		model.addAttribute("pagingVO", pvo);
//
//		return "board/getBoardList";
//	}
 	
 	// (개인)리뷰 입력
 	@RequestMapping("/myReviewInsert.do")
 	public String myInsertReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
 	    System.out.println(":: 마이페이지-리뷰작성");
 	    UserVO user = (UserVO) session.getAttribute("user");
 	    int userIdx = 0;
 	    if (user != null) {
 	        userIdx = user.getUserIdx();
 	        vo.setUserIdx(userIdx);
 	    }
 	    System.out.println("vo  : " + vo);
 	    
 	    model.addAttribute("hosIdx", hosIdx);
 	    model.addAttribute("userIdx", userIdx);
 	    
 	    // 리뷰 입력
 	    hospitalService.insertReview(vo);    

 	    // 별점 평균 업데이트
 	    updateAverageScore(hosIdx);
 	    
 	    // 리뷰 작성 시 사용자 상태 업데이트 	    
 	    hospitalService.updateCondition(vo); 

 	    return "redirect:/mypage/myReviewList.do" ;
 	}

 	// (개인)리뷰 수정 
 	@RequestMapping("/myReviewUpdate.do")
 	public String updateReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
 	    System.out.println(":: 마이페이지 - 리뷰 수정");
 	    int userIdx = ((UserVO) session.getAttribute("user")).getUserIdx();
 	    vo.setUserIdx(userIdx);

 	    model.addAttribute("hosIdx", hosIdx);
 	    model.addAttribute("userIdx", userIdx);
 	    
 	    // 리뷰 수정
 	    hospitalService.updateReview(vo);

 	    // 별점 평균 업데이트
 	    updateAverageScore(hosIdx);


 	    return "redirect:/mypage/myReviewList.do";
 	}

 	// (개인)리뷰 삭제
 	@RequestMapping("/myReviewDelete.do")
 	public String deleteReview(HosReviewVO vo, @RequestParam("hosIdx") int hosIdx, Model model, HttpSession session) {
 	    System.out.println(":: 마이페이지 - 리뷰 삭제");
 	    UserVO user = (UserVO) session.getAttribute("user");
 	    int userIdx = 0;
 	    if (user != null) {
 	        userIdx = user.getUserIdx();
 	        vo.setUserIdx(userIdx);
 	    }

 	    model.addAttribute("hosIdx", hosIdx);
 	    model.addAttribute("userIdx", userIdx);
 	    
 	    // 리뷰 삭제
 	    hospitalService.deleteReview(vo);
 	    
 	    // 별점 평균 업데이트
 	    updateAverageScore(hosIdx);
 	    System.out.println("vo : " + vo);

 	    // 리뷰 삭제 시 사용자 상태 업데이트 
 	    hospitalService.updateCondition(vo); 
 	    
 	    return "redirect:/mypage/myReviewList.do";
 	}
 	// 별점 평균 업데이트 메소드
 	private void updateAverageScore(int hosIdx) {
 	    // 해당 병원의 모든 리뷰 가져오기
 	    List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);

 	    // 별점 합계 계산
 	    double totalScore = 0.0;
 	    for (HosReviewVO reviewVo : reviewList) {
 	        totalScore += reviewVo.getScore();
 	    }

 	    // 별점 평균 계산
 	    double avgScore = 0.0;
 	    if (!reviewList.isEmpty()) {
 	        avgScore = totalScore / reviewList.size();
 	    }

 	    // 병원의 별점 평균 업데이트
 	    HospitalVO hosVo = new HospitalVO();
 	    hosVo.setHosIdx(hosIdx);
 	    hosVo.setScore(avgScore);

 	    hospitalService.updateAvgScore(hosVo);
 	}
 	
 	
}
