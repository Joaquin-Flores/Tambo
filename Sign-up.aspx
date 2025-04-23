<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sign-up.aspx.cs" Inherits="Tambo.Sign_up" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tambo - Sign-up</title>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="Content/Font-Awesome/css/all.min.css" rel="stylesheet" />
    <link href="Content/Fonts/fonts.css" rel="stylesheet" />
</head>
<body>

    <!-- Sign-up Card Section -->
    <section class="vh-100 align-content-center bg-gradient bg-primary-subtle"> 
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-7">
                    <div class="card p-5">
                        <h1 class="text-center text-gray-900 my-4">Create your account</h1>
                        <form class="user">
                            <div class="form-group row">
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Name" />
                                </div>
                                <div class="col">
                                    <input type="text" class="form-control" placeholder="Last name" />
                                </div>
                            </div>
                            <div class="form-group my-4">
                                <input type="email" class="form-control form-control-user" placeholder="Email Address"/>
                            </div>
                            <div class="form-group row mb-4">
                                <div class="col">
                                    <input type="password" class="form-control" placeholder="Password" />
                                </div>
                                <div class="col">
                                    <input type="password" class="form-control" placeholder="Repeat password" />
                                </div>
                            </div>
                            <a href="/" class="btn btn-primary w-100 p-2">Register</a>
                            <hr/>
                            <a href="/" class="btn btn-danger w-100 mb-3">
                                <i class="fa-brands fa-google"></i> Register with Google
                            </a>
                            <a href="/" class="btn btn-outline-primary w-100">
                                <i class="fa-brands fa-facebook"></i> Register with Facebook
                            </a>
                        </form>
                        <hr/>
                        <a class="text-center" href="/Login">Already have an account? Login</a>
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
