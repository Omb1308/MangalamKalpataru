<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

// =========================
// 🔥 GET TOTAL AMOUNT
// =========================

String amount =
        request.getParameter("amount");

if (amount == null
        || amount.trim().isEmpty()) {

    amount = "1";
}

%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>
    Secure Payment - Mangalam Kalpataru
</title>

<script src="https://cdn.tailwindcss.com"></script>

<!-- 🔥 RAZORPAY -->

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<div class="bg-white shadow-2xl rounded-2xl p-8 w-full max-w-md">

    <!-- ========================= -->
    <!-- 🔥 HEADER -->
    <!-- ========================= -->

    <div class="text-center mb-8">

        <h1 class="text-3xl font-bold text-green-700">

            Mangalam Kalpataru

        </h1>

        <p class="text-gray-500 mt-2">

            Complete Your Secure Payment

        </p>

    </div>

    <!-- ========================= -->
    <!-- 🔥 AMOUNT BOX -->
    <!-- ========================= -->

    <div class="bg-green-50 border border-green-200 rounded-xl p-5 mb-6">

        <div class="flex items-center justify-between">

            <span class="text-gray-600 font-medium">

                Total Amount

            </span>

            <span class="text-3xl font-bold text-green-700">

                ₹<%= amount %>

            </span>

        </div>

    </div>

    <!-- 🔥 HIDDEN TOTAL -->

    <input type="hidden"
           id="totalAmount"
           value="<%= amount %>">

    <!-- ========================= -->
    <!-- 🔥 PAY BUTTON -->
    <!-- ========================= -->

    <button onclick="payNow()"

        class="w-full bg-green-700 hover:bg-green-800 transition duration-300 text-white py-3 rounded-xl font-semibold text-lg shadow-md">

        Pay Now

    </button>

    <!-- ========================= -->
    <!-- 🔥 FOOTER -->
    <!-- ========================= -->

    <p class="text-center text-xs text-gray-400 mt-5">

        100% Secure Payments Powered by Razorpay

    </p>

</div>

<script>

// =========================
// 🔥 PAYMENT FUNCTION
// =========================

function payNow() {

    let amount =
            document.getElementById(
                    "totalAmount"
            ).value;

    // 🔥 CREATE ORDER

    fetch("CreateOrderServlet", {

        method: "POST",

        headers: {
            "Content-Type":
                "application/x-www-form-urlencoded"
        },

        body: "amount=" + amount
    })

    .then(response => response.json())

    .then(order => {

        // 🔥 RAZORPAY OPTIONS

        var options = {

            "key":
                "rzp_test_SmD1A71FoNxdnn",

            "amount":
                order.amount,

            "currency":
                "INR",

            "name":
                "Mangalam Kalpataru",

            "description":
                "Product Purchase Payment",

            "image":
                "images/common/logo.png",

            "order_id":
                order.id,

            // 🔥 SUCCESS

            "handler": function (response) {

                alert(
                    "Payment Successful"
                );

                window.location.href =

                    "RazorpaySuccessServlet"

                    + "?payment_id="
                    + response.razorpay_payment_id

                    + "&order_id="
                    + response.razorpay_order_id

                    + "&signature="
                    + response.razorpay_signature;
            },

            // 🔥 PREFILL

            "prefill": {

                "name": "Mangalam User",

                "email": "customer@mangalam.com"

            },

            // 🔥 THEME

            "theme": {

                "color": "#15803d"
            }

        };

        // 🔥 OPEN RAZORPAY

        var rzp =
                new Razorpay(options);

        // =========================
        // 🔥 PAYMENT FAILED
        // =========================

        rzp.on(
            'payment.failed',

            function (response) {

                console.log(response.error);

                alert(
                    "Payment Failed"
                );

                window.location.href =
                        "paymentFailed.jsp";
            }
        );

        // 🔥 OPEN CHECKOUT

        rzp.open();

    })

    .catch(error => {

        console.log(error);

        alert(
            "Unable to initiate payment"
        );

    });
}

</script>

</body>

</html>