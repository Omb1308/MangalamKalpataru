package com.mangalam.model;

public class CartItem {

    private String cartId;
    private String pId;
    private String pName;
    private double price;
    private int quantity;
    private String imageUrl;

    // 🔹 GETTERS

    private String productName;

    public String getProductName() {
        return productName;
    }
    
    
    
    public String getCartId() {
        return cartId;
    }

    public String getpId() {
        return pId;
    }

    public String getpName() {
        return pName;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    // 🔹 SETTERS

    public void setCartId(String cartId) {
        this.cartId = cartId;
    }

    public void setpId(String pId) {
        this.pId = pId;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}