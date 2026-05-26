  package com.mangalam.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.mangalam.dao.WasteDAO;

@WebServlet("/AdminActionServlet")
public class AdminActionServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // JSP se parameters receive karna
        String idParam = request.getParameter("id");
        String action = request.getParameter("action");
        String reason = request.getParameter("reason"); // Custom modal se aaya hua reason
        
        WasteDAO dao = new WasteDAO();
        int id = Integer.parseInt(idParam);

        // Approve Action Logic
        if ("approve".equals(action)) {
            dao.updateStatusWithReason(id, "SCHEDULED", null);
            response.sendRedirect("admdashreq.jsp?msg=Approved");
        } 
        // Reject Action Logic (Reason ke saath)
        else if ("reject".equals(action)) {
            dao.updateStatusWithReason(id, "REJECTED", reason);
            response.sendRedirect("admdashreq.jsp?msg=Rejected");
        } 
        // Payment Confirm Action Logic
        else if ("pay".equals(action)) {
            dao.updateStatusWithReason(id, "COMPLETED", null);
            response.sendRedirect("admdashreq.jsp?msg=Paid");
        }
    }
}