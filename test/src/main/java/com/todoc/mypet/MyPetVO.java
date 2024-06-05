package com.todoc.mypet;

public class MyPetVO {
	private int petIdx;
	private int userIdx;
	private String animal;
	private String petName;
	private int petAge;
	private String petImg;
	
	public String getPetImg() {
		return petImg;
	}
	public void setPetImg(String petImg) {
		this.petImg = petImg;
	}
	public int getPetIdx() {
		return petIdx;
	}
	public void setPetIdx(int petIdx) {
		this.petIdx = petIdx;
	}
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getAnimal() {
		return animal;
	}
	public void setAnimal(String animal) {
		this.animal = animal;
	}
	public String getPetName() {
		return petName;
	}
	public void setPetName(String petName) {
		this.petName = petName;
	}
	public int getPetAge() {
		return petAge;
	}
	public void setPetAge(int petAge) {
		this.petAge = petAge;
	}
	
	@Override
	public String toString() {
		return "MyPetVO [petIdx=" + petIdx + ", userIdx=" + userIdx + ", animal=" + animal + ", petName=" + petName
				+ ", petAge=" + petAge + ", petImg=" + petImg + "]";
	}
	
}
