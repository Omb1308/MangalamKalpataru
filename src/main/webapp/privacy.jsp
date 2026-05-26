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

<main><section class="max-w-5xl mx-auto px-6 py-16">

    <h1 class="text-3xl font-extrabold mb-6 text-green-800">Privacy Policy</h1>

    <p class="mb-4">
        At Mangalam Kalpataru Marketplace, we respect your privacy and are committed to protecting your personal data.
    </p>

    <h2 class="font-bold mt-6 mb-2">1. Information We Collect</h2>
    <p class="mb-4">
        We collect user information such as name, email, phone number, address, and farm details when you register or use our services.
    </p>

    <h2 class="font-bold mt-6 mb-2">2. How We Use Your Data</h2>
    <p class="mb-4">
        Your data is used to process orders, manage waste pickup requests, improve services, and communicate updates.
    </p>

    <h2 class="font-bold mt-6 mb-2">3. Data Protection</h2>
    <p class="mb-4">
        We ensure your data is stored securely and protected from unauthorized access.
    </p>

    <h2 class="font-bold mt-6 mb-2">4. Third-Party Sharing</h2>
    <p class="mb-4">
        We do not sell your data. Information may only be shared with trusted partners for logistics and payment processing.
    </p>

    <h2 class="font-bold mt-6 mb-2">5. Contact Us</h2>
    <p>
        If you have any questions, contact us at 
        <span class="text-green-700 font-semibold">support@mangalamkalpataru.in</span>
    </p>

</section>


</main>

<!-- ✅ Footer Include -->
<jsp:include page="all_com/footer.jsp" />


</body>
</html>