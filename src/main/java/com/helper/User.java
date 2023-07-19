package com.helper;

public class User {
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(String surname) {
		this.surname = surname;
	}

	public String getMailAddress() {
		return email;
	}

	public void setMailAddress(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public boolean getLoginStatus() {
		return loginStatus;
	}

	public void setLoginStatus(boolean loginStatus) {
		this.loginStatus = loginStatus;
	}

	private int userId;
	private String name;
	private String surname;
	private String email;
	private String phoneNumber;
	private boolean loginStatus;

}
