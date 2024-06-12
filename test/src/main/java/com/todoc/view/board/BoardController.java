package com.todoc.view.board;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
    public String getBoard(BoardVO vo, CommentVO co , Model model) {
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
	public String getBoardList(BoardVO vo, @RequestParam(value = "category", required = false) String category, Model model) {
		System.out.println(">> 게시글 전체 목록 보여주기");
		System.out.println("vo : " + vo);
		
		if (category != null && !category.isEmpty()) {
	        vo.setCategory(category);
		}
        
		List<BoardVO> boardList = boardService.getBoardList(vo);
		
		SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MM dd HH:mm:ss z yyyy");
	    SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    
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
	public String insertBoard(BoardVO vo, @RequestParam("file") MultipartFile file, Model model) throws IllegalStateException, IOException {
		System.out.println(">> 게시글 입력");
		System.out.println("vo : " + vo);
		
		 try {
	            String Img = gcsService.uploadFile(file); // 파일 업로드
	            vo.setImg(Img);            
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
	public String updateBoard(@ModelAttribute("board") BoardVO vo, @RequestParam("file") MultipartFile file, Model model) {
		System.out.println(">> 게시글 수정");
		System.out.println("vo : " + vo);
		
		try {
			if (!file.isEmpty()) { // 파일이 있으면 업로드 처리
				String Img = gcsService.uploadFile(file);
				vo.setImg(Img);
			}
			System.out.println("updating : " + vo); // 값 설정 확인
			boardService.updateBoard(vo);
			return "redirect:getBoardList.do";
		} catch (IOException e) {
			e.printStackTrace();
	        model.addAttribute("errorMessage", "파일 업로드 중 오류가 발생했습니다");
	        return "redirect:updateBoard.do";
		}
	}
	
	@RequestMapping("/deleteBoard.do")
	public String deleteBoard(BoardVO vo, SessionStatus sessionStatus, Model model) {
		System.out.println(">> 게시글 삭제");
		boardService.deleteBoard(vo);
		gcsService.deleteFile(vo.getImg()); // GCS에서 파일 삭제
		
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






