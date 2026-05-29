<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<!DOCTYPE html>

<html class="light" lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    BananaWaste Marketplace - Sustainable Future
</title>

<!-- Tailwind -->

<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>

<link rel="stylesheet" href="all_com/index.css">

<!-- Fonts -->

<link
href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
rel="stylesheet">

<link
href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1"
rel="stylesheet">

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

/* Prevent Horizontal Scroll */

html,
body {

    overflow-x: hidden;
}

</style>

</head>

<body
class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 transition-colors duration-300">

<!-- NAVBAR -->

<jsp:include page="all_com/navbar.jsp" />

<!-- MAIN -->

<main
class="flex flex-col px-4 sm:px-6 md:px-10 lg:px-20 py-0 gap-4 overflow-x-hidden">

<!-- ========================= -->
<!-- HERO SECTION -->
<!-- ========================= -->

<section class="py-8 sm:py-10">

    <div
    class="max-w-7xl mx-auto grid grid-cols-1 md:grid-cols-2 gap-10 items-center px-2 sm:px-4">

        <!-- LEFT -->

        <div
        class="order-2 md:order-1 text-center md:text-left">

            <!-- TAG -->

            <span
            class="inline-block text-xs tracking-widest uppercase bg-green-100 text-green-800 px-3 py-1 rounded">

                Agricultural Innovation

            </span>

            <!-- HEADING -->

            <h1
            class="mt-6 text-3xl sm:text-4xl lg:text-5xl font-bold leading-tight text-gray-900">

                Turn Your

                <span class="text-green-700 italic">

                    Banana Waste

                </span>

                <br>

                into Income

            </h1>

            <!-- DESCRIPTION -->

            <p
            class="mt-4 text-gray-600 max-w-lg mx-auto md:mx-0 text-sm sm:text-base leading-relaxed">

                Sell your farm waste easily and get paid directly.
                Join thousands of farmers contributing to a sustainable cycle
                while boosting their bottom line.

            </p>

            <!-- BUTTONS -->

            <div
            class="mt-6 flex flex-col sm:flex-row gap-4 justify-center md:justify-start">

                <a
                href="login.jsp"

                class="bg-green-700 text-white px-6 py-3 rounded-md font-medium hover:bg-green-800 transition text-center">

                    Start Selling Now →

                </a>

            </div>

            <!-- FEATURES -->

            <div
            class="mt-8 flex flex-wrap justify-center md:justify-start gap-4 sm:gap-8 text-sm text-gray-600">

                <div
                class="flex items-center gap-2">

                    <span
                    class="bg-green-100 p-2 rounded">

                        💰

                    </span>

                    <span>

                        Direct Payment

                    </span>

                </div>

                <div
                class="flex items-center gap-2">

                    <span
                    class="bg-green-100 p-2 rounded">

                        🌱

                    </span>

                    <span>

                        Eco-Friendly

                    </span>

                </div>

                <div
                class="flex items-center gap-2">

                    <span
                    class="bg-green-100 p-2 rounded">

                        ♻️

                    </span>

                    <span>

                        Zero Waste

                    </span>

                </div>

            </div>

        </div>

        <!-- RIGHT IMAGE -->

        <div
        class="flex justify-center order-1 md:order-2">

            <img
            src="img-vid/sellwaste.png"

            alt="Banana Farm"

            class="rounded-xl shadow-lg w-full max-w-xs sm:max-w-sm md:max-w-md lg:max-w-lg object-cover">

        </div>

    </div>

</section>

<!-- ========================= -->
<!-- JOURNEY SECTION -->
<!-- ========================= -->

<section
class="py-14 sm:py-20 bg-[#f5f5f2] w-full rounded-none">

    <div
    class="max-w-7xl mx-auto px-4 sm:px-6 text-center">

        <!-- HEADING -->

        <h2
        class="text-green-900 font-semibold tracking-widest text-xs sm:text-sm uppercase">

            The Marketplace Journey

        </h2>

        <div
        class="w-16 h-[2px] bg-green-900 mx-auto mt-3 mb-12">

        </div>

        <!-- STEPS -->

        <div
        class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10 items-start">

            <!-- STEP 1 -->

            <div
            class="flex flex-col items-center text-center">

                <div
                class="bg-white p-4 rounded-lg shadow-sm mb-4">

                    <span
                    class="material-symbols-outlined text-green-800">

                        play_arrow

                    </span>

                </div>

                <h3
                class="font-semibold text-gray-800 text-sm">

                    Submit Request

                </h3>

                <p
                class="text-gray-500 text-xs mt-1 max-w-[180px]">

                    List your banana stems and leaves
                    on our ledger.

                </p>

            </div>

            <!-- STEP 2 -->

            <div
            class="flex flex-col items-center text-center">

                <div
                class="bg-white p-4 rounded-lg shadow-sm mb-4">

                    <span
                    class="material-symbols-outlined text-green-800">

                        assignment_turned_in

                    </span>

                </div>

                <h3
                class="font-semibold text-gray-800 text-sm">

                    Get Approval

                </h3>

                <p
                class="text-gray-500 text-xs mt-1 max-w-[180px]">

                    Our agents verify the quality
                    of your agricultural waste.

                </p>

            </div>

            <!-- STEP 3 -->

            <div
            class="flex flex-col items-center text-center">

                <div
                class="bg-white p-4 rounded-lg shadow-sm mb-4">

                    <span
                    class="material-symbols-outlined text-green-800">

                        local_shipping

                    </span>

                </div>

                <h3
                class="font-semibold text-gray-800 text-sm">

                    Pickup Scheduled

                </h3>

                <p
                class="text-gray-500 text-xs mt-1 max-w-[180px]">

                    Logistics teams collect the waste
                    from your farm gates.

                </p>

            </div>

            <!-- STEP 4 -->

            <div
            class="flex flex-col items-center text-center">

                <div
                class="bg-white p-4 rounded-lg shadow-sm mb-4">

                    <span
                    class="material-symbols-outlined text-green-800">

                        account_balance_wallet

                    </span>

                </div>

                <h3
                class="font-semibold text-gray-800 text-sm">

                    Get Paid

                </h3>

                <p
                class="text-gray-500 text-xs mt-1 max-w-[180px]">

                    Instant digital transfer
                    to your verified account.

                </p>

            </div>

        </div>

    </div>

</section>

</main>

<!-- FOOTER -->

<jsp:include page="all_com/footer.jsp" />

</body>

</html>