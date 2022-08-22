package com.keepcodeclean.ssoauth.entity;

public class ObjectRecord {
	
	@Override
	public String toString() {
		return "ObjectRecord [totalsize=" + totalsize + "]";
	}

	public int getTotalsize() {
		return totalsize;
	}

	public void setTotalsize(int totalsize) {
		this.totalsize = totalsize;
	}

	private int totalsize;
	

}
