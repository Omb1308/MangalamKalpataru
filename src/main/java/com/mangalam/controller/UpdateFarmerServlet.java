
package com.mangalam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.mangalam.dao.UserDAO;

@WebServlet("/UpdateFarmerServlet")
public class UpdateFarmerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        String locality = request.getParameter("locality");
        String upi = request.getParameter("upi_id");

        UserDAO dao = new UserDAO();
        if(dao.updateFarmerProfile(email, pass, locality, upi)) {
            response.sendRedirect("farmerdash.jsp?msg=success");
        } else {
            response.sendRedirect("farmerdash.jsp?msg=error");
        }
    }
}