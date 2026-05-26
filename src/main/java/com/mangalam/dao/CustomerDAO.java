package com.mangalam.dao;

import java.sql.*;
import com.mangalam.model.Customer;
import com.mangalam.util.DBConnection;

public class CustomerDAO {
    public int registerCustomer(Customer customer) {
        int result = 0;
        // Recommendation: Use uppercase column names to match Oracle's default structure
        String sql = "INSERT INTO customers (FULL_NAME, EMAIL, MOBILE, PASSWORD, ADDRESS) VALUES (?, ?, ?, ?, ?)";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            // 💡 Change: Adding .trim() to ensure no accidental spaces are saved, 
            // especially for email which is used for login.
            ps.setString(1, customer.getFullName().trim());
            ps.setString(2, customer.getEmail().trim().toLowerCase()); // Save email in lowercase for consistency
            ps.setString(3, customer.getMobile().trim());
            ps.setString(4, customer.getPassword()); // Passwords should ideally be hashed before this step
            ps.setString(5, customer.getAddress().trim());
            
            result = ps.executeUpdate();
            
        } catch (SQLException e) { 
            // 💡 Tip: Production mein e.printStackTrace() ki jagah logger use karein
            System.err.println("Error during customer registration: " + e.getMessage());
            e.printStackTrace(); 
        }
        return result;
    }
}