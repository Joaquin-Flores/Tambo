<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sign-up.aspx.cs" Inherits="Tambo.Sign_up" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tambo - Sign-up</title>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500&display=swap" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400..900;1,400..900&display=swap" rel="stylesheet" />
</head>
<body>

    <!-- Features Section -->
    <section id="features" class="vh-100 align-content-center bg-gradient bg-primary-subtle">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="card w-50 m-auto p-5">
                        <h1 class="text-center">Create your account</h1>
                        <label>Enter email address</label>
                        <input type="email" name="Email" value="" class="form-control m-3" />
                        <label>Password</label>
                        <input type="password" name="Password" value="" class="form-control m-3" />
                        <button class="btn btn-primary btn-lg m-3">Create account</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer Section -->
    <footer class="bg-dark py-3">
        <div class="container text-center text-white">
            <p>&copy; 2025 Tambo. All rights reserved.</p>
            <p>Designed by <a class="text-white" href="https://github.com/Joaquin-Flores">Joaquín Flores</a></p>
        </div>
    </footer>

</body>
</html>
