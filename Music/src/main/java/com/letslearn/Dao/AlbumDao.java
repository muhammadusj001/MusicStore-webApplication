package com.letslearn.Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.letslearn.Modal.Album;

public class AlbumDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public AlbumDao(Connection con) {
        this.con = con;
    }

    public int addAlbum(Album album) {
        int result = 0;
        try {
            query = "INSERT INTO albums (title, artist, yearReleased, genre, numberOfTracks) VALUES (?, ?, ?, ?, ?);";
            pst = this.con.prepareStatement(query);
            pst.setString(1, album.getTitle());
            pst.setString(2, album.getArtist());
            pst.setInt(3, album.getYearReleased());
            pst.setString(4, album.getGenre());
            pst.setInt(5, album.getNumberOfTracks());
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Album> getAllAlbums() {
        List<Album> albums = new ArrayList<>();
        try {
            query = "SELECT * FROM albums";
            pst = this.con.prepareStatement(query);
            rs = pst.executeQuery();
            while (rs.next()) {
                Album album = new Album(rs.getString("title"), rs.getString("artist"),
                        rs.getInt("yearReleased"), rs.getString("genre"), rs.getInt("numberOfTracks"));
                albums.add(album);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return albums;
    }

    public int deleteAlbum(String title) {
        int result = 0;
        try {
            query = "DELETE FROM albums WHERE title=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, title);
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int updateAlbum(Album album) {
        int result = 0;
        try {
            query = "UPDATE albums SET artist=?, yearReleased=?, genre=?, numberOfTracks=? WHERE title=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, album.getArtist());
            pst.setInt(2, album.getYearReleased());
            pst.setString(3, album.getGenre());
            pst.setInt(4, album.getNumberOfTracks());
            pst.setString(5, album.getTitle());
            result = pst.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
