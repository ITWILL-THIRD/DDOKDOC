package com.todoc.hosMain;

public class hospitalVO {
	private int hosIdx;
	private String hosId;
	private String hosPw;
	private String hosName;
	private String hosPhone;
	private String animal;
	private double score;
	private String condition;
	
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
	
	@Override
	public String toString() {
		return "hospitalVO [hosIdx=" + hosIdx + ", hosId=" + hosId + ", hosPw=" + hosPw + ", hosName=" + hosName
				+ ", hosPhone=" + hosPhone + ", animal=" + animal + ", score=" + score + ", condition=" + condition
				+ "]";
	}
	
}
