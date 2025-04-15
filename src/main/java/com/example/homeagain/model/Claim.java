package com.example.homeagain.model;

import java.util.Date;

public class Claim {
    private int claimId;
    private boolean claimStatus;
    private Date claimDate;

    public Claim(int claimId, boolean claimStatus, Date claimDate) {
        this.claimId = claimId;
        this.claimStatus = claimStatus;
        this.claimDate = claimDate;
    }

    //getter and setter methods
    public int getClaimId() {
        return claimId;
    }
    public void setClaimId(int claimId) {
        this.claimId = claimId;
    }
    public boolean isClaimStatus() {
        return claimStatus;
    }
    public void setClaimStatus(boolean claimStatus) {
        this.claimStatus = claimStatus;    }
    public Date getClaimDate() {
        return claimDate;
    }
    public void setClaimDate(Date claimDate) {
        this.claimDate = claimDate;
    }
}