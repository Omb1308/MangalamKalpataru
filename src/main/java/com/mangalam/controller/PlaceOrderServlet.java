package com.mangalam.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.mangalam.dao.OrderDAO;

@WebServlet("/PlaceOrderServlet")
public class PlaceOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        String email = (String) session.getAttribute("userEmail");

        String product = request.getParameter("productName");
        double amount = Double.parseDouble(request.getParameter("amount"));

        OrderDAO dao = new OrderDAO();

        boolean success = dao.placeOrder(email, product, amount);

        if (success) {
            response.sendRedirect("custDashboard.jsp");
        } else {
            response.sendRedirect("cart.jsp?error");
        }
    }
}