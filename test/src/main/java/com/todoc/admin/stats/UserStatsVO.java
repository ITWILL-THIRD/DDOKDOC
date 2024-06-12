package com.todoc.admin.stats;

import java.util.Date;

public class UserStatsVO {
    private int userIdx;
    private String orderId;
    private String paymentKey;
    private int amount;
    private Date memStart;
    private Date memEnd;
    private String email;
    private String name;
    private int totalAmount;
    
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
	public Date getMemStart() {
		return memStart;
	}
	public void setMemStart(Date memStart) {
		this.memStart = memStart;
	}
	public Date getMemEnd() {
		return memEnd;
	}
	public void setMemEnd(Date memEnd) {
		this.memEnd = memEnd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(int totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	@Override
	public String toString() {
		return "UserStatsVO [userIdx=" + userIdx + ", orderId=" + orderId + ", paymentKey=" + paymentKey + ", amount="
				+ amount + ", memStart=" + memStart + ", memEnd=" + memEnd + ", email=" + email + ", name=" + name
				+ ", totalAmount=" + totalAmount + "]";
	}
}
