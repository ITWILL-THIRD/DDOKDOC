package com.todoc.stats;

import java.util.Date;

public class UserStatsVO {
	// USERMEMBER 테이블
	private int memberIdx;
	private int userIdx;
	private Date memStart;
	private Date memEnd;
	
	public int getMemberIdx() {
		return memberIdx;
	}
	public void setMemberIdx(int memberIdx) {
		this.memberIdx = memberIdx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public Date getMemStart() {
		return memStart;
	}
	public void setMemStart(Date memStart) {
		this.memStart = memStart;
	}
	public Date getMemEnd() {
		return memEnd;
	}
	public void setMemEnd(Date memEnd) {
		this.memEnd = memEnd;
	}
	
	@Override
	public String toString() {
		return "UserStatsVO [memberIdx=" + memberIdx + ", userIdx=" + userIdx + ", memStart=" + memStart + ", memEnd="
				+ memEnd + "]";
	}
	
}
