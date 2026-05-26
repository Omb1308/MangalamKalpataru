package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.mangalam.util.DBConnection;

public class ProductDAO {

    // =========================
    // 🔥 1. ADD PRODUCT
    // =========================

    public boolean addProduct(
            String name,
            String cat,
            double price,
            int stock,
            String desc,
            String img,
            int packSizes
    ) {

        boolean status = false;

        String sql =
                "INSERT INTO products "
                + "(p_name, p_category, p_price, "
                + "p_stock, p_desc, p_image, pack_sizes) "
                + "VALUES (?,?,?,?,?,?,?)";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, name);

            ps.setString(2, cat);

            ps.setDouble(3, price);

            ps.setInt(4, stock);

            ps.setString(5, desc);

            ps.setString(6, img);

            ps.setInt(7, packSizes);

            status =
                    ps.executeUpdate() == 1;

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in addProduct(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // 🔥 2. FETCH ALL PRODUCTS
    // =========================

    public ResultSet getAllProducts() {

        try {

            Connection con =
                    DBConnection.getConnection();

            Statement st =
                    con.createStatement();

            return st.executeQuery(
                    "SELECT * FROM products ORDER BY p_id DESC"
            );

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in getAllProducts(): "
                    + e.getMessage()
            );

            e.printStackTrace();

            return null;
        }
    }

    // =========================
    // 🔥 3. DELETE PRODUCT
    // =========================

    public boolean deleteProduct(int id) {

        boolean status = false;

        String sql =
                "DELETE FROM products WHERE p_id=?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, id);

            status =
                    ps.executeUpdate() == 1;

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in deleteProduct(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // 🔥 4. GET PRODUCT STOCK
    // =========================

    public int getProductStock(String pid) {

        int stock = 0;

        String sql =
                "SELECT p_stock "
                + "FROM products "
                + "WHERE p_id=?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, pid);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                stock =
                        rs.getInt("p_stock");
            }

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in getProductStock(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return stock;
    }

    // =========================
    // 🔥 5. DECREASE STOCK
    // =========================

    public boolean decreaseStock(
            String pid,
            int qty
    ) {

        boolean status = false;

        String sql =
                "UPDATE products "
                + "SET p_stock = p_stock - ? "
                + "WHERE p_id = ? "
                + "AND p_stock >= ?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, qty);

            ps.setString(2, pid);

            ps.setInt(3, qty);

            int rows =
                    ps.executeUpdate();

            status =
                    rows > 0;

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in decreaseStock(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // 🔥 6. INCREASE STOCK
    // =========================

    public boolean increaseStock(
            String pid,
            int qty
    ) {

        boolean status = false;

        String sql =
                "UPDATE products "
                + "SET p_stock = p_stock + ? "
                + "WHERE p_id = ?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setInt(1, qty);

            ps.setString(2, pid);

            status =
                    ps.executeUpdate() > 0;

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in increaseStock(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // 🔥 7. GET PRODUCT BY ID
    // =========================

    public ResultSet getProductById(int id) {

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM products WHERE p_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setInt(1, id);

            return ps.executeQuery();

        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }

    // =========================
    // 🔥 8. UPDATE PRODUCT
    // =========================

    public boolean updateProduct(
            int id,
            String name,
            String cat,
            double price,
            int stock,
            int pack,
            String desc
    ) {

        boolean status = false;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE products SET "
                    + "p_name=?, "
                    + "p_category=?, "
                    + "p_price=?, "
                    + "p_stock=?, "
                    + "pack_sizes=?, "
                    + "p_desc=? "
                    + "WHERE p_id=?";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ps.setString(1, name);

            ps.setString(2, cat);

            ps.setDouble(3, price);

            ps.setInt(4, stock);

            ps.setInt(5, pack);

            ps.setString(6, desc);

            ps.setInt(7, id);

            status =
                    ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();
        }

        return status;
    }
}