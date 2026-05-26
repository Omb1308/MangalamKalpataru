<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Mangalam Kalpataru</title>
<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<%-- 1. JavaScript Popup Logic --%>
<% 
   String msg = request.getParameter("msg");
   if("logout_success".equals(msg)) { 
%>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<script>

window.onload = function() {

    Swal.fire({

        icon: 'success',

        title: 'Logout Successful',

        text: 'You have been logged out successfully!',

        confirmButtonColor: '#16a34a'

    });

    window.history.replaceState(
        null,
        null,
        window.location.pathname
    );
};

</script>
<% } %>

</head>

<body class="bg-gray-100 flex items-center justify-center min-h-screen p-4">

<div class="w-full max-w-6xl bg-white rounded-2xl shadow-lg overflow-hidden grid md:grid-cols-2">

    <%-- Left Side: Login Form --%>
    <div class="p-10 border-r border-gray-100">
    
        <a href="index.jsp" class="inline-flex items-center gap-2 text-green-700 font-medium mb-6 hover:underline">
            <span class="text-lg">←</span> Back to Home
        </a>

        <h2 class="text-3xl font-bold text-green-800 mb-2">Welcome Back</h2>
        <p class="text-gray-500 mb-6">Enter your credentials to access your dashboard.</p>

        <%-- Error Message for Invalid Login --%>
        <% 
            String error = request.getParameter("error");
            if("invalid".equals(error) || "1".equals(error)) { 
        %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-2 rounded mb-4 text-sm">
                Invalid Email or Password. Please try again.
            </div>
        <% } %>
        <%
String success = request.getParameter("success");
if("registered".equals(success)) {
%>
<div class="bg-green-100 text-green-700 p-3 rounded mb-4 text-sm">
    Registration successful! Please login.
</div>
<% } %>

        <form action="LoginServlet" method="post">

            <label class="block text-xs font-semibold text-gray-500 mb-2 uppercase tracking-wider">Email Address</label>
            <input type="email" name="email"
                   placeholder="e.g. john@example.com" required
                   class="w-full mb-5 px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg outline-none focus:ring-2 focus:ring-green-500 transition"/>

            <label class="block text-xs font-semibold text-gray-500 mb-2 uppercase tracking-wider">Password</label>
            <input type="password" name="password"
                   placeholder="••••••••" required
                   class="w-full mb-3 px-4 py-3 bg-gray-50 border border-gray-200 rounded-lg outline-none focus:ring-2 focus:ring-green-500 transition"/>

            <div class="flex justify-end mb-6 text-sm">
                <a href="forgotpass.jsp" class="text-green-600 font-medium hover:underline">Forgot password?</a>
            </div>

            <button type="submit"
                    class="w-full bg-green-700 hover:bg-green-800 text-white py-4 rounded-lg font-bold text-lg shadow-md hover:shadow-lg transition-all">
                Login to Mangalam Kalpataru
            </button>

        </form>
    </div>

    <%-- Right Side: Signup Options --%>
    <div class="bg-gray-50 p-10 flex flex-col justify-center">
        <h2 class="text-2xl font-bold text-gray-800 mb-1">New to Mangalam Kalpataru?</h2>
        <p class="text-gray-500 mb-8 font-medium">Choose your path in our circular ecosystem.</p>

        <div class="space-y-4">

    <!-- Farmer -->
    <a href="farmersignup.jsp" class="group mb-6 block">
        <div class="bg-white border border-gray-200 group-hover:border-green-500 group-hover:bg-green-50 rounded-xl p-5 flex items-center gap-4 transition-all duration-300 shadow-sm">
            
            <div class="bg-green-100 p-3 rounded-lg group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined text-green-700 text-2xl">
                    eco
                </span>
            </div>

            <div>
                <h4 class="font-bold text-gray-800 group-hover:text-green-800">Join as a Farmer</h4>
                <p class="text-sm text-gray-500">Turn your agricultural waste into income.</p>
            </div>
        </div>
    </a>

    <!-- Customer -->
    <a href="customersignup.jsp" class="group">
        <div class="bg-white border border-gray-200 group-hover:border-green-500 group-hover:bg-green-50 rounded-xl p-5 flex items-center gap-4 transition-all duration-300 shadow-sm">
            
            <div class="bg-green-100 p-3 rounded-lg group-hover:scale-110 transition-transform">
                <span class="material-symbols-outlined text-green-700 text-2xl">
                    shopping_bag
                </span>
            </div>

            <div>
                <h4 class="font-bold text-gray-800 group-hover:text-green-800">Join as a Customer</h4>
                <p class="text-sm text-gray-500">Shop premium upcycled goods.</p>
            </div>
        </div>
    </a>

</div>

<!-- Bottom Card -->
<div class="mt-10 bg-green-900 rounded-xl p-5 text-white shadow-lg">
    <div class="flex items-start gap-3">
        
        <span class="material-symbols-outlined text-yellow-300 text-xl">
            verified
        </span>

        <div>
            <h5 class="font-bold text-green-300">The Provenance Promise</h5>
            <p class="text-xs text-green-100 leading-relaxed mt-1">
                Every transaction on Mangalam Kalpataru is archived, ensuring full transparency in our sustainable supply chain.
            </p>
        </div>
    </div>
</div>
    </div>
</div>

</body>
</html>