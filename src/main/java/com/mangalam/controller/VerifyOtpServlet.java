package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {

    private static final long OTP_VALIDITY = 300000;

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // SESSION CHECK

        if (session == null) {

            response.sendRedirect(
                    "forgotpass.jsp?msg=Session expired. Please try again."
            );

            return;
        }

        // SESSION DATA

        Integer sessionOtp =
                (Integer) session.getAttribute("resetOtp");

        Long otpTime =
                (Long) session.getAttribute("otpTime");

        String sessionEmail =
                (String) session.getAttribute("resetEmail");

        // USER OTP

        String otpParam =
                request.getParameter("otp");

        // NULL CHECK

        if (sessionOtp == null
                || otpTime == null
                || sessionEmail == null
                || otpParam == null
                || otpParam.trim().isEmpty()) {

            response.sendRedirect(
                    "forgotpass.jsp?msg=Invalid OTP request."
            );

            return;
        }

        int userOtp;

        try {

            userOtp =
                    Integer.parseInt(otpParam);

        } catch (NumberFormatException e) {

            response.sendRedirect(
                    "forgotpass.jsp?msg=Invalid OTP entered."
            );

            return;
        }

        // OTP EXPIRY CHECK

        long currentTime =
                System.currentTimeMillis();

        if ((currentTime - otpTime)
                > OTP_VALIDITY) {

            session.removeAttribute("resetOtp");

            session.removeAttribute("otpTime");

            response.sendRedirect(
                    "forgotpass.jsp?msg=OTP expired. Please request again."
            );

            return;
        }

        // WRONG OTP

        if (!sessionOtp.equals(userOtp)) {

            response.sendRedirect(
                    "forgotpass.jsp?msg=Incorrect OTP entered."
            );

            return;
        }

        // VERIFIED

        session.setAttribute(
                "otpVerified",
                true
        );

        session.setAttribute(
                "verifiedEmail",
                sessionEmail
        );

        // REMOVE OTP AFTER SUCCESS

        session.removeAttribute("resetOtp");

        session.removeAttribute("otpTime");

        // REDIRECT TO RESET PASSWORD PAGE

        response.sendRedirect(
                "resetpass.jsp"
        );
    }
}