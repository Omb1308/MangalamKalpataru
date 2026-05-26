<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
String amount = request.getParameter("amount");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Success</title>
<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-green-50 h-screen flex justify-center items-center">

<div class="bg-white p-10 rounded-3xl shadow-2xl text-center">

<h1 class="text-5xl font-bold text-green-600 mb-4">
Payment Successful ✅
</h1>

<p class="text-gray-600 mb-3">
Your Order Has Been Placed Successfully
</p>

<p class="text-2xl font-bold text-green-700 mb-8">
₹<%=amount%>
</p>

<a href="index.jsp"
class="bg-green-600 text-white px-8 py-3 rounded-xl">
Continue Shopping
</a>

</div>

</body>
</html>