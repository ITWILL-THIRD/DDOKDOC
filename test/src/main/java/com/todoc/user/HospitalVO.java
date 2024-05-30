package com.todoc.user;

public class HospitalVO {
	private int hosIdx;
	private String hosId;
	private String hosPw;
	private String hosName;
	private String hosPhone;
	private String animal;
	private int score;
	private String condition;
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	public String getHosId() {
		return hosId;
	}
	public void setHosId(String hosId) {
		this.hosId = hosId;
	}
	public String getHosPw() {
		return hosPw;
	}
	public void setHosPw(String hosPw) {
		this.hosPw = hosPw;
	}
	public String getHosName() {
		return hosName;
	}
	public void setHosName(String hosName) {
		this.hosName = hosName;
	}
	public String getHosPhone() {
		return hosPhone;
	}
	public void setHosPhone(String hosPhone) {
		this.hosPhone = hosPhone;
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
	@Override
	public String toString() {
		return "HospitalVO [hosIdx=" + hosIdx + ", hosId=" + hosId + ", hosPw=" + hosPw + ", hosName=" + hosName
				+ ", hosPhone=" + hosPhone + ", animal=" + animal + ", score=" + score + ", condition=" + condition
				+ "]";
	}
	
	
	

}
