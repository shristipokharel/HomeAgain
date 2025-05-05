package com.example.homeagain.model;

import java.sql.Timestamp;

public class Contact {
    private int id;
    private String name;
    private String email;
    private String subject;
    private String message;
    private Integer userId;
    private Timestamp createdAt;

    // Default constructor
    public Contact() {}

    // Constructor with fields
    public Contact(String name, String email, String subject, String message, Integer userId) {
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.userId = userId;
    }

    // Getters and Setters
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
} 