package com.todoc.board.dao;

import java.util.List;

import com.todoc.board.BoardVO;
import com.todoc.board.CommentVO;


public interface BoardDAO {
	//CRUD 기능 구현 메소드 정의
	void insertBoard(BoardVO vo);
	void updateBoard(BoardVO vo);
	void updateHit(BoardVO vo);
	void deleteBoard(BoardVO vo);
	BoardVO getBoard(BoardVO vo);
	List<BoardVO> getBoardList(BoardVO vo);
	List<BoardVO> getBoardListByCategory(BoardVO vo);
	
	void insertComment(CommentVO vo);
	void updateComment(CommentVO vo);
	void deleteComment(int commentIdx);
	CommentVO getComment(CommentVO vo);
	List<CommentVO> getCommentList(CommentVO co);
	List<CommentVO> getCommentList(int postidx);
	
	List<BoardVO> myPostList(int userIdx);
}




