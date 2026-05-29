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

<link rel="stylesheet" href="all_com/aboutas.css">

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


<!-- HERO -->
<section class="px-8 py-17 pb-7 max-w-7xl mx-auto">
<div class="grid grid-cols-1 lg:grid-cols-12 gap-12 items-center">

        <div class="lg:col-span-6 space-y-8">
 
     <h1 class="main-heading">
                About Mangalam Kalptaru Industries
            </h1>
 
 
            <p class="main-text">
               Nestled in the heart of Burhanpur, Madhya Pradesh, lies Mangalam-Kalpataru Industries LLP, a pioneering force in sustainable resource utilization. This region is renowned for its expansive 20,000 hectares of flourishing banana cultivations. With an unwavering commitment to harnessing untapped potential, we have established a cutting-edge processing unit dedicated to banana stems.

Our journey at MK Industries revolves around a singular mission: to tackle the pressing issue of ‘Solid Waste Management’ that emerges after the banana harvest. By ingeniously repurposing the often-overlooked Banana pseudostem, we’ve paved the way for a transformative shift. These pseudo-stems, once deemed waste, have been ingeniously transformed into a versatile raw material. This remarkable resource now finds purpose across diverse industries such as textiles, organic agricultural inputs, and an array of value-added end products. From the realm of home décor to the realm of intricate handicrafts, the resulting Banana Fiber breathes new life into everyday items, infusing them with eco-conscious elegance.
            </p>

            
        </div>

        <div class="lg:col-span-6 relative">
            <div class="image-box">
                <img src="img-vid/mang.jpg"
                     class="w-full h-full object-cover"/>
            </div>
        </div>

    </div>
      
</section>

<!-- VISION / MISSION -->
<section class="section-gray ">
    <div class="max-w-7xl mx-auto grid md:grid-cols-1 gap-8">

        <div class="card-dark">
            <h2 class="card-title-light">Our Vision</h2>
            <p>Amalgamation of farmer’s biomass and artisan's art into utility product and develop a Sustainable, Greener and Circular Economy.</p>
        </div>

        <div class="card-dark">
            <h2 class="card-title-light">Our Mission</h2>
            <p>Our mission is to Educate and encourage people to use Organic and Natural Products. For this we up skill our artists and connect them with need, customer expectation and real time experience with customers. Our products are handmade and eco-friendly, it also helps in creating employment and saving to farmers as well as saving environment.</p>
        </div>

    </div>
</section>


<section class="pt-10 pb-2 px-8 max-w-7xl mx-auto">

    <div class="mb-12">
        <h2 class="text-4xl font-bold text-primary mb-4">Our Skilled Professionals</h2>
        <p class="text-xl text-on-surface-variant max-w-3xl">
            Our team consists of deft professionals with deep proficiency in developing high-performance products across various thicknesses and specialized color finishes, ensuring precision in every organic solution.
        </p>
    </div>

    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8 pb-8">

        <!-- Team Member 1 -->
        <div class="group text-center">
            <div class="aspect-square rounded-xl overflow-hidden mb-6 bg-surface-container">
                <img class="w-full h-full object-contain bg-white transition-transform duration-500 group-hover:scale-105"
                     src="img-vid/mehul.jpg"/>
            </div>
            <h3 class="text-xl font-bold text-primary">Mehul Shroff</h3>
            <p class="text-on-surface-variant font-medium mb-2">Founder & Director</p>
            
        </div>

        <!-- Team Member 2 -->
        <div class="group text-center">
            <div class="aspect-square rounded-xl overflow-hidden mb-6 bg-surface-container">
                <img class="w-full h-full object-contain bg-white transition-transform duration-500 group-hover:scale-105"
                     src="img-vid/purvi.jpg"/>
            </div>
            <h3 class="text-xl font-bold text-primary">Purvi Shah</h3>
            <p class="text-on-surface-variant font-medium mb-2">Director</p>
            
        </div>

        <!-- Team Member 3 -->
        <div class="group text-center">
            <div class="aspect-square rounded-xl overflow-hidden mb-6 bg-surface-container">
                <img class="w-full h-full object-contain bg-white transition-transform duration-500 group-hover:scale-105"
                     src="img-vid/dharmendra.jpg"/>
            </div>
            <h3 class="text-xl font-bold text-primary">Dharmendra Patil</h3>
            <p class="text-on-surface-variant font-medium mb-2">General Manager</p>
           
        </div>

        <!-- Team Member 4 -->
        <div class="group text-center">
            <div class="aspect-square rounded-xl overflow-hidden mb-6 bg-surface-container">
                <img class="w-full h-full object-contain bg-white transition-transform duration-500 group-hover:scale-105"
                     src="img-vid/kuldeep.jpg"/>
            </div>
            <h3 class="text-xl font-bold text-primary">Kuldeep Singh</h3>
            <p class="text-on-surface-variant font-medium mb-2">Technical Head</p>
            
        </div>

    </div>
</section>



<!-- ✅ Footer Include -->
<jsp:include page="all_com/footer.jsp" />
</main>
</body>
</html>