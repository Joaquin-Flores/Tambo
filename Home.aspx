<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Tambo.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tambo - Home Page</title>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400..900;1,400..900&display=swap" rel="stylesheet" />
</head>
<body class="pt-5 mt-4">

    <!-- Header -->
    <header class="fixed-top bg-light shadow-sm">
        <div class="container">
            <div class="d-flex align-items-center justify-content-between">
                <div class="col-3 mb-0">
                    <a href="/Home">
                        <img src="tambo-logo-color.png" class="img-fluid" width="80" alt="Brand logo" />
                    </a>
                </div>

                <ul class="nav nav-pills">
                    <li class="nav-item"><a href="#welcome" class="nav-link active px-2">Welcome</a></li>
                    <li class="nav-item"><a href="#features" class="nav-link px-2">Features</a></li>
                    <li class="nav-item"><a href="#" class="nav-link px-2">Pricing</a></li>
                    <li class="nav-item"><a href="#" class="nav-link px-2">FAQs</a></li>
                    <li class="nav-item"><a href="#" class="nav-link px-2">About</a></li>
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
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="vh-100 align-content-center">
        <div class="container text-center">
            <div class="row">
                <div class="col text-white">
                    <h2 class="display-6 mb-5">Key features of the software</h2>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="card">
                        <h3></h3>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="hero">
        <div class="overlay"></div>
        <div class="col-6">
            <asp:Image ImageUrl="tamboLogo.png" runat="server" />
        </div>
        <div class="col-6">
            <div class="container">
                <h1 class="display-1">Welcome to <span class="fw-bold" style="font-family: 'Playfair Display', serif; font-style: italic;">Tambo</span></h1>
                <h2 class="lead">Your all-in-one farm management dashboard</h2>
                <a href="#features" class="btn btn-primary btn-lg mt-4">Explore Features</a>
            </div>
        </div>
    </section>



    <!-- Features Section -->
    <section class="py-5">
      <div class="container text-center">
        <h2 class="mb-4">Key Features</h2>
        <div class="row">
          <div class="col-md-4 mb-4">
            <div class="feature-box">
              <div class="feature-icon mb-3">
                <i class="fas fa-chart-line"></i>
              </div>
              <h4>Real-Time Analytics</h4>
              <p>Track your farm’s performance with live data and visual reports.</p>
            </div>
          </div>
          <div class="col-md-4 mb-4">
            <div class="feature-box">
              <div class="feature-icon mb-3">
                <i class="fas fa-leaf"></i>
              </div>
              <h4>Crop Management</h4>
              <p>Easily manage your crops, from planting to harvest.</p>
            </div>
          </div>
          <div class="col-md-4 mb-4">
            <div class="feature-box">
              <div class="feature-icon mb-3">
                <i class="fas fa-users"></i>
              </div>
              <h4>Team Collaboration</h4>
              <p>Collaborate with your team to manage tasks and resources efficiently.</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Call-to-Action Section -->
    <section class="py-5 bg-light text-center">
      <div class="container">
        <h2>Ready to take your farm management to the next level?</h2>
        <p class="lead">Sign in to start using Tambo and streamline your operations today!</p>
        <a href="login.aspx" class="btn btn-primary btn-lg">Sign In</a>
      </div>
    </section>

    <!-- Footer Section -->
    <footer class="footer">
      <p>&copy; 2025 Tambo. All rights reserved.</p>
      <p>
        <a href="privacy.html" class="text-white">Privacy Policy</a> | 
        <a href="terms.html" class="text-white">Terms of Service</a>
      </p>
    </footer>
</body>
</html>
