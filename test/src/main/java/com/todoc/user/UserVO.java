package com.todoc.user;

import java.sql.Date;

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
				+ "]";
	}
	
	
};

