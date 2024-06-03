package com.todoc.reservation;

import java.sql.Date;
import java.sql.Time;

public class ReservationVO {
	private int reserIdx;
	private int hosIdx;
	private int userIdx;
	private int petIdx;
	private Date reserDate;
	private String dayStr; //요일임.
	private Time reserTime;
	private String memo;
	
	public int getReserIdx() {
		return reserIdx;
	}
	public void setReserIdx(int reserIdx) {
		this.reserIdx = reserIdx;
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
	public int getPetIdx() {
		return petIdx;
	}
	public void setPetIdx(int petIdx) {
		this.petIdx = petIdx;
	}
	public Date getReserDate() {
		return reserDate;
	}
	public void setReserDate(Date reserDate) {
		this.reserDate = reserDate;
	}
	public String getDayStr() {
		return dayStr;
	}
	public void setDayStr(String dayStr) {
		this.dayStr = dayStr;
	}
	public Time getReserTime() {
		return reserTime;
	}
	public void setReserTime(Time reserTime) {
		this.reserTime = reserTime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	@Override
	public String toString() {
		return "ReservationVO [reserIdx=" + reserIdx + ", hosIdx=" + hosIdx + ", userIdx=" + userIdx + ", petIdx="
				+ petIdx + ", reserDate=" + reserDate + ", dayStr=" + dayStr + ", reserTime=" + reserTime + ", memo="
				+ memo + "]";
	}
}
