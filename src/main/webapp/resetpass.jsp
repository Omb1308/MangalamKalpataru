<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

    // =========================
    // SECURITY CHECK
    // =========================

    Boolean verified =
            (Boolean) session.getAttribute("otpVerified");

    if (verified == null || !verified) {

        response.sendRedirect(
                "forgotpass.jsp?msg=Please verify OTP first."
        );

        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Reset Password
</title>

<!-- Tailwind -->

<script src="https://cdn.tailwindcss.com"></script>

<!-- Google Font -->

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap"
      rel="stylesheet">

<style>

body {

    font-family: 'Inter', sans-serif;
}

#strengthBar {

    transition: all 0.3s ease;
}

</style>

</head>

<body class="bg-gray-100">

<!-- NAVBAR -->

<jsp:include page="all_com/navbar.jsp" />

<!-- MAIN -->

<main class="flex items-center justify-center min-h-[80vh] px-4">

<div class="w-full max-w-md">

    <!-- HEADING -->

    <p class="text-xs tracking-widest text-gray-500 mb-2">

        SECURITY PROTOCOLS

    </p>

    <h1 class="text-3xl font-bold text-green-800 mb-2">

        Reset Password

    </h1>

    <p class="text-gray-600 text-sm mb-6">

        Create a strong new password for your account.

    </p>

    <!-- ERROR MESSAGE -->

    <%

    String error =
            request.getParameter("error");

    if ("mismatch".equals(error)) {

    %>

        <div class="bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 text-sm">

            Passwords do not match.

        </div>

    <%

    } else if ("weak".equals(error)) {

    %>

        <div class="bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 text-sm">

            Password must be at least 6 characters.

        </div>

    <%

    } else if ("failed".equals(error)) {

    %>

        <div class="bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 text-sm">

            Failed to update password.

        </div>

    <%

    } else if ("server".equals(error)) {

    %>

        <div class="bg-red-100 border border-red-200 text-red-700 px-4 py-3 rounded-lg mb-4 text-sm">

            Server error occurred.

        </div>

    <%

    }

    %>

    <!-- CARD -->

    <div class="bg-white shadow-lg rounded-xl p-6">

        <!-- FORM -->

        <form action="ResetPasswordServlet"
              method="post">

            <!-- NEW PASSWORD -->

            <label class="text-xs text-gray-500">

                NEW PASSWORD

            </label>

            <input type="password"
                   name="password"
                   id="newPassword"
                   placeholder="Enter new password"
                   class="w-full mt-2 mb-2 bg-white border border-gray-300 px-4 py-3 rounded-md focus:ring-2 focus:ring-green-700 outline-none"
                   required>

            <!-- STRENGTH BAR -->

            <div class="h-1 bg-gray-200 rounded">

                <div id="strengthBar"
                     class="h-1 bg-red-500 rounded w-1/4">
                </div>

            </div>

            <p id="strengthText"
               class="text-xs text-right text-red-500 mt-1">

                WEAK

            </p>

            <!-- CONFIRM PASSWORD -->

            <label class="text-xs text-gray-500 mt-6 block">

                CONFIRM PASSWORD

            </label>

            <input type="password"
                   name="confirmPassword"
                   id="confirmPassword"
                   placeholder="Confirm password"
                   class="w-full mt-2 bg-white border border-gray-300 px-4 py-3 rounded-md focus:ring-2 focus:ring-green-700 outline-none"
                   required>

            <!-- BUTTON -->

            <button type="submit"
                    class="w-full mt-6 bg-green-800 hover:bg-green-900 text-white py-3 rounded-md transition">

                Update Password →

            </button>

        </form>

    </div>

</div>

</main>

<!-- FOOTER -->

<jsp:include page="all_com/footer.jsp" />

<!-- PASSWORD STRENGTH -->

<script>

document.getElementById("newPassword")
.addEventListener("input", function () {

    const val =
        this.value;

    const bar =
        document.getElementById("strengthBar");

    const text =
        document.getElementById("strengthText");

    let s = 0;

    if (val.length >= 6) s++;

    if (/[A-Z]/.test(val)) s++;

    if (/[0-9]/.test(val)) s++;

    if (/[@$!%*?&]/.test(val)) s++;

    if (s <= 1) {

        bar.style.width = "25%";

        bar.style.backgroundColor = "#ef4444";

        text.textContent = "WEAK";

        text.style.color = "#ef4444";
    }

    else if (s === 2) {

        bar.style.width = "50%";

        bar.style.backgroundColor = "#f59e0b";

        text.textContent = "MEDIUM";

        text.style.color = "#f59e0b";
    }

    else {

        bar.style.width = "75%";

        bar.style.backgroundColor = "#22c55e";

        text.textContent = "STRONG";

        text.style.color = "#22c55e";
    }

});

</script>

<!-- DISABLE BACK -->

<script>

history.pushState(
    null,
    null,
    location.href
);

window.onpopstate = function () {

    history.go(1);
};

</script>

</body>

</html>