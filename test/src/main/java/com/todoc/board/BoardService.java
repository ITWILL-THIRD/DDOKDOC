package com.todoc.board;

import java.util.List;

public interface BoardService {
	void insertBoard(BoardVO vo);
	void updateBoard(BoardVO vo);
	void updateHit(BoardVO vo);
	void deleteBoard(BoardVO vo);
	BoardVO getBoard(BoardVO vo);
	List<BoardVO> getBoardList(BoardVO vo);
	
	void insertComment(CommentVO vo);
	void deleteComment(CommentVO vo);
	CommentVO getComment(CommentVO vo);
	List<CommentVO> getCommentList(CommentVO vo);
	List<CommentVO> getCommentList(int postidx);
	
	List<BoardVO> myPostList(int userIdx);
}
