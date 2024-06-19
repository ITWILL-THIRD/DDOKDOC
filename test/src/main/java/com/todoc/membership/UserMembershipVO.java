package com.todoc.membership;

import java.util.Date;

public class UserMembershipVO {
	private int userIdx;
	private String orderId;
	private String paymentKey;
	private int amount;
	private Date memstart;
	private Date memend;
	private String startformattedDate;
	private String endformattedDate;
	
	public int getUserIdx() {
		return userIdx;
	}
	public void setUserIdx(int userIdx) {
		this.userIdx = userIdx;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public Date getMemstart() {
		return memstart;
	}
	public void setMemstart(Date memstart) {
		this.memstart = memstart;
	}
	public Date getMemend() {
		return memend;
	}
	public void setMemend(Date memend) {
		this.memend = memend;
	}
	public String getStartformattedDate() {
		return startformattedDate;
	}
	public void setStartformattedDate(String startformattedDate) {
		this.startformattedDate = startformattedDate;
	}
	public String getEndformattedDate() {
		return endformattedDate;
	}
	public void setEndformattedDate(String endformattedDate) {
		this.endformattedDate = endformattedDate;
	}
	@Override
	public String toString() {
		return "UserMembershipVO [userIdx=" + userIdx + ", orderId=" + orderId + ", paymentKey=" + paymentKey
				+ ", amount=" + amount + ", memstart=" + memstart + ", memend=" + memend + ", startformattedDate="
				+ startformattedDate + ", endformattedDate=" + endformattedDate + "]";
	}
	
	
}
