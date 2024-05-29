package com.todoc.hosMain;

public class hosaddressVO {
	private int hosidx;
	private String addressname;
	private String roadaddressname;
	private String addx;
	private String addy;
	private String sido;
	private String sigungu;
	
	public int getHosidx() {
		return hosidx;
	}
	public void setHosidx(int hosidx) {
		this.hosidx = hosidx;
	}
	public String getAddressname() {
		return addressname;
	}
	public void setAddressname(String addressname) {
		this.addressname = addressname;
	}
	public String getRoadaddressname() {
		return roadaddressname;
	}
	public void setRoadaddressname(String roadaddressname) {
		this.roadaddressname = roadaddressname;
	}
	public String getAddx() {
		return addx;
	}
	public void setAddx(String addx) {
		this.addx = addx;
	}
	public String getAddy() {
		return addy;
	}
	public void setAddy(String addy) {
		this.addy = addy;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getSigungu() {
		return sigungu;
	}
	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}
	
	@Override
	public String toString() {
		return "hosaddressVO [hosidx=" + hosidx + ", addressname=" + addressname + ", roadaddressname="
				+ roadaddressname + ", addx=" + addx + ", addy=" + addy + ", sido=" + sido + ", sigungu=" + sigungu
				+ "]";
	}
}
