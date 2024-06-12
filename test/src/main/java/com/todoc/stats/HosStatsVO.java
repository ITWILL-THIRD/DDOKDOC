package com.todoc.stats;

import java.util.Date;

public class HosStatsVO {
    private int hosIdx;
    private String orderId;
    private String paymentKey;
    private int amount;
    private Date hosStart;
    private Date hosEnd;
    
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
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
	public Date getHosStart() {
		return hosStart;
	}
	public void setHosStart(Date hosStart) {
		this.hosStart = hosStart;
	}
	public Date getHosEnd() {
		return hosEnd;
	}
	public void setHosEnd(Date hosEnd) {
		this.hosEnd = hosEnd;
	}
	
    @Override
    public String toString() {
        return "HosStatsVO [hosIdx=" + hosIdx + ", orderId=" + orderId + ", paymentKey=" + paymentKey + ", amount=" + amount + ", hosStart=" + hosStart + ", hosEnd=" + hosEnd + "]";
    }
}
