package com.letslearn.Dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.letslearn.Modal.Pensioner;

public class PensionerDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public PensionerDao(Connection con) {
		this.con = con;
	}

	public int addPensioner(Pensioner pensioner) {
		int result = 0;
		try {
			query = "INSERT INTO pensioner (name,email,nic,city,grade,tel)\r\n" + "VALUES (?,?,?,?,?,?);";
			pst = this.con.prepareStatement(query);
			pst.setString(1, pensioner.getName());
			pst.setString(2, pensioner.getEmail());
			pst.setString(3, pensioner.getNic());
			pst.setString(4, pensioner.getCity());
			pst.setString(5, pensioner.getGrade());
			pst.setString(6, pensioner.getTel());
			result = pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public List<Pensioner> getAllPensioners() {
		List<Pensioner> pensioner = new ArrayList<Pensioner>();
		try {
			query = "select * from pensioner";
			pst = this.con.prepareStatement(query);
			rs = pst.executeQuery();
			while (rs.next()) {
				Pensioner cpn = new Pensioner();
				cpn.setCity(rs.getString("city"));
				cpn.setName(rs.getString("name"));
				cpn.setNic(rs.getString("nic"));
				cpn.setEmail(rs.getString("email"));
				cpn.setGrade(rs.getString("grade"));
				cpn.setTel(rs.getString("tel"));
				pensioner.add(cpn);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pensioner;

	}

	public Pensioner getPensionerById(String email) {

		Pensioner cpn = new Pensioner();
		try {
			query = "select * from pensioner where email=?";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);
			rs = pst.executeQuery();
			while (rs.next()) {
				cpn.setCity(rs.getString("city"));
				cpn.setName(rs.getString("name"));
				cpn.setNic(rs.getString("nic"));
				cpn.setEmail(rs.getString("email"));
				cpn.setGrade(rs.getString("grade"));
				cpn.setTel(rs.getString("tel"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cpn;

	}

	public int deletePensioner(String email) {
		int result = 0;
		try {
			query = "DELETE FROM pensioner WHERE email=?;";
			pst = this.con.prepareStatement(query);
			pst.setString(1, email);

			result = pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updatePensioner(Pensioner pensioner) {
		int result = 0;
		try {
			query = "UPDATE pensioner SET name = ?, grade= ? , city=?,nic=?,tel=? WHERE email = ?;";
			pst = this.con.prepareStatement(query);
			pst.setString(1, pensioner.getName());
			pst.setString(2, pensioner.getGrade());
			pst.setString(3, pensioner.getCity());
			pst.setString(4, pensioner.getNic());
			pst.setString(5, pensioner.getTel());
			pst.setString(6, pensioner.getEmail());
			result = pst.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
