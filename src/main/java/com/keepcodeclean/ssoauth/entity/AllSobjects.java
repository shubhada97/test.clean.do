package com.keepcodeclean.ssoauth.entity;

import java.util.List;


public class AllSobjects {

private String encoding;
private int maxBatchSize;
	private List<Sobjects> sobjects;
	public String getEncoding() {
		return encoding;
	}
	public void setEncoding(String encoding) {
		this.encoding = encoding;
	}
	public int getMaxBatchSize() {
		return maxBatchSize;
	}
	public void setMaxBatchSize(int maxBatchSize) {
		this.maxBatchSize = maxBatchSize;
	}
	public List<Sobjects> getSobjects() {
		return sobjects;
	}
	public void setSobjects(List<Sobjects> sobjects) {
		this.sobjects = sobjects;
	}
	@Override
	public String toString() {
		return "AllSobjects [encoding=" + encoding + ", maxBatchSize=" + maxBatchSize + ", sobjects=" + sobjects + "]";
	}

	
	
}
