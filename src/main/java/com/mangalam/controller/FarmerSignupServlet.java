package com.mangalam.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.mangalam.dao.FarmerDAO;
import com.mangalam.model.Farmer;

@WebServlet("/FarmerSignupServlet")
public class FarmerSignupServlet extends HttpServlet {

    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // =========================
        // ❌ SESSION CHECK
        // =========================

        if (session == null) {

            response.sendRedirect(
                    "farmersignup.jsp?error=session"
            );

            return;
        }

        Boolean verified =
                (Boolean) session.getAttribute(
                        "otpVerified"
                );

        String verifiedEmail =
                (String) session.getAttribute(
                        "verifiedEmail"
                );

        String email =
                request.getParameter("email");

        // =========================
        // 🔥 EMAIL NORMALIZE
        // =========================

        if (email != null) {

            email =
                    email.trim().toLowerCase();
        }

        // =========================
        // ❌ OTP + EMAIL CHECK
        // =========================

        if (verified == null
                || !verified
                || verifiedEmail == null
                || !verifiedEmail.equals(email)) {

            response.sendRedirect(
                    "farmersignup.jsp?error=verifyemail"
            );

            return;
        }

        // =========================
        // 📥 GET FORM DATA
        // =========================

        String fullName =
                request.getParameter(
                        "full_name"
                );

        String locality =
                request.getParameter(
                        "locality"
                );

        String upiId =
                request.getParameter(
                        "upi_id"
                );

        String password =
                request.getParameter(
                        "password"
                );

        // =========================
        // ❌ BASIC VALIDATION
        // =========================

        if (fullName == null
                || email == null
                || password == null
                || fullName.trim().isEmpty()
                || email.trim().isEmpty()
                || password.trim().isEmpty()) {

            response.sendRedirect(
                    "farmersignup.jsp?error=empty"
            );

            return;
        }

        // =========================
        // 👤 CREATE FARMER MODEL
        // =========================

        Farmer farmer =
                new Farmer();

        farmer.setFullName(
                fullName.trim()
        );

        farmer.setEmail(
                email.trim().toLowerCase()
        );

        farmer.setLocality(
                locality
        );

        farmer.setUpiId(
                upiId
        );

        // ✅ SAVE NORMAL PASSWORD

        farmer.setPassword(
                password
        );

        // =========================
        // 🔗 SAVE IN DATABASE
        // =========================

        FarmerDAO dao =
                new FarmerDAO();

        int status =
                dao.registerFarmer(farmer);

        // =========================
        // ✅ SUCCESS
        // =========================

        if (status > 0) {

            // 🧹 CLEAR SESSION

            session.removeAttribute(
                    "otpVerified"
            );

            session.removeAttribute(
                    "verifiedEmail"
            );

            session.removeAttribute(
                    "email"
            );

            response.sendRedirect(
                    "login.jsp?success=farmer"
            );

        } else if (status == -1) {

            // ❌ EMAIL EXISTS

            response.sendRedirect(
                    "farmersignup.jsp?error=exists"
            );

        } else {

            // ❌ FAILED

            response.sendRedirect(
                    "farmersignup.jsp?error=failed"
            );
        }
    }
}