<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="App.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .container {
            max-width: 400px;
        }
        .links a {
            color: #5555FF;
            text-decoration: underline;
            display: block;
            text-align: center;
            margin: 5px;
        }

        .background {
            height: 80vh;
            border-radius: 10px;
            align-content:center;
        }

        .login-form {
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .login-form h1 {
            margin-bottom: 20px;
            text-align: center;
            font-size: 30px;
            font-weight: 700;
        }

        .login-form .form-group {
            margin-bottom: 15px;
        }

        .login-form .btn-primary {
            width: 100%;
        }

        .alert {
            display: none;
        }
    </style>
    <div class="bg-gradient bg-primary background">
        <div class="container">

            <!-- Login Form -->
            <div class="card shadow-lg">
                <div class="card-body">
                    <h1>Login</h1>

                    <!-- Error message for invalid login -->
                    <div class="alert alert-danger" id="errorMessage" role="alert">
                        Invalid username or password.
                    </div>

                    <!-- Form elements -->
                    <asp:Label runat="server" ID="lblUsername" Text="Username" CssClass="form-label"></asp:Label>
                    <asp:TextBox runat="server" ID="txtUsername" CssClass="form-control" placeholder="Enter your username" />

                    <asp:Label runat="server" ID="lblPassword" Text="Password" CssClass="form-label"></asp:Label>
                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" placeholder="Enter your password" />
                    <div class="links">
                        <a href="/">Forgot your password?</a>
                        <a href="/">First time here? Register</a>
                    </div>

                    <asp:Button runat="server" ID="btnLogin" Text="Login" CssClass="btn btn-primary mt-4"/>
                </div>
            </div>

        </div>
    </div>
</asp:Content>
