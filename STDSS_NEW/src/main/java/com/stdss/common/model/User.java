package com.stdss.common.model;

import java.io.Serializable;

public class User implements Serializable {

	private String user_id;
	private String user_pwd;
	private String user_group;
	private String user_city_code;
	private String user_name;
	private String user_tel;
	private String user_email;
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public String getUser_group() {
		return user_group;
	}
	public void setUser_group(String user_group) {
		this.user_group = user_group;
	}
	public String getUser_city_code() {
		return user_city_code;
	}
	public void setUser_city_code(String user_city_code) {
		this.user_city_code = user_city_code;
	}
	public String getUser_name(){
		return user_name;
	}  
	public String getUser_tel(){
		return user_tel;
	}
	public String getUser_email(){
		return user_email;
	}
}