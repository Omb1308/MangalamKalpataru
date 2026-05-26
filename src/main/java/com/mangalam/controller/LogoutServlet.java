package com.mangalam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Existing session ko pakadna (false ka matlab naya session nahi banega)
        HttpSession session = request.getSession(false);
        
        if (session != null) {
            // 2. Session se data hatana (Security ke liye)
            session.removeAttribute("userEmail");
            session.removeAttribute("userRole");
            session.removeAttribute("userName");
            
            // 3. Poora session destroy kar dena
            session.invalidate(); 
        }

        // 4. Redirect: Logout ke baad Login page par bhejein success message ke saath
        // Aap index.jsp par bhi bhej sakte hain, lekin login.jsp zyada sahi hai
        response.sendRedirect("login.jsp?msg=logout_success"); 
    }

    // doPost ko bhi doGet par redirect kar dena chahiye safety ke liye
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}