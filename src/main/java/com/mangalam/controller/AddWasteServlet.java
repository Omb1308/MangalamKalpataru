package com.mangalam.controller;

import java.io.IOException; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.mangalam.dao.WasteDAO;

@WebServlet("/AddWasteServlet")
public class AddWasteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String email = request.getParameter("email");
            double acres = Double.parseDouble(request.getParameter("acres"));
            String date = request.getParameter("pickupDate");
            String loc = request.getParameter("location");

            WasteDAO dao = new WasteDAO();
            if (dao.addWasteRequest(email, acres, date, loc)) {
                response.sendRedirect("sellwastelogin.jsp?msg=success");
            } else {
                response.sendRedirect("sellwastelogin.jsp?msg=error");
            }
        } catch (Exception e) {
            response.sendRedirect("sellwastelogin.jsp?msg=error");
        }
    }
}