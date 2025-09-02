<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="recursos-forrajeros.aspx.cs" Inherits="Tambo.recursos_forrajeros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">

        <!-- Título principal -->
        <h1 class="mb-4">Recursos Forrajeros</h1>

        <!-- Tarjeta: Información general -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Información General</h3>
            <p class="muted-text">
                En este módulo encontrarás el listado de los recursos forrajeros disponibles,
                su tipo, estado de disponibilidad y la fecha de registro.
            </p>
        </div>

        <!-- Tarjeta: Listado de recursos -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Listado de Recursos</h3>
            <table class="table table-dark table-hover table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Tipo</th>
                        <th>Disponibilidad</th>
                        <th>Fecha Registro</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>001</td>
                        <td>Alfalfa</td>
                        <td>Forraje</td>
                        <td>Alta</td>
                        <td>10/08/2025</td>
                    </tr>
                    <tr>
                        <td>002</td>
                        <td>Maíz</td>
                        <td>Grano</td>
                        <td>Media</td>
                        <td>15/08/2025</td>
                    </tr>
                    <tr>
                        <td>003</td>
                        <td>Sorgo</td>
                        <td>Forraje</td>
                        <td>Baja</td>
                        <td>20/08/2025</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- Tarjeta: Acciones -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Acciones</h3>
            <button class="btn btn-success me-2">➕ Nuevo recurso</button>
            <button class="btn btn-secondary">📊 Exportar</button>
        </div>

    </div>

</asp:Content>
