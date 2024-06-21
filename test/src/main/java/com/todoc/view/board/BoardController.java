package com.todoc.view.board;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;

import com.todoc.board.BoardService;
import com.todoc.board.BoardVO;
import com.todoc.board.CommentVO;
import com.todoc.common.Paging;
import com.todoc.googlecloudstorage.GCSService;


// @SessionAttributes : 같은 컨트롤러에서 모델객체 공유해서 사용하려는 경우에 사용
// 데이터 사용후 SessionStatus 객체의 setComplete() 메소드 사용 해제
//@SessionAttributes(value = {"board"}) //board 라는 이름의 Model 있으면 session에 저장
@SessionAttributes({"board", "comments"})
@Controller
@RequestMapping("/board") // 공통경로 지정시 사용
public class BoardController {
	//@Autowired
	private BoardService boardService;
	
	 @Autowired
	 @Qualifier("gcsService")
	 private GCSService gcsService;
	
	public BoardController() {
		System.out.println("=========> BoardController() 객체생성");
	}
	
	@Autowired
	public BoardController(BoardService boardService) {
		System.out.println("=========> BoardController(BoardService) 객체생성");
		System.out.println(":: BoardService boardService : " + boardService);
		this.boardService = boardService;
	}
	
	// 메소드 선언부에 작성된 @ModelAttribute 는 리턴값을 View에 전달
	// @ModelAttribute 선언된 메소드는 @RequestMapping 메소드보다 먼저 실행
	// 뷰에 전달될 때 설정된 명칭 사용(예: conditionMap)
	@ModelAttribute("conditionMap")
	public Map<String, String> searchConditionMap() {
		System.out.println("======> Map searchConditionMap() 실행 -------");
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("제목", "TITLE");
		conditionMap.put("내용", "CONTENT");
		return conditionMap;
	}
	
	@RequestMapping("/getBoard.do")
    public String getBoard(HttpServletRequest request, BoardVO vo, CommentVO co , Model model) {
		String cPage = request.getParameter("cPage");
		
        // 조회수 증가
        boardService.updateHit(vo);
       
        // 게시글 상세 조회
        BoardVO board = boardService.getBoard(vo);
        List<CommentVO> comments = boardService.getCommentList(co);
        co.setPostidx(vo.getPostidx());
        
        // 날짜 변환
        SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        String formattedDate = targetFormat.format(board.getPostdate());
        board.setFormattedDate(formattedDate);
        
        // 댓글 날짜 변환
        for (CommentVO comment : comments) {
            String formattedCommentDate = targetFormat.format(comment.getCommentdate());
            comment.setFormattedCommentDate(formattedCommentDate);
        }
        
        model.addAttribute("board", board); // Model에 데이터 저장
        model.addAttribute("comments", comments);
        
        return "board/getBoard";
    }
	
	@RequestMapping("/getBoardList.do")
	public String getBoardList(BoardVO vo, 
			@RequestParam(value = "searchCondition", required = false) String searchCondition,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(value = "category", required = false) String category, HttpServletRequest request, Model model) {
		System.out.println(">> 게시글 전체 목록 보여주기");
		System.out.println("vo : " + vo);
		
		if (category != null && !category.isEmpty()) {
	        vo.setCategory(category);
		}
		
		if (searchCondition != null) {
			
          vo.setSearchCondition(searchCondition);
               
		}
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		System.out.println("전체 게시물 수량 전 vo : " + vo);
		p.setTotalRecord(boardService.getAjaxTotCnt(vo));
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
        
		//List<BoardVO> boardList = boardService.getBoardList(vo);
		List<BoardVO> boardList = boardService.getListPage(vo,category,searchCondition, searchKeyword, begin, end);
		
		SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MM dd HH:mm:ss z yyyy");
	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	    
	    for (BoardVO board : boardList) {
	        String formattedDate = targetFormat.format(board.getPostdate());
	        board.setFormattedDate(formattedDate);
	    }
	   
		model.addAttribute("boardList", boardList); // Model에 데이터 저장
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("category", category);
		model.addAttribute("pagingVO", p);
		
		return "board/getBoardList";
	}
	
	@RequestMapping("/getSearchBoardList.do")
	public String getBoardList(BoardVO vo, HttpServletRequest request, Model model,
			@RequestParam(value = "searchCondition", required = false) String searchCondition,
			@RequestParam(value = "searchKeyword", required = false) String searchKeyword,
			@RequestParam(value = "category", required = false) String category ) {
		System.out.println(">> 게시글 전체 목록 보여주기");
		System.out.println("vo : " + vo);
		
		if (category != null && !category.isEmpty()) {
	        vo.setCategory(category);
		}
		
		if (searchCondition != null) {			
            vo.setSearchCondition(searchCondition);
		}
		
		if (searchKeyword != null) {
		    vo.setSearchKeyword(searchKeyword);
		}
		
		//페이징 처리를 위한 객체(Paging)생성 - numPerPage=10, pagePerBlock=10 세팅
		Paging p = new Paging();
		
		//1. 전체 게시물 수량 구하기
		System.out.println("전체 게시물 수량 전 vo : " + vo);
		p.setTotalRecord(boardService.getAjaxTotCnt(vo));
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
        
		//List<BoardVO> boardList = boardService.getBoardList(vo);
		List<BoardVO> boardList = boardService.getListPage(vo,category,searchCondition, searchKeyword, begin, end);
		
		SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MM dd HH:mm:ss z yyyy");
	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd");
	    
	    for (BoardVO board : boardList) {
	        String formattedDate = targetFormat.format(board.getPostdate());
	        board.setFormattedDate(formattedDate);
	    }
	   
		model.addAttribute("boardList", boardList); // Model에 데이터 저장
		model.addAttribute("pagingVO", p);
		model.addAttribute("searchCondition", searchCondition);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("category", category);
		
		return "board/getBoardList";
	}
	
	@RequestMapping("/getInsertBoard.do")
	public String getInsertBoard() { 
		System.out.println(">> 새 글 작성");

		return "board/insertBoard";
	}
	
	@RequestMapping("/insertBoard.do")
	//public String insertBoard(BoardVO vo, MultipartFile uploadFile) {
	public String insertBoard(BoardVO vo, @RequestParam("file") MultipartFile file, Model model) throws IllegalStateException, IOException {
		System.out.println(">> 게시글 입력");
		System.out.println("vo : " + vo);
		
		 try {
			 if (!file.isEmpty()) {
		            String img = gcsService.uploadFile(file); // 파일 업로드
		            vo.setImg(img);
		        }         
	            boardService.insertBoard(vo);
	    		return "redirect:getBoardList.do";
	        } catch (IOException e) {
	            e.printStackTrace();
	            model.addAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다");
	            return "redirect:insertBoard.do";
	        }
	}
	
	@RequestMapping("/getUpdateBoard.do")
	public String getUpdateBoard() {
		System.out.println(">> 글 수정");

		return "board/updateBoard";
	}
	
	//@ModelAttribute("board") : @SessionAttributes 설정으로 존재하는 "board" 데이터 사용
	@RequestMapping("/updateBoard.do")
	public String updateBoard(@ModelAttribute("board") BoardVO vo, Model model) {
		System.out.println(">> 게시글 수정");
		System.out.println("vo : " + vo);
		
		System.out.println("updating : " + vo); // 값 설정 확인
		boardService.updateBoard(vo);
		return "redirect:getBoardList.do";
	}
	
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(BoardVO vo, SessionStatus sessionStatus, Model model) {
		System.out.println(">> 게시글 삭제");
		boardService.deleteBoard(vo);
		 if (vo.getImg() != null) {
	            gcsService.deleteFile(vo.getImg()); // GCS에서 파일 삭제
	        }
		
		sessionStatus.setComplete(); //@SessionAttributes 저장객체 삭제 처리
		
		return "redirect:getBoardList.do";
	}
	
	
	@RequestMapping("/insertComment.do")
	public String insertComment(@RequestParam("postidx") int postidx, CommentVO vo) {
		System.out.println(">> 댓글등록");
		boardService.insertComment(vo);
		
		return "redirect:getBoard.do?postidx=" + postidx;
	}
	
	@RequestMapping(value = "/updateComment.do")
	public String updateComment(@RequestParam("commentidx") int commentIdx, @RequestParam("content") String content) {

	    try {
	        CommentVO comment = new CommentVO();
	        comment.setCommentidx(commentIdx);
	        comment.setContent(content);
	        boardService.updateComment(comment);
	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
	
//	@RequestMapping("/deleteComment.do")
//	public String deleteComment(@RequestParam("postidx") int postidx, CommentVO vo, SessionStatus sessionStatus) {
//		System.out.println(">> 댓글 삭제");
//		boardService.deleteComment(vo);
//		
//		sessionStatus.setComplete(); //@SessionAttributes 저장객체 삭제 처리
//		
//		return "redirect:getBoard.do?postidx=" + postidx;
//	}
	
	@RequestMapping(value = "/deleteComment.do")
	public String deleteComment(@RequestParam("commentidx") int commentIdx, SessionStatus sessionStatus) {
	    try {
	        boardService.deleteComment(commentIdx);
	        sessionStatus.setComplete(); //@SessionAttributes 저장객체 삭제 처리
	        return "success";
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "error";
	    }
	}

}






