package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.mangalam.dao.CartDAO;

@WebServlet("/RemoveFromCartServlet")

public class RemoveFromCartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            // =========================
            // 🔹 GET PRODUCT ID
            // =========================

            String pidStr =
                    request.getParameter("pid");

            // =========================
            // 🔹 SESSION CHECK
            // =========================

            HttpSession session =
                    request.getSession(false);

            String email =
                    (session != null)
                    ? (String) session.getAttribute(
                            "userEmail"
                    )
                    : null;

            // =========================
            // ❌ LOGIN CHECK
            // =========================

            if (email == null) {

                response.sendRedirect(
                        "login.jsp"
                );

                return;
            }

            // =========================
            // ❌ PID CHECK
            // =========================

            if (pidStr == null
                    || pidStr.trim().isEmpty()) {

                response.sendRedirect(
                        "cartlogin.jsp?status=invalid"
                );

                return;
            }

            // =========================
            // 🔥 CONVERT TO INT
            // =========================

            int pid =
                    Integer.parseInt(pidStr);

            // =========================
            // 🔥 REMOVE ITEM
            // =========================

            CartDAO dao =
                    new CartDAO();

            boolean isRemoved =
                    dao.removeItem(
                            email,
                            pid
                    );

            // =========================
            // 🔥 RESPONSE
            // =========================

            if (isRemoved) {

                response.sendRedirect(
                        "cartlogin.jsp?status=removed"
                );

            } else {

                response.sendRedirect(
                        "cartlogin.jsp?status=error"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "cartlogin.jsp?status=exception"
            );
        }
    }
}