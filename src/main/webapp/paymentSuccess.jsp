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

<title>Payment Successful - Mangalam Kalpataru</title>

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

    <!-- ✅ ICON -->
    <div class="text-6xl mb-4">✅</div>

    <!-- TITLE -->
    <h2 class="text-2xl font-bold text-green-600 mb-2">
        Payment Successful
    </h2>

    <!-- MESSAGE -->
    <p class="text-gray-600 text-sm mb-6">
        Your payment has been successfully processed.<br>
        Your order has been placed and will be delivered within <b>3 days</b>.
    </p>

    <!-- ORDER STATUS -->
    <div class="bg-green-50 border border-green-200 rounded-lg p-4 text-sm text-green-700 mb-6">
        ✔ Order Confirmed<br>
        📦 Delivery Expected: Within 3 Days
    </div>

    <!-- ACTION BUTTON -->
    <a href="cusdash.jsp"
       class="w-full block bg-primary text-white py-3 rounded font-semibold hover:bg-[#174816] transition">
        🏠 Go to Dashboard
    </a>

    <!-- AUTO REDIRECT INFO -->
    <p class="text-[10px] text-gray-400 mt-4">
        Redirecting to dashboard in 3 seconds...
    </p>

    <!-- FOOTER -->
    <p class="text-[10px] text-gray-400 mt-6 uppercase tracking-[1px]">
        Secure transaction by Mangalam Kalpataru
    </p>

</div>

<script>
    setTimeout(() => {
        window.location.href = "cusdash.jsp";
    }, 3000);
</script>

</body>
</html>