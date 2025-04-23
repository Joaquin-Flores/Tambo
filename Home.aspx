<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Tambo.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tambo - Home Page</title>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="Content/Font-Awesome/css/all.min.css" rel="stylesheet" />
    <link href="/Content/Fonts/fonts.css" rel="stylesheet" />
    
</head>
<body data-bs-spy="scroll" data-bs-offset="0" tabindex="0" data-bs-target="#navbar" class="pt-5 mt-4" style="position:relative;">

    <!-- Header -->
    <header class="fixed-top bg-light shadow-sm">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between">
                <div class="col-3 mb-0">
                    <a href="/Home">
                        <img src="Content/Images/Logo/tambo-logo-dark.png" class="img-fluid m-3" width="50" alt="Brand logo" />
                    </a>
                </div>

                <ul id="navbar" class="nav nav-pills">
                    <li class="nav-item"><a href="#welcome" class="nav-link px-2">Welcome</a></li>
                    <li class="nav-item"><a href="#features" class="nav-link px-2">Features</a></li>
                    <li class="nav-item"><a href="#about" class="nav-link px-2">About</a></li>
                </ul>

                <div class="col-3 text-end">
                    <a class="btn btn-outline-primary me-2" href="/Login">Login</a>
                    <a class="btn btn-primary" href="/Sign-up">Sign-up</a>
                </div>
            </div>
        </div>
    </header>

    <!-- Hero Section-->
    <section id="welcome" class="vh-100 bg-gradient bg-warning-subtle align-content-center">
        <div class="container">
            <div class="row">
                <div class="col">
                    <img src="tambo-logo-color.png" class="img-fluid" alt="Brand Logo" />
                </div>
                <div class="col">
                    <h1 class="display-1">WELCOME TO 
                        <span class="tambo-hero-title">Tambo</span>
                    </h1>
                    <h2 class="display-6">Your all-in-one farm management app</h2>
                    <a class="btn btn-lg btn-primary mt-5" href="/Sign-up">Sign-up</a>
                    <a class="btn btn-lg btn-outline-secondary ms-3 mt-5" href="#features">See more</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="vh-100 align-content-center features">
        <div class="container text-center">
            <div class="row">
                <div class="col text-white">
                    <h2 class="display-6 mb-5 fw-bold">Key features of the software</h2>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="card">
                        <div>
                          <i class="fa-solid fa-chart-line my-4" style="font-size: 3rem; color: #4CAF50;"></i>
                        </div>
                        <h3>Real-Time Analytics</h3>
                        <p class="p-2">Track your farm’s performance with live data and visual reports.</p>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div>
                          <i class="fa-solid fa-cow my-4" style="font-size: 3rem; color: #4CAF50;"></i>
                        </div>
                        <h3>Livestock Management</h3>
                        <p class="p-2">Effortlessly track your livestock inventory, monitor statuses, and stay updated on progress in real-time.</p>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <div>
                          <i class="fa-solid fa-comment-dots my-4" style="font-size: 3rem; color: #4CAF50;"></i>
                        </div>
                        <h3>Smart Reminders</h3>
                        <p class="p-2">Stay on top of your daily responsibilities with intelligent reminders and activity tracking.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="bg-gradient bg-success-subtle vh-100">
        <div class="container">
            <h1 class="p-5 display-1 text-center fw-bold">About us</h1>
            <p class="lead p-5">We’re a small, hands-on farm on the heart of Patagonia,  dedicated to raising animals with care. Run by two friends turned partners, our mission is simple: produce honest, high-quality food the old-fashioned way.</p>
            <div class="text-center">
                <img class="shadow-lg" src="https://content.yourcareer.gov.au/sites/default/files/2022-12/841514-poultryfarmworker.jpg" alt="poultry farm worker" />
            </div>
        </div>
    </section>

    <!-- Call-to-Action Section -->
    <section class="py-5 bg-light text-center m-0">
      <div class="container">
        <h2>Ready to take your farm management to the next level?</h2>
        <p class="lead">Sign in to start using Tambo and streamline your operations today!</p>
        <a href="/Sign-up" class="btn btn-primary btn-lg">Sign-up</a>
      </div>
    </section>

    <!-- Footer Section -->
    <footer class="bg-dark py-3">
        <div class="container text-center text-white">
            <p>&copy; 2025 Tambo. All rights reserved.</p>
            <p>Designed by <a class="text-white" href="https://github.com/Joaquin-Flores">Joaquín Flores</a></p>
        </div>
    </footer>

    <!-- Scroll-to-top Button -->
    <a onclick="scrollToTop()" class="scroll-to-top " href="javascript:void(0);" ><i class="fa-solid fa-angle-up"></i></a>
    <script type="text/javascript">
    function scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }
    </script>

</body>
</html>
