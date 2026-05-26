package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

import com.mangalam.util.DBConnection;

@WebServlet("/CustomerSignupServlet")
public class CustomerSignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        try {

            // ❌ SESSION CHECK (OTP Verified or not)
            Boolean verified = (session != null) ? (Boolean) session.getAttribute("otpVerified") : null;

            if (verified == null || !verified) {
                response.sendRedirect("customersignup.jsp?error=verifyemail");
                return;
            }

            // 📥 GET DATA
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");

            // 🔧 CLEAN INPUT
            if (email != null) email = email.trim().toLowerCase();

            // ❌ VALIDATION
            if (fullName == null || email == null || password == null ||
                mobile == null || address == null ||
                fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {

                response.sendRedirect("customersignup.jsp?error=emptyfields");
                return;
            }

            Connection con = DBConnection.getConnection();

            // ❌ DUPLICATE EMAIL CHECK
            String checkSql = "SELECT 1 FROM customers WHERE email = ?";
            PreparedStatement checkPs = con.prepareStatement(checkSql);
            checkPs.setString(1, email);

            ResultSet rs = checkPs.executeQuery();

            if (rs.next()) {
                response.sendRedirect("customersignup.jsp?error=emailexists");
                return;
            }

            // 🔒 PASSWORD HASH (basic - upgrade later)
            String hashedPassword = String.valueOf(password.hashCode());

            // 🧾 INSERT
            String sql = "INSERT INTO customers (full_name, email, mobile, password, address) VALUES (?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, mobile);
            ps.setString(4, hashedPassword);
            ps.setString(5, address);

            int i = ps.executeUpdate();

            if (i > 0) {

                // 🧹 CLEAR SESSION (IMPORTANT)
                if (session != null) {
                    session.removeAttribute("otpVerified");
                    session.removeAttribute("email");
                }

                response.sendRedirect("login.jsp?success=registered");

            } else {
                response.sendRedirect("customersignup.jsp?error=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("customersignup.jsp?error=server");
        }
    }
}