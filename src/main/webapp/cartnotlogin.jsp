<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<main class="flex flex-col px-6 md:px-12 lg:px-20 py-8 gap-12">

<section class="min-h-screen flex flex-col items-center justify-center bg-background-light px-6 text-center">

    <!-- Icon -->
    <div class="bg-gray-200 p-6 rounded-xl mb-6">
        <span class="material-symbols-outlined text-gray-500 text-4xl">
            shopping_bag
        </span>
    </div>

    <!-- Heading -->
    <h1 class="text-2xl md:text-3xl font-bold text-green-900">
        YOUR SHOPPING CART IS EMPTY
    </h1>

    <!-- Description -->
    <p class="text-gray-500 text-sm mt-3 max-w-md">
        No items in your cart.Log in to continue shopping and access your cart.
    </p>

    <!-- Button -->
    <a href="login.jsp"
       class="mt-6 bg-green-800 text-white px-6 py-2 rounded-md font-medium hover:bg-green-900 transition">
        Log In
    </a>

    <!-- Sub text -->
    <p class="text-gray-400 text-xs mt-3">
        New to our marketplace? 
        <a href="customersignup.jsp" class="text-green-800 font-medium hover:underline">
            Create an account
        </a>
    </p>

    <!-- Features -->
    <div class="mt-12 grid grid-cols-1 md:grid-cols-3 gap-6 max-w-3xl">

        <!-- Card 1 -->
        <div class="bg-white p-6 rounded-lg shadow-sm text-left">
            <span class="material-symbols-outlined text-green-700 mb-2">verified</span>
            <h4 class="font-semibold text-gray-800 text-sm">Verified Sourcing</h4>
            <p class="text-gray-500 text-xs mt-1">
                Every item in our archive meets strict ecological standards for regenerative impact.
            </p>
        </div>

        <!-- Card 2 -->
        <div class="bg-white p-6 rounded-lg shadow-sm text-left">
            <span class="material-symbols-outlined text-green-700 mb-2">recycling</span>
            <h4 class="font-semibold text-gray-800 text-sm">Circular Economy</h4>
            <p class="text-gray-500 text-xs mt-1">
                Transform waste into value. We facilitate the trade of organic byproducts for reuse.
            </p>
        </div>

        <!-- Card 3 -->
        <div class="bg-white p-6 rounded-lg shadow-sm text-left">
            <span class="material-symbols-outlined text-green-700 mb-2">eco</span>
            <h4 class="font-semibold text-gray-800 text-sm">Farmer Direct</h4>
            <p class="text-gray-500 text-xs mt-1">
                Direct-to-consumer pipelines ensuring fair compensation for regional ecologists.
            </p>
        </div>

    </div>

</section>


</main>

<!-- ✅ Footer Include -->
<jsp:include page="all_com/footer.jsp" />


</body>
</html>