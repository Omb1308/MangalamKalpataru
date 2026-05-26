package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

import com.mangalam.dao.CartDAO;
import com.mangalam.dao.ProductDAO;

@WebServlet("/AddToCartServlet")

public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        try {

            // =========================
            // 🔹 SESSION CHECK
            // =========================

            HttpSession session =
                    request.getSession(false);

            if (session == null
                    || session.getAttribute("userEmail") == null) {

                response.sendRedirect(
                        "login.jsp?msg=Please login first"
                );

                return;
            }

            String userEmail =
                    (String) session.getAttribute(
                            "userEmail"
                    );

            // =========================
            // 🔹 GET PARAMETERS
            // =========================

            int productId =
                    Integer.parseInt(
                            request.getParameter(
                                    "productId"
                            )
                    );

            String productName =
                    request.getParameter(
                            "productName"
                    );

            String priceStr =
                    request.getParameter(
                            "basePrice"
                    );

            String packSizeStr =
                    request.getParameter(
                            "packSize"
                    );

            // =========================
            // 🔥 VALIDATION
            // =========================

            if (productName == null
                    || priceStr == null
                    || packSizeStr == null) {

                response.sendRedirect(
                        "shop.jsp?msg=Invalid product data"
                );

                return;
            }

            // =========================
            // 🔥 CONVERT VALUES
            // =========================

            double basePrice =
                    Double.parseDouble(
                            priceStr
                    );

            int packSize =
                    Integer.parseInt(
                            packSizeStr
                    );

            // 🔥 FINAL PRICE

            double finalPrice =
                    basePrice;

            // =========================
            // 🔥 DAO OBJECTS
            // =========================

            CartDAO cartDao =
                    new CartDAO();

            ProductDAO productDao =
                    new ProductDAO();

            // =========================
            // 🔥 GET PRODUCT STOCK
            // =========================

            int stock =
                    productDao.getProductStock(
                            String.valueOf(productId)
                    );

            // =========================
            // 🔥 GET CURRENT CART QTY
            // =========================

            int currentQty =
                    cartDao.getCartQuantity(
                            userEmail,
                            productId
                    );

            // =========================
            // 🔥 STOCK CHECK
            // =========================

            if ((currentQty + 1) > stock) {

                response.sendRedirect(
                        "shop.jsp?msg=Stock limit reached"
                );

                return;
            }

            // =========================
            // 🔥 ADD TO CART
            // =========================

            boolean success =
                    cartDao.addToCart(
                            userEmail,
                            productId,
                            productName
                            + " (Pack of "
                            + packSize
                            + ")",
                            finalPrice
                    );

            // =========================
            // 🔥 RESPONSE
            // =========================

            if (success) {

                response.sendRedirect(
                        "shop.jsp?status=added"
                );

            } else {

                response.sendRedirect(
                        "shop.jsp?msg=Failed to add item"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "shop.jsp?msg=Server error"
            );
        }
    }
}