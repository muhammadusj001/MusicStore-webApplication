package com.letslearn.Modal;

public class Pensioner  {
	private String city;
	private String grade;
	private String tel;
	private String email;
	private String name;
	private String nic;
	

	public Pensioner() {
		super();
	}

	public Pensioner(String city, String grade, String tel, String email,String name, String nic) {
		super();
		this.city = city;
		this.grade = grade;
		this.tel = tel;
		this.email = email;
		this.name = name;
		this.nic = nic;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNic() {
		return nic;
	}

	public void setNic(String nic) {
		this.nic = nic;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

}
