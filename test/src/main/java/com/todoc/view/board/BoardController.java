package com.todoc.view.board;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
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


// @SessionAttributes : 같은 컨트롤러에서 모델객체 공유해서 사용하려는 경우에 사용
// 데이터 사용후 SessionStatus 객체의 setComplete() 메소드 사용 해제
//@SessionAttributes(value = {"board"}) //board 라는 이름의 Model 있으면 session에 저장
@SessionAttributes({"board", "comments"})
@Controller
//@RequestMapping("/board") // 공통경로 지정시 사용
public class BoardController {
	//@Autowired
	private BoardService boardService;
	
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
    public String getBoard(BoardVO vo, CommentVO co , Model model) {
        // 조회수 증가
        boardService.updateHit(vo);
       
        // 게시글 상세 조회
        BoardVO board = boardService.getBoard(vo);
        List<CommentVO> comments = boardService.getCommentList(co);
        co.setPostidx(vo.getPostidx());
        
        // 날짜 변환
        SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-M-d HH:mm:ss");

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
	public String getBoardList(BoardVO vo, @RequestParam(value = "category", required = false) String category, Model model) {
		System.out.println(">> 게시글 전체 목록 보여주기");
		System.out.println("vo : " + vo);
		
		if (category != null && !category.isEmpty()) {
	        vo.setCategory(category);
		}
        
		List<BoardVO> boardList = boardService.getBoardList(vo);
		
		SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-M-d HH:mm:ss");
	    
	    for (BoardVO board : boardList) {
	        String formattedDate = targetFormat.format(board.getPostdate());
	        board.setFormattedDate(formattedDate);
	    }
		
		model.addAttribute("boardList", boardList); // Model에 데이터 저장
		
		return "board/getBoardList";
	}
	
	@RequestMapping("/getInsertBoard.do")
	public String getInsertBoard() {
		System.out.println(">> 새 글 작성");

		return "board/insertBoard";
	}
	
	@RequestMapping("/insertBoard.do")
	//public String insertBoard(BoardVO vo, MultipartFile uploadFile) {
	public String insertBoard(BoardVO vo) throws IllegalStateException, IOException {
		System.out.println(">> 게시글 입력");
		System.out.println("vo : " + vo);
		
//		MultipartFile uploadFile = vo.getUploadFile();
//		System.out.println("> vo.uploadFile : " + uploadFile);
		
		/*파일업로드 관련 작업 처리
		MultipartFile 인터페이스 주요메소드
		String getOriginalFilename() : 업로드할 원본파일명 찾기
		void transferTo(File dest) : 업로드 할 파일을 업로드(복사) 처리
		boolean isEmpty() : 업로드 할 파일 존재 여부 확인(없으면 true 리턴)
		***************************/
//		if (uploadFile == null) {
//			System.out.println("::: uploadFile 파라미터가 전달되지 않았을 때~");
//		} else if (uploadFile.isEmpty()) {
//			System.out.println("::: 전달받은 파일데이터가 없는 경우");
//		} else {
//			System.out.println("::: 전달받은 파일데이터가 있는 경우");
//			System.out.println("uploadFile.isEmpty() : " + uploadFile.isEmpty());
//			String filename = uploadFile.getOriginalFilename(); //원본파일명
//			System.out.println("::: 원본파일명 : " + filename);
//			String savedFilename = UUID.randomUUID().toString(); //물리적 저장 파일명
//			System.out.println("::: 저장할파일명 : " + savedFilename);
//			
//			String destPathFile = "c:/MyStudy/temp/" + savedFilename;
//			uploadFile.transferTo(new File(destPathFile));
//		}
		
		boardService.insertBoard(vo);
		return "redirect:getBoardList.do";
	}
	
	@RequestMapping("/getUpdateBoard.do")
	public String getUpdateBoard() {
		System.out.println(">> 글 수정");

		return "board/updateBoard";
	}
	
	//@ModelAttribute("board") : @SessionAttributes 설정으로 존재하는 "board" 데이터 사용
	@RequestMapping("/updateBoard.do")
	public String updateBoard(@ModelAttribute("board") BoardVO vo) {
		System.out.println(">> 게시글 수정");
		System.out.println("vo : " + vo);
		
		String category = vo.getCategory();
		if (category != null) {
	        if (category.equals("free")) {
	            vo.setCategory("자유");
	        } else if (category.equals("med")) {
	            vo.setCategory("의료");
	        } else if (category.equals("feed")) {
	            vo.setCategory("사료/간식");
	        } else if (category.equals("goods")) {
	            vo.setCategory("용품");
	        }
	    }
		
		boardService.updateBoard(vo);
		return "redirect:getBoardList.do";
	}
	
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(BoardVO vo, SessionStatus sessionStatus) {
		System.out.println(">> 게시글 삭제");
		boardService.deleteBoard(vo);
		
		sessionStatus.setComplete(); //@SessionAttributes 저장객체 삭제 처리
		
		return "redirect:getBoardList.do";
	}
	
	
	@RequestMapping("/insertComment.do")
	public String insertComment(@RequestParam("postidx") int postidx, CommentVO vo) {
		System.out.println(">> 댓글등록");
		boardService.insertComment(vo);
		
		return "redirect:getBoard.do?postidx=" + postidx;
	}
	
	@RequestMapping("/deleteComment.do")
	public String deleteComment(@RequestParam("postidx") int postidx, CommentVO vo, SessionStatus sessionStatus) {
		System.out.println(">> 댓글 삭제");
		boardService.deleteComment(vo);
		
		sessionStatus.setComplete(); //@SessionAttributes 저장객체 삭제 처리
		
		return "redirect:getBoard.do?postidx=" + postidx;
	}

}






