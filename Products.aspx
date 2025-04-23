<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="App.Products" %>
<asp:Content ID="Products" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid p-5">
        <h1>Products</h1>
        <!-- DataTables part -->
        <div class="row justify-content-center m-3">
            <div class="card shadow p-3">
                <asp:Literal ID="ltTable" runat="server" />
            </div>
        </div>

        <!-- 2 cards -->
        <div class="row">

            <div class="col">

                <!-- card is for adding new products -->
                <div class="card p-3 text-center shadow">
                    <h2>Add New Product</h2>
                    <div id="addProductForm" runat="server">
                        <div>
                            <input class="form-control m-3 mx-auto" type="text" id="productName" name="productName" runat="server" placeholder="Name:" />
                        </div>
                        <div>
                            <input class="form-control m-3 mx-auto" type="text" id="productDescription" name="productDescription" runat="server" placeholder="Description:" />
                        </div>
                        <div>
                            <input class="form-control m-3 mx-auto" type="number" id="productPrice" name="productPrice" runat="server" step="0.01" placeholder="Unit Price:" />
                        </div>
                        <div>
                            <input class="form-control m-3 mx-auto" type="number" id="productStock" name="productStock" runat="server" placeholder="Stock Quantity:" />
                        </div>
                        <div>
                            <input class="form-control m-3 mx-auto" type="text" id="productCategory" name="productCategory" runat="server" placeholder="Category:" />
                        </div>
                        <div>
                            <input class="form-control m-3 mx-auto" type="text" id="productShape" name="productShape" runat="server" placeholder="Shape:" />
                        </div>
                        <div>
                            <button class="btn btn-primary" type="submit" runat="server" onserverclick="AddProduct_Click">Add Product</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>

    </div>
    <script>
    $(document).ready(function () {
        $('#myTable').DataTable();
    });
    </script>
</asp:Content>
