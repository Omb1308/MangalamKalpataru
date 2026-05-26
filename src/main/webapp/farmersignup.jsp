<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Farmer Enrollment - Mangalam Kalpataru</title>

<script src="https://cdn.tailwindcss.com"></script>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet">

<script>
    // ❌ Removed duplicate otpVerified

    function validateForm() {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirm_password").value;
        
        if (password !== confirmPassword) {
            alert("Passwords do not match. Please re-enter.");
            return false;
        }

        if (!otpVerified) {
            alert("Please verify OTP first");
            return false;
        }

        return true;
    }
</script>

</head>

<body class="bg-gray-100 font-sans">

<div class="min-h-screen flex">

    <div class="w-1/2 relative hidden lg:flex flex-col justify-between">

    <img src="img-vid/farmersign.jpg"
         class="absolute inset-0 w-full h-full object-cover" />

    <div class="absolute inset-0 bg-green-900/70"></div>

    <div class="relative z-10 text-white p-10 flex flex-col justify-between h-full">

        <div>
            <h1 class="text-2xl font-bold mb-10">Mangalam Kalpataru</h1>

            <h2 class="text-4xl font-bold leading-tight mb-6">
                Turn your harvest<br> waste into wealth.
            </h2>

            <p class="text-green-200 max-w-md">
                Join our sustainable marketplace in Burhanpur.
            </p>
        </div>
    </div>
</div>


<div class="w-1/2 bg-white p-12 overflow-y-auto">

<h2 class="text-3xl font-bold mb-2">Farmer Enrollment</h2>
<p class="text-gray-500 mb-8">Complete your profile to start selling your banana waste.</p>

<form action="FarmerSignupServlet" method="post"
      onsubmit="return validateForm()" class="space-y-8">

<div>
    <h3 class="font-semibold mb-4 text-green-800">1 Personal Information</h3>

    <div class="grid grid-cols-2 gap-4">
        <input type="text" name="full_name" placeholder="Enter your full name"
            class="border p-3 rounded w-full focus:ring-2 focus:ring-green-500 outline-none" required>
        
        <input type="email" id="email" name="email" placeholder="Enter your email ID"
            class="border p-3 rounded w-full focus:ring-2 focus:ring-green-500 outline-none" required>
    </div>
</div>

<!-- OTP SECTION -->
<div class="flex gap-2">
    <input type="text" id="otp" placeholder="Enter OTP"
           class="w-full p-3 border rounded-lg">

    <button type="button" id="sendBtn" onclick="sendOTP()"
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

<div>
    <h3 class="font-semibold mb-4 text-green-800">2 Location Details</h3>

    <input type="text" name="locality" placeholder="Locality / Village Name"
        class="border p-3 rounded w-full focus:ring-2 focus:ring-green-500 outline-none" required>
</div>

<div>
    <h3 class="font-semibold mb-4 text-green-800">3 Financial Details</h3>

    <input type="text" name="upi_id" placeholder="name@okaxis"
        class="border p-3 rounded w-full focus:ring-2 focus:ring-green-500 outline-none" required>
</div>

<div>
    <h3 class="font-semibold mb-4 text-green-800">4 Security</h3>

    <div class="grid grid-cols-2 gap-4">
        <input type="password" id="password" name="password" placeholder="At least 8 characters"
            class="border p-3 rounded focus:ring-2 focus:ring-green-500 outline-none" required>

        <input type="password" id="confirm_password" placeholder="Re-enter password"
            class="border p-3 rounded focus:ring-2 focus:ring-green-500 outline-none" required>
    </div>
</div>

<button type="submit" id="registerBtn" disabled
class="w-full bg-green-800 text-white py-4 rounded-lg opacity-50 cursor-not-allowed">
    Join as Farmer →
</button>

<p class="text-sm text-gray-500 text-center">
    By joining, you agree to our <a href="#" class="underline">Farmer Terms & Conditions</a>.
</p>

</form>
</div>

</div>

<!-- ✅ FINAL WORKING SCRIPT -->
<script>

let otpVerified = false;

function sendOTP() {
    let email = document.getElementById("email").value;

    if (email === "") {
        alert("Enter email first");
        return;
    }

    document.getElementById("sendBtn").disabled = true;

    fetch("/MangalamKalpataru/SendOtpServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "email=" + encodeURIComponent(email) + "&type=farmer"
    })
    .then(res => res.text())
    .then(data => {
        console.log("Server Response:", data);
        alert(data);
    })
    .catch(err => {
        console.error(err);
        alert("Server error");
    });
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

            document.getElementById("email").readOnly = true;
            document.getElementById("otp").readOnly = true;

            let btn = document.getElementById("registerBtn");
            btn.disabled = false;
            btn.classList.remove("opacity-50", "cursor-not-allowed");

            otpVerified = true;

        } else {
            status.innerText = data;
            status.style.color = "red";
        }
    });
}

// block submit
document.querySelector("form").addEventListener("submit", function(e) {
    if (!otpVerified) {
        e.preventDefault();
        alert("Please verify OTP first");
    }
});

</script>

</body>
</html>