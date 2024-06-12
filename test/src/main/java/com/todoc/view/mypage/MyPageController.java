package com.todoc.view.mypage;

import java.io.IOException;
import java.util.List;

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

import com.todoc.googlecloudstorage.GCSService;
import com.todoc.hospital.HosReviewVO;
import com.todoc.hospital.HospitalService;
import com.todoc.hospital.HospitalVO;
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
    @Qualifier("gcsService")
    private GCSService gcsService;
	@Autowired
	private MyPetService myPetService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private HospitalService hospitalService;
	
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
	    	String userImg = gcsService.uploadFile(file);
	    	vo.setUserImg(userImg);
	    	UserVO user = (UserVO) session.getAttribute("user");
            vo.setUserIdx(user.getUserIdx());
            System.out.println("내 정보 수정");
            System.out.println("vo : " + vo);
            userService.updateUser(vo);
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
	
	
    @RequestMapping("/myPage.do")
    public String myPage(Model model, HttpSession session) {
    	UserVO user = (UserVO) session.getAttribute("user");
    	if (user == null) {
    		return "redirect:/index.jsp"; // 로그인 정보가 없으면 로그인 페이지로 리다이렉트 처리
    	}
    	List<MyPetVO> pets = myPetService.getMyPetList(user.getUserIdx());
    	model.addAttribute("pets", pets);
        return "mypage/myPage";
    }
    
    //예약 리스트
    @RequestMapping("/myReserList.do")
    public String myReserList(Model model, HttpSession session) {
    	// 로그인 정보 가져오기
    	UserVO user = (UserVO) session.getAttribute("user");
    	
    	//예약 리스트 가져오기
    	List<ReservationVO> myReserList = reservationService.myReserList(user.getUserIdx());
    	
    	//변환된 시간 추가
    	for (int i = 0; i < myReserList.size(); i++) {
    		String formattedTime = myReserList.get(i).getReserTime().toString().substring(0, 5);
    		myReserList.get(i).setFormattedTime(formattedTime);
    	}
    	
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
		// 리뷰 전체 조회
		//List<HosReviewVO> reviewList = hospitalService.getHosReview(hosIdx);
	   // model.addAttribute("reviewList", reviewList);
		
		
		return "mypage/myReviewList";
 	}
 	
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
 	
 	// (병원)리뷰 목록 조회
  	@RequestMapping("/hosReviewList.do")
  	public String hosReviewList(Model model, HttpSession session) {
 		System.out.println("::마이페이지-리뷰리스트");
 		HospitalVO hoUser = (HospitalVO) session.getAttribute("hoUser");
 		int hosIdx = 0;
 		if (hoUser != null) {
 		    hosIdx = hoUser.getHosIdx();
 		}
 		
 		model.addAttribute("hosIdx", hosIdx);
 		
	    // 병원 1개 조회
	    HospitalVO hospital = hospitalService.selectOne(hosIdx);
	    model.addAttribute("hospital", hospital);

 		//작성된 리뷰 목록
 		List<HosReviewVO> hosReviewList = hospitalService.getHosReviewList(hosIdx);
 		model.addAttribute("hosReviewList", hosReviewList);

 		return "mypage/hosReviewList";
  	}
 	
}
