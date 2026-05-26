<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>
    Verify OTP
</title>

<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-gray-100 min-h-screen flex items-center justify-center px-4">

    <div class="w-full max-w-md">

        <!-- CARD -->

        <div class="bg-white border border-gray-200 rounded-xl shadow-sm p-8">

            <!-- HEADER -->

            <div class="text-center mb-8">

                <h1 class="text-2xl font-semibold text-gray-800">

                    Verify OTP

                </h1>

                <p class="text-sm text-gray-500 mt-2 leading-relaxed">

                    We've sent a 6-digit verification code
                    to your registered email address.

                </p>

            </div>

            <!-- ERROR MESSAGE -->

            <%

                String error =
                        request.getParameter("error");

                if ("invalid".equals(error)) {

            %>

                <div class="mb-5 bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-lg">

                    Invalid OTP. Please try again.

                </div>

            <%

                } else if ("expired".equals(error)) {

            %>

                <div class="mb-5 bg-red-50 border border-red-200 text-red-600 text-sm px-4 py-3 rounded-lg">

                    OTP expired. Please request again.

                </div>

            <%

                }

            %>

            <!-- FORM -->

            <form action="VerifyOtpServlet"
                  method="post">

                <!-- OTP BOXES -->

                <div class="flex justify-center gap-2 mb-6">

                    <input type="text"
                           maxlength="1"
                           class="otp-box w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-700 outline-none">

                    <input type="text"
                           maxlength="1"
                           class="otp-box w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-700 outline-none">

                    <input type="text"
                           maxlength="1"
                           class="otp-box w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-700 outline-none">

                    <input type="text"
                           maxlength="1"
                           class="otp-box w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-700 outline-none">

                    <input type="text"
                           maxlength="1"
                           class="otp-box w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-700 outline-none">

                    <input type="text"
                           maxlength="1"
                           class="otp-box w-12 h-12 text-center text-lg rounded-lg border border-gray-300 focus:ring-2 focus:ring-green-700 outline-none">

                </div>

                <!-- HIDDEN OTP -->

                <input type="hidden"
                       name="otp"
                       id="finalOtp">

                <!-- BUTTON -->

                <button type="submit"
                        class="w-full bg-green-700 hover:bg-green-800 text-white py-3 rounded-lg transition">

                    Verify OTP

                </button>

            </form>

            <!-- RESEND -->

            <div class="text-center mt-5 text-sm text-gray-500">

                Didn't receive the OTP?

                <span id="resendText"
                      class="text-green-700 font-medium">
                </span>

            </div>

        </div>

        <!-- BACK -->

        <div class="text-center mt-6">

            <a href="forgotpass.jsp"
               class="text-sm text-gray-600 hover:text-green-700 transition">

                ← Back to Forgot Password

            </a>

        </div>

    </div>

<script>

const resendText =
document.getElementById("resendText");

function updateTimer() {

    const expiry =
        localStorage.getItem("otpExpiry");

    if (!expiry) {

        resendText.innerHTML =
            "Request OTP again";

        return;
    }

    const now =
        new Date().getTime();

    const remaining =
        expiry - now;

    if (remaining <= 0) {

        resendText.innerHTML =
            "<a href='forgotpass.jsp' class='text-green-700 font-semibold'>Resend OTP</a>";

        return;
    }

    const seconds =
        Math.floor(remaining / 1000);

    resendText.innerHTML =
        "Resend in 00:"
        + (seconds < 10 ? "0" : "")
        + seconds;

    setTimeout(updateTimer, 1000);
}

updateTimer();

const inputs =
document.querySelectorAll(".otp-box");

const finalOtp =
document.getElementById("finalOtp");

inputs[0].focus();

inputs.forEach((input, index) => {

    input.addEventListener("input", () => {

        input.value =
            input.value.replace(/[^0-9]/g, "");

        if (input.value
                && index < inputs.length - 1) {

            inputs[index + 1].focus();
        }
    });

    input.addEventListener("keydown", (e) => {

        if (e.key === "Backspace"
                && !input.value
                && index > 0) {

            inputs[index - 1].focus();
        }
    });
});

document.querySelector("form")
.addEventListener("submit", function (e) {

    let otp = "";

    inputs.forEach(input => {

        otp += input.value;
    });

    if (otp.length < 6) {

        e.preventDefault();

        alert("Please enter complete OTP");

        return;
    }

    finalOtp.value = otp;
});

</script>

</body>

</html>