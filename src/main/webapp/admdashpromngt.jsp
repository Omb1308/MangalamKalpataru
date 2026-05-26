<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mangalam.dao.ProductDAO, java.sql.*" %>

<%

// =========================
// 🔒 SECURITY HEADERS
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
// 🔒 ADMIN AUTH CHECK
// =========================

if (session.getAttribute("userEmail") == null
        || !"ADMIN".equals(
                session.getAttribute("userRole")
        )) {

    response.sendRedirect("login.jsp");

    return;
}

// =========================
// 🔥 FETCH PRODUCTS
// =========================

ProductDAO dao = new ProductDAO();

ResultSet rs = dao.getAllProducts();

String currentPage = "product";

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Admin - Product Management</title>

<script src="https://cdn.tailwindcss.com"></script>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
      rel="stylesheet">

</head>

<body class="bg-gray-100 font-sans">

<div class="flex h-screen overflow-hidden">

<!-- ========================= -->
<!-- 🔥 SIDEBAR -->
<!-- ========================= -->

<aside class="w-64 bg-white shadow-xl flex flex-col z-10">

    <div class="p-8 border-b border-gray-50">

        <h1 class="text-2xl font-black text-green-800 tracking-tighter">
            Mangalam
        </h1>

        <p class="text-[10px] text-gray-400 uppercase font-bold tracking-widest">
            Sustainability Admin
        </p>

    </div>

           <!-- NAVIGATION -->

        <nav class="mt-4 px-4 space-y-3">

            <!-- DASHBOARD -->

            <a href="admindashboard.jsp"

               class="flex items-center gap-3 px-4 py-3.5 rounded-2xl font-bold transition <%= currentPage.equals("dashboard") ? "bg-green-700 text-white shadow-lg shadow-green-100" : "text-slate-500 hover:bg-green-50 hover:text-green-700" %>">

                <span class="material-symbols-outlined">

                    dashboard

                </span>

                Dashboard

            </a>

            <!-- WASTE -->

            <a href="admdashreq.jsp"

               class="flex items-center gap-3 px-4 py-3.5 rounded-2xl font-bold transition <%= currentPage.equals("waste") ? "bg-green-700 text-white shadow-lg shadow-green-100" : "text-slate-500 hover:bg-green-50 hover:text-green-700" %>">

                <span class="material-symbols-outlined">

                    recycling

                </span>

                Waste Requests

            </a>

            <!-- PRODUCTS -->

            <a href="admdashpromngt.jsp"

               class="flex items-center gap-3 px-4 py-3.5 rounded-2xl font-bold transition <%= currentPage.equals("product") ? "bg-green-700 text-white shadow-lg shadow-green-100" : "text-slate-500 hover:bg-green-50 hover:text-green-700" %>">

                <span class="material-symbols-outlined">

                    agriculture

                </span>

                Product Management

            </a>

        </nav>

    <div class="p-8 border-t border-gray-50">

        <a href="LogoutServlet"
           class="flex items-center gap-2 text-red-500 font-black text-xs uppercase hover:underline transition-all">

            <span class="material-symbols-outlined text-sm">
                logout
            </span>

            Logout

        </a>

    </div>

</aside>

<!-- ========================= -->
<!-- 🔥 MAIN CONTENT -->
<!-- ========================= -->

<div class="flex-1 p-8 overflow-y-auto">

    <h1 class="text-3xl font-bold text-green-800 mb-6">
        Product Catalog
    </h1>

    <!-- ========================= -->
    <!-- 🔥 MESSAGES -->
    <!-- ========================= -->

    <%

    String msg = request.getParameter("msg");

    if ("success".equals(msg)) {

    %>

    <div class="mb-4 bg-green-600 text-white px-4 py-2 rounded">
        Product Added Successfully
    </div>

    <%

    } else if ("deleted".equals(msg)) {

    %>

    <div class="mb-4 bg-red-500 text-white px-4 py-2 rounded">
        Product Deleted
    </div>

    <%

    } else if ("error".equals(msg)) {

    %>

    <div class="mb-4 bg-gray-600 text-white px-4 py-2 rounded">
        Something went wrong
    </div>

    <%

    }

    %>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-10">

        <!-- ========================= -->
        <!-- 🔥 ADD PRODUCT FORM -->
        <!-- ========================= -->

        <div class="bg-white p-6 rounded-2xl shadow border">

            <h2 class="font-semibold mb-6 border-b pb-2">
                Add New Product
            </h2>

            <form action="ProductServlet"
                  method="post"
                  enctype="multipart/form-data"
                  class="space-y-4">

                <input type="hidden"
                       name="action"
                       value="add">

                <!-- PRODUCT NAME -->

                <input type="text"
                       name="pName"
                       placeholder="Product Name"
                       class="w-full border p-2 rounded"
                       required>

                <!-- CATEGORY -->

                <select name="pCat"
                        class="w-full border p-2 rounded">

                    <option>Home Decor</option>
                    <option>Soil & Fertilizers</option>
                    <option>Ropes & Fiber</option>
                    <option>Eco Products</option>
                    <option>Handicrafts</option>

                </select>

                <!-- PRICE -->

                <input type="number"
                       name="pPrice"
                       placeholder="Price (₹)"
                       class="w-full border p-2 rounded"
                       required>

                <!-- STOCK -->

                <input type="number"
                       name="pStock"
                       placeholder="Stock"
                       class="w-full border p-2 rounded"
                       required>

                <!-- 🔥 PACK SIZE -->

                <input type="number"
                       name="packSizes"
                       placeholder="Pack Size (Example: 5)"
                       class="w-full border p-2 rounded"
                       required>

                <!-- DESCRIPTION -->

                <textarea name="pDesc"
                          placeholder="Description"
                          class="w-full border p-2 rounded"></textarea>

                <!-- IMAGE -->

                <input type="file"
                       name="pImage"
                       accept="image/*"
                       required>

                <!-- BUTTON -->

                <button class="w-full bg-green-800 text-white py-2 rounded hover:bg-black">

                    Add Product

                </button>

            </form>

        </div>

        <!-- ========================= -->
        <!-- 🔥 PRODUCT LIST -->
        <!-- ========================= -->

        <div class="lg:col-span-2 space-y-4">

            <%

            while (rs != null && rs.next()) {

            %>

            <div class="flex items-center gap-6 bg-white p-5 rounded-2xl shadow border">

                <!-- PRODUCT IMAGE -->

                <img src="${pageContext.request.contextPath}/images/products/<%= rs.getString("p_image") %>"

                     onerror="this.src='${pageContext.request.contextPath}/images/common/default.png'"

                     class="w-20 h-20 rounded-xl object-cover">

                <div class="flex-1">

                    <!-- PRODUCT NAME -->

                    <h3 class="font-semibold text-lg text-gray-800">

                        <%= rs.getString("p_name") %>

                    </h3>

                    <!-- CATEGORY -->

                    <p class="text-xs text-gray-500">

                        <%= rs.getString("p_category") %>

                    </p>

                    <!-- 🔥 PACK SIZE -->

                    <p class="text-sm text-green-700 font-semibold mt-1">

                        Pack of
                        <%= rs.getInt("pack_sizes") %>

                    </p>

                    <!-- PRICE + STOCK -->

                    <div class="flex justify-between mt-3">

                        <span class="text-green-700 font-bold">

                            ₹<%= rs.getDouble("p_price") %>

                        </span>

                        <span class="text-sm text-gray-500">

                            Stock:
                            <%= rs.getInt("p_stock") %>

                        </span>

                    </div>

                   <div class="mt-3 flex gap-4">

    <!-- EDIT -->

    <a href="editproduct.jsp?id=<%= rs.getInt("p_id") %>"
       class="text-blue-500 text-sm hover:underline">

        Edit

    </a>

    <!-- DELETE -->

    <a href="ProductServlet?action=delete&id=<%= rs.getInt("p_id") %>"
       class="text-red-500 text-sm hover:underline">

        Delete

    </a>

</div>
                      
                      
                      
                </div>

            </div>

            <%

            }

            %>

        </div>

    </div>

</div>

</div>

</body>

</html>