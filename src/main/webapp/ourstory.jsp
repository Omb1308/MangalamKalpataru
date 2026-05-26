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

<link rel="stylesheet" href="all_com/ourstory.css">

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


<!-- HERO SECTION -->
<section class="relative w-full h-[80vh] flex items-center justify-center overflow-hidden">
<div class="absolute inset-0">
<img class="w-full h-full object-cover"
src="https://lh3.googleusercontent.com/aida-public/AB6AXuCbjBmuvTi7u3DnvBu_N-8HQoHpqHliAuYOdXj0YTmJsOFo9BXlUR1BJmNat6JkxAbUNb1KfDQ1sEenYVv5dJtQWG1Ez9QyXi-VGsRRC6UteeJQTrvt4gt_WcEK-Iym7kqbC7KKarIsYeelM2mhFoYsIVgD5ZVQljPUXXV5q-8ziL3tyeMXIKQygxKGmEPtd0OMT0r6sQe1vcgBLH6f43HVmgJ7XRa7CtfyIisfjHjk7wrk_Z7e4JwZtK8y0J4GVUYSv1UzaZEmBv8"/>
<div class="absolute inset-0 bg-gradient-to-b from-forest/40 via-forest/20 to-cream dark:to-background-dark"></div>
</div>

<div class="relative z-10 max-w-4xl text-center px-6">
<span class="inline-block py-1 px-4 rounded-full bg-primary/20 text-primary font-bold text-xs tracking-widest uppercase mb-6 backdrop-blur-sm">
Our Purpose
</span>
<h1 class="text-5xl md:text-7xl font-black text-white leading-tight tracking-tight mb-6">
Mangalam Kalptaru Industries: Crafting a Greener Future
</h1>
<p class="text-lg md:text-xl text-white/90 max-w-2xl mx-auto mb-10 leading-relaxed font-light">
Manufacturing high-quality 100% Organic Liquid Fertilizers and exquisite Banana Fiber handicrafts for a global market.
</p>

</div>
</section>

<section class="relative px-8 py-20 md:py-28 overflow-hidden">

    <div class="max-w-7xl mx-auto relative z-10">
        <div class="grid lg:grid-cols-2 gap-16 items-center">

            <!-- LEFT CONTENT -->
            <div>
                

                <h1 class="text-5xl md:text-7xl font-headline font-extrabold text-primary leading-[1.1] tracking-tight mb-8">
                    From Waste to Wealth
                </h1>

                <p class="text-lg md:text-xl text-on-surface-variant max-w-xl leading-relaxed mb-10">
                    We don't just ship goods; we orchestrate a circular economy that breathes life into forgotten resources, turning agricultural waste into premium tactile experiences.
                </p>

            </div>

            <!-- RIGHT IMAGE -->
            <div class="relative">
                <div class="aspect-square rounded-xl overflow-hidden shadow-2xl">
                    <img class="w-full h-full object-cover"
                         src="img-vid/major-impact.jpg"/>
                </div>

                <!-- FLOATING CARD -->
                <div class="absolute -bottom-8 -left-8 bg-white p-8 rounded-xl shadow-xl max-w-xs border border-outline-variant/10">
                    <p class="font-headline font-bold text-primary text-2xl">94%</p>
                    <p class="text-on-surface-variant text-sm leading-tight">
                        Reduction in logistics-related methane emissions since 2022.
                    </p>
                </div>
            </div>

        </div>
    </div>

</section>

<section class="px-8 py-12 bg-surface-bright">

    <div class="max-w-7xl mx-auto">

        <!-- Heading -->
        <div class="text-center mb-16">
            <h2 class="text-4xl md:text-5xl font-headline font-bold text-primary mb-4">
                Media Coverage: Sharing Our Story
            </h2>
            <p class="text-on-surface-variant max-w-2xl mx-auto">
                Spreading the seeds of change. See how global media is covering our journey from waste to wonder.
            </p>
        </div>

        <!-- Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">

            <!-- Card 1 -->
            <div class="magazine-card bg-white rounded-2xl overflow-hidden shadow-md border border-outline-variant/10 flex flex-col h-full">
                
                <div class="aspect-[4/3] relative">
                    <img class="w-full h-full object-cover"
                         src="img-vid/press1.jpeg"/>
                    
                    <div class="absolute inset-0 bg-gradient-to-t from-primary/80 to-transparent"></div>

                    <div class="absolute bottom-4 left-6">
                        <span class="text-white/80 text-xs font-bold tracking-widest uppercase block">
                            The Green Journal
                        </span>
                        <p class="text-white font-headline font-bold text-lg leading-tight">
                            The Future of Textiles: Scaling Circularity
                        </p>
                    </div>
                </div>

                <div class="p-6 flex-grow">
                    <p class="text-on-surface-variant text-sm italic">
                        Banana fiber is a highly versatile material used to create eco-friendly products such as paper, ropes, handicrafts, and textiles. It transforms agricultural waste into valuable resources, promoting sustainability and reducing environmental impact.
                    </p>
                </div>

            </div>

            <!-- Card 2 -->
            <div class="magazine-card bg-white rounded-2xl overflow-hidden shadow-md border border-outline-variant/10 flex flex-col h-auto mt-4 md:mt-8">
                
                <div class="aspect-[4/3] relative">
                    <img class="w-full h-full object-cover"
                         src="img-vid/press2.jpeg"/>
                    
                    <div class="absolute inset-0 bg-gradient-to-t from-secondary/80 to-transparent"></div>

                    <div class="absolute bottom-4 left-6">
                        <span class="text-white/80 text-xs font-bold tracking-widest uppercase block">
                            Global Logistics Weekly
                        </span>
                        <p class="text-white font-headline font-bold text-lg leading-tight">
                            Empowering Local Roots through Supply Chain
                        </p>
                    </div>
                </div>

                <div class="p-6 flex-grow">
                    <p class="text-on-surface-variant text-sm italic">
                        The process of extracting and converting banana fiber involves local workers and small-scale industries. This not only utilizes waste efficiently but also generates employment opportunities and supports decentralized production systems.
                    </p>
                </div>

            </div>

            <!-- Card 3 -->
            <div class="magazine-card bg-white rounded-2xl overflow-hidden shadow-md border border-outline-variant/10 flex flex-col h-full">
                
                <div class="aspect-[4/3] relative">
                    <img class="w-full h-full object-cover"
                         src="img-vid/press3.jpeg"/>
                    
                    <div class="absolute inset-0 bg-gradient-to-t from-tertiary-container/80 to-transparent"></div>

                    <div class="absolute bottom-4 left-6">
                        <span class="text-white/80 text-xs font-bold tracking-widest uppercase block">
                            Conscious Curation
                        </span>
                        <p class="text-white font-headline font-bold text-lg leading-tight">
                            Crafting Waste into Modern Gold
                        </p>
                    </div>
                </div>

                <div class="p-6 flex-grow">
                    <p class="text-on-surface-variant text-sm italic">
                       Entrepreneurs are now establishing banana fiber units to convert waste into profitable products. This innovation supports rural development, empowers communities, and promotes a circular economy focused on sustainability.
                    </p>
                </div>

            </div>

        </div>

    </div>

</section>

<section class="px-8 py-30 overflow-hidden">

    <div class="max-w-7xl mx-auto">

        <!-- Heading -->
        <div class="mb-20 max-w-3xl">
            <h2 class="text-4xl font-headline font-bold text-primary mb-6">
                Carbon Emission Reduction
            </h2>
            <p class="text-lg text-on-surface-variant leading-relaxed">
                In traditional farming, banana waste is often burned or left to decompose in open pits, releasing massive amounts of methane and CO2. Our circular model intercepts this waste, transforming it into value before the environment pays the price.
            </p>
        </div>

        <div class="grid md:grid-cols-2 gap-16 items-center">

            <!-- LEFT CONTENT -->
            <div class="space-y-8">

  <!-- Item 1 -->
  <div class="flex items-start gap-4">
    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-red-100 text-red-600">
      <span class="material-symbols-outlined text-lg">error</span>
    </div>
    <div>
      <h4 class="text-base font-semibold text-green-900">
        The Traditional Disposal
      </h4>
      <p class="text-sm text-gray-600 mt-1 leading-relaxed">
        Untreated organic waste undergoes anaerobic decomposition,
        emitting CH4 (Methane)—a greenhouse gas 25 times more potent than CO2.
      </p>
    </div>
  </div>

  <!-- Item 2 -->
  <div class="flex items-start gap-4">
    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-green-100 text-green-600">
      <span class="material-symbols-outlined text-lg">sync</span>
    </div>
    <div>
      <h4 class="text-base font-semibold text-green-900">
        The Tactile Earth Pivot
      </h4>
      <p class="text-sm text-gray-600 mt-1 leading-relaxed">
        We harvest the stems and fibers immediately. By drying and processing
        them into textiles, we lock the carbon into a durable, usable form.
      </p>
    </div>
  </div>

  <!-- Item 3 -->
  <div class="flex items-start gap-4">
    <div class="w-10 h-10 flex items-center justify-center rounded-full bg-emerald-100 text-emerald-700">
      <span class="material-symbols-outlined text-lg">eco</span>
    </div>
    <div>
      <h4 class="text-base font-semibold text-green-900">
        Complete Circularity
      </h4>
      <p class="text-sm text-gray-600 mt-1 leading-relaxed">
        Any leftover residual during our process is returned to the farmers
        as enriched bio-fertilizer, completing the nutrient cycle.
      </p>
    </div>
  </div>

</div>

            <!-- RIGHT INFOGRAPHIC -->
            <div class="relative bg-surface-container rounded-3xl p-12 overflow-hidden h-full min-h-[400px] flex items-center justify-center">

              

                <!-- Background Image -->
                <div class="absolute inset-0">
                    <img class="w-full h-full object-cover"
                         src="img-vid/Carbon-Emission.jpg"/>
                </div>

            </div>

        </div>

    </div>

</section>

<section class="px-8 py-32 pb-12 bg-white">

    <div class="max-w-7xl mx-auto">
        <div class="grid lg:grid-cols-12 gap-16 items-center">

            <!-- LEFT IMAGE -->
            <div class="lg:col-span-5 order-2 lg:order-1">
                <div class="rounded-2xl overflow-hidden shadow-2xl relative group">

                    <img class="w-full aspect-[4/5] object-cover grayscale transition-all duration-700 group-hover:grayscale-0"
                         src="img-vid/mehul.jpg"/>

                    <!-- Overlay -->
                    <div class="absolute bottom-6 left-6 right-6 p-6 bg-white/90 backdrop-blur-md rounded-xl">
                        <p class="italic text-on-surface-variant mb-2">
                           “Banana waste is not waste — it is an opportunity to empower farmers, create income, and build a sustainable future.”
                        </p>
                        <p class="font-bold text-primary">
                            — Mehul Shroff, Founder of MK
                        </p>
                    </div>

                </div>
            </div>

            <!-- RIGHT CONTENT -->
            <div class="lg:col-span-7 order-1 lg:order-2">

    <h2 class="text-4xl font-bold text-primary mb-8 tracking-tight">
        Farmer Empowerment
    </h2>

    <p class="text-xl text-gray-600 leading-relaxed mb-8">
        Sustainable logistics is about people. By creating a direct supply chain for agricultural by-products, we've enabled farming communities to monetize what was previously a disposal liability.
    </p>

    <div class="space-y-6">

        <!-- Card 1 -->
        <div class="info-card border-primary">
            <h5 class="card-title">Predictable Revenue Streams</h5>
            <p class="card-desc">
                A 60% average increase in household income allows for education funding, healthcare, and infrastructure investment in rural areas.
            </p>
        </div>

        <!-- Card 2 -->
        <div class="info-card border-secondary">
            <h5 class="card-title">Sustainable Education</h5>
            <p class="card-desc">
                We provide training on organic cultivation and waste management, ensuring the land remains fertile for generations to come.
            </p>
        </div>

        <!-- Card 3 -->
        <div class="info-card border-green-600">
            <h5 class="card-title">Gender Equity</h5>
            <p class="card-desc">
                Over 70% of our waste-processing cooperatives are women-led, fostering financial independence and leadership within communities.
            </p>
        </div>

    </div>

</div>

        </div>
    </div>

</section>

</main>

<!-- ✅ Footer Include -->
<jsp:include page="all_com/footer.jsp" />

</body>
</html>