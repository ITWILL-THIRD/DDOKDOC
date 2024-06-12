package com.todoc.stats;

import java.util.Date;

public class UserStatsVO {
    private int userIdx;
    private String orderId;
    private String paymentKey;
    private int amount;
    private Date memStart;
    private Date memEnd;
    
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
	
	@Override
	public String toString() {
		return "UserStatsVO [userIdx=" + userIdx + ", orderId=" + orderId + ", paymentKey=" + paymentKey + ", amount="
				+ amount + ", memStart=" + memStart + ", memEnd=" + memEnd + "]";
	}
}
