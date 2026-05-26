package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.mangalam.util.DBConnection;

public class WasteDAO {

    // Farmer ki nayi request insert karne ka method
    public boolean addWasteRequest(String email, double acres, String date, String loc) {

        boolean f = false;

        try (Connection con = DBConnection.getConnection()) {

            // MySQL Compatible Query
            String query =
                    "INSERT INTO waste_requests (farmer_email, acres, pickup_date, location, status) VALUES (?, ?, ?, ?, 'PENDING')";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);
            ps.setDouble(2, acres);
            ps.setString(3, date);
            ps.setString(4, loc);

            if (ps.executeUpdate() == 1) {

                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }

    // Farmer dashboard ke liye requests fetch karna
    public ResultSet getFarmerRequests(String email) {

        try {

            Connection con = DBConnection.getConnection();

            // MySQL DATE_FORMAT use kiya
            String query =
                    "SELECT id, acres, DATE_FORMAT(pickup_date, '%d-%b-%Y') as pdate, status, rejection_reason FROM waste_requests WHERE farmer_email=? ORDER BY id DESC";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);

            return ps.executeQuery();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // Admin dashboard ke liye saari requests fetch karna
    public ResultSet getAllRequests() {

        try {

            Connection con = DBConnection.getConnection();

            // MySQL DATE_FORMAT use kiya
            String query =
                    "SELECT w.*, f.full_name, DATE_FORMAT(w.pickup_date, '%d-%b-%Y') as pdate FROM waste_requests w JOIN farmers f ON w.farmer_email = f.email ORDER BY w.id DESC";

            Statement st = con.createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY
            );

            return st.executeQuery(query);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // Admin status update method
    public boolean updateStatusWithReason(int id, String newStatus, String reason) {

        boolean f = false;

        try (Connection con = DBConnection.getConnection()) {

            String query =
                    "UPDATE waste_requests SET status=?, rejection_reason=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, newStatus);
            ps.setString(2, reason);
            ps.setInt(3, id);

            if (ps.executeUpdate() == 1) {

                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }
}