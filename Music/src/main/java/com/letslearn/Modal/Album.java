package com.letslearn.Modal;

public class Album {
    private String title;
    private String artist;
    private int yearReleased;
    private String genre;
    private int numberOfTracks;

    public Album(String title, String artist, int yearReleased, String genre, int numberOfTracks) {
        this.title = title;
        this.artist = artist;
        this.yearReleased = yearReleased;
        this.genre = genre;
        this.numberOfTracks = numberOfTracks;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public int getYearReleased() {
        return yearReleased;
    }

    public void setYearReleased(int yearReleased) {
        this.yearReleased = yearReleased;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getNumberOfTracks() {
        return numberOfTracks;
    }

    public void setNumberOfTracks(int numberOfTracks) {
        this.numberOfTracks = numberOfTracks;
    }
}
