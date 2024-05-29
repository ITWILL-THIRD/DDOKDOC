package com.todoc.user;

import java.sql.Date;

public class UserVO {
	private int userIdx;
	private String email;
	private String nickName;
	private String password;
	private String name;
	private Date birth;
	private String phone;
	private String role;
	
	// 임시 사용자 데이터
	public UserVO(int userIdx, String email, String nickName) {
	    this.userIdx = userIdx;
	    this.email = email;
	    this.nickName = nickName;
	}
	
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
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
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
	
	@Override
	public String toString() {
		return "UserVO [userIdx=" + userIdx + ", email=" + email + ", nickName=" + nickName + ", password=" + password
				+ ", name=" + name + ", birth=" + birth + ", phone=" + phone + ", role=" + role + "]";
	}
	
	

}
