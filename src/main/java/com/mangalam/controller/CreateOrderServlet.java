package com.mangalam.controller;

import java.io.IOException;

import org.json.JSONObject;

import com.mangalam.util.RazorpayConfig;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/CreateOrderServlet")
public class CreateOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            double amount =
                    Double.parseDouble(
                    request.getParameter("amount"));

            RazorpayClient client =
                    new RazorpayClient(
                    RazorpayConfig.KEY,
                    RazorpayConfig.SECRET);

            JSONObject options = new JSONObject();

            options.put("amount", (int)(amount * 100));

            options.put("currency", "INR");

            options.put("receipt",
                    "txn_" + System.currentTimeMillis());

            Order order =
                    client.orders.create(options);

            response.setContentType("application/json");

            response.getWriter().write(order.toString());

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().write("{\"status\":\"failed\"}");
        }
    }
}