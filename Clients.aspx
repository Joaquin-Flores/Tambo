<%@ Page Title="Clients" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Clients.aspx.cs" Inherits="App.Clients" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .container {
            margin-top: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .client-image {
            max-width: 100px;
            max-height: 100px;
        }
    </style>
    <div class="container">
        <h2>Clients - Upload and View</h2>

        <!-- Form to Upload Client Data -->
        <div class="card mt-4">
            <div class="card-body">
                <h4 class="card-title">Add Client</h4>
                <asp:Label runat="server" ID="Label1" Text="Client Name:"></asp:Label>
                <asp:TextBox runat="server" ID="txtClientName" CssClass="form-control" placeholder="Enter client name"></asp:TextBox>
                
                <asp:Label runat="server" ID="Label2" Text="Client Email:"></asp:Label>
                <asp:TextBox runat="server" ID="txtClientEmail" CssClass="form-control" placeholder="Enter client email"></asp:TextBox>

                <asp:Label runat="server" ID="Label3" Text="Profile Picture:"></asp:Label>
                <asp:FileUpload runat="server" ID="fuClientImage" CssClass="form-control" />

                <asp:Button runat="server" ID="btnUpload" Text="Upload Client" CssClass="btn btn-primary mt-3" />

            </div>
        </div>

        <!-- Display Clients -->
        <h3 class="mt-5">Clients List</h3>
        <asp:GridView runat="server" ID="gvClients" CssClass="table table-striped" AutoGenerateColumns="False" EmptyDataText="No clients available.">
            <Columns>
                <asp:BoundField DataField="ClientName" HeaderText="Client Name" SortExpression="ClientName" />
                <asp:BoundField DataField="ClientEmail" HeaderText="Client Email" SortExpression="ClientEmail" />
                <asp:ImageField DataImageUrlField="ClientImage" HeaderText="Profile Picture" SortExpression="ClientImage" ControlStyle-Width="100px" ControlStyle-Height="100px" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
