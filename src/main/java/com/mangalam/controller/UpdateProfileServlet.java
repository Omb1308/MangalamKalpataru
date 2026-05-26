package com.mangalam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.mangalam.dao.UserDAO;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Form (JSP) se data nikalna
        // JSP mein input ka 'name="email"', 'name="password"', etc. hona chahiye
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String mno = request.getParameter("mno"); // Ye JSP form ka 'name' hai
        String address = request.getParameter("address");

        // 2. DAO object banana
        UserDAO dao = new UserDAO();
        
        // 3. Database update call karna 
        // Note: mno variable yahan 'mobile' column ke liye pass ho raha hai
        boolean isUpdated = dao.updateCustomerProfile(email, pass, mno, address);

        // 4. Result ke basis par redirect karna
        if (isUpdated) {
            // Success hone par 'msg=success' parameter bhej rahe hain
            response.sendRedirect("cusdash.jsp?msg=success");
        } else {
            // Error hone par 'msg=error' bhej rahe hain
            response.sendRedirect("cusdash.jsp?msg=error");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Direct URL access ko rokne ke liye dashboard par redirect
        response.sendRedirect("cusdash.jsp");
    }
}