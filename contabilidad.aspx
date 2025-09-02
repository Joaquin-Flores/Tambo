<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="contabilidad.aspx.cs" Inherits="Tambo.contabilidad" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">

        <!-- Título principal -->
        <h1 class="mb-4">Contabilidad</h1>

        <!-- Tarjeta: Información general -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Información General</h3>
            <p class="muted-text">
                En este módulo podrás llevar el control de ingresos y egresos del campo, 
                así como revisar balances y generar reportes financieros.
            </p>
        </div>

        <!-- Tarjeta: Resumen financiero -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Resumen Financiero</h3>
            <div class="row text-center">
                <div class="col-md-4 mb-3">
                    <div class="p-3 bg-success rounded">
                        <h4>Ingresos</h4>
                        <p class="h3">$ 25,000</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 bg-danger rounded">
                        <h4>Egresos</h4>
                        <p class="h3">$ 12,500</p>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="p-3 bg-secondary rounded">
                        <h4>Balance</h4>
                        <p class="h3">$ 12,500</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tarjeta: Movimientos recientes -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Movimientos Recientes</h3>
            <table class="table table-dark table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Concepto</th>
                        <th>Tipo</th>
                        <th>Monto</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>20/08/2025</td>
                        <td>Venta de maíz</td>
                        <td><span class="badge bg-success">Ingreso</span></td>
                        <td>$ 8,000</td>
                    </tr>
                    <tr>
                        <td>22/08/2025</td>
                        <td>Compra de fertilizante</td>
                        <td><span class="badge bg-danger">Egreso</span></td>
                        <td>$ 3,500</td>
                    </tr>
                    <tr>
                        <td>25/08/2025</td>
                        <td>Servicio veterinario</td>
                        <td><span class="badge bg-danger">Egreso</span></td>
                        <td>$ 2,000</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Tarjeta: Acciones -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Acciones</h3>
            <button class="btn btn-success me-2">➕ Nuevo movimiento</button>
            <button class="btn btn-secondary me-2">📊 Generar reporte</button>
            <button class="btn btn-secondary">💾 Exportar</button>
        </div>

    </div>
</asp:Content>
