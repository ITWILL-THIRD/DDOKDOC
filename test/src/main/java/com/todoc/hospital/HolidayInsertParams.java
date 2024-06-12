package com.todoc.hospital;

import java.sql.Date;

public class HolidayInsertParams {
	private int hosIdx;
    private Date holiDate;
    
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	public Date getHoliDate() {
		return holiDate;
	}
	public void setHoliDate(Date holiDate) {
		this.holiDate = holiDate;
	}
	
	@Override
	public String toString() {
		return "HolidayInsertParams [hosIdx=" + hosIdx + ", holiDate=" + holiDate + "]";
	}
    
}
