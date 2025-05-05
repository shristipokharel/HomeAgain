package com.example.homeagain.model;

import java.sql.Timestamp;

public class Item {
    private int id;
    private String title;
    private String description;
    private int categoryId;
    private String imageUrl;
    private String location;
    private String postType;  // "lost" or "found"
    private String status;    // "pending", "approved", "rejected"
    private String rejectionReason;
    private int userId;
    private Timestamp postedAt;
    private String type;  // "lost" or "found"

    // Default constructor
    public Item() {
    }

    public Item(int id, String title, String description, int categoryId, String imageUrl,
                String location, String postType, String status, String rejectionReason,
                int userId, Timestamp postedAt) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.categoryId = categoryId;
        this.imageUrl = imageUrl;
        this.location = location;
        this.postType = postType;
        this.status = status;
        this.rejectionReason = rejectionReason;
        this.userId = userId;
        this.postedAt = postedAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRejectionReason() {
        return rejectionReason;
    }

    public void setRejectionReason(String rejectionReason) {
        this.rejectionReason = rejectionReason;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Timestamp getPostedAt() {
        return postedAt;
    }

    public void setPostedAt(Timestamp postedAt) {
        this.postedAt = postedAt;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
} 