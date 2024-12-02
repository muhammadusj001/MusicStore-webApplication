package com.letslearn.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.letslearn.Modal.MusicPackage;

public class MusicPackageDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public MusicPackageDao(Connection con) {
        this.con = con;
    }

    public int addMusicPackage(MusicPackage musicPackage) {
        int result = 0;
        try {
            query = "INSERT INTO music_package1 (name, price, numberOfSongs, unlimitedStreaming) VALUES (?, ?, ?, ?);";
            pst = this.con.prepareStatement(query);
            pst.setString(1, musicPackage.getName());
            pst.setString(2, musicPackage.getPrice());
            pst.setString(3, musicPackage.getNumberOfSongs());
            pst.setBoolean(4, musicPackage.isUnlimitedStreaming());
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<MusicPackage> getAllMusicPackages() {
        List<MusicPackage> musicPackages = new ArrayList<>();
        try {
            query = "SELECT * FROM music_package";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                MusicPackage musicPackage = new MusicPackage("", "", "", false);
                musicPackage.setId(rs.getInt("id"));
                musicPackage.setName(rs.getString("name"));
                musicPackage.setPrice(rs.getString("price"));
                musicPackage.setNumberOfSongs(rs.getString("numberOfSongs"));
                musicPackage.setUnlimitedStreaming(rs.getBoolean("unlimitedStreaming"));
                musicPackages.add(musicPackage);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return musicPackages;
    }

    public int deleteMusicPackage(int id) {
        int result = 0;
        try {
            query = "DELETE FROM music_package WHERE id = ?;";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateMusicPackage(MusicPackage musicPackage) {
        int result = 0;
        try {
            query = "UPDATE music_package SET name = ?, price = ?, numberOfSongs = ?, unlimitedStreaming = ? WHERE id = ?;";
            pst = this.con.prepareStatement(query);
            pst.setString(1, musicPackage.getName());
            pst.setString(2, musicPackage.getPrice());
            pst.setString(3, musicPackage.getNumberOfSongs());
            pst.setBoolean(4, musicPackage.isUnlimitedStreaming());
            pst.setInt(5, musicPackage.getId());
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
