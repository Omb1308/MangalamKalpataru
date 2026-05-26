package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.mangalam.model.CartItem;
import com.mangalam.util.DBConnection;

public class CartDAO {

    // =========================
    // 🔥 ADD TO CART
    // =========================

    public boolean addToCart(
            String email,
            int pid,
            String pName,
            double price
    ) {

        boolean status = false;

        ProductDAO pdao =
                new ProductDAO();

        // 🔥 CHECK STOCK

        int stock =
                pdao.getProductStock(
                        String.valueOf(pid)
                );

        if (stock <= 0) {

            System.out.println(
                    "❌ Product Out of Stock"
            );

            return false;
        }

        String cartId =
                UUID.randomUUID()
                .toString()
                .substring(0, 8);

        try (Connection conn =
                     DBConnection.getConnection()) {

            // =========================
            // 🔥 CHECK EXISTING PRODUCT
            // =========================

            String checkQuery =
                    "SELECT quantity FROM cart "
                    + "WHERE user_email=? "
                    + "AND p_id=?";

            PreparedStatement checkPs =
                    conn.prepareStatement(checkQuery);

            checkPs.setString(1, email);

            checkPs.setInt(2, pid);

            ResultSet rs =
                    checkPs.executeQuery();

            // =========================
            // 🔥 UPDATE QUANTITY
            // =========================

            if (rs.next()) {

                String updateQuery =
                        "UPDATE cart "
                        + "SET quantity = quantity + 1 "
                        + "WHERE user_email=? "
                        + "AND p_id=?";

                PreparedStatement updatePs =
                        conn.prepareStatement(updateQuery);

                updatePs.setString(1, email);

                updatePs.setInt(2, pid);

                status =
                        updatePs.executeUpdate() > 0;

            } else {

                // =========================
                // 🔥 INSERT NEW ITEM
                // =========================

                String insertQuery =
                        "INSERT INTO cart "
                        + "(cart_id, user_email, "
                        + "p_id, p_name, "
                        + "price, quantity) "
                        + "VALUES (?, ?, ?, ?, ?, ?)";

                PreparedStatement insertPs =
                        conn.prepareStatement(insertQuery);

                insertPs.setString(1, cartId);

                insertPs.setString(2, email);

                insertPs.setInt(3, pid);

                insertPs.setString(4, pName);

                insertPs.setDouble(5, price);

                insertPs.setInt(6, 1);

                status =
                        insertPs.executeUpdate() > 0;
            }

        } catch (Exception e) {

            System.err.println(
                    "AddToCart Error: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return status;
    }

    // =========================
    // 🔥 GET CART ITEMS
    // =========================

    public List<CartItem> getCartItems(
            String email
    ) {

        List<CartItem> cartList =
                new ArrayList<>();

        String sql =
                "SELECT c.cart_id, "
                + "c.p_id, "
                + "c.p_name, "
                + "c.price, "
                + "c.quantity, "
                + "p.p_image "
                + "FROM cart c "
                + "JOIN products p "
                + "ON c.p_id = p.p_id "
                + "WHERE c.user_email=? "
                + "ORDER BY c.p_id ASC";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                CartItem item =
                        new CartItem();

                item.setCartId(
                        rs.getString("cart_id")
                );

                item.setpId(
                        rs.getString("p_id")
                );

                item.setpName(
                        rs.getString("p_name")
                );

                item.setPrice(
                        rs.getDouble("price")
                );

                item.setQuantity(
                        rs.getInt("quantity")
                );

                String image =
                        rs.getString("p_image");

                item.setImageUrl(
                        image != null
                        ? image
                        : "default.png"
                );

                cartList.add(item);
            }

        } catch (Exception e) {

            System.err.println(
                    "GetCartItems Error: "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return cartList;
    }

    // =========================
    // 🔥 GET CART COUNT
    // =========================

    public int getCartCount(
            String email
    ) {

        int count = 0;

        String sql =
                "SELECT IFNULL(SUM(quantity),0) "
                + "FROM cart "
                + "WHERE user_email=?";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                count =
                        rs.getInt(1);
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    // =========================
    // 🔥 REMOVE ITEM
    // =========================

    public boolean removeItem(
            String email,
            int pid
    ) {

        String sql =
                "DELETE FROM cart "
                + "WHERE user_email=? "
                + "AND p_id=?";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setString(1, email);

            ps.setInt(2, pid);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // =========================
    // 🔥 GET CART QUANTITY
    // =========================

    public int getCartQuantity(
            String email,
            int pid
    ) {

        int qty = 0;

        String sql =
                "SELECT quantity "
                + "FROM cart "
                + "WHERE user_email=? "
                + "AND p_id=?";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, email);

            ps.setInt(2, pid);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                qty =
                        rs.getInt("quantity");
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return qty;
    }

    // =========================
    // 🔥 UPDATE QUANTITY
    // =========================

    public boolean updateQuantity(
            String email,
            int pid,
            int qty
    ) {

        ProductDAO pdao =
                new ProductDAO();

        int stock =
                pdao.getProductStock(
                        String.valueOf(pid)
                );

        if (qty > stock) {

            System.out.println(
                    "❌ Quantity exceeds stock"
            );

            return false;
        }

        String sql =
                "UPDATE cart "
                + "SET quantity=? "
                + "WHERE user_email=? "
                + "AND p_id=?";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setInt(1, qty);

            ps.setString(2, email);

            ps.setInt(3, pid);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }

    // =========================
    // 🔥 CLEAR CART
    // =========================

    public boolean clearCart(
            String email
    ) {

        String sql =
                "DELETE FROM cart "
                + "WHERE user_email=?";

        try (Connection conn =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     conn.prepareStatement(sql)) {

            ps.setString(1, email);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            System.err.println(
                    "ClearCart Error: "
                    + e.getMessage()
            );

            e.printStackTrace();

            return false;
        }
    }
}