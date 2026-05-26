package com.mangalam.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.mangalam.util.DBConnection;

public class DashboardDAO {

    // =========================
    // TOTAL SALES
    // =========================

    public double getTotalSales() {

        double total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            // MySQL Compatible Query
            String sql =
                    "SELECT IFNULL(SUM(amount),0) FROM orders";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                total =
                        rs.getDouble(1);
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return total;
    }

    // =========================
    // PRODUCTS SOLD
    // =========================

    public int getProductsSold() {

        int count = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            // Total Orders Count
            String sql =
                    "SELECT COUNT(*) FROM orders";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                count =
                        rs.getInt(1);
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return count;
    }

    // =========================
    // TOTAL USERS
    // =========================

    public int getTotalUsers() {

        int total = 0;

        try {

            Connection con =
                    DBConnection.getConnection();

            String sql =
            		"SELECT "
            		+ "(SELECT COUNT(*) FROM customers) + "
            		+ "(SELECT COUNT(*) FROM farmers)";

            PreparedStatement ps =
                    con.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            if (rs.next()) {

                total =
                        rs.getInt(1);
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return total;
    }
}