<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.mangalam.dao.DashboardDAO" %>

<%

// SECURITY

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

// ADMIN CHECK

if (session.getAttribute("userEmail") == null
        || !"ADMIN".equals(
                session.getAttribute("userRole")
        )) {

    response.sendRedirect("login.jsp");

    return;
}

// DASHBOARD DATA

DashboardDAO dao =
        new DashboardDAO();

double totalSales =
        dao.getTotalSales();

int productsSold =
        dao.getProductsSold();

int totalUsers =
        dao.getTotalUsers();

%>

<%

String currentPage = "dashboard";

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>
    Admin Dashboard
</title>

<script src="https://cdn.tailwindcss.com"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
      rel="stylesheet">

</head>

<body class="bg-gray-100 font-sans">

<div class="flex h-screen overflow-hidden">

    <!-- SIDEBAR -->

    <aside class="w-64 bg-white shadow-xl flex flex-col z-10">

        <!-- LOGO -->

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

        <!-- LOGOUT -->

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

    <!-- MAIN -->

    <main class="flex-1 p-10 overflow-y-auto">

        <!-- HEADER -->

        <div class="mb-10">

            <h2 class="text-3xl font-bold text-green-800 mb-6">Admin Dashboard</h2>

            <p class="text-sm text-slate-400 font-medium mt-2">

                Monitor platform growth and sales analytics.

            </p>

        </div>

       <!-- STATS -->

<div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">

    <!-- TOTAL SALES -->

    <div class="bg-white border border-gray-200 rounded-xl p-6">

        <div class="flex items-center justify-between">

            <div>

                <p class="text-sm text-gray-500 font-medium">

                    Total Sales

                </p>

                <h3 class="text-3xl font-semibold text-green-600 mt-3">

                    ₹<%= totalSales %>

                </h3>

            </div>

            <div class="w-14 h-14 rounded-xl bg-green-100 flex items-center justify-center">

                <span class="material-symbols-outlined text-green-600 text-2xl">

                    monitoring

                </span>

            </div>

        </div>

    </div>

    <!-- PRODUCTS SOLD -->

    <div class="bg-white border border-gray-200 rounded-xl p-6">

        <div class="flex items-center justify-between">

            <div>

                <p class="text-sm text-gray-500 font-medium">

                    Products Sold

                </p>

                <h3 class="text-3xl font-semibold text-blue-600 mt-3">

                    <%= productsSold %>

                </h3>

            </div>

            <div class="w-14 h-14 rounded-xl bg-blue-100 flex items-center justify-center">

                <span class="material-symbols-outlined text-blue-600 text-2xl">

                    inventory_2

                </span>

            </div>

        </div>

    </div>

    <!-- TOTAL USERS -->

    <div class="bg-white border border-gray-200 rounded-xl p-6">

        <div class="flex items-center justify-between">

            <div>

                <p class="text-sm text-gray-500 font-medium">

                    Total Users

                </p>

                <h3 class="text-3xl font-semibold text-purple-600 mt-3">

                    <%= totalUsers %>

                </h3>

            </div>

            <div class="w-14 h-14 rounded-xl bg-purple-100 flex items-center justify-center">

                <span class="material-symbols-outlined text-purple-600 text-2xl">

                    groups

                </span>

            </div>

        </div>

    </div>

</div>

       <!-- CHART CARD -->

<div class="bg-white border border-gray-200 rounded-xl p-6">

    <!-- HEADER -->

    <div class="flex items-center justify-between mb-6">

        <div>

            <h3 class="text-xl font-semibold text-gray-800">

                Analytics Overview

            </h3>

            <p class="text-sm text-gray-500 mt-1">

                Sales and platform performance metrics.

            </p>

        </div>

        <div class="px-3 py-1 bg-green-100 text-green-700 text-xs rounded-md font-medium">

            Overview

        </div>

    </div>

    <!-- CHART -->

    <div class="h-[320px]">

        <canvas id="dashboardChart"></canvas>

    </div>

</div>

<!-- CHART SCRIPT -->

<script>

const ctx =
document.getElementById('dashboardChart');

new Chart(ctx, {

    type: 'bar',

    data: {

        labels: [

            'Products Sold',
            'Total Users',
            'Revenue'

        ],

        datasets: [{

            label: 'Analytics',

            data: [

                <%= productsSold %>,
                <%= totalUsers %>,
                <%= (int)(totalSales / 1000) %>

            ],

            backgroundColor: [

                '#16a34a',
                '#2563eb',
                '#f59e0b'

            ],

            borderRadius: 6,

            barThickness: 50

        }]
    },

    options: {

        responsive: true,

        maintainAspectRatio: false,

        animation: {

            duration: 800
        },

        plugins: {

            legend: {

                display: false
            },

            tooltip: {

                backgroundColor: '#111827',

                titleColor: '#ffffff',

                bodyColor: '#ffffff',

                padding: 12,

                cornerRadius: 6
            }
        },

        scales: {

            y: {

                beginAtZero: true,

                grid: {

                    color: '#f1f5f9'
                },

                border: {

                    display: false
                },

                ticks: {

                    color: '#6b7280',

                    font: {

                        size: 12
                    }
                }
            },

            x: {

                grid: {

                    display: false
                },

                border: {

                    display: false
                },

                ticks: {

                    color: '#6b7280',

                    font: {

                        size: 12,
                        weight: '500'
                    }
                }
            }
        }
    }
});

</script>
</body>

</html>