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
	void updateComment(CommentVO vo);
	void deleteComment(int commentIdx);
	CommentVO getComment(CommentVO vo);
	List<CommentVO> getCommentList(CommentVO vo);
	List<CommentVO> getCommentList(int postidx);
	
	List<BoardVO> myPostList(int userIdx);
	List<CommentVO> myCommentList(int userIdx);
	int getTotCnt();
	int getAjaxTotCnt(BoardVO vo);
	List<BoardVO> getListPage(BoardVO vo, String category, String searchCondition, String searchKeyword, int begin, int end);
}
