package com.todoc.membership;

import java.util.Date;

import org.json.simple.JSONObject;

public class HosMembershipVO {
	private int hosIdx;
	private String orderId;
	private int amount;
	private String paymentKey;
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
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getPaymentKey() {
		return paymentKey;
	}
	public void setPaymentKey(String paymentKey) {
		this.paymentKey = paymentKey;
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
	public void put(String string, String string2) {
		// TODO Auto-generated method stub
		
	}
	public void put(String string, int i) {
		// TODO Auto-generated method stub
		
	}
	public void put(String string, boolean b) {
		// TODO Auto-generated method stub
		
	}
	
	public String toJSONString() {
		JSONObject jsonObject = new JSONObject();

		return jsonObject.toString();
	}
	@Override
	public String toString() {
		return "HosMembershipVO [hosIdx=" + hosIdx + ", orderId=" + orderId + ", amount=" + amount + ", paymentKey="
				+ paymentKey + ", startDate=" + hosStart + ", endDate=" + hosEnd + "]";
	}
	
	
}