<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="
com.mangalam.dao.ProductDAO,
java.sql.*" %>

<%

response.setHeader(
        "Cache-Control",
        "no-cache, no-store, must-revalidate"
);

response.setHeader(
        "Pragma",
        "no-cache"
);

response.setDateHeader(
        "Expires",
        0
);

ProductDAO dao =
        new ProductDAO();

ResultSet rs =
        dao.getAllProducts();

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Shop - Mangalam Kalpataru
</title>

<script src="https://cdn.tailwindcss.com?plugins=forms"></script>

<script>

tailwind.config = {

    theme: {

        extend: {

            colors: {

                primary: "#13ec13",

                "earth-green": "#2D4B2D",

                "background-light": "#f6f8f6"
            }
        }
    }
}

</script>

</head>

<body class="bg-background-light overflow-x-hidden">

<jsp:include page="all_com/navbar.jsp" />

<!-- ========================= -->
<!-- MAIN -->
<!-- ========================= -->

<main
class="max-w-7xl mx-auto px-4 sm:px-6 py-6 flex flex-col md:flex-row gap-6 lg:gap-8 items-start min-h-screen">

<!-- ========================= -->
<!-- SIDEBAR -->
<!-- ========================= -->

<aside
class="w-full md:w-64 bg-white p-5 rounded-2xl shadow border border-gray-100 space-y-6 md:sticky md:top-24 self-start">

    <h3 class="text-lg font-bold text-earth-green">

        Filters

    </h3>

    <!-- CATEGORY -->

    <div>

        <h4 class="text-sm font-bold mb-3">

            Categories

        </h4>

        <div class="space-y-2 text-sm">

            <label class="flex items-center gap-2">

                <input type="checkbox"
                       class="category"
                       value="Soil & Fertilizers">

                Soil & Fertilizers

            </label>

            <label class="flex items-center gap-2">

                <input type="checkbox"
                       class="category"
                       value="Ropes & Fiber">

                Ropes & Fiber

            </label>

            <label class="flex items-center gap-2">

                <input type="checkbox"
                       class="category"
                       value="Home Decor">

                Home Decor

            </label>

            <label class="flex items-center gap-2">

                <input type="checkbox"
                       class="category"
                       value="Eco Products">

                Eco Products

            </label>

            <label class="flex items-center gap-2">

                <input type="checkbox"
                       class="category"
                       value="Handicrafts">

                Handicrafts

            </label>

        </div>

    </div>

    <!-- PRICE FILTER -->

    <div>

        <h4 class="text-sm font-bold mb-3">

            Max Price

        </h4>

        <input type="range"
               id="priceRange"
               min="0"
               max="5000"
               value="5000"
               class="w-full">

        <p class="mt-2 text-sm">

            ₹<span id="priceValue">5000</span>

        </p>

    </div>

</aside>

<!-- ========================= -->
<!-- PRODUCTS SECTION -->
<!-- ========================= -->

<div class="flex-1 w-full flex flex-col">

    <!-- ========================= -->
    <!-- HEADER -->
    <!-- ========================= -->

    <div
    class="sticky top-0 z-20 bg-background-light pb-4 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">

        <h1
        class="text-2xl sm:text-3xl font-bold text-earth-green">

            Explore Products

        </h1>

        <!-- SEARCH -->

        <div class="relative w-full sm:w-80">

            <input
                type="text"
                id="searchInput"
                placeholder="Search products..."
                class="w-full border border-gray-300 rounded-xl px-4 py-2 pl-10 focus:outline-none focus:ring-2 focus:ring-green-500"
            >

            <span
            class="absolute left-3 top-2.5 text-gray-400">

                🔍

            </span>

        </div>

    </div>

    <!-- ========================= -->
    <!-- PRODUCT GRID -->
    <!-- ========================= -->

    <div
    id="productGrid"
    class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-5 sm:gap-6 pb-10">

    <%

    boolean found = false;

    if (rs != null) {

        while (rs.next()) {

            found = true;

            int id =
                    rs.getInt("p_id");

            String name =
                    rs.getString("p_name");

            String cat =
                    rs.getString("p_category");

            double price =
                    rs.getDouble("p_price");

            String img =
                    rs.getString("p_image");

            int stock =
                    rs.getInt("p_stock");

            String desc =
                    rs.getString("p_desc");

            int packSize =
                    rs.getInt("pack_sizes");

    %>

    <!-- PRODUCT CARD -->

    <div
    class="product bg-white p-4 rounded-2xl shadow hover:shadow-lg transition duration-300"

    data-name="<%= name.toLowerCase() %>"

    data-category="<%= cat %>"

    data-price="<%= price %>">

        <!-- IMAGE -->

        <img
        src="${pageContext.request.contextPath}/images/products/<%= img %>"

        onerror="this.src='${pageContext.request.contextPath}/images/common/default.png'"

        class="w-full h-52 sm:h-56 object-cover rounded-xl">

        <!-- NAME -->

        <h3
        class="mt-4 font-bold text-lg text-earth-green">

            <%= name %>

        </h3>

        <!-- CATEGORY -->

        <p
        class="text-sm text-gray-500 mb-2">

            <%= cat %>

        </p>

        <!-- DESCRIPTION -->

        <p
        class="text-xs text-gray-400 mb-3 line-clamp-2">

            <%= desc %>

        </p>

        <!-- PACK -->

        <p
        class="text-sm text-green-700 font-semibold mb-4">

            Pack of <%= packSize %>

        </p>

        <!-- PRICE + BUTTON -->

        <div
        class="flex items-center justify-between gap-3">

            <!-- PRICE -->

            <span
            class="text-green-700 font-bold text-lg">

                ₹<%= price %>

            </span>

            <!-- STOCK -->

            <%

            if (stock > 0) {

            %>

            <!-- ADD TO CART -->

            <form
            action="AddToCartServlet"
            method="POST">

                <input type="hidden"
                       name="productId"
                       value="<%= id %>">

                <input type="hidden"
                       name="productName"
                       value="<%= name %>">

                <input type="hidden"
                       name="basePrice"
                       value="<%= price %>">

                <input type="hidden"
                       name="packSize"
                       value="<%= packSize %>">

                <input type="hidden"
                       name="productImage"
                       value="<%= img %>">

                <button
                class="bg-primary hover:scale-105 transition px-4 py-2 rounded-lg text-earth-green font-bold">

                    Add

                </button>

            </form>

            <%

            } else {

            %>

            <!-- OUT OF STOCK -->

            <button
            class="bg-gray-400 px-4 py-2 rounded-lg text-white font-bold cursor-not-allowed"
            disabled>

                Out of Stock

            </button>

            <%

            }

            %>

        </div>

    </div>

    <%

        }
    }

    if (!found) {

    %>

    <div
    class="col-span-full text-center py-20 text-gray-500">

        No products available

    </div>

    <%

    }

    %>

    </div>

</div>

</main>

<!-- ========================= -->
<!-- FILTER JS -->
<!-- ========================= -->

<script>

const products =
        document.querySelectorAll(".product");

const categories =
        document.querySelectorAll(".category");

const priceRange =
        document.getElementById("priceRange");

const priceValue =
        document.getElementById("priceValue");

function filterProducts() {

    let selected =
        Array.from(categories)

        .filter(c => c.checked)

        .map(c => c.value);

    let max =
        parseInt(priceRange.value);

    let search =
        document.getElementById("searchInput")
        .value
        .toLowerCase();

    products.forEach(p => {

        let cat =
            p.dataset.category;

        let price =
            parseFloat(p.dataset.price);

        let name =
            p.dataset.name;

        let matchCategory =

            selected.length === 0

            || selected.includes(cat);

        let matchPrice =
            price <= max;

        let matchSearch =
            name.includes(search);

        let show =

            matchCategory
            && matchPrice
            && matchSearch;

        p.style.display =
            show
            ? "block"
            : "none";
    });
}

categories.forEach(c => {

    c.addEventListener(
        "change",
        filterProducts
    );

});

priceRange.addEventListener(
    "input",

    () => {

        priceValue.innerText =
                priceRange.value;

        filterProducts();
    }
);

document.getElementById("searchInput")
.addEventListener(
    "input",
    filterProducts
);

filterProducts();

</script>

</body>

</html>