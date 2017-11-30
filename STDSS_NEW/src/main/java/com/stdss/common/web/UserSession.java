package com.stdss.common.web;

import java.io.Serializable;

import com.stdss.common.model.User;


public class UserSession implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private User user;
	
	public UserSession(User user) {
		this.user = user;
	}
	
	public User getUser() {
		return user;
	}
}
