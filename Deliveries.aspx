<%@ Page Title="Deliveries" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Deliveries.aspx.cs" Inherits="App.Deliveries" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
    .container {
        margin-top: 30px;
    }

    .form-group {
        margin-bottom: 20px;
    }

    .Delivery-image {
        max-width: 100px;
        max-height: 100px;
    }
</style>
<div class="container">
    <h2>Deliveries - Upload and View</h2>

    <!-- Form to Upload Delivery Data -->
    <div class="card mt-4">
        <div class="card-body">
            <h4 class="card-title">Add Delivery</h4>
            <asp:Label runat="server" ID="Label1" Text="Delivery Name:"></asp:Label>
            <asp:TextBox runat="server" ID="txtDeliveryName" CssClass="form-control" placeholder="Enter Delivery name"></asp:TextBox>
            
            <asp:Label runat="server" ID="Label2" Text="Delivery Email:"></asp:Label>
            <asp:TextBox runat="server" ID="txtDeliveryEmail" CssClass="form-control" placeholder="Enter Delivery email"></asp:TextBox>

            <asp:Label runat="server" ID="Label3" Text="Profile Picture:"></asp:Label>
            <asp:FileUpload runat="server" ID="fuDeliveryImage" CssClass="form-control" />

            <asp:Button runat="server" ID="btnUpload" Text="Upload Delivery" CssClass="btn btn-primary mt-3" />

        </div>
    </div>

    <!-- Display Deliveries -->
    <h3 class="mt-5">Deliveries List</h3>
    <asp:GridView runat="server" ID="gvDeliveries" CssClass="table table-striped" AutoGenerateColumns="False" EmptyDataText="No Deliveries available.">
        <Columns>
            <asp:BoundField DataField="DeliveryName" HeaderText="Delivery Name" SortExpression="DeliveryName" />
            <asp:BoundField DataField="DeliveryEmail" HeaderText="Delivery Email" SortExpression="DeliveryEmail" />
            <asp:ImageField DataImageUrlField="DeliveryImage" HeaderText="Profile Picture" SortExpression="DeliveryImage" ControlStyle-Width="100px" ControlStyle-Height="100px" />
        </Columns>
    </asp:GridView>
</div>
</asp:Content>
