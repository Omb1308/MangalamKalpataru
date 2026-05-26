<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Error - Something went wrong</title>

<!-- Tailwind CSS CDN -->
<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-gray-100 flex items-center justify-center min-h-screen">

    <div class="text-center">

        <!-- Icon Circle -->
        <div class="relative mx-auto w-24 h-24 rounded-full bg-gray-200 flex items-center justify-center mb-6">
            
            <!-- Plant Icon -->
            <span class="text-3xl">🪴</span>

            <!-- Red Cross -->
            <div class="absolute top-0 right-0 bg-red-600 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm font-bold">
                ×
            </div>
        </div>

        <!-- Heading -->
        <h1 class="text-4xl font-bold text-green-900 mb-3">
            Something went wrong.
        </h1>

        <!-- Sub Text -->
        <p class="text-gray-600 mb-8">
            Please try again later or go back to home.
        </p>

        <!-- Button -->
        <a href="index.jsp"
           class="inline-block bg-green-900 text-white px-6 py-3 rounded-lg font-semibold hover:bg-green-800 transition">
            Back to Home
        </a>

        <!-- Footer Text -->
        <div class="mt-12 text-gray-400 text-sm flex items-center justify-center gap-2">
            <span>◌</span>
            <span>CURATED ECOSYSTEM</span>
        </div>

    </div>

</body>
</html>