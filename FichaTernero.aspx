<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FichaTernero.aspx.cs" Inherits="Tambo.FichaTernero" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="p-4">
        <!-- Title Section -->
        <section class="p-4 pb-0">
                <h1 class="pb-3"><i class="fa fa-cow"></i> Ficha Animal</h1>
        </section>

        <!-- Section de información general -->
        <section class="p-4 pb-0">
            <div class="row">
                <div class="col-8">
                    <!-- Datos principales -->
                    <div class="card bg-card mb-4 light-text">
                        <div class="card-header">
                            <h2 runat="server" id="fichaTitulo" class="pt-1"></h2> <!-- El código animal lo debe sacar de forma dinámica -->
                        </div>
                        <div class="card-body"> <!-- La información se debe sacar de forma dinámica -->
                            <div class="row">
                                <div class="col-4">
                                    <p><strong>Especie:</strong> <span runat="server" id="animalEspecie"></span></p>
                                    <p><strong>Tipo:</strong> <span runat="server" id="animalTipo"></span></p>
                                    <p><strong>Estado:</strong> <span runat="server" id="animalEstado"></span></p>
                                </div>
                                <div class="col-4">
                                    <p><strong>Nacimiento:</strong> <span runat="server" id="animalNacimiento"></span></p>
                                    <p><strong>Sexo:</strong> <span runat="server" id="animalSexo"></span></p>
                                    <p><strong>Origen:</strong> <span runat="server" id="animalOrigen"></span></p>
                                </div>
                                <div class="col-4">
                                    <p><strong>Lote:</strong> <span id="lblLoteActual" runat="server"></span></p>
                                    <p><strong>Notas:</strong> <span runat="server" id="animalNotas"></span></p>
                                    <asp:Button Text="Borrar Animal" CssClass="btn btn-light btn-lg" runat="server" OnClick="BorrarAnimal" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <!-- Genealogía-->
                    <div class="card bg-card mb-4 light-text">
                        <div class="card-header">
                            <h2 class="pt-1">Genealogía</h2>
                        </div>
                        <div runat="server" id="genealogiaLiteral" class="card-body">
                             <!-- La información se debe sacar de forma dinámica -->
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Listado de pesajes -->
        <section class="p-4 py-3">
            <div class="card light-text bg-card p-5">
                <div class="d-flex justify-content-between pb-2">
                    <h2>Historial de Pesajes</h2>
                    <a href="#formularioPesaje" class="btn btn-primary btn-lg">+ Agregar Pesaje</a>
                </div>
                <div class="table-responsive">
                    <table id="tablaPesajes" class="table-dark table-hover">
                        <thead>
                            <tr class="bg-card">
                                <th>Fecha de pesaje</th>
                                <th>Peso</th>
                                <th>Notas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Literal ID="tablaPesajesLiteral" runat="server"></asp:Literal>
                        </tbody>
                    </table>
                </div>
            <asp:Button CssClass="btn btn-primary btn-lg py-3" Text="Exportar .xlsx" OnClick="ExportarPesajes" runat="server" />
            </div>
        </section>

        <script>
            $(document).ready(function () {
                $('#tablaPesajes').DataTable({
                    "language": {
                        "url": "Content/DataTables/datatables_esp.json"
                    },
                    "pageLength": 5
                });
            });
        </script>

        <!-- Formulario nuevo pesaje -->
        <section class="p-4 py-3 w-100" id="formularioNuevoPesaje">
            <div class="card light-text bg-card p-5">
                <h2>Nuevo Pesaje</h2>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="inputFechaPesaje" class="form-label">Fecha de pesaje</label>
                        <input runat="server" type="date" class="form-control" id="inputFechaPesaje">
                    </div>
                    <div class="col-md-4">
                        <label for="inputPesoPesaje" class="form-label">Peso medido</label>
                        <input runat="server" type="number" class="form-control" id="inputPesoPesaje">
                    </div>
                    <div class="col-md-4">
                        <label for="inputNotasPesaje" class="form-label">Notas del pesaje</label>
                        <input runat="server" type="text" class="form-control" id="inputNotasPesaje" />
                    </div>
                </div>
                <asp:Button runat="server" Text="+ Añadir pesaje" CssClass="btn btn-primary btn-lg py-3" OnClick="clickAñadirPesaje" />
            </div>
        </section>

        <!-- Listado de Eventos -->
        <section class="p-4 py-3">
            <div class="card light-text bg-card p-5">
                <div class="d-flex justify-content-between pb-2">
                    <h2>Eventos del ternero</h2>
                    <a href="#formularioEventos" class="btn btn-primary btn-lg">+ Agregar Evento</a>
                </div>
                <div class="table-responsive">
                    <table id="tablaEventos" class="table-dark table-hover">
                        <thead>
                            <tr class="bg-card">
                                <th style="width: 5%">ID</th>
                                <th style="width: 15%">Fecha</th>
                                <th style="width: 15%">Tipo</th>
                                <th style="width: 55%">Descripción</th>
                                <th style="width: 10%">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:Literal ID="tablaEventosLiteral" runat="server"></asp:Literal>
                        </tbody>
                    </table>
                </div>
            <asp:Button CssClass="btn btn-primary btn-lg py-3" Text="Exportar .xlsx" OnClick="ExportarEventosTernero" runat="server" />
            </div>
        </section>

        <script>
            $(document).ready(function () {
                $('#tablaEventos').DataTable({
                    "language": {
                        "url": "Content/DataTables/datatables_esp.json"
                    },
                    "pageLength": 5
                });
            });
        </script>

        <!-- Formulario de evento -->
        <section class="p-4 py-3 w-100" id="formularioNuevoEvento">
            <div class="card light-text bg-card p-5">
                <h2>Nuevo evento</h2>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="ddlTipoEvento" class="form-label">Tipo</label>
                        <asp:DropDownList runat="server" ID="ddlTipoEvento" CssClass="form-select">
                            <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-4">
                        <label for="inputFechaEvento" class="form-label">Fecha</label>
                        <input runat="server" type="date" class="form-control" id="inputFechaEvento">
                    </div>
                    <div class="col-md-4">
                        <label for="inputDescripcionEvento" class="form-label">Descripción</label>
                        <input runat="server" type="text" class="form-control" id="inputDescripcionEvento" />
                    </div>
                </div>
                <asp:Button runat="server" Text="+ Añadir evento" CssClass="btn btn-primary btn-lg py-3" OnClick="clickAñadirEvento" />
            </div>
        </section>

        <!-- Botón volver -->
        <div class="text-center">
            <a href="cria.aspx" class="btn btn-lg btn-outline-light"><i class="fa fa-arrow-left"></i> Ir a Cría</a>
            <a href="recria.aspx" class="btn btn-lg btn-outline-light"><i class="fa fa-arrow-left"></i> Ir a Recría</a>
        </div>
    </div>

</asp:Content>
