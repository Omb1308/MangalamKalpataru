<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="
com.mangalam.dao.ProductDAO,
java.sql.*" %>

<%

// =========================
// CACHE CONTROL
// =========================

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

// =========================
// FETCH PRODUCTS
// =========================

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

<body class="bg-background-light overflow-hidden">

<jsp:include page="all_com/navbar.jsp" />

<!-- ========================= -->
<!-- MAIN -->
<!-- ========================= -->

<main class="max-w-7xl mx-auto px-6 py-6 flex flex-col md:flex-row gap-8 items-start h-[calc(100vh-80px)] overflow-hidden">

<!-- ========================= -->
<!-- SIDEBAR -->
<!-- ========================= -->

<aside class="w-full md:w-64 sticky top-24 self-start bg-white p-5 rounded-2xl shadow border border-gray-100 space-y-6">

    <h3 class="text-lg font-bold text-earth-green">

        Filters

    </h3>

    <!-- CATEGORY -->

    <div>

        <h4 class="text-sm font-bold mb-3">

            Categories

        </h4>

        <label>
            <input type="checkbox"
                   class="category"
                   value="Soil & Fertilizers">

            Soil & Fertilizers
        </label>

        <br>

        <label>
            <input type="checkbox"
                   class="category"
                   value="Ropes & Fiber">

            Ropes & Fiber
        </label>

        <br>

        <label>
            <input type="checkbox"
                   class="category"
                   value="Home Decor">

            Home Decor
        </label>

        <br>

        <label>
            <input type="checkbox"
                   class="category"
                   value="Eco Products">

            Eco Products
        </label>

        <br>

        <label>
            <input type="checkbox"
                   class="category"
                   value="Handicrafts">

            Handicrafts
        </label>

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

        <p class="mt-2">

            ₹<span id="priceValue">5000</span>

        </p>

    </div>

</aside>

<!-- ========================= -->
<!-- PRODUCTS SECTION -->
<!-- ========================= -->

<div class="flex-1 h-full overflow-hidden flex flex-col">

    <!-- ========================= -->
    <!-- STICKY HEADER -->
    <!-- ========================= -->

    <div class="sticky top-0 z-20 bg-background-light pb-4 flex flex-col md:flex-row md:items-center md:justify-between gap-4">

        <h1 class="text-3xl font-bold text-earth-green">

            Explore Products

        </h1>

        <!-- SEARCH -->

        <div class="relative w-full md:w-80">

            <input
                type="text"
                id="searchInput"
                placeholder="Search products..."
                class="w-full border border-gray-300 rounded-xl px-4 py-2 pl-10 focus:outline-none focus:ring-2 focus:ring-green-500"
            >

            <span class="absolute left-3 top-2.5 text-gray-400">

                🔍

            </span>

        </div>

    </div>

    <!-- ========================= -->
    <!-- PRODUCT GRID -->
    <!-- ========================= -->

    <div id="productGrid"
         class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 overflow-y-auto pr-2 flex-1">

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

    <div class="product bg-white p-4 rounded-xl shadow"

         data-name="<%= name.toLowerCase() %>"

         data-category="<%= cat %>"

         data-price="<%= price %>">

        <!-- IMAGE -->

        <img src="${pageContext.request.contextPath}/images/products/<%= img %>"

             onerror="this.src='${pageContext.request.contextPath}/images/common/default.png'"

             class="w-full h-52 object-cover rounded">

        <!-- NAME -->

        <h3 class="mt-3 font-bold text-lg">

            <%= name %>

        </h3>

        <!-- CATEGORY -->

        <p class="text-sm text-gray-500 mb-2">

            <%= cat %>

        </p>

        <!-- DESCRIPTION -->

        <p class="text-xs text-gray-400 mb-3">

            <%= desc %>

        </p>

        <!-- PACK -->

        <p class="text-sm text-green-700 font-semibold mb-2">

            Pack of <%= packSize %>

        </p>

        <!-- PRICE + BUTTON -->

        <div class="flex justify-between items-center">

            <!-- PRICE -->

            <span class="text-green-700 font-bold text-lg">

                ₹<%= price %>

            </span>

            <!-- STOCK -->

            <%

            if (stock > 0) {

            %>

            <!-- ADD TO CART -->

            <form action="AddToCartServlet"
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
                    class="bg-primary px-3 py-1 rounded text-earth-green font-bold">

                    Add

                </button>

            </form>

            <%

            } else {

            %>

            <!-- OUT OF STOCK -->

            <button

                class="bg-gray-400 px-3 py-1 rounded text-white font-bold cursor-not-allowed"

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

    // EMPTY

    if (!found) {

    %>

    <p>

        No products available

    </p>

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

// FILTER FUNCTION

function filterProducts() {

    // CATEGORY

    let selected =
        Array.from(categories)

        .filter(c => c.checked)

        .map(c => c.value);

    // PRICE

    let max =
        parseInt(priceRange.value);

    // SEARCH

    let search =
        document.getElementById("searchInput")
        .value
        .toLowerCase();

    // LOOP PRODUCTS

    products.forEach(p => {

        let cat =
            p.dataset.category;

        let price =
            parseFloat(p.dataset.price);

        let name =
            p.dataset.name;

        // CATEGORY MATCH

        let matchCategory =

            selected.length === 0

            || selected.includes(cat);

        // PRICE MATCH

        let matchPrice =
            price <= max;

        // SEARCH MATCH

        let matchSearch =
            name.includes(search);

        // FINAL

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

// CATEGORY FILTER

categories.forEach(c => {

    c.addEventListener(
        "change",
        filterProducts
    );

});

// PRICE FILTER

priceRange.addEventListener(
    "input",

    () => {

        priceValue.innerText =
                priceRange.value;

        filterProducts();
    }
);

// SEARCH FILTER

document.getElementById("searchInput")
.addEventListener(
    "input",
    filterProducts
);

// INITIAL LOAD

filterProducts();

</script>

</body>

</html>