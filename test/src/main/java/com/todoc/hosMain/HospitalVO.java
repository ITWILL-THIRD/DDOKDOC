package com.todoc.hosMain;

import java.sql.Time;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class HospitalVO {
	private int hosIdx;
	private String hosId;
	private String hosPw;
	private String hosName;
	private String hosPhone;
	private String animal;
	private double score;
	private String condition;

	//hostime 테이블
	private Time openTime;
	private Time closeTime;
	private Time lunchTime;
	private Time endLunchTime;

	//hosaddress 테이블
	private String addressName;
	private String roadAddressName;
	private String detailAddress;
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
	public Time getOpenTime() {
		return openTime;
	}
	public void setOpenTime(Time openTime) {
		this.openTime = openTime;
	}
	public Time getCloseTime() {
		return closeTime;
	}
	public void setCloseTime(Time closeTime) {
		this.closeTime = closeTime;
	}
	public Time getLunchTime() {
		return lunchTime;
	}
	public void setLunchTime(Time lunchTime) {
		this.lunchTime = lunchTime;
	}
	public Time getEndLunchTime() {
		return endLunchTime;
	}
	public void setEndLunchTime(Time endLunchTime) {
		this.endLunchTime = endLunchTime;
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
	//병원 검색 조건 처리용
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
				+ endLunchTime + ", addressName=" + addressName + ", roadAddressName=" + roadAddressName
				+ ", detailAddress=" + detailAddress + ", addx=" + addx + ", addy=" + addy + ", sido=" + sido

				+ ", sigungu=" + sigungu + ", searchCondition=" + searchCondition + ", searchKeyword=" + searchKeyword
				+ "]";
	}
}
