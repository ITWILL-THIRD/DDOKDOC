package com.todoc.stats;

import java.util.Date;

public class HosStatsVO {
	// HOSREG 테이블
	private int hosregIdx;
	private int hosIdx;
	private Date regStart;
	private Date regEnd;
	
	public int getHosregIdx() {
		return hosregIdx;
	}
	public void setHosregIdx(int hosregIdx) {
		this.hosregIdx = hosregIdx;
	}
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	public Date getRegStart() {
		return regStart;
	}
	public void setRegStart(Date regStart) {
		this.regStart = regStart;
	}
	public Date getRegEnd() {
		return regEnd;
	}
	public void setRegEnd(Date regEnd) {
		this.regEnd = regEnd;
	}
	
	@Override
	public String toString() {
		return "HosStatsVO [hosregIdx=" + hosregIdx + ", hosIdx=" + hosIdx + ", regStart=" + regStart + ", regEnd="
				+ regEnd + "]";
	}
	
}
