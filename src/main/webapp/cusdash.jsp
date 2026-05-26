<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mangalam.dao.UserDAO" %>
<%@ page import="com.mangalam.dao.OrderDAO" %>
<%@ page import="java.util.*" %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String role = (String) session.getAttribute("userRole");
String email = (String) session.getAttribute("userEmail");

if (role == null || email == null || !role.equalsIgnoreCase("CUSTOMER")) {
    response.sendRedirect("login.jsp");
    return;
}

// USER DATA
UserDAO dao = new UserDAO();

String fullName = dao.getCustomerName(email);
String address = dao.getUserAddress(email);
String mobile = dao.getUserMobile(email);
String pass = dao.getUserPassword(email);

// NULL SAFETY
if(fullName == null) fullName = "User";
if(address == null) address = "-";
if(mobile == null) mobile = "-";

// ORDER DATA
OrderDAO orderDao = new OrderDAO();
List<String[]> orders = orderDao.getOrdersByEmail(email);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer Dashboard</title>
<script src="https://cdn.tailwindcss.com"></script>

<style>
.edit-active input:not([readonly]) {
    border-bottom: 2px solid #16a34a;
    background-color: #fff;
}
</style>

</head>

<body class="bg-gray-50">

<jsp:include page="all_com/navbar.jsp" />

<div class="max-w-7xl mx-auto p-6">

<!-- HEADER -->
<div class="flex justify-between items-center mb-10">
    <div>
        <h1 class="text-3xl font-bold text-green-700">
            WELCOME, <%= fullName %>!
        </h1>
        <p class="text-gray-500">Manage your account and orders</p>
    </div>

    <button onclick="toggleEdit()" id="editBtn"
        class="bg-white border border-green-600 text-green-600 font-semibold px-5 py-2 rounded-lg shadow hover:bg-green-50 transition">
        Edit Profile
    </button>
</div>

<div class="grid md:grid-cols-2 gap-8">

<!-- PROFILE -->
<div class="bg-white p-6 rounded-xl shadow-sm border border-gray-100">

<h2 class="font-bold mb-6 text-gray-400 uppercase text-xs tracking-wider">
Account Information
</h2>

<form id="profileForm" action="UpdateProfileServlet" method="post">

<input type="hidden" name="email" value="<%= email %>">

<div class="mb-4">
<label class="text-xs font-semibold text-gray-500">Full Name</label>
<input type="text" name="fullName" value="<%= fullName %>" readonly
class="w-full border-b border-gray-200 py-2 bg-gray-50">
</div>

<div class="mb-4">
<label class="text-xs font-semibold text-gray-500">Email</label>
<input type="text" value="<%= email %>" readonly
class="w-full border-b border-gray-200 py-2 bg-gray-50">
</div>

<div class="mb-4">
<label class="text-xs font-semibold text-green-700">Mobile</label>
<input type="text" id="mno" name="mno" value="<%= mobile %>" readonly
class="w-full border-b border-gray-200 py-2">
</div>

<div class="mb-4">
<label class="text-xs font-semibold text-green-700">Address</label>
<input type="text" id="address" name="address" value="<%= address %>" readonly
class="w-full border-b border-gray-200 py-2">
</div>

<div class="mb-6">
<label class="text-xs font-semibold text-green-700">Password</label>
<input type="password" id="pass" name="password" value="********" readonly
class="w-full border-b border-gray-200 py-2">
</div>

<div id="actionBtns" class="hidden flex gap-3">
<button type="submit"
class="bg-green-600 text-white px-6 py-2 rounded-lg">
Update Profile
</button>

<button type="button" onclick="location.reload()"
class="bg-gray-100 px-6 py-2 rounded-lg">
Cancel
</button>
</div>

</form>

</div>

<!-- ORDERS -->
<!-- ORDERS -->
<div class="bg-white p-6 rounded-xl shadow">

<h2 class="font-bold mb-4 text-gray-500 text-sm uppercase">Recent Orders</h2>

<%
if (orders != null && !orders.isEmpty()) {

    for (String[] o : orders) {

        String product = (o.length > 0 && o[0] != null) ? o[0] : "-";
        String amount = (o.length > 1 && o[1] != null) ? o[1] : "0";
        String status = (o.length > 2 && o[2] != null) ? o[2] : "Placed";
        String orderDate = (o.length > 3 && o[3] != null) ? o[3] : "-";
        String deliveryDate = (o.length > 4 && o[4] != null) ? o[4] : "-";
        String paymentStatus = (o.length > 5 && o[5] != null) ? o[5] : "Success";

        String deliveryText = "-".equals(deliveryDate) ? "Within 3 Days" : deliveryDate;
%>

<div class="border p-4 mb-3 rounded-lg bg-green-50 flex justify-between items-center">

    <!-- LEFT -->
    <div>
        <p class="font-bold text-gray-800"><%= product %></p>

        <p class="text-xs text-gray-500 mt-1">
            Order: <%= orderDate %>
        </p>

        <p class="text-xs text-gray-500">
            Delivery: <%= deliveryText %>
        </p>

        <%
String finalStatus = status;

try {
    if (!"-".equals(deliveryDate)) {

        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        java.util.Date now = new java.util.Date();
        java.util.Date delivery = sdf.parse(deliveryDate);

        if (now.after(delivery)) {
            finalStatus = "Delivered";
        }
    }
} catch(Exception e) {
    e.printStackTrace();
}
%>

<p class="text-xs mt-1">
    Status: <span class="text-blue-600 font-medium"><%= finalStatus %></span>
</p>
    </div>

    <!-- RIGHT -->
    <div class="text-right">
        <p class="text-green-700 font-bold text-lg">₹<%= amount %></p>

        <span class="text-xs bg-green-200 text-green-800 px-2 py-1 rounded">
            <%= paymentStatus %>
        </span>
    </div>

</div>

<%
    }

} else {
%>

<p class="text-gray-400">No orders found</p>

<%
}
%>

</div>

</div>

</div>

<script>
function toggleEdit() {

document.getElementById("mno").readOnly = false;
document.getElementById("address").readOnly = false;
document.getElementById("pass").readOnly = false;

document.getElementById("actionBtns").classList.remove("hidden");
document.getElementById("editBtn").classList.add("hidden");
}
</script>

</body>
</html>