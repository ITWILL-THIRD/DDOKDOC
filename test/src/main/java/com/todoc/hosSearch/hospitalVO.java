package com.todoc.hosSearch;

public class hospitalVO {
	private int hosidx;
	private String inhosid;
	private String hospw;
	private String hosname;
	private String hosphone;
	private String animal;
	private double score;
	private String condition;
	
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
		return "hospitalVO [hosidx=" + hosidx + ", inhosid=" + inhosid + ", hospw=" + hospw + ", hosname=" + hosname
				+ ", hosphone=" + hosphone + ", animal=" + animal + ", score=" + score + ", condition=" + condition
				+ "]";
	}
}
