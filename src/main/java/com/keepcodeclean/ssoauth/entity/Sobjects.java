package com.keepcodeclean.ssoauth.entity;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Sobjects {

	private String name;
	private String label;
	private boolean createable;
	private boolean queryable;
	private boolean updateable;
	private boolean  searchable;
	private boolean  layoutable;
	private boolean  triggerable;
	public boolean isTriggerable() {
		return triggerable;
	}
	public void setTriggerable(boolean triggerable) {
		this.triggerable = triggerable;
	}
	public boolean isLayoutable() {
		return layoutable;
	}
	public void setLayoutable(boolean layoutable) {
		this.layoutable = layoutable;
	}
	public boolean isSearchable() {
		return searchable;
	}
	public void setSearchable(boolean searchable) {
		this.searchable = searchable;
	}
	public boolean isUpdateable() {
		return updateable;
	}
	public void setUpdateable(boolean updateable) {
		this.updateable = updateable;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public boolean isCreateable() {
		return createable;
	}
	public void setCreateable(boolean createable) {
		this.createable = createable;
	}
	public boolean isQueryable() {
		return queryable;
	}
	public void setQueryable(boolean queryable) {
		this.queryable = queryable;
	}
	@Override
	public String toString() {
		return "Sobjects [name=" + name + ", label=" + label + ", createable=" + createable + ", queryable=" + queryable
				+ ", updateable=" + updateable + ", searchable=" + searchable + ", layoutable=" + layoutable
				+ ", triggerable=" + triggerable + "]";
	}
	   
	
	
	
	
	
}
