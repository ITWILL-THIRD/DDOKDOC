package com.todoc.hospital;

import java.sql.Date;

public class HosReviewVO {
	private int reviewIdx;
	private int hosIdx;
	private int userIdx;
	private int reserIdx;
	private String content;
	private int score;
	private Date reviewDate;
	
	//user 테이블
	private String nickname;
	//reservation 테이블
	private Date reserDate;
	private String hosName; 
	
	public int getReviewIdx() {
		return reviewIdx;
	}
	public void setReviewIdx(int reviewIdx) {
		this.reviewIdx = reviewIdx;
	}
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public int getReserIdx() {
		return reserIdx;
	}
	public void setReserIdx(int reserIdx) {
		this.reserIdx = reserIdx;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getReserDate() {
		return reserDate;
	}
	public void setReserDate(Date reserDate) {
		this.reserDate = reserDate;
	}
	public String getHosName() {
		return hosName;
	}
	public void setHosName(String hosName) {
		this.hosName = hosName;
	}
	
	@Override
	public String toString() {
		return "HosReviewVO [reviewIdx=" + reviewIdx + ", hosIdx=" + hosIdx + ", userIdx=" + userIdx + ", reserIdx="
				+ reserIdx + ", content=" + content + ", score=" + score + ", reviewDate=" + reviewDate + ", nickname="
				+ nickname + ", reserDate=" + reserDate + ", hosName=" + hosName + "]";
	}
	
};