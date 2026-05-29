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

@WebServlet("/SendOtpForgotServlet")
public class SendOtpForgotServlet extends HttpServlet {

    private static final long OTP_COOLDOWN = 30000; // 30 seconds
    private static final long OTP_EXPIRY = 300000;  // 5 minutes

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // =========================
        // 🔹 GET EMAIL
        // =========================

        String email =
                request.getParameter("email");

        // =========================
        // 🔹 VALIDATION
        // =========================

        if (email == null
                || email.trim().isEmpty()) {

            response.sendRedirect(
                    "forgotpass.jsp?error=empty"
            );

            return;
        }

        email =
                email.trim().toLowerCase();

        HttpSession session =
                request.getSession();

        // =========================
        // 🔹 OTP COOLDOWN
        // =========================

        Long lastTime =
                (Long) session.getAttribute("otpTime");

        if (lastTime != null
                && (System.currentTimeMillis()
                - lastTime) < OTP_COOLDOWN) {

            response.sendRedirect(
                    "forgotpass.jsp?error=cooldown"
            );

            return;
        }

        // =========================
        // 🔹 CHECK EMAIL EXISTS
        // =========================

        UserDAO dao =
                new UserDAO();

        boolean exists =
                dao.isEmailExistsAnywhere(email);

        if (!exists) {

            response.sendRedirect(
                    "forgotpass.jsp?error=notfound"
            );

            return;
        }

        // =========================
        // 🔹 GENERATE OTP
        // =========================

        int otp =
                100000
                + new Random().nextInt(900000);

        // =========================
        // 🔹 STORE SESSION DATA
        // =========================

        session.setAttribute(
                "resetOtp",
                otp
        );

        session.setAttribute(
                "resetEmail",
                email
        );

        session.setAttribute(
                "otpTime",
                System.currentTimeMillis()
        );

        session.setAttribute(
                "otpExpiry",
                System.currentTimeMillis()
                + OTP_EXPIRY
        );

        // =========================
        // 🔹 EMAIL CONFIG
        // =========================

        final String fromEmail =
                "gyaneshwarnit@gmail.com";

        final String appPassword =
                "kjsdjsabpdglatdb";

        Properties props =
                new Properties();

        props.put(
                "mail.smtp.host",
                "smtp.gmail.com"
        );

        props.put(
                "mail.smtp.port",
                "587"
        );

        props.put(
                "mail.smtp.auth",
                "true"
        );

        props.put(
                "mail.smtp.starttls.enable",
                "true"
        );

        Session mailSession =
                Session.getInstance(
                        props,
                        new Authenticator() {

            @Override
            protected PasswordAuthentication
            getPasswordAuthentication() {

                return new PasswordAuthentication(
                        fromEmail,
                        appPassword
                );
            }
        });

        try {

            // =========================
            // 🔹 CREATE EMAIL
            // =========================

            Message message =
                    new MimeMessage(mailSession);

            message.setFrom(
                    new InternetAddress(fromEmail)
            );

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(email)
            );

            message.setSubject(
                    "Password Reset OTP - Mangalam Kalpataru"
            );

            message.setText(

                    "Dear User,\n\n"

                    + "We received a request to reset your "
                    + "Mangalam Kalpataru account password.\n\n"

                    + "Your One-Time Password (OTP) is: "
                    + otp

                    + "\n\n"

                    + "This OTP is valid for 5 minutes. "
                    + "Please do not share this code with anyone "
                    + "for security reasons.\n\n"

                    + "If you did not request a password reset, "
                    + "you can safely ignore this email.\n\n"

                    + "Regards,\n"
                    + "Mangalam Kalpataru Team"
            );

            // =========================
            // 🔹 SEND EMAIL
            // =========================

            Transport.send(message);

            System.out.println(
                    "✅ OTP Sent Successfully"
            );

            // =========================
            // 🔹 REDIRECT
            // =========================

            response.sendRedirect("verify.jsp");

        } catch (Exception e) {

            System.out.println(
                    "❌ Failed to Send OTP"
            );

            e.printStackTrace();

            response.sendRedirect(
                    "forgotpass.jsp?error=mailfail"
            );
        }
    }
}