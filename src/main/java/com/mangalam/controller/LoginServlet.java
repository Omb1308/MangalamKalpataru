package com.mangalam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.mangalam.dao.UserDAO;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String pass = request.getParameter("password");

        if (email != null) email = email.trim().toLowerCase();

        // ✅ USE PLAIN TEXT (FIX)
        String finalPassword = pass;

        UserDAO dao = new UserDAO();

        // 🔥 check using plain password
        String role = dao.checkUserRole(email, finalPassword);

        if (role != null) {

            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userRole", role);

            String userName = dao.getUserName(email, role);
            session.setAttribute("userName", userName);

            if ("ADMIN".equals(role)) {
                response.sendRedirect("admindashboard.jsp");
            } 
            else if ("FARMER".equals(role)) {
                response.sendRedirect("farmerdash.jsp");
            } 
            else if ("CUSTOMER".equals(role)) {
                response.sendRedirect("cusdash.jsp");
            }

        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}