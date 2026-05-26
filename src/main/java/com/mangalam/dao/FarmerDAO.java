package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mangalam.model.Farmer;
import com.mangalam.util.DBConnection;

public class FarmerDAO {

    // =========================
    // ✅ REGISTER FARMER
    // =========================

    public int registerFarmer(Farmer farmer) {

        int result = 0;

        String insertQuery =
                "INSERT INTO farmers "
                + "(full_name, email, locality, upi_id, password) "
                + "VALUES (?, ?, ?, ?, ?)";

        try (Connection con =
                     DBConnection.getConnection()) {

            // 🔥 CHECK DUPLICATE EMAIL

            String checkQuery =
                    "SELECT 1 FROM farmers "
                    + "WHERE LOWER(email)=?";

            try (PreparedStatement checkPs =
                         con.prepareStatement(checkQuery)) {

                checkPs.setString(
                        1,
                        farmer.getEmail()
                        .trim()
                        .toLowerCase()
                );

                ResultSet rs =
                        checkPs.executeQuery();

                if (rs.next()) {

                    // ❌ EMAIL ALREADY EXISTS

                    return -1;
                }
            }

            // 🔥 INSERT FARMER

            try (PreparedStatement ps =
                         con.prepareStatement(insertQuery)) {

                ps.setString(
                        1,
                        farmer.getFullName()
                );

                ps.setString(
                        2,
                        farmer.getEmail()
                        .trim()
                        .toLowerCase()
                );

                ps.setString(
                        3,
                        farmer.getLocality()
                );

                ps.setString(
                        4,
                        farmer.getUpiId()
                );

                ps.setString(
                        5,
                        farmer.getPassword()
                );

                result =
                        ps.executeUpdate();

                if (result > 0) {

                    System.out.println(
                            "✅ Farmer Registered Successfully"
                    );
                }
            }

        } catch (SQLException e) {

            System.out.println(
                    "❌ Error in registerFarmer(): "
                    + e.getMessage()
            );

            e.printStackTrace();

            result = 0;
        }

        return result;
    }
}