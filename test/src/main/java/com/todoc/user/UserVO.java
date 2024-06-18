package com.todoc.user;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class UserVO {
	private int userIdx;
	private String email;
	private String nickname;
	private String password;
	private String name;
	private Date birth;
	private String phone;
	private String role;
	private String userImg;
	private String condition;
	//회원 예약, 진료 완료, 노쇼 건수 조회
	private int ReserCount;
	private int FinishCount;
	private int NoShowCount;
	
	
	//회원 리뷰,게시물,댓글 건수 조회
	private int reviewCount;
    private int postCount;
    private int commentCount;
	
	//검색조건 처리용
	@JsonIgnore // JSON 데이터 변경 제외
	private String searchType;
	@JsonIgnore
	private String searchKeyword;
	
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Date getBirth() {
		return birth;
	}
	public void setBirth(Date birth) {
		this.birth = birth;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}

	@Override
	public String toString() {
		return "UserVO [userIdx=" + userIdx + ", email=" + email + ", nickname=" + nickname + ", password=" + password
				+ ", name=" + name + ", birth=" + birth + ", phone=" + phone + ", role=" + role + ", userImg=" + userImg
				+ ", condition=" + condition + ", ReserCount=" + ReserCount + ", FinishCount=" + FinishCount
				+ ", NoShowCount=" + NoShowCount + ", reviewCount=" + reviewCount + ", postCount=" + postCount
				+ ", commentCount=" + commentCount + ", searchType=" + searchType + ", searchKeyword=" + searchKeyword
				+ "]";
	}
	//검색조건 처리용 ------
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	//건수조회
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public int getPostCount() {
		return postCount;
	}
	public void setPostCount(int postCount) {
		this.postCount = postCount;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public int getReserCount() {
		return ReserCount;
	}
	public void setReserCount(int reserCount) {
		ReserCount = reserCount;
	}
	public int getFinishCount() {
		return FinishCount;
	}
	public void setFinishCount(int finishCount) {
		FinishCount = finishCount;
	}
	public int getNoShowCount() {
		return NoShowCount;
	}
	public void setNoShowCount(int noShowCount) {
		NoShowCount = noShowCount;
	}
	
	
	
	
	
	
	
	
};

