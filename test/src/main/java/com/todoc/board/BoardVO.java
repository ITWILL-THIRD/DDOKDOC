 package com.todoc.board;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;

public class BoardVO {
	private int postidx;
	private int useridx;
	private String title;
	private String category;
	private String content;
	private Date postdate;
	private int hit;
	private String img;
	private String nickname;
	private String formattedDate;
	
	//검색조건 처리용
	@JsonIgnore // JSON 데이터 변경 제외
	private String searchCondition;
	@JsonIgnore
	private String searchKeyword;
	
	public int getPostidx() {
		return postidx;
	}
	public void setPostidx(int postidx) {
		this.postidx = postidx;
	}
	public int getUseridx() {
		return useridx;
	}
	public void setUseridx(int useridx) {
		this.useridx = useridx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date getPostdate() {
		return postdate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public void setPostdate(Date postdate) {
		this.postdate = postdate;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	@Override
	public String toString() {
		return "boardVO [postidx=" + postidx + ", useridx=" + useridx + ", title=" + title + ", category=" + category
				+ ", content=" + content + ", postdate=" + postdate + ", hit=" + hit + img + "]";
	}
	
	//검색조건 처리용
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
	
	public String getFormattedDate() {
		return formattedDate;
	}
	public void setFormattedDate(String formattedDate) {
		this.formattedDate = formattedDate;
	}
	
}
