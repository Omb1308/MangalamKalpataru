package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.mangalam.model.CartItem;
import com.mangalam.util.DBConnection;

public class OrderDAO {

    // =========================
    // 🔥 SINGLE ORDER
    // =========================

    public boolean placeOrder(
            String email,
            String productName,
            double amount
    ) {

        boolean success = false;

        // ✅ MySQL Compatible Query

        String sql =
                "INSERT INTO orders "
                + "(user_email, product_name, amount, "
                + "status, order_date, delivery_date, payment_status) "
                + "VALUES (?, ?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), ?)";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, email);

            ps.setString(2, productName);

            ps.setDouble(3, amount);

            ps.setString(4, "Placed");

            ps.setString(5, "Success");

            int rows =
                    ps.executeUpdate();

            success =
                    rows > 0;

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in placeOrder(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return success;
    }

    // =========================
    // 🔥 MULTIPLE ORDERS
    // =========================

    public boolean placeMultipleOrders(
            String email,
            List<CartItem> items
    ) {

        boolean allSuccess = true;

        // ✅ MySQL Compatible Query

        String sql =
                "INSERT INTO orders "
                + "(user_email, product_name, amount, "
                + "status, order_date, delivery_date, payment_status) "
                + "VALUES (?, ?, ?, ?, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), ?)";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            // 🔥 Transaction Start

            con.setAutoCommit(false);

            for (CartItem item : items) {

                ps.setString(1, email);

                ps.setString(2, item.getProductName());

                ps.setDouble(
                        3,
                        item.getPrice()
                        * item.getQuantity()
                );

                ps.setString(4, "Placed");

                ps.setString(5, "Success");

                ps.addBatch();
            }

            int[] result =
                    ps.executeBatch();

            for (int r : result) {

                if (r == 0) {

                    allSuccess = false;

                    break;
                }
            }

            if (allSuccess) {

                con.commit();

            } else {

                con.rollback();
            }

        } catch (Exception e) {

            allSuccess = false;

            e.printStackTrace();
        }

        return allSuccess;
    }

    // =========================
    // 🔥 GET ORDERS BY EMAIL
    // =========================

    public List<String[]> getOrdersByEmail(
            String email
    ) {

        List<String[]> list =
                new ArrayList<>();

        String sql =
                "SELECT product_name, "
                + "amount, "
                + "status, "
                + "DATE_FORMAT(order_date, '%d-%b-%Y %h:%i %p') as order_date, "
                + "DATE_FORMAT(delivery_date, '%d-%b-%Y') as delivery_date, "
                + "payment_status "
                + "FROM orders "
                + "WHERE user_email=? "
                + "ORDER BY order_date DESC";

        try (Connection con =
                     DBConnection.getConnection();

             PreparedStatement ps =
                     con.prepareStatement(sql)) {

            ps.setString(1, email);

            ResultSet rs =
                    ps.executeQuery();

            while (rs.next()) {

                String[] o =
                        new String[6];

                o[0] =
                        rs.getString("product_name");

                o[1] =
                        rs.getString("amount");

                o[2] =
                        rs.getString("status");

                o[3] =
                        rs.getString("order_date");

                o[4] =
                        rs.getString("delivery_date");

                o[5] =
                        rs.getString("payment_status");

                list.add(o);
            }

        } catch (Exception e) {

            System.out.println(
                    "❌ Error in getOrdersByEmail(): "
                    + e.getMessage()
            );

            e.printStackTrace();
        }

        return list;
    }
}