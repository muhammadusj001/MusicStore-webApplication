package com.letslearn.Modal;

public class Musician extends Admin {
    private String genre;
    private int age;
    private String instrument;
    private String id;
    private String tel;

    public Musician(String name, String email, String nic) {
        super(name, email, nic);
    }

    public Musician(String name, String email, String nic, String genre, int age, String instrument, String id, String tel) {
        super(name, email, nic);
        this.genre = genre;
        this.age = age;
        this.instrument = instrument;
        this.id = id;
        this.tel = tel;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getInstrument() {
        return instrument;
    }

    public void setInstrument(String instrument) {
        this.instrument = instrument;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }
}
