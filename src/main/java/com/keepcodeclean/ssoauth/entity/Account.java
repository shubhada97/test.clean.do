package com.keepcodeclean.ssoauth.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Account {
//  public String Id;
	public String Label;
	public String QualifiedApiName;

	public String getLabel() {
		return Label;
	}

	public void setLabel(String label) {
		Label = label;
	}

	public String getQualifiedApiName() {
		return QualifiedApiName;
	}

	@Override
	public String toString() {
		return "Account [Label=" + Label + ", QualifiedApiName=" + QualifiedApiName + "]";
	}

	public void setQualifiedApiName(String qualifiedApiName) {
		QualifiedApiName = qualifiedApiName;
	}
}
