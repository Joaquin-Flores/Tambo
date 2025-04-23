<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Forgot-password.aspx.cs" Inherits="Tambo.Forgot_password" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Tambo - Reset your password</title>
    <script src="Scripts/bootstrap.js"></script>
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/Bootstrap/bootstrap.css" rel="stylesheet" />
    <link href="Content/Font-Awesome/css/all.min.css" rel="stylesheet" />
    <link href="Content/Fonts/fonts.css" rel="stylesheet" />
</head>
<body>

    <section class="vh-100 align-content-center bg-gradient bg-primary-subtle">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-7">
                    <div class="card p-5">
                        <h1 class="text-center text-gray-900 my-4">Forgot Your Password?</h1>
                        <p class="lead m-2">We get it, stuff happens. Just enter your email address below and we'll send you a link to reset your password!</p>
                        <form class="user">
                            <div class="form-group my-4">
                                <input type="email" class="form-control form-control-user" placeholder="Email Address"/>
                            </div>
                            <label></label>
                            <a href="/" class="btn btn-primary w-100 p-2">Reset password</a>
                        </form>
                        <hr/>
                        <a class="text-center" href="/Login">Already have an account? Login</a>
                        <a class="text-center" href="/Sign-up">Create an account</a>
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
