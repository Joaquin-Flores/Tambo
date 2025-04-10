<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="App._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
  <style>
    body {
      font-family: 'Roboto', sans-serif;
    }
    .hero {
      background: url('https://images.unsplash.com/9/fields.jpg?q=80&w=1280&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D') no-repeat center center ;
      background-size: cover;
      border-radius: 10px;
      color: #fff;
      padding: 100px 0;
      text-align: center;
      position: relative;
      overflow: hidden;
    }
    .overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0, 0, 0, 0.6);
        z-index: 1;
    }
    .hero .container {
        position: relative;
        z-index: 2;
    }
    .feature-icon {
      font-size: 3rem;
      color: #4CAF50;
    }
    .feature-box {
      padding: 30px;
      background-color: #f8f9fa;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    .feature-box:hover {
      transform: scale(1.05);
      transition: transform 0.3s ease-in-out;
    }
    .footer {
      background-color: #343a40;
      color: #fff;
      padding: 40px 0;
      text-align: center;
    }
    .btn-primary {
      background-color: #28a745;
      border-color: #28a745;
    }
    .btn-primary:hover {
      background-color: #218838;
      border-color: #1e7e34;
    }
  </style>

  <!-- Hero Section -->
  <section class="hero">
      <div class="overlay"></div>
    <div class="container">
      <h1 class="display-1">Welcome to <span class="fw-bold" style="font-family: 'Playfair Display', serif; font-style: italic;">Tambo</span></h1>
      <p class="lead">Your all-in-one farm management dashboard</p>
      <a href="#features" class="btn btn-primary btn-lg mt-4">Explore Features</a>
    </div>
  </section>

  <!-- Features Section -->
  <section id="features" class="py-5">
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
</asp:Content>
