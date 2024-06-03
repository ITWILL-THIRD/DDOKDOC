package com.todoc.user;

public class HosAddressVO {
	private int hosIdx;
	private String addressName;
	private String roadAddressName;
	private String addx;
	private String addy;
	private String sido;
	private String sigungu;
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public String getRoadAddressName() {
		return roadAddressName;
	}
	public void setRoadAddressName(String roadAddressName) {
		this.roadAddressName = roadAddressName;
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
		return "HosAddressVO [hosIdx=" + hosIdx + ", addressName=" + addressName + ", roadAddressName="
				+ roadAddressName + ", addx=" + addx + ", addy=" + addy + ", sido=" + sido + ", sigungu=" + sigungu
				+ "]";
	}
	
	
	
}
