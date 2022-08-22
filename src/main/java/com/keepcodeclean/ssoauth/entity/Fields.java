package com.keepcodeclean.ssoauth.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Fields {

	private String label;
	private String name;
	private String type;
	private boolean isCreateable;

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public boolean isCreateable() {
		return isCreateable;
	}

	public void setCreateable(boolean isCreateable) {
		this.isCreateable = isCreateable;
	}

	@Override
	public String toString() {
		return "Fields [label=" + label + ", name=" + name + ", type=" + type + ", isCreateable=" + isCreateable + "]";
	}

}
