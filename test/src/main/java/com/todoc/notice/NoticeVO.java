package com.todoc.notice;

import java.sql.Date;

public class NoticeVO {
	private String noticeContent;
	private Date noticeDate;
	private int hosIdx;
	
	public String getNoticeContent() {
		return noticeContent;
	}
	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}
	public Date getNoticeDate() {
		return noticeDate;
	}
	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	
	@Override
	public String toString() {
		return "NoticeVO [noticeContent=" + noticeContent + ", noticeDate=" + noticeDate + ", hosIdx=" + hosIdx + "]";
	}
	
	
}
