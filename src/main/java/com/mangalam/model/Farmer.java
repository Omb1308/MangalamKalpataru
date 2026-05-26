package com.mangalam.model;

public class Farmer {
    private String fullName;
    private String email; // Naya field
    private String locality;
    private String upiId;
    private String password;

    // Getters and Setters
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getLocality() { return locality; }
    public void setLocality(String locality) { this.locality = locality; }

    public String getUpiId() { return upiId; }
    public void setUpiId(String upiId) { this.upiId = upiId; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}