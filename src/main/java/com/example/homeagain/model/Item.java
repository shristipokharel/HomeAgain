package com.example.homeagain.model;

import java.util.Date;

public class Item {
    private int id;
    private String title;
    private String description;
    private String imagePath;
    private String postType;   // "lost" or "found"
    private boolean approvalStatus;  // true if admin approves
    private String itemStatus; // "Claimed" or "Received"
    private int userId;        // foreign key to the user
    private Date postedDate;


    public Item(int id, String title, String description, String imagePath,
                String postType, boolean approved, String itemStatus, int userId, Date postedDate) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.imagePath = imagePath;
        this.postType = postType;
        this.approvalStatus = approved;
        this.itemStatus = itemStatus;
        this.userId = userId;
        this.postedDate = postedDate;
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

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getPostType() {
        return postType;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public String getItemStatus() {
        return itemStatus;
    }

    public void setItemStatus(String itemStatus) {
        this.itemStatus = itemStatus;
    }

    public boolean isApproved() {
        return approvalStatus;
    }

    public void setApproved(boolean approved) {
        this.approvalStatus = approved;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getPostedDate() {
        return postedDate;
    }

    public void setPostedDate(Date postedDate) {
        this.postedDate = postedDate;
    }
}
