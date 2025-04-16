<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="App.Products" %>
<asp:Content ID="Products" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid p-5">
        <h1>Products</h1>

        <!-- 2 cards -->
        <div class="row">

            <!-- 1st card is for filtering the table -->
            <div class="col">   
                <div class="card p-3 text-center shadow">

                    <h2>Filters</h2>
                    <div>
                        
                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtName" runat="server" placeholder="Name Contains:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtDescription" runat="server" placeholder="Description Contains:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtCategory" runat="server" placeholder="Category:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtShape" runat="server" placeholder="Shape:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtMinPrice" runat="server" placeholder="Min Price:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtMaxPrice" runat="server" placeholder="Max Price:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtMinStock" runat="server" placeholder="Min Stock:" />

                        <asp:TextBox CssClass="form-control m-3 mx-auto" ID="txtMaxStock" runat="server" placeholder="Max Stock:" />

                        <asp:Button ID="btnFilter" CssClass="btn btn-primary" runat="server" Text="Apply Filters" OnClick="btnFilter_Click" />
                        <asp:Button ID="btnClear" CssClass="btn btn-primary" runat="server" Text="Clear Filters" OnClick="btnClear_Click" />
                    </div>

                </div>
            </div>

            <div class="col">

                <!-- 2nd card is for adding new products -->
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


        <!-- Table -->
        <div class="row">
            <div class="card my-5 p-5 text-center shadow">
                <asp:GridView CssClass="table table-striped" ID="gvProducts" runat="server" AutoGenerateColumns="true" />
            </div>
        </div>

    </div>
    
</asp:Content>
