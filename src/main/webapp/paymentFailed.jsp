<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String sessionEmail = (String) session.getAttribute("userEmail");

if(sessionEmail == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Payment Failed - Mangalam Kalpataru</title>

<script src="https://cdn.tailwindcss.com"></script>

<script>
tailwind.config = {
    theme: {
        extend: {
            colors: {
                primary: "#1f5f1e",
                lightbg: "#e9e9e4"
            }
        }
    }
}
</script>

<style>
body{
    font-family: Arial, Helvetica, sans-serif;
}
</style>

</head>

<body class="bg-lightbg min-h-screen flex items-center justify-center p-6">

<div class="bg-white rounded-xl shadow-lg p-10 max-w-md w-full text-center">

    <!-- ❌ ICON -->
    <div class="text-6xl mb-4">❌</div>

    <!-- TITLE -->
    <h2 class="text-2xl font-bold text-red-600 mb-2">
        Payment Failed
    </h2>

    <!-- MESSAGE -->
    <p class="text-gray-600 text-sm mb-6">
        Something went wrong while processing your payment.<br>
        Please try again or use another payment method.
    </p>

    <!-- ACTION BUTTONS -->
    <div class="flex flex-col gap-3">

        <!-- 🔁 Retry Payment -->
        <a href="paymentDemo.jsp"
           class="w-full bg-blue-600 text-white py-3 rounded font-semibold hover:bg-blue-700 transition">
            🔁 Retry Payment
        </a>

        <!-- 🛒 Back to Cart -->
        <a href="cart.jsp"
           class="w-full bg-gray-200 text-gray-800 py-3 rounded font-semibold hover:bg-gray-300 transition">
            🛒 Back to Cart
        </a>

        <!-- 🏠 Dashboard -->
        <a href="customerDashboard.jsp"
           class="w-full bg-primary text-white py-3 rounded font-semibold hover:bg-[#174816] transition">
            🏠 Go to Dashboard
        </a>

    </div>

    <!-- FOOTER -->
    <p class="text-[10px] text-gray-400 mt-6 uppercase tracking-[1px]">
        Secure transaction by Mangalam Kalpataru
    </p>

</div>

</body>
</html>