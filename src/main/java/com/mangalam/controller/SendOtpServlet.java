package com.mangalam.controller;

import jakarta.servlet.*; 
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import jakarta.mail.*;
import jakarta.mail.internet.*;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;

import com.mangalam.dao.UserDAO;

@WebServlet("/SendOtpServlet")
public class SendOtpServlet extends HttpServlet {

    private static final long OTP_COOLDOWN = 300000; // 30 sec

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String type = request.getParameter("type"); // 🔥 NEW (customer / farmer)

        // ❌ Email validation
        if (email == null || email.trim().isEmpty()) {
            response.getWriter().write("Enter email first");
            return;
        }

        email = email.trim().toLowerCase();

        HttpSession session = request.getSession();

        // ⚠️ Cooldown check
        Long lastTime = (Long) session.getAttribute("otpTime");
        if (lastTime != null && (System.currentTimeMillis() - lastTime) < OTP_COOLDOWN) {
            response.getWriter().write("Wait 30 seconds before retry");
            return;
        }

        UserDAO dao = new UserDAO();
        boolean exists = false;

        // 🔥 ROLE-BASED CHECK
        if ("customer".equalsIgnoreCase(type)) {
            exists = dao.isEmailExists(email); // customers
        } 
        else if ("farmer".equalsIgnoreCase(type)) {
            exists = dao.isEmailExistsInFarmers(email); // farmers
        } 
        else {
            // fallback: check both
            exists = dao.isEmailExists(email) || dao.isEmailExistsInFarmers(email);
        }

        // ❌ Duplicate email
        if (exists) {
            response.getWriter().write("Email already registered");
            return;
        }

        // 🔢 Generate OTP
        int otp = 100000 + new Random().nextInt(900000);

        // 💾 Store session
        session.setAttribute("otp", otp);
        session.setAttribute("email", email);
        session.setAttribute("otpTime", System.currentTimeMillis());

        // 📧 Email config (use App Password)
        final String fromEmail = "gyaneshwarnit@gmail.com";
        final String password = "kjsdjsabpdglatdb"; // 🔥 replace

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(mailSession);

            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));

            message.setSubject("OTP Verification - BananaWaste");

            message.setText(
                    "Hello,\n\n" +
                    "Your OTP is: " + otp + "\n\n" +
                    "Valid for 5 minutes.\n\n" +
                    "Do not share this OTP.\n\n" +
                    "BananaWaste Team"
            );

            Transport.send(message);

            response.getWriter().write("OTP Sent Successfully");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error sending OTP");
        }
    }
}