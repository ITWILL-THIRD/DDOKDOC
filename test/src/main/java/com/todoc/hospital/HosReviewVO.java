package com.todoc.hospital;

import java.sql.Date;

public class HosReviewVO {
	private int reviewIdx;
	private int hosIdx;
	private int userIdx;
	private String content;
	private int score;
	private Date reviewDate;
	
	//user 테이블
	private String nickname;
	
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
	
	@Override
	public String toString() {
		return "HosReviewVO [reviewIdx=" + reviewIdx + ", hosIdx=" + hosIdx + ", userIdx=" + userIdx + ", content="
				+ content + ", score=" + score + ", reviewDate=" + reviewDate + ", nickname=" + nickname + "]";
	}
};