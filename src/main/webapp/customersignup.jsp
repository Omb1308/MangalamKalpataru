<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Create Account</title>

<script src="https://cdn.tailwindcss.com"></script>

<script>
tailwind.config = {
    theme: {
        extend: {
            colors: {
                primary: '#1b5e20',
                secondary: '#4caf50'
            }
        }
    }
}
</script>

</head>

<body class="bg-gray-100">

<section class="min-h-screen flex items-center justify-center px-6 py-12">

<div class="max-w-7xl w-full grid grid-cols-1 md:grid-cols-2 gap-12 items-center">

<!-- LEFT CONTENT (OLD UI SAME) -->
<div>
    <h1 class="text-4xl md:text-5xl font-bold text-primary mb-6">
        Create Your Account
    </h1>

    <p class="text-gray-600 mb-8 leading-relaxed">
        Join our curated community of conscious consumers and start your journey toward a circular lifestyle.
    </p>

    <div class="flex gap-6 mb-8">
        <div class="bg-white p-5 rounded-xl shadow w-40 text-center">
            <p class="text-green-700 text-xl font-bold">12k+</p>
            <p class="text-gray-500 text-sm">Trees Planted</p>
        </div>

        <div class="bg-white p-5 rounded-xl shadow w-40 text-center">
            <p class="text-red-500 text-xl font-bold">5,000+</p>
            <p class="text-gray-500 text-sm">Active Shoppers</p>
        </div>
    </div>

    <div class="bg-gradient-to-r from-green-900 to-green-700 text-white p-6 rounded-xl shadow-lg mb-8">
        <p class="text-sm uppercase mb-2 opacity-80">Your Potential Impact</p>
        <h3 class="text-lg font-semibold">
            Your first purchase will save approx. 2.4kg of CO2 emissions.
        </h3>
    </div>

    <div class="flex items-center gap-4">
        <img src="https://randomuser.me/api/portraits/women/44.jpg"
             class="w-10 h-10 rounded-full">

        <p class="text-sm text-gray-600 italic">
            "BananaEco changed how I think about waste."
        </p>
    </div>
</div>

<!-- RIGHT FORM -->
<div class="bg-white p-8 rounded-2xl shadow-lg">

<form action="CustomerSignupServlet" method="post" class="space-y-4">

<div class="grid grid-cols-2 gap-4">
    <div>
        <label class="text-sm text-gray-600">Full Name</label>
        <input type="text" name="fullName" required placeholder="Enter your full name"
               class="w-full mt-1 p-3 border rounded-lg">
    </div>

    <div>
        <label class="text-sm text-gray-600">Email</label>
        <input type="email" id="email" name="email" required placeholder="Enter your email ID"
               class="w-full mt-1 p-3 border rounded-lg">
    </div>
</div>

<!-- OTP -->
<div class="flex gap-2">
    <input type="text" id="otp" placeholder="Enter OTP"
           class="w-full p-3 border rounded-lg">

    <button type="button" onclick="sendOTP()"
            class="bg-blue-600 text-white px-4 rounded-lg">
        Send OTP
    </button>
</div>

<div class="flex gap-2 items-center">
    <button type="button" onclick="verifyOTP()"
            class="bg-green-600 text-white px-4 py-2 rounded-lg">
        Verify OTP
    </button>

    <span id="otpStatus" class="text-sm font-semibold"></span>
</div>

<input type="hidden" id="emailVerified" name="emailVerified" value="false">

<div class="grid grid-cols-2 gap-4">
    <input type="text" name="mobile" required placeholder="Mobile"
           class="p-3 border rounded-lg">

    <input type="password" name="password" required placeholder="Password"
           class="p-3 border rounded-lg">
</div>

<input type="text" name="address" required placeholder="Address"
       class="w-full p-3 border rounded-lg">

<button type="submit" id="registerBtn"
        class="w-full bg-green-800 text-white py-3 rounded-lg opacity-50 cursor-not-allowed" disabled>
    Register
</button>

</form>
</div>

</div>
</section>

<!-- 🔥 UPDATED JS -->
<script>

let otpVerified = false;

function sendOTP() {
    let email = document.getElementById("email").value;

    if (email === "") {
        alert("Enter email first");
        return;
    }

    fetch("/MangalamKalpataru/SendOtpServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "email=" + encodeURIComponent(email)
    })
    .then(res => res.text())
    .then(data => {
        alert(data);
    })
    .catch(() => alert("Error sending OTP"));
}

function verifyOTP() {
    let otp = document.getElementById("otp").value;

    if (otp === "") {
        alert("Enter OTP");
        return;
    }

    fetch("/MangalamKalpataru/VerifyOtpServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "otp=" + encodeURIComponent(otp)
    })
    .then(res => res.text())
    .then(data => {

        let status = document.getElementById("otpStatus");

        if (data.trim() === "Verified") {
            status.innerText = "✅ Verified";
            status.style.color = "green";

            document.getElementById("emailVerified").value = "true";

            // 🔥 Enable Register Button
            let btn = document.getElementById("registerBtn");
            btn.disabled = false;
            btn.classList.remove("opacity-50", "cursor-not-allowed");

            // 🔥 Lock Email Field
            document.getElementById("email").readOnly = true;

            otpVerified = true;

        } else {
            status.innerText = data;
            status.style.color = "red";
        }

    })
    .catch(() => alert("Error verifying OTP"));
}


// 🔥 Prevent manual submit bypass
document.querySelector("form").addEventListener("submit", function(e) {
    if (!otpVerified) {
        e.preventDefault();
        alert("Please verify OTP first");
    }
});

</script>

</body>
</html>