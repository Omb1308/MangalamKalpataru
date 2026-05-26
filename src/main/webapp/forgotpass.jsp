<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Forgot Password</title>

<!-- Tailwind CDN -->
<script src="https://cdn.tailwindcss.com"></script>

<!-- Custom CSS -->
<link rel="stylesheet" href="css/forgot-password.css">

</head>

<body class="bg-gray-100 flex items-center justify-center min-h-screen">

<div class="w-full max-w-md">

    <!-- Card -->
    <div class="bg-white rounded-2xl shadow-md p-8">

        <!-- Heading -->
        <h1 class="text-3xl font-bold text-[#0f3d1e] mb-3">
            Forgot Password?
        </h1>

        <p class="text-gray-600 text-sm mb-8 leading-relaxed">
            Enter your registered email to receive a 4-digit verification code.
        </p>

        <!-- 🔴 ERROR MESSAGE -->
        <%
            String error = request.getParameter("error");
            if ("mailfail".equals(error)) {
        %>
            <p class="text-red-600 text-sm mb-4">
                Failed to send OTP. Try again.
            </p>
        <%
            }
        %>

        <!-- ✅ FORM START -->
        <form action="SendOtpForgotServlet" method="post">

            <!-- Email Input -->
            <label class="text-xs tracking-widest text-gray-500">
                EMAIL ADDRESS
            </label>

            <input type="email"
                   name="email"
                   required
                   placeholder="name@kalpataru-marketplace.com"
                   class="w-full mt-2 bg-[#f4f2ed] px-4 py-3 rounded-md focus:outline-none focus:ring-2 focus:ring-green-800">

            <!-- ✅ BUTTON (NOT ANCHOR NOW) -->
            <button type="submit"
                class="w-full mt-8 bg-[#1f4d2b] hover:bg-[#163a20] text-white py-3 rounded-md flex items-center justify-center gap-2">
                Send OTP →
            </button>

        </form>
        <!-- ✅ FORM END -->

        <!-- Divider -->
        <div class="flex items-center justify-center my-6">
            <div class="h-[1px] w-12 bg-gray-300"></div>
        </div>

        <!-- Back Link -->
        <a href="login.jsp"
           class="text-center block text-sm text-gray-600 hover:text-black transition">
            ← Back to Login
        </a>

    </div>

    <!-- Bottom Text -->
    <p class="text-center text-xs text-gray-500 mt-8 px-4 leading-relaxed">
        SECURITY POLICY: WE WILL NEVER ASK FOR YOUR PASSWORD VIA EMAIL OR PHONE.
        ENSURE YOU ARE ON THE OFFICIAL 
        <span class="font-semibold text-black">MANGALAM KALPATARU</span>.
    </p>

</div>

</body>
</html>