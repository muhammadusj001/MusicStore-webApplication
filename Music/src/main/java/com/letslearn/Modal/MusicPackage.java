package com.letslearn.Modal;

public class MusicPackage {
    private int id;
    private String name;
    private String price;
    private String numberOfSongs;
    private boolean unlimitedStreaming;
	public MusicPackage(int id, String name, String price, String numberOfSongs, boolean unlimitedStreaming) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.numberOfSongs = numberOfSongs;
		this.unlimitedStreaming = unlimitedStreaming;
	}
	
	public MusicPackage(String name, String price, String numberOfSongs, boolean unlimitedStreaming) {
		super();
		this.name = name;
		this.price = price;
		this.numberOfSongs = numberOfSongs;
		this.unlimitedStreaming = unlimitedStreaming;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getNumberOfSongs() {
		return numberOfSongs;
	}
	public void setNumberOfSongs(String numberOfSongs) {
		this.numberOfSongs = numberOfSongs;
	}
	public boolean isUnlimitedStreaming() {
		return unlimitedStreaming;
	}
	public void setUnlimitedStreaming(boolean unlimitedStreaming) {
		this.unlimitedStreaming = unlimitedStreaming;
	}

   
}
