package com.letslearn.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.letslearn.Modal.Musician;

public class MusicianDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public MusicianDao(Connection con) {
        this.con = con;
    }

    public int addMusician(Musician musician) {
        int result = 0;
        try {
            query = "INSERT INTO musician (name, genre, tel, age, instrument)\r\n"
                    + "VALUES (?, ?, ?, ?, ?);";
            pst = this.con.prepareStatement(query);
            pst.setString(1, musician.getName());
            pst.setString(2, musician.getGenre());
            pst.setString(3, musician.getTel());
            pst.setInt(4, musician.getAge());
            pst.setString(5, musician.getInstrument());
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Musician> getAllMusicians() {
        List<Musician> musicians = new ArrayList<>();
        try {
            query = "SELECT * FROM musician";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Musician musician = new Musician("", "", "");
                musician.setName(rs.getString("name"));
                musician.setGenre(rs.getString("genre"));
                musician.setTel(rs.getString("tel"));
                musician.setAge(rs.getInt("age"));
                musician.setInstrument(rs.getString("instrument"));
                musician.setId(rs.getString("id"));
                musicians.add(musician);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return musicians;
    }

    public int deleteMusician(String id) {
        int result = 0;
        try {
            query = "DELETE FROM musician WHERE id = ?;";
            pst = this.con.prepareStatement(query);
            pst.setString(1, id);
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateMusician(Musician musician) {
    	System.out.println(musician.getId());
        int result = 0;
        try {
            query = "UPDATE musician SET name = ?, genre = ?, tel = ?, age = ?, instrument = ? WHERE id = ?;";
            pst = this.con.prepareStatement(query);
            pst.setString(1, musician.getName());
            pst.setString(2, musician.getGenre());
            pst.setString(3, musician.getTel());
            pst.setInt(4, musician.getAge());
            pst.setString(5, musician.getInstrument());
            pst.setString(6, musician.getId());
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
