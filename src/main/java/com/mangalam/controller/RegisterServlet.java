package com.mangalam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.mangalam.model.Customer;
import com.mangalam.dao.CustomerDAO;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Customer c = new Customer();
        c.setFullName(request.getParameter("full_name"));
        c.setEmail(request.getParameter("email"));
        c.setMobile(request.getParameter("mobile"));
        c.setPassword(request.getParameter("password"));
        c.setAddress(request.getParameter("address"));

        CustomerDAO dao = new CustomerDAO();
        if (dao.registerCustomer(c) > 0) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("customersignup.jsp?error=failed");
        }
    }
}