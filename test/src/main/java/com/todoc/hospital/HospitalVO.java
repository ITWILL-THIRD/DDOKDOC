package com.todoc.hospital;

import java.time.LocalTime;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class HospitalVO {
   //hospital 테이블
   private int hosIdx;
   private String hosId;
   private String hosPw;
   private String hosName;
   private String hosPhone;
   private String animal;
   private double score;
   private String condition;
   //hostime 테이블
   private LocalTime openTime;
   private LocalTime closeTime;
   private LocalTime lunchTime;
   private LocalTime endLunchTime;
   // +토요일 시간 컬럼4개 추가
   private LocalTime satOpenTime;
   private LocalTime satCloseTime;
   private LocalTime satLunchTime;
   private LocalTime satEndLunchTime;
   //hosaddress 테이블
   private String addressName;
   private String roadAddressName;
   private String detailAddress;
   private String addx;
   private String addy;
   private String sido;
   private String sigungu;
   
   //병원 검색 조건 처리용
   @JsonIgnore
   private String searchCondition;
   @JsonIgnore
   private String searchKeyword;
   
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
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public LocalTime getOpenTime() {
		return openTime;
	}
	public void setOpenTime(LocalTime openTime) {
		this.openTime = openTime;
	}
	public LocalTime getCloseTime() {
		return closeTime;
	}
	public void setCloseTime(LocalTime closeTime) {
		this.closeTime = closeTime;
	}
	public LocalTime getLunchTime() {
		return lunchTime;
	}
	public void setLunchTime(LocalTime lunchTime) {
		this.lunchTime = lunchTime;
	}
	public LocalTime getEndLunchTime() {
		return endLunchTime;
	}
	public void setEndLunchTime(LocalTime endLunchTime) {
		this.endLunchTime = endLunchTime;
	}
	public LocalTime getSatOpenTime() {
		return satOpenTime;
	}
	public void setSatOpenTime(LocalTime satOpenTime) {
		this.satOpenTime = satOpenTime;
	}
	public LocalTime getSatCloseTime() {
		return satCloseTime;
	}
	public void setSatCloseTime(LocalTime satCloseTime) {
		this.satCloseTime = satCloseTime;
	}
	public LocalTime getSatLunchTime() {
		return satLunchTime;
	}
	public void setSatLunchTime(LocalTime satLunchTime) {
		this.satLunchTime = satLunchTime;
	}
	public LocalTime getSatEndLunchTime() {
		return satEndLunchTime;
	}
	public void setSatEndLunchTime(LocalTime satEndLunchTime) {
		this.satEndLunchTime = satEndLunchTime;
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
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
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
	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	@Override
	public String toString() {
		return "HospitalVO [hosIdx=" + hosIdx + ", hosId=" + hosId + ", hosPw=" + hosPw + ", hosName=" + hosName
				+ ", hosPhone=" + hosPhone + ", animal=" + animal + ", score=" + score + ", condition=" + condition
				+ ", openTime=" + openTime + ", closeTime=" + closeTime + ", lunchTime=" + lunchTime + ", endLunchTime="
				+ endLunchTime + ", satOpenTime=" + satOpenTime + ", satCloseTime=" + satCloseTime + ", satLunchTime="
				+ satLunchTime + ", satEndLunchTime=" + satEndLunchTime + ", addressName=" + addressName
				+ ", roadAddressName=" + roadAddressName + ", detailAddress=" + detailAddress + ", addx=" + addx
				+ ", addy=" + addy + ", sido=" + sido + ", sigungu=" + sigungu + ", searchCondition=" + searchCondition
				+ ", searchKeyword=" + searchKeyword + "]";
	}
	   
}
