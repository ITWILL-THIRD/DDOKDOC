package com.todoc.notice;

import java.util.List;

public interface NoticeService {
	//CRUD 기능 구현 메소드 정의
	List<NoticeVO> getNoticeList(int hosIdx);
	NoticeVO getNotice(int hosIdx);
	void insertNotice(NoticeVO vo);
	void updateNotice(NoticeVO vo);
	void deleteNotice(int hosIdx);
	List<NoticeVO> hosNoticeList(int hosIdx);
}
