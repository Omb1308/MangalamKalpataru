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

<main class="flex flex-col px-6 md:px-12 lg:px-20 py-0 gap-4">

<section class="px-8 py-8">
    <div class="max-w-7xl mx-auto grid md:grid-cols-2 gap-6 items-center px-4">

        <!-- LEFT CONTENT -->
        <div>

            <!-- Tag -->
            <span class="text-xs tracking-widest uppercase bg-green-100 text-green-800 px-3 py-1 rounded">
                Agricultural Innovation
            </span>

            <!-- Heading -->
            <h1 class="mt-6 text-4xl md:text-5xl font-bold leading-tight text-gray-900">
                Turn Your 
                <span class="text-green-700 italic">Banana Waste</span>
                <br>into Income
            </h1>

            <!-- Description -->
            <p class="mt-4 text-gray-600 max-w-lg">
                Sell your farm waste easily and get paid directly. Join thousands of farmers 
                contributing to a sustainable cycle while boosting their bottom line.
            </p>

            <!-- Buttons -->
            <div class="mt-6 flex gap-4">
                <a href="login.jsp" class="bg-green-700 text-white px-6 py-3 rounded-md font-medium hover:bg-green-800 transition">
                    Start Selling Now →
                </a>

                
            </div>

            <!-- Features -->
            <div class="mt-8 flex gap-8 text-sm text-gray-600">

                <div class="flex items-center gap-2">
                    <span class="bg-green-100 p-2 rounded">💰</span>
                    <span>Direct Payment</span>
                </div>

                <div class="flex items-center gap-2">
                    <span class="bg-green-100 p-2 rounded">🌱</span>
                    <span>Eco-Friendly</span>
                </div>

                <div class="flex items-center gap-2">
                    <span class="bg-green-100 p-2 rounded">♻️</span>
                    <span>Zero Waste</span>
                </div>

            </div>

        </div>

        <!-- RIGHT IMAGE -->
        <div class="flex justify-center">
            <img src="img-vid/sellwaste.png" 
                 alt="Banana Farm"
                 class="rounded-xl shadow-lg w-full max-w-md object-cover">
        </div>

    </div>
    
    
    
    
</section>

<section class="py-20 bg-[#f5f5f2] w-full">
    <div class="max-w-7xl mx-auto px-6 text-center">

        <!-- Heading -->
        <h2 class="text-green-900 font-semibold tracking-widest text-sm uppercase">
            The Marketplace Journey
        </h2>

        <div class="w-16 h-[2px] bg-green-900 mx-auto mt-3 mb-12"></div>

        <!-- Steps -->
        <div class="grid grid-cols-2 md:grid-cols-4 gap-10 items-start relative">

            <!-- Step 1 -->
            <div class="flex flex-col items-center text-center">
                <div class="bg-white p-4 rounded-lg shadow-sm mb-4">
                    <span class="material-symbols-outlined text-green-800">play_arrow</span>
                </div>
                <h3 class="font-semibold text-gray-800 text-sm">Submit Request</h3>
                <p class="text-gray-500 text-xs mt-1 max-w-[150px]">
                    List your banana stems and leaves on our ledger.
                </p>
            </div>

            <!-- Step 2 -->
            <div class="flex flex-col items-center text-center">
                <div class="bg-white p-4 rounded-lg shadow-sm mb-4">
                    <span class="material-symbols-outlined text-green-800">assignment_turned_in</span>
                </div>
                <h3 class="font-semibold text-gray-800 text-sm">Get Approval</h3>
                <p class="text-gray-500 text-xs mt-1 max-w-[150px]">
                    Our agents verify the quality of your agricultural waste.
                </p>
            </div>

            <!-- Step 3 -->
            <div class="flex flex-col items-center text-center">
                <div class="bg-white p-4 rounded-lg shadow-sm mb-4">
                    <span class="material-symbols-outlined text-green-800">local_shipping</span>
                </div>
                <h3 class="font-semibold text-gray-800 text-sm">Pickup Scheduled</h3>
                <p class="text-gray-500 text-xs mt-1 max-w-[150px]">
                    Logistics teams collect the waste from your farm gates.
                </p>
            </div>

            <!-- Step 4 -->
            <div class="flex flex-col items-center text-center">
                <div class="bg-white p-4 rounded-lg shadow-sm mb-4">
                    <span class="material-symbols-outlined text-green-800">account_balance_wallet</span>
                </div>
                <h3 class="font-semibold text-gray-800 text-sm">Get Paid</h3>
                <p class="text-gray-500 text-xs mt-1 max-w-[150px]">
                    Instant digital transfer to your verified account.
                </p>
            </div>

        </div>

    </div>

</section>


</main>

<!-- ✅ Footer Include -->
<jsp:include page="all_com/footer.jsp" />


</body>
</html>