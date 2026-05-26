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

<!-- Your CSS -->
<link rel="stylesheet" href="all_com/ourstory.css">
<link rel="stylesheet" href="css/ourMission.css">

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

<!-- ✅ Navbar -->
<jsp:include page="all_com/navbar.jsp" />

<main>

<!-- ================= OUR MISSION SECTION ================= -->
<section class="px-8 py-24">

    <div class="max-w-7xl mx-auto grid lg:grid-cols-2 gap-16 items-center">

        <!-- LEFT CONTENT -->
        <div>

            
            <h1 class="text-5xl md:text-6xl font-extrabold leading-tight mb-6">
                Join the <span class="text-primary">Circular</span> Economy.
            </h1>

            <p class="text-lg text-slate-600 dark:text-slate-300 max-w-xl leading-relaxed mb-10">
                Mangalam Kalpataru connects banana growers with eco-conscious creators. We transform agricultural waste into premium organic textiles and materials, ensuring nothing goes to waste.
            </p>



        </div>

       <!-- RIGHT IMAGE -->
<div class="relative group perspective">

    <div class="rounded-2xl overflow-hidden shadow-2xl transform rotate-2 
                transition-all duration-500 ease-out 
                group-hover:rotate-0 group-hover:scale-105 group-hover:-translate-y-2">

        <img src="img-vid/economy.jpg"
             class="w-full h-full object-cover transition-transform duration-500 ease-out group-hover:scale-110"/>
    </div>


            <!-- FLOATING CARD -->
            <div class="absolute bottom-6 left-6 bg-orange-200 p-6 rounded-xl shadow-lg max-w-xs">
                <p class="font-bold text-earth-green text-lg">1,240kg offset</p>
                <p class="text-sm text-slate-700">
                    Average CO2 saved per small-scale farm partner annually.
                </p>
            </div>

        </div>

    </div>

</section>
<!-- ================= END SECTION ================= -->
<!-- ================= DUAL IMPACT MARKETPLACE ================= -->
<section class="px-8 py-15">

    <div class="max-w-7xl mx-auto">

        <!-- Heading -->
        <div class="mb-12">
            <h2 class="text-3xl font-extrabold text-earth-green mb-2">
                Dual-Impact Marketplace
            </h2>
            <p class="text-slate-500">
                Empowering both ends of the supply chain through intentional design.
            </p>
        </div>

        <!-- TOP GRID -->
        <div class="grid lg:grid-cols-3 gap-6 mb-8">

            <!-- Farmers Card -->
            <div class="lg:col-span-2 bg-white rounded-xl p-8 shadow-sm">

                <div class="flex items-start gap-4 mb-4">
                    <span class="material-symbols-outlined text-earth-green text-2xl">agriculture</span>
                    <h3 class="text-xl font-bold text-earth-green">For the Farmers</h3>
                </div>

                <p class="text-slate-600 mb-6">
                    Turn your post-harvest banana stems into a new revenue stream. We provide the logistics to collect your organic waste and pay you premium rates, turning a disposal problem into financial growth.
                </p>

                <ul class="space-y-2 mb-6 text-sm text-slate-700">
                    <li class="flex items-center gap-2">
                        <span class="w-2 h-2 bg-primary rounded-full"></span>
                        Competitive agreements
                    </li>
                    <li class="flex items-center gap-2">
                        <span class="w-2 h-2 bg-primary rounded-full"></span>
                        Zero-cost waste collection
                    </li>
                </ul>

                <a href="farmersignup.jsp" class="text-earth-green font-medium text-sm">
                    Register your farm →
                </a>

            </div>

            <!-- Stats Card -->
            <div class="bg-earth-green text-white rounded-xl p-8 flex flex-col justify-center items-center text-center">

                <div class="mb-6">
                    <h3 class="text-3xl font-bold">92%</h3>
                    <p class="text-sm opacity-80">WASTE REDUCTION</p>
                </div>

                <div>
                    <h3 class="text-3xl font-bold">15k</h3>
                    <p class="text-sm opacity-80">ACTIVE ARTISANS</p>
                </div>

            </div>

        </div>

        <!-- BOTTOM GRID -->
        <div class="grid lg:grid-cols-2 gap-6">

            <!-- Creators Content -->
            <div class="bg-white rounded-xl p-8 shadow-sm">
            
            

                <div class="flex items-start gap-4 mb-4">
                    <span class="material-symbols-outlined text-earth-green text-2xl">eco</span>
                    <h3 class="text-xl font-bold text-earth-green">For the Creators</h3>
                </div>

                <p class="text-slate-600 mb-6">
                    Source high-quality, traceable banana-based textiles, papers, and bioplastics. Perfect for brands looking to pivot toward radical sustainability without sacrificing aesthetic quality.
                </p>
                   
                   <p class="text-slate-500 text-sm mb-6">
    Our materials are ethically sourced, eco-friendly, and crafted to support 
    modern businesses in building responsible and future-ready products.
</p>     

 <p class="text-xs uppercase tracking-widest text-primary font-bold mb-2">
        Sustainable Materials
    </p>
                   
                <div class="grid grid-cols-2 md:grid-cols-4 gap-4">

        <!-- Card 1 -->
        <div class="bg-[#f6f8f6] p-4 rounded-2xl hover:shadow-md transition group">
            <span class="material-symbols-outlined text-primary mb-2">check_circle</span>
            <h4 class="font-semibold text-sm">Textiles</h4>
            <p class="text-xs text-slate-500">Durable & breathable</p>
        </div>

        <!-- Card 2 -->
        <div class="bg-[#f6f8f6] p-4 rounded-2xl hover:shadow-md transition group">
            <span class="material-symbols-outlined text-primary mb-2">eco</span>
            <h4 class="font-semibold text-sm">Bioplastics</h4>
            <p class="text-xs text-slate-500">100% compostable</p>
        </div>

        <!-- Card 3 -->
        <div class="bg-[#f6f8f6] p-4 rounded-2xl hover:shadow-md transition group">
            <span class="material-symbols-outlined text-primary mb-2">description</span>
            <h4 class="font-semibold text-sm">Handmade Papers</h4>
            <p class="text-xs text-slate-500">Premium & sustainable</p>
        </div>

        <!-- Card 4 -->
        <div class="bg-[#f6f8f6] p-4 rounded-2xl hover:shadow-md transition group">
            <span class="material-symbols-outlined text-primary mb-2">all_inclusive</span>
            <h4 class="font-semibold text-sm">Fiber Products</h4>
            <p class="text-xs text-slate-500">Strong & versatile</p>
        </div>

    </div>

            </div>

            <!-- Image -->
            <div class="rounded-xl overflow-hidden shadow-sm">
                <img src="img-vid/creator.jpg"
                     class="w-full h-full object-cover"/>
            </div>

        </div>

    </div>

</section>
<!-- ================= END ================= -->
<!-- ================= FINAL CTA SECTION ================= -->
<section class="px-8 py-24 text-center">

    <div class="max-w-3xl mx-auto">

        <!-- Heading -->
        <h2 class="text-4xl md:text-5xl font-bold text-earth-green mb-6">
            Ready to close the loop?
        </h2>

        <!-- Description -->
        <p class="text-slate-600 text-lg mb-10 leading-relaxed">
            Whether you're a farmer in the tropics or a designer in Berlin, your role in the circular economy starts here. Join thousands of pioneers turning waste into worth.
        </p>

        <!-- Button -->
       <a href="login.jsp"
   class="inline-block px-8 py-4 bg-green-800 text-white rounded-lg font-semibold shadow-md hover:shadow-lg transition">
    Get Started Today
</a>

        <!-- Footer Text -->
        <p class="text-sm text-slate-400 mt-4">
            Free to join. Impact measured instantly.
        </p>

    </div>

</section>
<!-- ================= END ================= -->

</main>

<!-- ✅ Footer -->
<jsp:include page="all_com/footer.jsp" />

</body>
</html>