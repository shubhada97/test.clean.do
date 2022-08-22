package com.keepcodeclean.ssoauth.domain;

import lombok.Data;

public @Data class User {
    
	public User(String user_id, String name, String email) {
		
		this.user_id = user_id;
		this.name = name;
		this.email = email;
	}
	private  String user_id;
    private  String name;
    private  String email;
   
}
