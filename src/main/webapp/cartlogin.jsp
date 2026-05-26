<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="
com.mangalam.dao.CartDAO,
com.mangalam.dao.UserDAO,
com.mangalam.model.CartItem,
java.util.List" %>

<%

// =========================
// 🔒 SECURITY
// =========================

response.setHeader(
        "Cache-Control",
        "no-cache, no-store, must-revalidate"
);

String sessionEmail =
        (String) session.getAttribute("userEmail");

if (sessionEmail == null) {

    response.sendRedirect("login.jsp");

    return;
}

// =========================
// 🔥 FETCH CART
// =========================

CartDAO dao = new CartDAO();

List<CartItem> cartItems =
        dao.getCartItems(sessionEmail);

// =========================
// 🔥 USER ADDRESS
// =========================

UserDAO uDao = new UserDAO();

String userAddress =
        uDao.getUserAddress(sessionEmail);

if (userAddress == null
        || userAddress.trim().isEmpty()) {

    userAddress =
            "No address found. "
            + "Please update your shipping address.";
}

// =========================
// 🔥 TOTAL
// =========================

double subtotal = 0.0;

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>
    Shopping Cart
</title>

<script src="https://cdn.tailwindcss.com"></script>

<style>

body {

    font-family: system-ui;
}

</style>

</head>

<body class="bg-gray-100">

<jsp:include page="all_com/navbar.jsp" />

<main class="max-w-7xl mx-auto p-6">

    <!-- ========================= -->
    <!-- 🔥 TITLE -->
    <!-- ========================= -->

    <h1 class="text-3xl font-bold text-green-800 mb-6">

        Your Cart

    </h1>

    <!-- ========================= -->
    <!-- 🔥 MESSAGE -->
    <!-- ========================= -->

    <%

    if(request.getParameter("msg") != null) {

    %>

    <div class="mb-4 bg-red-100 text-red-700 px-4 py-2 rounded">

        <%= request.getParameter("msg") %>

    </div>

    <%

    }

    %>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">

        <!-- ========================= -->
        <!-- 🔥 LEFT SIDE -->
        <!-- ========================= -->

        <div class="lg:col-span-2 space-y-4">

            <!-- ADDRESS -->

            <div class="bg-white p-4 rounded shadow">

                <h3 class="font-bold">

                    Shipping Address

                </h3>

                <p class="text-sm text-gray-500">

                    <%= userAddress %>

                </p>

            </div>

            <!-- ========================= -->
            <!-- 🔥 EMPTY CART -->
            <!-- ========================= -->

            <%

            if (cartItems == null
                    || cartItems.isEmpty()) {

            %>

            <div class="bg-white p-10 text-center rounded shadow">

                <p class="text-gray-500">

                    Cart is empty

                </p>

            </div>

            <%

            } else {

                for (CartItem item : cartItems) {

                    // 🔥 ITEM TOTAL

                    double itemTotal =
                            item.getPrice()
                            * item.getQuantity();

                    subtotal += itemTotal;

                    // 🔥 IMAGE

                    String image =
                            item.getImageUrl();

                    if (image == null
                            || image.trim().isEmpty()) {

                        image = "default.png";
                    }

            %>

            <!-- ========================= -->
            <!-- 🔥 CART ITEM -->
            <!-- ========================= -->

            <div class="bg-white p-4 rounded shadow flex items-center gap-4">

                <!-- IMAGE -->

                <img src="<%= request.getContextPath() %>/images/products/<%= image %>"

                     class="w-20 h-20 object-cover rounded"

                     onerror="this.src='<%= request.getContextPath() %>/images/common/default.png'">

                <!-- PRODUCT DETAILS -->

                <div class="flex-1">

                    <!-- PRODUCT NAME -->

                    <h3 class="font-bold text-gray-800">

                        <%= item.getpName() %>

                    </h3>

                    <!-- REMOVE -->

                    <a href="RemoveFromCartServlet?pid=<%= item.getpId() %>"

                       class="text-xs text-red-500 hover:underline">

                        Remove

                    </a>

                </div>
                
                <p>Quantity</p>

                <!-- ========================= -->
                <!-- 🔥 QUANTITY -->
                <!-- ========================= -->

                <div class="flex items-center border rounded">  
                
                

                    <!-- MINUS -->

                    <button

                        onclick="changeQty(
                            '<%= item.getpId() %>',
                            <%= item.getQuantity() - 1 %>
                        )"

                        class="px-2 font-bold">

                        -

                    </button>

                    <!-- QTY -->

                    <span class="px-3">

                        <%= item.getQuantity() %>

                    </span>

                    <!-- PLUS -->

                    <button

                        onclick="changeQty(
                            '<%= item.getpId() %>',
                            <%= item.getQuantity() + 1 %>
                        )"

                        class="px-2 font-bold">

                        +

                    </button>

                </div>

                <!-- ========================= -->
                <!-- 🔥 PRICE -->
                <!-- ========================= -->

                <div class="font-bold text-green-700">

                    ₹<%= (int)itemTotal %>

                </div>

            </div>

            <%

                }
            }

            %>

        </div>

        <!-- ========================= -->
        <!-- 🔥 RIGHT SIDE -->
        <!-- ========================= -->

        <div class="bg-white p-6 rounded shadow h-fit">

            <h2 class="font-bold text-xl mb-4">

                Order Summary

            </h2>

            <%

            // 🔥 DISCOUNT

            double discount =
                    subtotal * 0;

            // 🔥 SHIPPING

            int shipping =
                    (subtotal > 0)
                    ? 0
                    : 0;

            // 🔥 TOTAL

            double total =
                    (subtotal - discount)
                    + shipping;

            %>

            <!-- SUMMARY -->

            <div class="space-y-3">

                <!-- SUBTOTAL -->

                <div class="flex justify-between">

                    <span>

                        Subtotal

                    </span>

                    <span>

                        ₹<%= (int)subtotal %>

                    </span>

                </div>

                <!-- DISCOUNT -->

                <div class="flex justify-between text-green-600">

                    <span>

                        Discount

                    </span>

                    <span>

                        -₹<%= (int)discount %>

                    </span>

                </div>

                <!-- SHIPPING -->

                <div class="flex justify-between">

                    <span>

                        Shipping

                    </span>

                    <span>

                        <%= (shipping == 0)
                        ? "FREE"
                        : "₹" + shipping %>

                    </span>

                </div>

                <!-- TOTAL -->

                <div class="border-t pt-3 flex justify-between font-bold text-lg text-green-800">

                    <span>

                        Total

                    </span>

                    <span>

                        ₹<%= (int)total %>

                    </span>

                </div>

            </div>

            <!-- ========================= -->
            <!-- 🔥 CHECKOUT -->
            <!-- ========================= -->

            <a href="paymentdemo.jsp?amount=<%= total %>"

               class="block mt-6 bg-green-700 text-white text-center py-2 rounded hover:bg-green-800">

                Checkout

            </a>

        </div>

    </div>

</main>

<!-- ========================= -->
<!-- 🔥 JS -->
<!-- ========================= -->

<script>

function changeQty(pid, qty) {

    // 🔥 REMOVE

    if (qty < 1) {

        window.location =
                "RemoveFromCartServlet?pid="
                + pid;

    } else {

        // 🔥 UPDATE

        window.location =
                "UpdateQuantityServlet?pid="
                + pid
                + "&qty="
                + qty;
    }
}

</script>

</body>

</html>