<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cria.aspx.cs" Inherits="Tambo.cria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">    
    <!-- Title Section -->
    <section class="p-4 pb-0">
        <div>
            <h1><i class="fa fa-cow"></i> Cría</h1>
        </div>
    </section>

    <!-- Tarjetas de Estadísticas -->
    <section class="p-4 pt-0">
        <div class="row text-center">
            <div class="col-md-3">
                <div class="card bg-card light-text p-3 shadow-sm">
                    <h4>Vientres en servicio</h4>
                    <h2><asp:Literal ID="litVientres" runat="server"></asp:Literal></h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-card light-text p-3 shadow-sm">
                    <h4>Vacas preñadas</h4>
                    <h2><asp:Literal ID="litPreniadas" runat="server"></asp:Literal></h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-card light-text p-3 shadow-sm">
                    <h4>Porcentaje de preñez</h4>
                    <h2><asp:Literal ID="litPorcentaje" runat="server"></asp:Literal>%</h2>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card bg-card light-text p-3 shadow-sm">
                    <h4>Edad promedio</h4>
                    <h2><asp:Literal ID="litEdad" runat="server"></asp:Literal> años</h2>
                </div>
            </div>
        </div>
    </section>

    <!-- Tabla de vacas en cría -->
    <section class="p-4 py-3">
        <div class="card light-text bg-card p-5">
            <div class="d-flex justify-content-between pb-2">
                <h2>Vacas</h2>
                <a href="#formulario" class="btn btn-primary btn-lg">+ Agregar Vaca</a>
            </div>
            <div class="table-responsive">
                <table id="tablaVacasCria" class="table-dark table-hover">
                    <thead>
                        <tr class="bg-card">
                            <th>ID</th>
                            <th>Especie</th>
                            <th>Tipo</th>
                            <th>Orígen</th>
                            <th>Nacimiento</th>
                            <th>Madre | Padre</th>
                            <th>Estado</th>
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
            $('#tablaVacasCria').DataTable({
                "language": {
                    "url": "Content/DataTables/datatables_esp.json"
                },
                "pageLength": 10
            });
        });
    </script>


    <!-- Formulario agregar vaca -->
    <section class="p-4 py-3 w-100" id="formulario">
        <div class="card light-text bg-card p-5">
            <h2>Agregar Nueva Vaca</h2>
            <div>
                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="idVaca" class="form-label">ID</label>
                        <input runat="server" type="text" class="form-control" id="idVaca" placeholder="00007">
                    </div>
                    <div class="col-md-4">
                        <label for="especie" class="form-label">Especie</label>
                        <select runat="server" id="especie" class="form-select">
                            <option value="1">Angus</option>
                            <option value="2">Brangus</option>
                            <option value="3">Jersey</option>
                            <option value="4">Orlando</option>
                            <option value="5">Brahman</option>
                            <option value="6">Hereford</option>
                            <option value="7">Braford</option>
                            <option value="8">Charolais</option>
                            <option value="9">Limousin</option>
                            <option value="10">Shorthorn</option>
                            <option value="11">Pardo Suizo</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="tipo" class="form-label">Tipo</label>
                        <select runat="server" id="tipo" class="form-select">
                            <option value="2">Vaca</option>
                            <option value="3">Toro</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-4">
                        <label for="origen" class="form-label">Origen</label>
                        <select runat="server" id="origen" class="form-select">
                            <option value="1">Propio</option>
                            <option value="2">Comprado</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="nacimiento" class="form-label">Nacimiento</label>
                        <input runat="server" type="date" class="form-control" id="nacimiento">
                    </div>
                    <div class="col-md-4">
                        <label for="estado" class="form-label">Estado</label>
                        <select runat="server" id="estado" class="form-select">
                            <option value="1">Vivo</option>
                            <option value="2">Muerto</option>
                            <option value="3">Enfermo</option>
                            <option value="4">Pariendo</option>
                        </select>
                    </div>
                </div>

                <div class="row mb-4">
                    <div class="col-md-4">
                        <label for="madre" class="form-label">Madre (ID)</label>
                        <select runat="server" id="selector_madre" class="form-select">
                            <option value="">Nulo</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="padre" class="form-label">Padre (ID)</label>
                        <select runat="server" id="selector_padre" class="form-select">
                            <option value="">Nulo</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label for="notas" class="form-label">Notas</label>
                        <input runat="server" class="form-control" type="text" id="notas" placeholder="Tiene una oreja cortada" />
                    </div>
                </div>

                <asp:Button runat="server" Text="+ Agregar Vaca" CssClass="btn btn-primary btn-lg" OnClick="agregarVaca" />

            </div>
        </div>
    </section>
    
    
</asp:Content>
