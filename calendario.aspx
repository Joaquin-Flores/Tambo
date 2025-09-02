<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="calendario.aspx.cs" Inherits="Tambo.calendario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">

        <!-- Título principal -->
        <h1 class="mb-4">Calendario</h1>

        <!-- Tarjeta: Información general -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Información General</h3>
            <p class="muted-text">
                Aquí puedes visualizar y gestionar las actividades programadas en el campo, 
                como siembras, riegos, fertilizaciones, vacunaciones y cosechas.
            </p>
        </div>

        <!-- Tarjeta: Próximas actividades -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Próximas Actividades</h3>
            <table class="table table-dark table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Actividad</th>
                        <th>Responsable</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>28/08/2025</td>
                        <td>Riego de pasturas</td>
                        <td>Juan Pérez</td>
                        <td><span class="badge bg-warning">Pendiente</span></td>
                    </tr>
                    <tr>
                        <td>30/08/2025</td>
                        <td>Vacunación bovina</td>
                        <td>María López</td>
                        <td><span class="badge bg-success">Confirmada</span></td>
                    </tr>
                    <tr>
                        <td>05/09/2025</td>
                        <td>Fertilización de maíz</td>
                        <td>Carlos Gómez</td>
                        <td><span class="badge bg-danger">Retrasada</span></td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Tarjeta: Acciones -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Acciones</h3>
            <button class="btn btn-success me-2">➕ Nueva actividad</button>
            <button class="btn btn-secondary me-2">📅 Ver calendario completo</button>
            <button class="btn btn-secondary">📊 Exportar</button>
        </div>

    </div>
</asp:Content>
