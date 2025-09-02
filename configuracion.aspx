<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="configuracion.aspx.cs" Inherits="Tambo.configuracion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container-fluid mt-4">

        <!-- Título principal -->
        <h1 class="mb-4">Configuración</h1>

        <!-- Tarjeta: Información general -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Información General</h3>
            <p class="muted-text">
                En este módulo puedes ajustar las preferencias de la aplicación, gestionar usuarios 
                y definir parámetros básicos de funcionamiento.
            </p>
        </div>

        <!-- Tarjeta: Preferencias del sistema -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Preferencias del Sistema</h3>
            <form>
                <div class="mb-3">
                    <label class="form-label">Idioma</label>
                    <select class="form-select bg-dark text-light">
                        <option selected>Español</option>
                        <option>Inglés</option>
                    </select>
                </div>
                <div class="mb-3">
                    <label class="form-label">Formato de Fecha</label>
                    <select class="form-select bg-dark text-light">
                        <option selected>DD/MM/AAAA</option>
                        <option>MM/DD/AAAA</option>
                    </select>
                </div>
                <button class="btn btn-success">💾 Guardar cambios</button>
            </form>
        </div>

        <!-- Tarjeta: Gestión de usuarios -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Gestión de Usuarios</h3>
            <table class="table table-dark table-hover table-bordered">
                <thead>
                    <tr>
                        <th>Usuario</th>
                        <th>Rol</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>admin</td>
                        <td>Administrador</td>
                        <td><span class="badge bg-success">Activo</span></td>
                    </tr>
                    <tr>
                        <td>juanp</td>
                        <td>Operador</td>
                        <td><span class="badge bg-warning">Pendiente</span></td>
                    </tr>
                    <tr>
                        <td>maria</td>
                        <td>Consulta</td>
                        <td><span class="badge bg-danger">Bloqueado</span></td>
                    </tr>
                </tbody>
            </table>
            <button class="btn btn-success me-2">➕ Nuevo usuario</button>
            <button class="btn btn-secondary">⚙️ Roles y permisos</button>
        </div>

        <!-- Tarjeta: Acciones -->
        <div class="card bg-card shadow-sm p-3 mb-4">
            <h3 class="mb-3">Acciones</h3>
            <button class="btn btn-secondary me-2">📦 Copia de seguridad</button>
            <button class="btn btn-secondary me-2">🔄 Restaurar</button>
            <button class="btn btn-danger">⚠️ Restablecer configuración</button>
        </div>

    </div>
</asp:Content>
