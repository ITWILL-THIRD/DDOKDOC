package com.todoc.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public void deleteComment(CommentVO vo) {
		boardDAO.deleteComment(vo);
		
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
	
}






