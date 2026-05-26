<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    // Browser ko cache karne se rokne ke liye
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies ke liye
%>
<!DOCTYPE html>
<html class="light" lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>BananaWaste Marketplace - Sustainable Future</title>

<!-- Tailwind -->
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

<link rel="stylesheet" href="all_com/index.css">

<!-- Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1" rel="stylesheet">

<script>
tailwind.config = {
    darkMode: "class",
    theme: {
        extend: {
            colors: {
                primary: "#13ec13",
                "earth-green": "#2D4B2D",
                "warm-beige": "#F5F2EA",
                "background-light": "#f6f8f6",
                "background-dark": "#102210",
            }
        }
    }
}
</script>

<style>
body {
    font-family: 'Inter', sans-serif;
}
</style>

</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 transition-colors duration-300">

<!-- ✅ Navbar Include -->
<jsp:include page="all_com/navbar.jsp" />

<main>
<section class="max-w-5xl mx-auto px-6 py-16">

    <h1 class="text-3xl font-extrabold mb-6 text-green-800">Terms of Service</h1>

    <p class="mb-4">
        By using Mangalam Kalpataru Marketplace, you agree to the following terms and conditions.
    </p>

    <h2 class="font-bold mt-6 mb-2">1. User Responsibilities</h2>
    <p class="mb-4">
        Users must provide accurate information while registering and placing requests.
    </p>

    <h2 class="font-bold mt-6 mb-2">2. Waste Selling Process</h2>
    <p class="mb-4">
        Farmers can submit waste requests. Approval depends on quality verification by our team.
    </p>

    <h2 class="font-bold mt-6 mb-2">3. Payments</h2>
    <p class="mb-4">
        Payments will be processed after successful pickup and verification of waste.
    </p>

    <h2 class="font-bold mt-6 mb-2">4. Order & Cancellation</h2>
    <p class="mb-4">
        We reserve the right to cancel requests in case of incorrect or fraudulent information.
    </p>

    <h2 class="font-bold mt-6 mb-2">5. Liability</h2>
    <p class="mb-4">
        We are not responsible for delays caused by logistics or unforeseen circumstances.
    </p>

</section>



</main>

<!-- ✅ Footer Include -->
<jsp:include page="all_com/footer.jsp" />


</body>
</html>