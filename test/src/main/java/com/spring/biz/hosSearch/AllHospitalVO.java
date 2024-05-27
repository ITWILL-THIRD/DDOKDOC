package com.spring.biz.hosSearch;

public class AllHospitalVO {
	private int hosidx;
	private String inhosid;
	private String hospw;
	private String hosname;
	private String hosphone;
	private String animal;
	private int score;
	private String condition;
	
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
	public String getInhosid() {
		return inhosid;
	}
	public void setInhosid(String inhosid) {
		this.inhosid = inhosid;
	}
	public String getHospw() {
		return hospw;
	}
	public void setHospw(String hospw) {
		this.hospw = hospw;
	}
	public String getHosname() {
		return hosname;
	}
	public void setHosname(String hosname) {
		this.hosname = hosname;
	}
	public String getHosphone() {
		return hosphone;
	}
	public void setHosphone(String hosphone) {
		this.hosphone = hosphone;
	}
	public String getAnimal() {
		return animal;
	}
	public void setAnimal(String animal) {
		this.animal = animal;
	}
	public int getScore() {
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
		return "AllHospitalVO [hosidx=" + hosidx + ", inhosid=" + inhosid + ", hospw=" + hospw + ", hosname=" + hosname
				+ ", hosphone=" + hosphone + ", animal=" + animal + ", score=" + score + ", condition=" + condition
				+ ", addressname=" + addressname + ", roadaddressname=" + roadaddressname + ", addx=" + addx + ", addy="
				+ addy + ", sido=" + sido + ", sigungu=" + sigungu + "]";
	}
}
