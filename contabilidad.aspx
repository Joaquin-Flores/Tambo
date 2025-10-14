<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contabilidad.aspx.cs" Inherits="Tambo.contabilidad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <!-- Title Section -->
    <section class="p-4 pb-0">
        <div>
            <h1><i class="fa fa-money-bill"></i> Contabilidad</h1>
        </div>
    </section>

    <!-- Tarjeta: Resumen financiero -->
    <section class="p-4 pb-0">
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h2 class="mb-3">Resumen Financiero</h2>
            <div class="row text-center">
                <div class="col-md-4 mb-3">
                    <div class="p-3 bg-success rounded">
                        <h3>Ingresos</h3>
                        <p class="h3">
                            <asp:Literal id="litIngresos" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 bg-danger rounded">
                        <h3>Egresos</h3>
                        <p class="h3">
                            <asp:Literal id="litEgresos" runat="server" />
                        </p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 bg-secondary rounded">
                        <h3>Balance</h3>
                        <p class="h3">
                            <asp:Literal id="LitBalance" runat="server" />
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Tabla de gastos -->
    <section class="p-4 py-3">
        <div class="card light-text bg-card p-5">
            <div class="d-flex justify-content-between pb-2">
                <h2>Gastos</h2>
                <a href="#formularioGasto" class="btn btn-primary btn-lg">+ Agregar Gasto</a>
            </div>
            <div class="table-responsive">
                <table id="tablaGastos" class="table-dark table-hover">
                    <thead>
                        <tr class="bg-card">
                            <th>ID</th>
                            <th>Categoría</th>
                            <th>Fecha</th>
                            <th>Monto</th>
                            <th>Descripción</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="tablaBodyLiteral" runat="server"></asp:Literal>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
        $(document).ready(function () {
            $('#tablaGastos').DataTable({
                "language": {
                    "url": "Content/DataTables/datatables_esp.json"
                },
                "pageLength": 5
            });
        });
    </script>

    <!-- Formulario agregar gasto -->
    <section class="p-4 py-3 w-100" id="formularioGasto">
        <div class="card light-text bg-card p-5">
            <h2>Agregar Nuevo Gasto</h2>
            <div>
                <div class="row mb-3">
                    <div class="col-md-3">
                        <label for="ddlCategoriaGasto" class="form-label">Categoría</label>
                        <asp:DropDownList runat="server" ID="ddlCategoriaGasto" CssClass="form-select"></asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <label for="idFechaGasto" class="form-label">Fecha del Gasto</label>
                        <asp:TextBox runat="server" ID="idFechaGasto" TextMode="Date" CssClass="form-control" />
                    </div>
                    <div class="col-md-3">
                        <label for="idMontoGasto" class="form-label">Monto del Gasto</label>
                        <asp:TextBox runat="server" ID="idMontoGasto" TextMode="Number" CssClass="form-control" />
                    </div>
                    <div class="col-md-3">
                        <label for="idDescripcionGasto" class="form-label">Descripción del Gasto</label>
                        <asp:TextBox runat="server" ID="idDescripcionGasto" CssClass="form-control" placeholder="10L de gasoil..." />
                    </div>
                </div>
                
                <asp:Button runat="server" Text="+ Agregar Gasto" CssClass="btn btn-primary btn-lg" OnClick="agregarGasto_Click" />
                <asp:Label ID="lblMensaje" runat="server" CssClass="text-success ms-3"></asp:Label>

            </div>
        </div>
    </section>
    

</asp:Content>
