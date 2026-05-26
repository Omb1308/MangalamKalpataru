 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mangalam.dao.WasteDAO, java.sql.*" %>
<%
    // 1. Security: Logout ke baad back button disable karne ke liye
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    // 2. Authorization: Check if user is logged in as ADMIN
    if (session.getAttribute("userEmail") == null || !"ADMIN".equals(session.getAttribute("userRole"))) {
        response.sendRedirect("login.jsp");
        return; 
    }
    
    // 3. Data Fetching
    WasteDAO dao = new WasteDAO();
    ResultSet rs = dao.getAllRequests();
%>

<%
String currentPage = "waste";   // 👈 is page ke hisaab se change hoga
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin - Waste Requests</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
   
</head>
<body class="bg-gray-100 font-sans">
<div class="flex h-screen overflow-hidden">
    
    <aside class="w-64 bg-white shadow-xl flex flex-col z-10">
        <div class="p-8 border-b border-gray-50">
            <h1 class="text-2xl font-black text-green-800 tracking-tighter">Mangalam</h1>
            <p class="text-[10px] text-gray-400 uppercase font-bold tracking-widest">Sustainability Admin</p>
        </div>

           <!-- NAVIGATION -->

        <nav class="mt-4 px-4 space-y-3">

            <!-- DASHBOARD -->

            <a href="admindashboard.jsp"

               class="flex items-center gap-3 px-4 py-3.5 rounded-2xl font-bold transition <%= currentPage.equals("dashboard") ? "bg-green-700 text-white shadow-lg shadow-green-100" : "text-slate-500 hover:bg-green-50 hover:text-green-700" %>">

                <span class="material-symbols-outlined">

                    dashboard

                </span>

                Dashboard

            </a>

            <!-- WASTE -->

            <a href="admdashreq.jsp"

               class="flex items-center gap-3 px-4 py-3.5 rounded-2xl font-bold transition <%= currentPage.equals("waste") ? "bg-green-700 text-white shadow-lg shadow-green-100" : "text-slate-500 hover:bg-green-50 hover:text-green-700" %>">

                <span class="material-symbols-outlined">

                    recycling

                </span>

                Waste Requests

            </a>

            <!-- PRODUCTS -->

            <a href="admdashpromngt.jsp"

               class="flex items-center gap-3 px-4 py-3.5 rounded-2xl font-bold transition <%= currentPage.equals("product") ? "bg-green-700 text-white shadow-lg shadow-green-100" : "text-slate-500 hover:bg-green-50 hover:text-green-700" %>">

                <span class="material-symbols-outlined">

                    agriculture

                </span>

                Product Management

            </a>

        </nav>

        <div class="p-8 border-t border-gray-50">
            <a href="LogoutServlet" class="flex items-center gap-2 text-red-500 font-black text-xs uppercase hover:underline transition-all">
                <span class="material-symbols-outlined text-sm">logout</span> Logout
            </a>
        </div>
    </aside>

    <main class="flex-1 p-10 overflow-y-auto">
        <header class="flex justify-between items-end mb-12">
            <div>
                <h2 class="text-3xl font-bold text-green-800 mb-6">Request Management</h2>
                <p class="text-sm text-slate-400 font-medium">Verify and process agricultural waste sell requests.</p>
            </div>
            <% if(request.getParameter("msg") != null) { %>
                <div class="bg-green-100 text-green-700 px-3 py-1.5 rounded-md text-xs font-medium">
                    Status: <%= request.getParameter("msg") %>
                </div>
            <% } %>
        </header>

       <div class="bg-white border border-gray-200 rounded-xl overflow-hidden">

    <!-- HEADER -->
    <div class="px-6 py-4 border-b border-gray-200 flex items-center justify-between bg-white">
        <h2 class="text-lg font-semibold text-gray-800">
            New Incoming Requests
        </h2>

        <span class="text-sm text-gray-500">
            Pending Requests
        </span>
    </div>

    <!-- PENDING REQUESTS -->
    <div class="divide-y divide-gray-100">

        <% 
           rs.beforeFirst(); 
           boolean hasPending = false; 

           while(rs.next()) { 

               if("PENDING".equals(rs.getString("status"))) { 

                   hasPending = true; 
        %>

        <div class="grid grid-cols-4 gap-4 px-6 py-5 items-center hover:bg-gray-50 transition">

            <!-- USER -->
            <div class="flex items-center gap-3">

                <div class="w-10 h-10 rounded-full bg-gray-100 flex items-center justify-center text-gray-700 font-semibold">
                    <%= rs.getString("full_name").charAt(0) %>
                </div>

                <div>
                    <p class="font-semibold text-gray-800 text-sm">
                        <%= rs.getString("full_name") %>
                    </p>

                    <p class="text-xs text-gray-500">
                        <%= rs.getString("farmer_email") %>
                    </p>
                </div>
            </div>

            <!-- LAND -->
            <div>
                <p class="text-xs text-gray-500 mb-1">
                    Land Area
                </p>

                <p class="font-semibold text-gray-800">
                    <%= rs.getDouble("acres") %> Acres
                </p>
            </div>

            <!-- DATE -->
            <div>
                <p class="text-xs text-gray-500 mb-1">
                    Pickup Date
                </p>

                <p class="text-sm text-gray-700">
                    <%= rs.getString("pdate") %>
                </p>
            </div>

            <!-- ACTIONS -->
            <div class="flex justify-end gap-2">

                <a href="AdminActionServlet?id=<%= rs.getInt("id") %>&action=approve"
                   class="px-4 py-2 bg-green-600 text-white text-sm rounded-md hover:bg-green-700 transition">

                    Approve

                </a>

                <button onclick="openModal('<%= rs.getInt("id") %>')"
                        class="px-4 py-2 border border-red-200 text-red-500 text-sm rounded-md hover:bg-red-50 transition">

                    Reject

                </button>
            </div>
        </div>

        <%      
               }
           } 

           if(!hasPending) { 
        %>

        <!-- EMPTY STATE -->

        <div class="py-16 text-center">

            <span class="material-symbols-outlined text-5xl text-gray-300">
                inbox
            </span>

            <p class="mt-3 text-sm text-gray-500">
                No pending requests available.
            </p>
        </div>

        <% } %>

    </div>

    <!-- HISTORY HEADER -->

    <div class="px-6 py-4 border-t border-gray-200 bg-gray-50">
        <h3 class="text-sm font-semibold text-gray-700">
            Processed Requests History
        </h3>
    </div>

    <!-- HISTORY -->

    <div class="divide-y divide-gray-100">

        <% 
           rs.beforeFirst(); 

           while(rs.next()) { 

               String status = rs.getString("status");

               if(!"PENDING".equals(status)) { 
        %>

        <div class="grid grid-cols-5 gap-4 px-6 py-4 items-center hover:bg-gray-50 transition">

            <div class="font-medium text-gray-800 text-sm">
                <%= rs.getString("full_name") %>
            </div>

            <div class="text-sm text-gray-700">
                <%= rs.getDouble("acres") %> Acres
            </div>

            <div class="text-sm text-gray-600">
                <%= rs.getString("pdate") %>
            </div>

            <!-- STATUS -->

            <div>

                <span class="px-3 py-1 rounded-full text-xs font-medium

                    <%= status.equals("REJECTED")
                    ? "bg-red-100 text-red-600"
                    : "bg-green-100 text-green-700" %>">

                    <%= status %>

                </span>

                <% if("REJECTED".equals(status)) { %>

                    <p class="text-xs text-red-500 mt-1">
                        Reason:
                        <%= rs.getString("rejection_reason") %>
                    </p>

                <% } %>

            </div>

            <!-- PAY BUTTON -->

            <div class="flex justify-end">

                <% if("SCHEDULED".equals(status)) { %>

                    <a href="AdminActionServlet?id=<%= rs.getInt("id") %>&action=pay"
                       class="px-4 py-2 bg-gray-800 text-white text-xs rounded-md hover:bg-black transition">

                        Confirm & Pay

                    </a>

                <% } %>

            </div>
        </div>

        <%      
               }
           } 
        %>

    </div>
</div>

<div id="modalBox"
     class="hidden fixed inset-0 bg-black/40 flex items-center justify-center z-50 p-4">

    <div class="bg-white w-full max-w-md rounded-xl shadow-xl p-6">

        <!-- HEADER -->

        <div class="flex items-start justify-between mb-5">

            <div>

                <h3 class="text-xl font-semibold text-gray-800">
                    Reject Request
                </h3>

                <p class="text-sm text-gray-500 mt-1">
                    This reason will be visible to the farmer.
                </p>

            </div>

            <button onclick="closeModal()"
                    class="text-gray-400 hover:text-red-500 transition">

                <span class="material-symbols-outlined">
                    close
                </span>

            </button>
        </div>

        <!-- HIDDEN ID -->

        <input type="hidden" id="rejectId">

        <!-- TEXTAREA -->

        <textarea
            id="reasonText"
            placeholder="Enter rejection reason..."
            class="w-full h-32 border border-gray-300 rounded-lg p-4 text-sm outline-none focus:ring-2 focus:ring-red-400 resize-none">
        </textarea>

        <!-- BUTTONS -->

        <div class="flex justify-end gap-3 mt-6">

            <button onclick="closeModal()"
                    class="px-4 py-2 border border-gray-300 rounded-md text-sm text-gray-600 hover:bg-gray-100 transition">

                Cancel

            </button>

            <button onclick="submitReject()"
                    class="px-4 py-2 bg-red-500 text-white rounded-md text-sm hover:bg-red-600 transition">

                Submit Rejection

            </button>

        </div>
    </div>
</div>

<script>
    const modal = document.getElementById('modalBox');
    const reasonInput = document.getElementById('reasonText');

    function openModal(id) { 
        document.getElementById('rejectId').value = id; 
        modal.classList.remove('hidden'); 
        // Add a small scale effect
        modal.firstElementChild.classList.add('scale-100');
    }

    function closeModal() { 
        modal.classList.add('hidden'); 
        reasonInput.value = ""; 
    }

    function submitReject() {
        const id = document.getElementById('rejectId').value;
        const reason = reasonInput.value.trim();
        
        if(reason === "") {
            alert("Please provide a valid reason for the farmer.");
            return;
        }
        
        // Final Action: Sending to Servlet
        window.location.href = "AdminActionServlet?id=" + id + "&action=reject&reason=" + encodeURIComponent(reason);
    }

    // Close modal on escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closeModal();
    });
</script>
</body>
</html>