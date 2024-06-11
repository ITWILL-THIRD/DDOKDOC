package com.todoc.notice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todoc.notice.NoticeService;
import com.todoc.notice.NoticeVO;
import com.todoc.notice.dao.NoticeDAO;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDAO noticeDAO;
	
	@Override
	public List<NoticeVO> getNoticeList(int hosIdx) {
		return noticeDAO.getNoticeList(hosIdx);
	}

	@Override
	public NoticeVO getNotice(int noticeIdx) {
		return noticeDAO.getNotice(noticeIdx);
	}

	@Override
	public void insertNotice(NoticeVO vo) {
		noticeDAO.insertNotice(vo);
	}

	@Override
	public void updateNotice(NoticeVO vo) {
		noticeDAO.updateNotice(vo);
	}

	@Override
	public void deleteNotice(NoticeVO vo) {
		noticeDAO.deleteNotice(vo);
	}
	
	@Override
	public List<NoticeVO> hosNoticeList(int hosIdx) {
		return noticeDAO.hosNoticeList(hosIdx);
	}

}
