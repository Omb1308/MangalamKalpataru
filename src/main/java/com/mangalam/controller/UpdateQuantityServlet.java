package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.mangalam.dao.CartDAO;
import com.mangalam.dao.ProductDAO;

@WebServlet("/UpdateQuantityServlet")

public class UpdateQuantityServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            // =========================
            // 🔹 GET PARAMETERS
            // =========================

            int pid =
                    Integer.parseInt(
                            request.getParameter("pid")
                    );

            int qty =
                    Integer.parseInt(
                            request.getParameter("qty")
                    );

            // =========================
            // 🔹 SESSION CHECK
            // =========================

            HttpSession session =
                    request.getSession(false);

            if (session == null
                    || session.getAttribute("userEmail") == null) {

                response.sendRedirect(
                        "login.jsp"
                );

                return;
            }

            String email =
                    (String) session.getAttribute(
                            "userEmail"
                    );

            // =========================
            // 🔥 DAO OBJECTS
            // =========================

            CartDAO cartDao =
                    new CartDAO();

            ProductDAO productDao =
                    new ProductDAO();

            // =========================
            // 🔥 STOCK CHECK
            // =========================

            int stock =
                    productDao.getProductStock(
                            String.valueOf(pid)
                    );

            if (qty > stock) {

                response.sendRedirect(
                        "cartlogin.jsp?msg=Max stock reached"
                );

                return;
            }

            // =========================
            // 🔥 REMOVE IF QTY < 1
            // =========================

            if (qty < 1) {

                cartDao.removeItem(
                        email,
                        pid
                );

            } else {

                // =========================
                // 🔥 UPDATE QUANTITY
                // =========================

                cartDao.updateQuantity(
                        email,
                        pid,
                        qty
                );
            }

            // =========================
            // 🔥 REDIRECT
            // =========================

            response.sendRedirect(
                    "cartlogin.jsp"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "cartlogin.jsp?msg=Error updating quantity"
            );
        }
    }
}