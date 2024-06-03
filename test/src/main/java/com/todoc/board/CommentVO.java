package com.todoc.board;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CommentVO {
	private int commentidx;
	private int postidx;
	private int useridx;
	private String content;
	private Date commentdate;
	private String nickname;
	private String formattedCommentDate;
	
	public int getCommentidx() {
		return commentidx;
	}
	public void setCommentidx(int commentidx) {
		this.commentidx = commentidx;
	}
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public Date getCommentdate() {
		return commentdate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	public void setCommentdate(Date commentdate) {
		this.commentdate = commentdate;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	@Override
	public String toString() {
		return "CommentVO [commentidx=" + commentidx + ", postidx=" + postidx + ", useridx=" + useridx + ", content="
				+ content + ", commentdate=" + commentdate + "]";
	}
	public String getFormattedCommentDate() {
		return formattedCommentDate;
	}
	public void setFormattedCommentDate(String formattedDate) {
		this.formattedCommentDate = formattedCommentDate;
	}
	
	
}
