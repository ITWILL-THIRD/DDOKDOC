package com.todoc.notice;

import java.util.List;

public interface NoticeService {
	//CRUD 기능 구현 메소드 정의
	List<NoticeVO> getNoticeList(int hosIdx);
	NoticeVO getNotice(int noticeIdx);
	void insertNotice(NoticeVO vo);
	void updateNotice(NoticeVO vo);
	void deleteNotice(NoticeVO vo);
}
