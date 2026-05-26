package com.mangalam.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.mangalam.dao.UserDAO;

// 🔥 Yeh annotation zaroori hai, iske bina 404 aayega
@WebServlet("/UpdateAddressServlet")
public class UpdateAddressServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Form se naya address lena
        String newAddress = request.getParameter("newAddress");
        
        // 2. Session se user email lena
        HttpSession session = request.getSession(false);
        String email = (session != null) ? (String) session.getAttribute("userEmail") : null;

        if (email != null && newAddress != null) {
            UserDAO dao = new UserDAO();
            // 3. Database update karna
            boolean success = dao.updateUserAddress(email, newAddress);
            
            if (success) {
                // Taaki cart page par success popup dikhe
                response.sendRedirect("cartlogin.jsp?msg=success");
            } else {
                response.sendRedirect("cartlogin.jsp?msg=error");
            }
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}