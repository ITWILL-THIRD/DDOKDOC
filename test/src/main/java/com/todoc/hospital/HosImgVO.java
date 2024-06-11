package com.todoc.hospital;

public class HosImgVO {
	private int imgIdx;
	private int hosIdx;
	private String hosImg;
	
	public int getImgIdx() {
		return imgIdx;
	}
	public void setImgIdx(int imgIdx) {
		this.imgIdx = imgIdx;
	}
	public int getHosIdx() {
		return hosIdx;
	}
	public void setHosIdx(int hosIdx) {
		this.hosIdx = hosIdx;
	}
	public String getHosImg() {
		return hosImg;
	}
	public void setHosImg(String hosImg) {
		this.hosImg = hosImg;
	}
	
	@Override
	public String toString() {
		return "hosImgVO [imgIdx=" + imgIdx + ", hosIdx=" + hosIdx + ", hosImg=" + hosImg + "]";
	}
}
