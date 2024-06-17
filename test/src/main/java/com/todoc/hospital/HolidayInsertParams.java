package com.todoc.hospital;

import java.sql.Date;

public class HolidayInsertParams {
	private int hosIdx;
    private Date holiDate;
    private String holiDateStr;
    
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
	public String getHoliDateStr() {
		return holiDateStr;
	}
	public void setHoliDateStr(String holiDateStr) {
		this.holiDateStr = holiDateStr;
	}
	
	@Override
	public String toString() {
		return "HolidayInsertParams [hosIdx=" + hosIdx + ", holiDate=" + holiDate + ", holiDateStr=" + holiDateStr
				+ "]";
	}
	
}
