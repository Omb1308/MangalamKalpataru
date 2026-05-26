<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="
com.mangalam.dao.ProductDAO,
java.sql.*" %>

<%

// =========================
// 🔒 SECURITY
// =========================

response.setHeader(
        "Cache-Control",
        "no-cache, no-store, must-revalidate"
);

if (session.getAttribute("userEmail") == null
        || !"ADMIN".equals(
                session.getAttribute("userRole")
        )) {

    response.sendRedirect("login.jsp");

    return;
}

// =========================
// 🔥 GET PRODUCT ID
// =========================

int id =
        Integer.parseInt(
                request.getParameter("id")
        );

// =========================
// 🔥 FETCH PRODUCT
// =========================

ProductDAO dao =
        new ProductDAO();

ResultSet rs =
        dao.getProductById(id);

String name = "";
String cat = "";
double price = 0;
int stock = 0;
int pack = 1;
String desc = "";
String image = "";

if (rs != null && rs.next()) {

    name =
            rs.getString("p_name");

    cat =
            rs.getString("p_category");

    price =
            rs.getDouble("p_price");

    stock =
            rs.getInt("p_stock");

    pack =
            rs.getInt("pack_sizes");

    desc =
            rs.getString("p_desc");

    image =
            rs.getString("p_image");
}

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Edit Product
</title>

<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-gray-100">

<div class="max-w-3xl mx-auto py-10 px-6">

    <!-- ========================= -->
    <!-- 🔥 TITLE -->
    <!-- ========================= -->

    <div class="mb-8">

        <h1 class="text-3xl font-bold text-green-800">

            Edit Product

        </h1>

        <p class="text-gray-500 mt-2">

            Update product details

        </p>

    </div>

    <!-- ========================= -->
    <!-- 🔥 FORM -->
    <!-- ========================= -->

    <div class="bg-white rounded-2xl shadow p-8">

        <form action="ProductServlet"
              method="POST"
              class="space-y-5">

            <!-- ACTION -->

            <input type="hidden"
                   name="action"
                   value="update">

            <!-- PRODUCT ID -->

            <input type="hidden"
                   name="pId"
                   value="<%= id %>">

            <!-- PRODUCT NAME -->

            <div>

                <label class="block mb-2 font-semibold text-gray-700">

                    Product Name

                </label>

                <input type="text"
                       name="pName"
                       value="<%= name %>"
                       class="w-full border rounded-lg p-3"
                       required>

            </div>

            <!-- CATEGORY -->

            <div>

                <label class="block mb-2 font-semibold text-gray-700">

                    Category

                </label>

                <select name="pCat"
                        class="w-full border rounded-lg p-3">

                    <option
                        <%= cat.equals("Home Decor")
                        ? "selected"
                        : "" %>>

                        Home Decor

                    </option>

                    <option
                        <%= cat.equals("Soil & Fertilizers")
                        ? "selected"
                        : "" %>>

                        Soil & Fertilizers

                    </option>

                    <option
                        <%= cat.equals("Ropes & Fiber")
                        ? "selected"
                        : "" %>>

                        Ropes & Fiber

                    </option>

                    <option
                        <%= cat.equals("Eco Products")
                        ? "selected"
                        : "" %>>

                        Eco Products

                    </option>

                    <option
                        <%= cat.equals("Handicrafts")
                        ? "selected"
                        : "" %>>

                        Handicrafts

                    </option>

                </select>

            </div>

            <!-- PRICE -->

            <div>

                <label class="block mb-2 font-semibold text-gray-700">

                    Price

                </label>

                <input type="number"
                       name="pPrice"
                       value="<%= price %>"
                       class="w-full border rounded-lg p-3"
                       required>

            </div>

            <!-- STOCK -->

            <div>

                <label class="block mb-2 font-semibold text-gray-700">

                    Stock

                </label>

                <input type="number"
                       name="pStock"
                       value="<%= stock %>"
                       class="w-full border rounded-lg p-3"
                       required>

            </div>

            <!-- PACK SIZE -->

            <div>

                <label class="block mb-2 font-semibold text-gray-700">

                    Pack Size

                </label>

                <input type="number"
                       name="packSizes"
                       value="<%= pack %>"
                       class="w-full border rounded-lg p-3"
                       required>

            </div>

            <!-- DESCRIPTION -->

            <div>

                <label class="block mb-2 font-semibold text-gray-700">

                    Description

                </label>

                <textarea
                    name="pDesc"
                    rows="4"
                    class="w-full border rounded-lg p-3"><%= desc %></textarea>

            </div>

            <!-- IMAGE -->

            <div>

                <label class="block mb-3 font-semibold text-gray-700">

                    Product Image

                </label>

                <img src="<%= request.getContextPath() %>/images/products/<%= image %>"

                     class="w-40 h-40 rounded-xl object-cover border"

                     onerror="this.src='<%= request.getContextPath() %>/images/common/default.png'">

            </div>

            <!-- BUTTONS -->

            <div class="flex gap-4 pt-4">

                <!-- UPDATE -->

                <button
                    type="submit"
                    class="bg-green-700 hover:bg-green-800 text-white px-6 py-3 rounded-lg font-semibold">

                    Update Product

                </button>

                <!-- BACK -->

                <a href="admdashpromngt.jsp"

                   class="bg-gray-200 hover:bg-gray-300 px-6 py-3 rounded-lg font-semibold">

                    Back

                </a>

            </div>

        </form>

    </div>

</div>

</body>

</html>