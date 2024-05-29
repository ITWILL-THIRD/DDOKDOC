package com.todoc.mypet;

public class MyPetVO {
	private int petIdx;
	private int userIdx;
	private String animal;
	private String petName;
	private int petAge;
	
	public int getPetidx() {
		return petIdx;
	}
	public void setPetidx(int petidx) {
		this.petIdx = petidx;
	}
	public int getUseridx() {
		return userIdx;
	}
	public void setUseridx(int useridx) {
		this.userIdx = useridx;
	}
	public String getAnimal() {
		return animal;
	}
	public void setAnimal(String animal) {
		this.animal = animal;
	}
	public String getPetname() {
		return petName;
	}
	public void setPetname(String petname) {
		this.petName = petname;
	}
	public int getPetage() {
		return petAge;
	}
	public void setPetage(int petage) {
		this.petAge = petage;
	}
	
	@Override
	public String toString() {
		return "MyPetVO [petidx=" + petIdx + ", useridx=" + userIdx + ", animal=" + animal + ", petname=" + petName
				+ ", petage=" + petAge + "]";
	}
	
}
