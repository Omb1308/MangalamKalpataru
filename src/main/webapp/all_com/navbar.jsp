<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mangalam.dao.UserDAO, com.mangalam.dao.CartDAO" %>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">
<%
String sessionRole = (String) session.getAttribute("userRole");
String sessionEmail = (String) session.getAttribute("userEmail");

String navUserName = "User";
String sellWasteLink = "sellwastenotlogin.jsp"; 
String cartLink = "cartnotlogin.jsp"; 
int cartCount = 0;

// Dashboard link (FINAL FIX)
String dashLink = "login.jsp";

if (sessionEmail != null && sessionRole != null) {

    UserDAO navDao = new UserDAO();
    navUserName = navDao.getUserName(sessionEmail, sessionRole);

    // Role based dashboard
    if ("ADMIN".equalsIgnoreCase(sessionRole)) {
        dashLink = "admdashreq.jsp";
    } else if ("FARMER".equalsIgnoreCase(sessionRole)) {
        dashLink = "farmerdash.jsp";
    } else {
        dashLink = "cusdash.jsp";
    }

    // Cart logic (ONLY CUSTOMER)
    if (!"ADMIN".equalsIgnoreCase(sessionRole) && !"FARMER".equalsIgnoreCase(sessionRole)) {
        cartLink = "cartlogin.jsp";

        CartDAO cartDao = new CartDAO();
        cartCount = cartDao.getCartCount(sessionEmail);
    }

    if ("FARMER".equalsIgnoreCase(sessionRole)) {
        sellWasteLink = "sellwastelogin.jsp";
    }
}
%>

<header class="sticky top-0 z-50 w-full bg-white/80 backdrop-blur-md border-b border-slate-200">
<div class="max-w-7xl mx-auto px-6 h-16 flex items-center justify-between">

<!-- Logo -->
<div class="flex items-center gap-3">
    <div class="bg-[#13ec13] p-1.5 rounded-lg text-white">
        <span class="material-symbols-outlined">eco</span>
    </div>
    <h2 class="text-xl font-extrabold text-slate-800">
        Mangalam<span class="text-[#13ec13]">Kalpataru</span>
    </h2>
</div>

<!-- Nav -->
<nav class="hidden md:flex items-center gap-8">

    <a href="index.jsp" class="text-sm font-semibold hover:text-[#13ec13]">Home</a>
    <a href="aboutas.jsp" class="text-sm font-semibold hover:text-[#13ec13]">About</a>
    <a href="ourstory.jsp" class="text-sm font-semibold hover:text-[#13ec13]">Story</a>
    <a href="ourMission.jsp" class="text-sm font-semibold hover:text-[#13ec13]">Impact</a>

    <!-- Sell Waste -->
    <% 
boolean isFarmer = "FARMER".equalsIgnoreCase(sessionRole);
boolean isGuest = (sessionRole == null);
%>

<% if (isGuest || isFarmer) { %>
    <a href="<%= (isFarmer ? "sellwastelogin.jsp" : "sellwastenotlogin.jsp") %>" 
       class="text-sm font-semibold hover:text-[#13ec13]">
        Sell Waste
    </a>
<% } %>

    <!-- Shop + Cart (ONLY CUSTOMER) -->
    <% if (sessionRole == null || (!sessionRole.equalsIgnoreCase("FARMER") && !sessionRole.equalsIgnoreCase("ADMIN"))) { %>

        <a href="shop.jsp" class="text-sm font-semibold hover:text-[#13ec13]">Shop</a>

        <a href="<%= cartLink %>" class="relative flex items-center">
            <span class="material-symbols-outlined hover:text-[#13ec13]">shopping_cart</span>

            <% if (cartCount > 0) { %>
                <span class="absolute -top-2 -right-2 bg-red-500 text-white text-xs rounded-full px-1">
                    <%= cartCount %>
                </span>
            <% } %>
        </a>

    <% } %>

</nav>

<!-- Profile -->
<div class="flex items-center gap-4">

<% if (sessionEmail == null) { %>

    <a href="login.jsp" class="bg-[#13ec13] hover:bg-green-600 hover:scale-105 transition-all duration-300 text-white px-6 py-2 rounded-xl">Login</a>

<% } else { %>

<div class="relative group cursor-pointer">

    <!-- Avatar -->
    <div class="w-10 h-10 rounded-full border-2 border-green-500 flex items-center justify-center bg-green-50 font-bold text-green-700">
        <%= (navUserName != null && !navUserName.isEmpty()) 
    ? navUserName.substring(0,1).toUpperCase() 
    : "U" %>
    </div>

    <!-- Dropdown -->
    <div class="absolute right-0 top-full mt-2 w-52 opacity-0 invisible group-hover:opacity-100 group-hover:visible transition">

        <div class="bg-white shadow-xl rounded-xl p-2">

            <p class="text-xs text-gray-400 text-center mb-2">
                <%= sessionRole %> Account
            </p>

            <!-- Dashboard -->
            <a href="<%= dashLink %>" class="block px-3 py-2 hover:bg-green-50 rounded">
                Dashboard
            </a>

            <!-- Cart (ONLY CUSTOMER) -->
            <% if (!"ADMIN".equalsIgnoreCase(sessionRole) && !"FARMER".equalsIgnoreCase(sessionRole)) { %>
                <a href="cartlogin.jsp" class="block px-3 py-2 hover:bg-green-50 rounded">
                    My Cart
                </a>
            <% } %>

            <hr class="my-2">

            <a href="LogoutServlet" class="block px-3 py-2 text-red-500 hover:bg-red-50 rounded">
                Logout
            </a>

        </div>

    </div>

</div>

<% } %>

</div>
</div>
</header>

<script>
window.onpageshow = function(event) {
    if (event.persisted || (window.performance && window.performance.getEntriesByType("navigation")[0].type === 'back_forward')) {
        window.location.reload();
    }
};
</script>