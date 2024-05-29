package com.todoc.hosMain;

public class JoinHospitalVO {
	//hospital 테이블
	private int hosIdx;
	private String hosId;
	private String hosPw;
	private String hosName;
	private String hosPhone;
	private String animal;
	private double score;
	private String condition;
	//hosaddress 테이블
	private String addressName;
	private String roadAddressName;
	private String addx;
	private String addy;
	private String sido;
	private String sigungu;
	
	public int getHosidx() {
		return hosIdx;
	}
	public void setHosidx(int hosidx) {
		this.hosIdx = hosidx;
	}
	public String getInhosid() {
		return hosId;
	}
	public void setInhosid(String inhosid) {
		this.hosId = inhosid;
	}
	public String getHospw() {
		return hosPw;
	}
	public void setHospw(String hospw) {
		this.hosPw = hospw;
	}
	public String getHosname() {
		return hosName;
	}
	public void setHosname(String hosname) {
		this.hosName = hosname;
	}
	public String getHosphone() {
		return hosPhone;
	}
	public void setHosphone(String hosphone) {
		this.hosPhone = hosphone;
	}
	public String getAnimal() {
		return animal;
	}
	public void setAnimal(String animal) {
		this.animal = animal;
	}
	public double getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}

	
	public String getAddressname() {
		return addressName;
	}
	public void setAddressname(String addressname) {
		this.addressName = addressname;
	}
	public String getRoadaddressname() {
		return roadAddressName;
	}
	public void setRoadaddressname(String roadaddressname) {
		this.roadAddressName = roadaddressname;
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
		return "JoinHospitalVO [hosIdx=" + hosIdx + ", hosId=" + hosId + ", hosPw=" + hosPw + ", hosName=" + hosName
				+ ", hosPhone=" + hosPhone + ", animal=" + animal + ", score=" + score + ", condition=" + condition
				+ ", addressName=" + addressName + ", roadAddressName=" + roadAddressName + ", addx=" + addx + ", addy="
				+ addy + ", sido=" + sido + ", sigungu=" + sigungu + "]";
	}
	
	
}
