package com.example.homeagain.model;

public class Category {
    private int id;
    private String name;
    private String description;

    // Default constructor
    public Category() {
    }

    // Constructor with name and description
    public Category(String name, String description) {
        this.name = name;
        this.description = description;
    }
    
    // Constructor with id, name and description
    public Category(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
} 