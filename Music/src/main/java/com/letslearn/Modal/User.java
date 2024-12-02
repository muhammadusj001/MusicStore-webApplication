package com.letslearn.Modal;

public class User {
	private String name;
	private String tel;
	private String nic;
	
	
	
	public User(String name, String email, String nic) {
		super();
		this.name = name;
		this.tel = email;
		this.nic = nic;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String email) {
		this.tel = email;
	}
	public String getNic() {
		return nic;
	}
	public void setNic(String nic) {
		this.nic = nic;
	}
	
	
}
