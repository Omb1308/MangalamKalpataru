package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mangalam.util.DBConnection;

public class UserDAO {

    // =========================
    // ✅ 1. LOGIN ROLE CHECK
    // =========================

    public String checkUserRole(
            String email,
            String password
    ) {

        try (Connection con =
                     DBConnection.getConnection()) {

            // 🔥 ADMIN LOGIN

            PreparedStatement ps0 =
                    con.prepareStatement(
                            "SELECT 1 FROM admin "
                            + "WHERE LOWER(email)=? AND password=?"
                    );

            ps0.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ps0.setString(2, password);

            if (ps0.executeQuery().next()) {

                return "ADMIN";
            }

            // 🔥 FARMER LOGIN

            PreparedStatement ps1 =
                    con.prepareStatement(
                            "SELECT 1 FROM farmers "
                            + "WHERE LOWER(email)=? AND password=?"
                    );

            ps1.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ps1.setString(2, password);

            if (ps1.executeQuery().next()) {

                return "FARMER";
            }

            // 🔥 CUSTOMER LOGIN

            PreparedStatement ps2 =
                    con.prepareStatement(
                            "SELECT 1 FROM customers "
                            + "WHERE LOWER(email)=? AND password=?"
                    );

            ps2.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ps2.setString(2, password);

            if (ps2.executeQuery().next()) {

                return "CUSTOMER";
            }

        } catch (Exception e) {

            System.out.println(
                    "❌ Login Error: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // ✅ 2. GET ROLE BY EMAIL
    // =========================

    public String getRoleByEmail(String email) {

        try (Connection con =
                     DBConnection.getConnection()) {

            PreparedStatement ps0 =
                    con.prepareStatement(
                            "SELECT email FROM admin "
                            + "WHERE LOWER(email)=?"
                    );

            ps0.setString(
                    1,
                    email.trim().toLowerCase()
            );

            if (ps0.executeQuery().next()) {

                return "ADMIN";
            }

            PreparedStatement ps1 =
                    con.prepareStatement(
                            "SELECT email FROM farmers "
                            + "WHERE LOWER(email)=?"
                    );

            ps1.setString(
                    1,
                    email.trim().toLowerCase()
            );

            if (ps1.executeQuery().next()) {

                return "FARMER";
            }

            PreparedStatement ps2 =
                    con.prepareStatement(
                            "SELECT email FROM customers "
                            + "WHERE LOWER(email)=?"
                    );

            ps2.setString(
                    1,
                    email.trim().toLowerCase()
            );

            if (ps2.executeQuery().next()) {

                return "CUSTOMER";
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // ✅ 3. UPDATE PASSWORD
    // =========================

    public boolean updatePassword(
            String email,
            String role,
            String password
    ) {

        boolean status = false;

        String table = "";

        if ("ADMIN".equalsIgnoreCase(role)) {

            table = "admin";

        } else if ("FARMER".equalsIgnoreCase(role)) {

            table = "farmers";

        } else if ("CUSTOMER".equalsIgnoreCase(role)) {

            table = "customers";
        }

        try (Connection con =
                     DBConnection.getConnection()) {

            String query =
                    "UPDATE " + table
                    + " SET password=? WHERE LOWER(email)=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            // 🔥 SAVE NORMAL PASSWORD

            ps.setString(1, password);

            ps.setString(
                    2,
                    email.trim().toLowerCase()
            );

            int row =
                    ps.executeUpdate();

            if (row > 0) {

                status = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // ✅ 4. GET USER NAME
    // =========================

    public String getUserName(
            String email,
            String role
    ) {

        String name = null;

        String table = "customers";

        if ("ADMIN".equalsIgnoreCase(role)) {

            table = "admin";

        } else if ("FARMER".equalsIgnoreCase(role)) {

            table = "farmers";
        }

        String query =
                "SELECT full_name FROM "
                + table
                + " WHERE LOWER(email)=?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(query)) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                name =
                        rs.getString("full_name");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return name;
    }

    // =========================
    // ✅ 5. GET USER ADDRESS
    // =========================

    public String getUserAddress(
            String email
    ) {

        String address = "";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "SELECT address FROM customers "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                address =
                        rs.getString("address");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return address == null ? "" : address;
    }

    // =========================
    // ✅ 6. UPDATE USER ADDRESS
    // =========================

    public boolean updateUserAddress(
            String email,
            String newAddress
    ) {

        boolean f = false;

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "UPDATE customers "
                             + "SET address=? "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(1, newAddress);

            ps.setString(
                    2,
                    email.trim().toLowerCase()
            );

            if (ps.executeUpdate() == 1) {

                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }

    // =========================
    // ✅ 7. UPDATE CUSTOMER PROFILE
    // =========================

    public boolean updateCustomerProfile(
            String email,
            String pass,
            String mobile,
            String address
    ) {

        boolean f = false;

        try (Connection con =
                     DBConnection.getConnection()) {

            PreparedStatement ps =
                    con.prepareStatement(
                            "UPDATE customers "
                            + "SET password=?, mobile=?, address=? "
                            + "WHERE LOWER(email)=?"
                    );

            ps.setString(1, pass);

            ps.setString(2, mobile);

            ps.setString(3, address);

            ps.setString(
                    4,
                    email.trim().toLowerCase()
            );

            if (ps.executeUpdate() == 1) {

                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }

    // =========================
    // ✅ 8. UPDATE FARMER PROFILE
    // =========================

    public boolean updateFarmerProfile(
            String email,
            String pass,
            String locality,
            String upiId
    ) {

        boolean f = false;

        try (Connection con =
                     DBConnection.getConnection()) {

            PreparedStatement ps =
                    con.prepareStatement(
                            "UPDATE farmers "
                            + "SET password=?, locality=?, upi_id=? "
                            + "WHERE LOWER(email)=?"
                    );

            ps.setString(1, pass);

            ps.setString(2, locality);

            ps.setString(3, upiId);

            ps.setString(
                    4,
                    email.trim().toLowerCase()
            );

            if (ps.executeUpdate() == 1) {

                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }

    // =========================
    // ✅ 9. GET CUSTOMER NAME
    // =========================

    public String getCustomerName(
            String email
    ) {

        String name = "User";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "SELECT full_name FROM customers "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                String dbName =
                        rs.getString("full_name");

                if (dbName != null
                        && !dbName.trim().isEmpty()) {

                    name = dbName;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return name;
    }

    // =========================
    // ✅ 10. GET USER MOBILE
    // =========================

    public String getUserMobile(
            String email
    ) {

        String mobile = "";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "SELECT mobile FROM customers "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                mobile =
                        rs.getString("mobile");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return mobile;
    }

    // =========================
    // ✅ 11. GET USER PASSWORD
    // =========================

    public String getUserPassword(
            String email
    ) {

        String pass = "";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "SELECT password FROM customers "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                pass =
                        rs.getString("password");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return pass;
    }

    // =========================
    // ✅ 12. GET USER DETAILS
    // =========================

    public ResultSet getUserDetails(
            String email,
            String role
    ) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String table =
                    "customers";

            if ("ADMIN".equalsIgnoreCase(role)) {

                table = "admin";

            } else if ("FARMER".equalsIgnoreCase(role)) {

                table = "farmers";
            }

            String sql =
                    "SELECT * FROM "
                    + table
                    + " WHERE LOWER(email)=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            return ps.executeQuery();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }

    // =========================
    // ✅ 13. EMAIL EXISTS
    // =========================

    public boolean isEmailExists(
            String email
    ) {

        boolean exists = false;

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "SELECT 1 FROM customers "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                exists = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return exists;
    }

    // =========================
    // ✅ 14. EMAIL EXISTS ANYWHERE
    // =========================

    public boolean isEmailExistsAnywhere(
            String email
    ) {

        try (Connection con =
                     DBConnection.getConnection()) {

            PreparedStatement ps1 =
                    con.prepareStatement(
                            "SELECT 1 FROM customers "
                            + "WHERE LOWER(email)=?"
                    );

            ps1.setString(
                    1,
                    email.trim().toLowerCase()
            );

            if (ps1.executeQuery().next()) {

                return true;
            }

            PreparedStatement ps2 =
                    con.prepareStatement(
                            "SELECT 1 FROM farmers "
                            + "WHERE LOWER(email)=?"
                    );

            ps2.setString(
                    1,
                    email.trim().toLowerCase()
            );

            if (ps2.executeQuery().next()) {

                return true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return false;
    }

    // =========================
    // ✅ 15. EMAIL EXISTS IN FARMERS
    // =========================

    public boolean isEmailExistsInFarmers(
            String email
    ) {

        boolean exists = false;

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(
                             "SELECT 1 FROM farmers "
                             + "WHERE LOWER(email)=?"
                     )) {

            ps.setString(
                    1,
                    email.trim().toLowerCase()
            );

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                exists = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return exists;
    }
}