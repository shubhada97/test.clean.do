package com.keepcodeclean.ssoauth.entity;

import java.util.List;

public class ObjectResponse {

	private String label;
	private String name;
	private String type;
	private List<Fields> fields;

	public List<Fields> getFields() {
		return fields;
	}

	public void setFields(List<Fields> fields) {
		this.fields = fields;
	}

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

	@Override
	public String toString() {
		return "ObjectResponse [label=" + label + ", name=" + name + ", type=" + type + ", fields=" + fields + "]";
	}

}
