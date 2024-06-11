package com.todoc.notice.dao;

import java.util.List;

import com.todoc.notice.NoticeVO;

public interface NoticeDAO {
	List<NoticeVO> getNoticeList(int hosIdx);
	NoticeVO getNotice(int noticeIdx);
	void insertNotice(NoticeVO vo);
	void updateNotice(NoticeVO vo);
	void deleteNotice(NoticeVO vo);
	List<NoticeVO> hosNoticeList(int hosIdx);
}
