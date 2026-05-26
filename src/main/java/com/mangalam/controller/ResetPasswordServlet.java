package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.mangalam.dao.UserDAO;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        // =========================
        // SESSION CHECK
        // =========================

        if (session == null
                || session.getAttribute("verifiedEmail") == null) {

            response.sendRedirect(
                    "forgotpass.jsp?msg=Session expired."
            );

            return;
        }

        // =========================
        // GET DATA
        // =========================

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");

        String email =
                (String) session.getAttribute("verifiedEmail");

        // =========================
        // PASSWORD CHECK
        // =========================

        if (password == null
                || confirmPassword == null
                || password.trim().isEmpty()
                || confirmPassword.trim().isEmpty()) {

            response.sendRedirect(
                    "resetpass.jsp?error=empty"
            );

            return;
        }

        // =========================
        // PASSWORD MATCH
        // =========================

        if (!password.equals(confirmPassword)) {

            response.sendRedirect(
                    "resetpass.jsp?error=mismatch"
            );

            return;
        }

        // =========================
        // PASSWORD LENGTH
        // =========================

        if (password.length() < 6) {

            response.sendRedirect(
                    "resetpass.jsp?error=weak"
            );

            return;
        }

        try {

            UserDAO dao =
                    new UserDAO();

            // =========================
            // GET ROLE
            // =========================

            String role =
                    dao.getRoleByEmail(email);

            if (role == null) {

                response.sendRedirect(
                        "forgotpass.jsp?msg=User not found."
                );

                return;
            }

            // =========================
            // UPDATE PASSWORD
            // =========================

            boolean status =
                    dao.updatePassword(
                            email,
                            role,
                            password
                    );

            // =========================
            // SUCCESS
            // =========================

            if (status) {

                // CLEAR SESSION

                session.invalidate();

                // REDIRECT LOGIN

                response.sendRedirect(
                        "login.jsp?reset=success"
                );

            } else {

                response.sendRedirect(
                        "resetpass.jsp?error=failed"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "resetpass.jsp?error=server"
            );
        }
    }
}