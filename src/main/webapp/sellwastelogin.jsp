<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mangalam.dao.WasteDAO, java.sql.*" %>
<%
    String fEmail = (String) session.getAttribute("userEmail");
    if (fEmail == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    WasteDAO wDao = new WasteDAO();
    ResultSet rs = wDao.getFarmerRequests(fEmail);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sell Waste - Farmer Portal</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700;900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    <style> body { font-family: 'Inter', sans-serif; } </style>
</head>
<body class="bg-[#f6f8f6]">

<jsp:include page="all_com/navbar.jsp" />

<main class="max-w-7xl mx-auto px-6 py-12">
    
    <div class="grid lg:grid-cols-2 gap-16 items-start mb-20">
        <div>
            <p class="text-xs font-bold text-green-600 uppercase tracking-widest mb-4">Farmer Portal</p>
            <h1 class="text-5xl font-black text-slate-900 leading-tight mb-6">
                Turn your waste into <span class="text-green-600 italic">Living Wealth.</span>
            </h1>
            <p class="text-slate-600 text-lg mb-8">Submit your farm area details. Our team will verify and schedule a pickup to transform your banana residue into eco-credits.</p>
            
            <div class="bg-white p-6 rounded-2xl shadow-sm border-l-8 border-green-500 flex items-center gap-4">
                <span class="material-symbols-outlined text-green-600 text-4xl">payments</span>
                <div>
                    <h4 class="font-bold text-slate-800 text-sm">Instant Payouts</h4>
                    <p class="text-xs text-slate-500 font-medium">Get paid directly to your UPI after verification.</p>
                </div>
            </div>
        </div>

        <div class="bg-white p-10 rounded-3xl shadow-xl border border-slate-100">
            <h3 class="text-xl font-black text-slate-900 mb-8">Create New Request</h3>
            
            <form action="AddWasteServlet" method="post" class="space-y-6">
                <input type="hidden" name="email" value="<%= fEmail %>">
                
                <div class="grid grid-cols-2 gap-6">
                    <div>
                        <label class="text-[10px] font-black text-slate-400 uppercase">Farm Area (Acres)</label>
                        <input type="number" step="0.1" name="acres" placeholder="e.g. 2.5" class="w-full border-b-2 border-slate-100 py-3 focus:border-green-500 outline-none font-bold" required>
                    </div>
                    <div>
    <label class="text-[10px] font-black text-slate-400 uppercase">Preferred Pickup</label>
    <input type="date" id="datePicker" name="pickupDate" 
           class="w-full border-b-2 border-slate-100 py-3 focus:border-green-500 outline-none font-bold" required>
</div>
                </div>

                <div>
                    <label class="text-[10px] font-black text-slate-400 uppercase">Pickup Location / Village</label>
                    <input type="text" name="location" placeholder="Village name, Road, Landmark" class="w-full border-b-2 border-slate-100 py-3 focus:border-green-500 outline-none font-bold" required>
                </div>

                <button type="submit" class="w-full bg-green-900 text-white py-4 rounded-2xl font-black text-sm uppercase tracking-widest hover:bg-green-800 transition shadow-lg shadow-green-100">
                    Submit Request to Admin →
                </button>
            </form>
        </div>
    </div>

    <section class="mt-12">
        <div class="flex justify-between items-end mb-8">
            <div>
                <h2 class="text-2xl font-black text-slate-900">Recent Requests</h2>
                <p class="text-sm text-slate-500 font-medium italic">Live tracking of your contributions.</p>
            </div>
        </div>

        <div class="bg-white rounded-3xl shadow-sm border border-slate-100 overflow-hidden">
            <table class="w-full text-left">
                <thead class="bg-slate-50 border-b">
                    <tr class="text-[10px] font-black text-slate-400 uppercase tracking-widest">
                        <th class="px-8 py-5">Request ID</th>
                        <th class="px-8 py-5">Area</th>
                        <th class="px-8 py-5">Pickup Date</th>
                        <th class="px-8 py-5">Current Status</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50">
                    <% while(rs != null && rs.next()) { 
                        String status = rs.getString("status");
                        String badge = "bg-orange-100 text-orange-600"; // Default PENDING
                        if("SCHEDULED".equals(status)) badge = "bg-blue-100 text-blue-600";
                        else if("COMPLETED".equals(status)) badge = "bg-green-100 text-green-600";
                        else if("REJECTED".equals(status)) badge = "bg-red-100 text-red-600";
                    %>
                    <tr class="hover:bg-slate-50 transition-colors">
                        <td class="px-8 py-5 font-black text-slate-800">#MK-<%= rs.getInt("id") %></td>
                        <td class="px-8 py-5 font-bold text-slate-600"><%= rs.getDouble("acres") %> Acres</td>
                        <td class="px-8 py-5 font-bold text-slate-600"><%= rs.getString("pdate") %></td>
                        <td class="px-8 py-5">
                            <span class="<%= badge %> px-4 py-1.5 rounded-full text-[9px] font-black uppercase tracking-tighter">
                                <%= status %>
                            </span>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </section>

</main>

<jsp:include page="all_com/footer.jsp" />

</body>
</html>

<script>
    // Page load hote hi aaj ki date nikalne ke liye
    window.onload = function() {
        var today = new Date();
        var dd = String(today.getDate()).padStart(2, '0');
        var mm = String(today.getMonth() + 1).padStart(2, '0'); // January 0 hota hai
        var yyyy = today.getFullYear();

        // Date format: YYYY-MM-DD
        today = yyyy + '-' + mm + '-' + dd;
        
        // Input field ki 'min' property set karna
        document.getElementById("datePicker").setAttribute("min", today);
        
        // Optional: Default value bhi aaj ki hi set kar sakte hain
        // document.getElementById("datePicker").value = today;
    };

    // Purana 404 fix (Just in case page cache issues ho)
    window.onpageshow = function(event) {
        if (event.persisted || (window.performance && window.performance.getEntriesByType("navigation")[0].type === 'back_forward')) {
            window.location.reload();
        }
    };
</script>