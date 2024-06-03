package com.todoc.notice;

import java.sql.Date;

public class NoticeVO {
	private int noticeIdx;
	private String noticeTitle;
	private String noticeContent;
	private Date noticeDate;
	private int hit;
	private int hosIdx;
	
	public int getNoticeIdx() {
		return noticeIdx;
	}
	public void setNoticeIdx(int noticeIdx) {
		this.noticeIdx = noticeIdx;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}
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
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	
	@Override
	public String toString() {
		return "NoticeVO [noticeIdx=" + noticeIdx + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
				+ ", noticeDate=" + noticeDate + ", hit=" + hit + ", hosIdx=" + hosIdx + "]";
	}
}
