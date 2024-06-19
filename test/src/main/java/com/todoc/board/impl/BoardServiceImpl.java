package com.todoc.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.admin.hosapproval.HosApprovalVO;
import com.todoc.board.BoardService;
import com.todoc.board.BoardVO;
import com.todoc.board.CommentVO;
import com.todoc.board.dao.BoardDAO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	@Autowired //타입이 일치하는 객체(인스턴스) 주입
	private BoardDAO boardDAO;
	
	public BoardServiceImpl() {
		System.out.println(">> BoardServiceImpl() 객체생성");
	}
	//@Autowired
//	public BoardServiceImpl(BoardDAO boardDAO) {
//		System.out.println(">> BoardServiceImpl(BoardDAO) 객체생성");
//		this.boardDAO = boardDAO;
//	}

	@Override
	public void insertBoard(BoardVO vo) {
		boardDAO.insertBoard(vo);
	}

	@Override
	public void updateBoard(BoardVO vo) {
		boardDAO.updateBoard(vo);
	}

	@Override
	public void deleteBoard(BoardVO vo) {
		boardDAO.deleteBoard(vo);
	}

	@Override
	public BoardVO getBoard(BoardVO vo) {
		return boardDAO.getBoard(vo);
	}

	@Override
	public List<BoardVO> getBoardList(BoardVO vo) {
		//return boardDAO.getBoardList(vo);
		 if (vo.getCategory() != null && !vo.getCategory().isEmpty()) {
	            return boardDAO.getBoardListByCategory(vo);
	        } else {
	            return boardDAO.getBoardList(vo);
	        }
	}
	
	 @Override
	    public void updateHit(BoardVO vo) {
		 boardDAO.updateHit(vo);
	   }

	@Override
	public void insertComment(CommentVO vo) {
		boardDAO.insertComment(vo);
		
	}
	
	@Override
	public void updateComment(CommentVO vo) {
		boardDAO.updateComment(vo);
	}

	@Override
	public void deleteComment(int commentIdx) {
		boardDAO.deleteComment(commentIdx);
		
	}

	@Override
	public CommentVO getComment(CommentVO vo) {
		return boardDAO.getComment(vo);
	}

	@Override
	public List<CommentVO> getCommentList(int postidx) {
		return boardDAO.getCommentList(postidx);
	}

	@Override
	public List<CommentVO> getCommentList(CommentVO co) {
		return boardDAO.getCommentList(co);
	}
	
	@Override
	public List<BoardVO> myPostList(int userIdx) {
		return boardDAO.myPostList(userIdx);
	}
	
	@Override
	public List<CommentVO> myCommentList(int userIdx) {
		return boardDAO.myCommentList(userIdx);
	}

	//전체 병원 건수 cnt 조회
	@Override
	public int getTotCnt() {
		return boardDAO.getTotCnt();
	}
	//(동적처리 조건별)전체 건수 cnt 조회
	@Override
	public int getAjaxTotCnt(BoardVO vo) {
		System.out.println(">> boardServiceImpl - getAjaxTotCnt() 실행");
		System.out.println("vo.getSearchCondition() : " + vo.getSearchCondition());
		
		if(vo.getCategory() != null && !vo.getCategory().isEmpty()) {
			return boardDAO.getAjaxTotCnt(vo);
		} else if(vo.getSearchCondition() != null) {
			return boardDAO.getAjaxTotCnt(vo);
		}
		return boardDAO.getAjaxTotCnt(vo);
		
	}
	// 동적 검색 전체 목록 + 페이징
	@Override
	public List<BoardVO> getListPage(BoardVO vo, String category, String searchCondition, String searchKeyword
				,int begin, int end) {
		if (category != null && !category.isEmpty()) {
			//동적 검색(카테고리) + 페이징 적용
			System.out.println(":: boardDAO.getSearchPage(map)- category 검색");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("category", category);
			map.put("begin", begin);
			map.put("end", end);
			System.out.println("map : " + map);
			
			return boardDAO.getSearchPage(map);
			
		} else if (searchKeyword != null) { 
			//동적 검색(검색) + 페이징 적용
			System.out.println(":: boardDAO.getSearchPage(map)-condition 검색");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("searchCondition", searchCondition);
			map.put("searchKeyword", searchKeyword);
			map.put("begin", begin);
			map.put("end", end);
			System.out.println("map : " + map);
			
			return boardDAO.getSearchPage(map);
			
		} else {
			//페이징만 적용
			System.out.println(":: boardDAO.getListPage(map)-페이징");
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("begin", begin);
			map.put("end", end);
			System.out.println("map : " + map);
			return boardDAO.getListPage(map);
		}
	}
	
}






