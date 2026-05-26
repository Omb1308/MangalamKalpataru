package com.mangalam.controller;

import java.io.IOException;
import java.util.List;

import com.mangalam.dao.CartDAO;
import com.mangalam.dao.OrderDAO;
import com.mangalam.dao.ProductDAO;
import com.mangalam.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/RazorpaySuccessServlet")
public class RazorpaySuccessServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            HttpSession session = request.getSession();

            String email =
                    (String) session.getAttribute("userEmail");

            // Safety Check
            if (email == null) {

                response.sendRedirect("login.jsp");
                return;
            }

            CartDAO cartDAO = new CartDAO();
            OrderDAO orderDAO = new OrderDAO();
            ProductDAO productDAO = new ProductDAO();

            List<CartItem> cartItems =
                    cartDAO.getCartItems(email);

            boolean allSuccess = true;

            for (CartItem item : cartItems) {

                // Save Order
                boolean orderResult = orderDAO.placeOrder(
                        email,
                        item.getpName(),
                        item.getPrice() * item.getQuantity()
                );

                // Reduce Stock
                boolean stockResult = productDAO.decreaseStock(
                        item.getpId(),
                        item.getQuantity()
                );

                if (!orderResult || !stockResult) {

                    allSuccess = false;
                    break;
                }
            }

            if (allSuccess) {

                // Clear Cart
                cartDAO.clearCart(email);

                response.sendRedirect("paymentSuccess.jsp");

            } else {

                response.sendRedirect("paymentFailed.jsp");
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("paymentFailed.jsp");
        }
    }
}