 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mangalam.dao.UserDAO" %>
<%@ page import="com.mangalam.dao.WasteDAO" %>
<%@ page import="java.sql.*" %>
<%
    // 1. SECURITY: Logout ke baad browser back button se page load na ho
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 2. SESSION & ROLE CHECK: Sirf logged-in FARMER hi access kar sake
    String role = (String) session.getAttribute("userRole");
    String email = (String) session.getAttribute("userEmail");

    if (role == null || !role.equalsIgnoreCase("FARMER")) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 3. DATABASE FETCH LOGIC: Profile aur Waste Logs ke liye objects
    UserDAO dao = new UserDAO();
    WasteDAO wDao = new WasteDAO();
    
    String fullName = "Farmer"; 
    String locality = ""; 
    String upiId = ""; 
    String pass = "";

    // Farmer ki Profile details nikalna
    try {
        ResultSet rsProfile = dao.getUserDetails(email, role);
        if (rsProfile != null && rsProfile.next()) {
            fullName = rsProfile.getString("full_name");
            locality = rsProfile.getString("locality") != null ? rsProfile.getString("locality") : "";
            upiId = rsProfile.getString("upi_id") != null ? rsProfile.getString("upi_id") : "";
            pass = rsProfile.getString("password");
        }
    } catch(Exception e) { e.printStackTrace(); }
    
    // Farmer ke dwara ki gayi saari sell requests fetch karna
    ResultSet rsWaste = wDao.getFarmerRequests(email); 

    if(fullName == null) fullName = "Farmer";
%>

<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmer Dashboard - Mangalam Kalpataru</title>
    
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
    
    <style> 
        body { font-family: 'Inter', sans-serif; } 
        /* Profile edit mode ke liye green border effect */
        .edit-active input:not([readonly]) {
            border-bottom: 2px solid #13ec13 !important;
            background-color: #fff !important;
            color: #000 !important;
        }
    </style>
</head>

<body class="bg-[#f6f8f6] text-slate-900">

    <jsp:include page="all_com/navbar.jsp" />

    <main class="max-w-7xl mx-auto p-8">
        
        <div class="flex justify-between items-center mb-10">
            <div>
                <p class="text-sm tracking-widest text-green-700 font-bold mb-2 uppercase">Verified Farmer Partner</p>
                <h1 class="text-4xl font-bold text-green-700">
                    WELCOME, <%= fullName %>!
                </h1>
            </div>
            
            <button id="editBtn" onclick="toggleEdit()" class="flex items-center gap-2 bg-white border border-slate-200 px-6 py-2.5 rounded-xl font-bold text-slate-700 shadow-sm hover:bg-slate-50 transition-all">
                <span class="material-symbols-outlined text-lg">edit</span> Edit Profile
            </button>
        </div>

        <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
            
            <div class="bg-white rounded-3xl p-8 shadow-sm border border-slate-100 lg:col-span-1 h-fit">
                <h2 class="text-xs tracking-widest text-slate-400 font-black uppercase mb-8">Personal Information</h2>
                <form id="profileForm" action="UpdateFarmerServlet" method="post" class="space-y-6">
                    <input type="hidden" name="email" value="<%= email %>">
                    <div>
                        <p class="text-[10px] font-bold text-slate-400 uppercase mb-1">Full Name (Locked)</p>
                        <input type="text" value="<%= fullName %>" class="w-full border-b border-slate-50 py-2 font-semibold text-slate-400 bg-slate-50 outline-none cursor-not-allowed" readonly>
                    </div>
                    <div>
                        <p class="text-[10px] font-bold text-green-600 uppercase mb-1">Locality / Village</p>
                        <input type="text" id="locality" name="locality" value="<%= locality %>" class="w-full border-b border-slate-100 py-2 font-bold text-slate-800 outline-none" readonly required>
                    </div>
                    <div>
                        <p class="text-[10px] font-bold text-green-600 uppercase mb-1">UPI ID</p>
                        <input type="text" id="upi" name="upi_id" value="<%= upiId %>" class="w-full border-b border-slate-100 py-2 font-bold text-slate-800 outline-none" readonly required>
                    </div>
                    <div>
                        <p class="text-[10px] font-bold text-green-600 uppercase mb-1">Security Password</p>
                        <input type="password" id="pass" name="password" value="<%= pass %>" class="w-full border-b border-slate-100 py-2 font-bold text-slate-800 outline-none" readonly required>
                    </div>
                    <div id="saveBtnArea" class="hidden pt-4">
                        <button type="submit" class="w-full bg-green-600 text-white font-bold py-3 rounded-2xl shadow-lg">Save Changes</button>
                    </div>
                </form>
            </div>

            <div class="bg-white rounded-3xl p-8 shadow-sm border border-slate-100 lg:col-span-2">
                <h2 class="text-xs tracking-widest text-slate-400 font-black uppercase mb-8">Recent Waste Logs</h2>
                <div class="overflow-x-auto">
                    <table class="w-full text-sm">
                        <thead class="text-slate-400 text-xs uppercase border-b border-slate-50">
                            <tr>
                                <th class="text-left py-4 px-2">ID</th>
                                <th class="text-left py-4 px-2">Area (Acres)</th>
                                <th class="text-left py-4 px-2">Pickup Date</th>
                                <th class="text-left py-4 px-2">Status & Notifications</th>
                            </tr>
                        </thead>
                        <tbody class="text-slate-700 divide-y divide-slate-50">
                            <% 
                            boolean hasData = false;
                            while(rsWaste != null && rsWaste.next()) { 
                                hasData = true;
                                String status = rsWaste.getString("status");
                                // 🚩 Yahan WasteDAO ka 'pdate' alias use kiya hai jo timing nahi dikhayega
                                String displayDate = rsWaste.getString("pdate"); 
                                String reason = rsWaste.getString("rejection_reason");
                                
                                // Status ke hisab se badge colors decide karna
                                String badgeClass = "bg-orange-100 text-orange-700"; 
                                if("SCHEDULED".equals(status)) badgeClass = "bg-blue-100 text-blue-700";
                                else if("COMPLETED".equals(status)) badgeClass = "bg-green-100 text-green-700";
                                else if("REJECTED".equals(status)) badgeClass = "bg-red-100 text-red-700";
                            %>
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="py-6 px-2 font-bold text-slate-400">#MK-<%= rsWaste.getInt("id") %></td>
                                <td class="py-6 px-2 font-bold text-green-900"><%= rsWaste.getDouble("acres") %> Acres</td>
                                <td class="py-6 px-2 font-semibold text-slate-500 italic"><%= displayDate %></td>
                                <td class="py-6 px-2 text-right md:text-left">
                                    <div class="flex flex-col gap-2">
                                        <span class="<%= badgeClass %> w-fit px-3 py-1 rounded-full text-[10px] font-black uppercase tracking-tighter">
                                            <%= status %>
                                        </span>
                                        
                                        <% if("SCHEDULED".equals(status)) { %>
                                            <p class="text-[10px] text-blue-600 font-bold italic leading-tight">Request Approved for <%= displayDate %>.</p>
                                        <% } else if("REJECTED".equals(status)) { %>
                                            <div class="bg-red-50 p-2 rounded-lg border border-red-100">
                                                <p class="text-[10px] text-red-500 font-bold">Reason: <span class="font-normal italic"><%= (reason != null && !reason.isEmpty()) ? reason : "Please contact admin." %></span></p>
                                            </div>
                                        <% } else if("COMPLETED".equals(status)) { %>
                                            <p class="text-[10px] text-green-600 font-bold italic">Payment Processed Successfully!</p>
                                        <% } else { %>
                                            <p class="text-[10px] text-orange-500 font-bold italic">Waiting for Admin review...</p>
                                        <% } %>
                                    </div>
                                </td>
                            </tr>
                            <% } 
                            if(!hasData) { %>
                            <tr>
                                <td colspan="4" class="py-16 text-center text-gray-400 font-bold italic tracking-widest uppercase text-xs">No waste requests found.</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <div class="mt-10 bg-green-50 rounded-2xl p-6 border border-green-100 flex items-center justify-between">
                    <div>
                        <h3 class="text-green-900 font-black mb-1 italic">Have more waste to sell?</h3>
                        <p class="text-green-700 text-xs font-medium">Turn your harvest residue into extra income.</p>
                    </div>
                    <a href="sellwastelogin.jsp" class="bg-green-600 text-white px-8 py-3 rounded-2xl text-sm font-black uppercase tracking-widest shadow-lg shadow-green-100 hover:bg-black transition-all">
                        + New Request
                    </a>
                </div>
            </div>
        </div>
    </main>

    <script>
        // Profile Edit button ka toggle logic
        function toggleEdit() {
            const form = document.getElementById('profileForm');
            const saveArea = document.getElementById('saveBtnArea');
            const editBtn = document.getElementById('editBtn');
            const inputs = [document.getElementById('locality'), document.getElementById('upi'), document.getElementById('pass')];

            const isReadOnly = inputs[0].readOnly;
            if (isReadOnly) {
                // Edit Mode Enable karna
                inputs.forEach(input => input.readOnly = false);
                form.classList.add('edit-active');
                saveArea.classList.remove('hidden');
                editBtn.innerHTML = '<span class="material-symbols-outlined text-lg">close</span> Cancel Edit';
                editBtn.classList.add('text-red-500', 'border-red-100', 'bg-red-50');
            } else {
                // Cancel hone par page reload karna
                window.location.reload();
            }
        }
    </script>
</body>
</html>