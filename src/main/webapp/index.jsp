<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 1. Browser Caching rokne ke liye Headers (Security)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 2. SESSION LOGIC: Role ke basis par links tay karna
    String userRole = (String) session.getAttribute("userRole");
    String sellWasteLink = "sellwastenotlogin.jsp"; // Default link

    if (userRole != null && userRole.equalsIgnoreCase("FARMER")) {
        sellWasteLink = "sellwastelogin.jsp";
    }
%>

<%
String role = (String) session.getAttribute("userRole");

if ("ADMIN".equalsIgnoreCase(role)) {
    response.sendRedirect("admdashreq.jsp");
    return;
}
%>

<!DOCTYPE html>
<html class="light" lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BananaWaste Marketplace - Sustainable Future</title>

    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link rel="stylesheet" href="all_com/index.css">

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
    <style> body { font-family: 'Inter', sans-serif;  } </style>

</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 transition-colors duration-300">

<jsp:include page="all_com/navbar.jsp" />

<main>

<section class="relative h-[90vh] flex items-center overflow-hidden">
    <div class="absolute inset-0">
        <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCOlK41DN8BQlBxbIFUSGvTyJTUSHz3g7pKxyQNyUTbpL8Jn_RxB4BWjpYDseOU7sz_gGdPGhL5lFCAxqwnTZtfibJkGEJB97Wu2w1d6zgOMQfvlLeM9gqg7Qlhfp4VgqbKaFx4vZtBFovyJb4QFoytSCBHbKiS8c-1h5gpWGXqN12CzwDxY0CTMb7CeqOIc3A4_uVZB2vfYHLfzIS8mkwIL4cH6wiMpYap7Un8LGxgWqdQk9M4gDviBem5qBQLsOnE9iz8VDzU4vc" alt="Banana Plantation" class="w-full h-full object-cover object-center">
        <div class="absolute inset-0 bg-gradient-to-r from-[#0b1f0b]/90 via-[#0b1f0b]/60 to-transparent"></div>
    </div>

    <div class="relative z-10 max-w-7xl mx-auto px-6 w-full">
        <div class="max-w-2xl">
            <div class="inline-flex items-center gap-2 bg-primary/20 border border-primary/30 text-primary text-xs font-bold uppercase tracking-widest px-4 py-1 rounded-full mb-6">
                Circular Economy Leader
            </div>

            <h1 class="text-5xl md:text-7xl font-black text-white leading-[1.05] mb-6">
                Waste to Wealth:<br>Upcycling the <span class="text-primary">Future.</span>
            </h1>

            <p class="text-lg text-slate-200 mb-10 leading-relaxed">
                Transforming banana plantation residues into premium sustainable products. 
                Join our movement to eliminate agricultural waste.
            </p>

            <div class="flex flex-wrap gap-4">
                <a href="shop.jsp" class="bg-primary hover:bg-primary/90 text-background-dark font-bold px-8 py-4 rounded-xl shadow-primary/30 transition-all">
                    Shop Products
                </a>
                <a href="<%= sellWasteLink %>" class="bg-white/10 backdrop-blur-sm border border-white/30 text-white font-bold px-8 py-4 rounded-xl hover:bg-white/20 transition-all">
                    Start Selling Waste
                </a>
            </div>
        </div>
    </div>
</section>

<!-- SCROLL DOWN -->

<div class="absolute bottom-6 left-1/2 -translate-x-1/2 animate-bounce">

    <a href="#nextSection">

        <span class="material-symbols-outlined text-white text-5xl">

            keyboard_arrow_down

        </span>

    </a>

</div>

<section id="nextSection" class="bg-gradient-to-r from-[#0f2d0f] via-[#0c250c] to-[#081b08] py-20">
    <div class="max-w-7xl mx-auto px-6 text-center">
        <p class="text-primary font-bold uppercase tracking-widest text-xs mb-4">Our Measured Impact</p>
        <h2 class="text-3xl md:text-4xl font-extrabold text-white mb-14">Sustainability in Numbers</h2>
        
        <div class="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-6 gap-6">
            <div class="bg-[#123512]/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-lg hover:shadow-primary/20 transition-all">
                <span class="material-symbols-outlined text-primary text-3xl mb-4 block">delete_sweep</span>
                <h3 class="text-2xl font-black text-white">21T</h3>
                <p class="text-xs uppercase tracking-widest text-slate-400 mt-1">WASTE UPSYCLED</p>
            </div>
            <div class="bg-[#123512]/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-lg hover:shadow-primary/20 transition-all">
                <span class="material-symbols-outlined text-primary text-3xl mb-4 block">co2</span>
                <h3 class="text-2xl font-black text-white">24.5k</h3>
                <p class="text-xs uppercase tracking-widest text-slate-400 mt-1">Kg CO₂ Reduced</p>
            </div>
            <div class="bg-[#123512]/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-lg hover:shadow-primary/20 transition-all">
                <span class="material-symbols-outlined text-primary text-3xl mb-4 block">water_drop</span>
                <h3 class="text-2xl font-black text-white">342 KG</h3>
                <p class="text-xs uppercase tracking-widest text-slate-400 mt-1">NATURAL FIBER</p>
            </div>
            <div class="bg-[#123512]/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-lg hover:shadow-primary/20 transition-all">
                <span class="material-symbols-outlined text-primary text-3xl mb-4 block">landscape</span>
                <h3 class="text-2xl font-black text-white">5K+</h3>
                <p class="text-xs uppercase tracking-widest text-slate-400 mt-1">FARMERS IMPACTED</p>
            </div>
            <div class="bg-[#123512]/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-lg hover:shadow-primary/20 transition-all">
                <span class="material-symbols-outlined text-primary text-3xl mb-4 block">payments</span>
                <h3 class="text-2xl font-black text-white">50+</h3>
                <p class="text-xs uppercase tracking-widest text-slate-400 mt-1">VILLAGES CONNECTED</p>
            </div>
            <div class="bg-[#123512]/60 backdrop-blur-md border border-white/10 rounded-2xl p-6 shadow-lg hover:shadow-primary/20 transition-all">
                <span class="material-symbols-outlined text-primary text-3xl mb-4 block">groups</span>
                <h3 class="text-2xl font-black text-white">1.4k+</h3>
                <p class="text-xs uppercase tracking-widest text-slate-400 mt-1">Active Farmers</p>
            </div>
        </div>
    </div>
</section>

<section class="pt-12 pb-20 bg-warm-beige dark:bg-slate-900">
    <div class="max-w-7xl mx-auto px-6">
        <div class="text-center mb-20">
            <h2 class="text-3xl md:text-5xl font-black text-earth-green dark:text-white mb-4 italic">The Farm to Company Journey</h2>
            <p class="text-slate-600 dark:text-slate-400 max-w-2xl mx-auto">A transparent look at how we transform raw agricultural residues into ethical lifestyle products.</p>
        </div>
        <div class="relative">
            <div class="hidden lg:block absolute top-1/2 left-0 w-full h-1 bg-primary/20 -translate-y-1/2 z-0"></div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 relative z-10">
                <div class="journey-card">
                    <div class="journey-icon"><span class="material-symbols-outlined text-3xl">agriculture</span></div>
                    <h3 class="journey-title">1. Harvest</h3>
                    <p class="journey-desc">Farmers harvest fruit and collect discarded pseudostems, leaves, and peels.</p>
                </div>
                <div class="journey-card">
                    <div class="journey-icon"><span class="material-symbols-outlined text-3xl">precision_manufacturing</span></div>
                    <h3 class="journey-title">2. Processing</h3>
                    <p class="journey-desc">Natural fibers are extracted through decortication and waste is fermented.</p>
                </div>
                <div class="journey-card">
                    <div class="journey-icon"><span class="material-symbols-outlined text-3xl">factory</span></div>
                    <h3 class="journey-title">3. Manufacturing</h3>
                    <p class="journey-desc">Fibers are woven into ropes or heat-pressed into biodegradable packaging.</p>
                </div>
                <div class="journey-card">
                    <div class="journey-icon"><span class="material-symbols-outlined text-3xl">storefront</span></div>
                    <h3 class="journey-title">4. Marketplace</h3>
                    <p class="journey-desc">Finished goods are listed on our platform, connecting consumers with farmers.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="recent-marketplace ">
    <div class="recent-container px-6 max-w-7xl mx-auto pt-0 pb-0">
        <div class="recent-header flex justify-between items-end mb-12">
            <div>
                <h2 class="text-3xl font-bold">Recent Marketplace Products</h2>
                <p class="text-gray-500">Newly added sustainable innovations from our farming partners.</p>
            </div>
            <a href="shop.jsp" class="recent-view-all flex items-center gap-2 text-primary font-bold hover:underline">
                Explore All <span class="material-symbols-outlined">arrow_forward</span>
            </a>
        </div>

        <div class="recent-grid grid grid-cols-1 md:grid-cols-3 gap-8">
            <div class="recent-card bg-white rounded-2xl shadow-md overflow-hidden">
                <div class="recent-image h-64 overflow-hidden relative">
                    <img src="img-vid/Banana Rope.jpeg" alt="Banana Fiber Rope" class="w-full h-full object-cover">
                    <span class="absolute top-4 left-4 bg-primary text-black text-xs font-bold px-3 py-1 rounded-full">New</span>
                </div>
                <div class="recent-content p-6">
                    <h3 class="font-bold text-lg mb-2">Premium Banana Fiber Rope 10M</h3>
                    <p class="text-gray-500 text-sm mb-4">High-tensile natural fiber rope for industrial use.</p>
                    <div class="flex justify-between items-center">
                        <span class="text-xl font-bold">₹449</span>
                        
                    </div>
                </div>
            </div>
            <div class="recent-card bg-white rounded-2xl shadow-md overflow-hidden">
                <div class="recent-image h-64 overflow-hidden relative">
                    <img src="img-vid/Soil Booster.jpeg" alt="Organic Soil Booster" class="w-full h-full object-cover">
                    <span class="absolute top-4 left-4 bg-green-600 text-white text-xs font-bold px-3 py-1 rounded-full">Organic</span>
                </div>
                <div class="recent-content p-6">
                    <h3 class="font-bold text-lg mb-2">Bio Soil Booster 5kg</h3>
                    <p class="text-gray-500 text-sm mb-4">Eco-friendly nutrient booster from peels.</p>
                    <div class="flex justify-between items-center">
                        <span class="text-xl font-bold">₹399</span>
                        
                    </div>
                </div>
            </div>
            <div class="recent-card bg-white rounded-2xl shadow-md overflow-hidden">
                <div class="recent-image h-64 overflow-hidden relative">
                    <img src="img-vid/Banana Plate.jpeg" alt="Banana Plates" class="w-full h-full object-cover">
                    <span class="absolute top-4 left-4 bg-orange-500 text-white text-xs font-bold px-3 py-1 rounded-full">Eco Pack</span>
                </div>
                <div class="recent-content p-6">
                    <h3 class="font-bold text-lg mb-2">Biodegradable Plates (Pack of 10)</h3>
                    <p class="text-gray-500 text-sm mb-4">Compostable heat-pressed banana leaf plates.</p>
                    <div class="flex justify-between items-center">
                        <span class="text-xl font-bold">₹249</span>
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="farm-section -mt-10 pt-12 pb-20 relative z-10">
    <div class="farm-container max-w-7xl mx-auto px-6">
        <div class="farm-card bg-[#0b1f0b] rounded-3xl overflow-hidden flex flex-col lg:flex-row shadow-2xl">
            <div class="farm-content p-10 lg:w-1/2 text-white">
                <h2 class="text-3xl font-bold mb-6">Farmer's Corner: Turn Waste into Revenue</h2>
                <p class="text-gray-300 mb-8">Stop burning harvest waste. We buy stems, peels, and leaves to create extra income for your family.</p>
                <div class="space-y-6 mb-10">
                    <div class="flex gap-4 items-start">
                        <div class="bg-primary text-black font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">1</div>
                        <div><h4 class="font-bold">Collect Residue</h4><p class="text-sm text-gray-400">Gather pseudostems post-harvest.</p></div>
                    </div>
                    <div class="flex gap-4 items-start">
                        <div class="bg-primary text-black font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">2</div>
                        <div><h4 class="font-bold">Request Pickup</h4><p class="text-sm text-gray-400">Use our app to schedule a collection.</p></div>
                    </div>
                    <div class="flex gap-4 items-start">
                        <div class="bg-primary text-black font-bold w-8 h-8 rounded-full flex items-center justify-center shrink-0">3</div>
                        <div><h4 class="font-bold">Instant Payment</h4><p class="text-sm text-gray-400">Funds released after verification.</p></div>
                    </div>
                </div>
                <a href="<%= sellWasteLink %>" class="inline-block bg-primary text-black font-bold px-10 py-4 rounded-xl hover:scale-105 transition-transform">
                    Start Selling Waste Now
                </a>
            </div>
            <div class="farm-image lg:w-1/2">
                <img src="https://lh3.googleusercontent.com/aida-public/AB6AXuCD9QAR8n-RvSCWK5E1v3DQ49AJIKnFT1lh_AuGgti5Xvl5ZDTAbl-7ljKc9UG0MfSV7zFgf8r6WdWX57COPqS-F6DVggxVraubqAraEJMsumePctMsqM4eTZ0wN4nxLSWtAVaHvEehwI2-6FTqlB00tip4unoI1OUjTIGsH8hmSIAtHsPLFGQEOMFQuGO6mVXxndCn9iIt65--6xD7lpgAFyD8B8xDxgDxT19lnUHtQJSo-qqj7E9vklLe3viC5tWZEjRgYjAvUdA" alt="Farmer" class="w-full h-full object-cover">
            </div>
        </div>
    </div>
</section>

</main>

<jsp:include page="all_com/footer.jsp" />

</body>
</html>