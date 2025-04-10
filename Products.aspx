<%@ Page Title="Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="App.Products" %>
<asp:Content ID="Products" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .container {
        margin-top: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .Product-image {
        max-width: 100px;
        max-height: 100px;
    }
</style>
<div class="container">
    <h2>Products - Upload and View</h2>

    <!-- Form to Upload Product Data -->
    <div class="card mt-4">
        <div class="card-body">
            <h4 class="card-title">Add Product</h4>
            <asp:Label runat="server" ID="Label1" Text="Product Name:"></asp:Label>
            <asp:TextBox runat="server" ID="txtProductName" CssClass="form-control" placeholder="Enter Product name"></asp:TextBox>
            
            <asp:Label runat="server" ID="Label2" Text="Product Email:"></asp:Label>
            <asp:TextBox runat="server" ID="txtProductEmail" CssClass="form-control" placeholder="Enter Product email"></asp:TextBox>

            <asp:Label runat="server" ID="Label3" Text="Profile Picture:"></asp:Label>
            <asp:FileUpload runat="server" ID="fuProductImage" CssClass="form-control" />

            <asp:Button runat="server" ID="btnUpload" Text="Upload Product" CssClass="btn btn-primary mt-3" />

        </div>
    </div>

    <!-- Display Products -->
    <h3 class="mt-5">Products List</h3>
    <asp:GridView runat="server" ID="gvProducts" CssClass="table table-striped" AutoGenerateColumns="False" EmptyDataText="No Products available.">
        <Columns>
            <asp:BoundField DataField="ProductName" HeaderText="Product Name" SortExpression="ProductName" />
            <asp:BoundField DataField="ProductEmail" HeaderText="Product Email" SortExpression="ProductEmail" />
            <asp:ImageField DataImageUrlField="ProductImage" HeaderText="Profile Picture" SortExpression="ProductImage" ControlStyle-Width="100px" ControlStyle-Height="100px" />
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
