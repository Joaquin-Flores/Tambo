<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="recria.aspx.cs" Inherits="Tambo.recria" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Title Section -->
    <section class="p-4 pb-0">
        <div>
            <h1><i class="fa fa-drumstick-bite"></i> Recría</h1>
        </div>
    </section>

    <!-- Tabla de vacas en cría -->
    <section class="p-4 py-3">
        <div class="card light-text bg-card p-5">
            <div class="d-flex justify-content-between pb-2">
                <h2>Vacas</h2>
                <a href="#formularioTernero" class="btn btn-primary btn-lg">+ Agregar Vaca</a>
            </div>
            <div class="table-responsive">
                <table id="tablaTernerosRecria" class="table-dark table-hover">
                    <thead>
                        <tr class="bg-card">
                            <th>ID</th>
                            <th>Especie</th>
                            <th>Sexo</th>
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
            $('#tablaTernerosRecria').DataTable({
                "language": {
                    "url": "Content/DataTables/datatables_esp.json"
                },
                "pageLength": 5
            });
        });
    </script>


    <!-- Formulario agregar ternero -->
    <section class="p-4 py-3 w-100" id="formularioTernero">
        <div class="card light-text bg-card p-5">
            <h2>Agregar Nueva Vaca</h2>
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
                    <label for="sexo" class="form-label">Sexo</label>
                    <select runat="server" id="sexo" class="form-select">
                        <option value="1">Macho</option>
                        <option value="2">Hembra</option>
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

            <asp:Button runat="server" Text="+ Agregar Ternero" CssClass="btn btn-primary btn-lg py-3" OnClick="agregarVaca" />
        </div>
    </section>

    <!-- Tabla de lotes de engorde -->
    <section class="p-4 py-3">
        <div class="card light-text bg-card p-5">
            <div class="d-flex justify-content-between pb-2">
                <h2>Lotes</h2>
                <a href="#formularioLote" class="btn btn-primary btn-lg">+ Agregar Lote</a>
            </div>
            <div class="table-responsive">
                <table id="tablaLotesEngorde" class="table-dark table-hover">
                    <thead>
                        <tr class="bg-card">
                            <th>ID</th>
                            <th>Ingreso</th>
                            <th>Alimentación</th>
                            <th>Egreso</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <asp:Literal ID="tablaLotesBodyLiteral" runat="server"></asp:Literal>
                    </tbody>
                </table>
            </div>
        </div>
    </section>

    <script>
        $(document).ready(function () {
            $('#tablaLotesEngorde').DataTable({
                "language": {
                    "url": "Content/DataTables/datatables_esp.json"
                },
                "pageLength": 5
            });
        });
    </script>
    
    <!-- Formulario agregar lote de engorde -->
    <section class="p-4 py-3 w-100" id="formularioLote">
        <div class="card light-text bg-card p-5">
            <h2>Crear Nuevo Lote</h2>
            <div class="row mb-3">
                <div class="col-md-4">
                    <label for="inputLoteEntryDate" class="form-label">Fecha de ingreso</label>
                    <input runat="server" type="date" class="form-control" id="inputLoteEntryDate">
                </div>
                <div class="col-md-4">
                    <label for="inputLoteFeedingTypeId" class="form-label">Tipo de alimentación</label>
                    <select runat="server" id="inputLoteFeedingTypeId" class="form-select">
                        <option value="1">FeedLot</option>
                        <option value="2">Pastura</option>
                        <option value="3">Mixto</option>
                    </select>
                </div>
                <div class="col-md-4">
                    <label for="inputLoteExitDate" class="form-label">Fecha de egreso (opcional)</label>
                    <input runat="server" type="date" class="form-control" id="inputLoteExitDate" />
                </div>
            </div>
            <asp:Button runat="server" Text="+ Crear Lote" CssClass="btn btn-primary btn-lg py-3" OnClick="clickCrearLote" />
        </div>
    </section>
    
    <!-- Formulario asociar Ternero a Lote (Recría) -->
    <section class="p-4 py-3 w-100" id="formularioEngordeAnimal">
        <div class="card light-text bg-card p-5">
            <h2>Nuevo Engorde Animal (asocia ternero a lote)</h2>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label for="ddlTerneroId" class="form-label">ID Ternero</label>
                    <asp:DropDownList runat="server" ID="ddlTerneroId" CssClass="form-select">
                        <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <label for="ddlLoteId" class="form-label">Lote de Engorde</label>
                    <asp:DropDownList runat="server" ID="ddlLoteId" CssClass="form-select">
                        <asp:ListItem Value="">-- Seleccione --</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <label for="txtPesoInicial" class="form-label">Peso Inicial (Kg) — opcional</label>
                    <asp:TextBox runat="server" ID="txtPesoInicial" CssClass="form-control" TextMode="Number" />
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <label for="txtPesoFinal" class="form-label">Peso Final (Kg) — opcional</label>
                    <asp:TextBox runat="server" ID="txtPesoFinal" CssClass="form-control" TextMode="Number" />
                </div>

                <div class="col-md-4">
                    <label for="txtFechaIngreso" class="form-label">Fecha de Ingreso</label>
                    <asp:TextBox runat="server" ID="txtFechaIngreso" CssClass="form-control" TextMode="Date" />
                </div>

                <div class="col-md-4">
                    <label for="txtFechaEgreso" class="form-label">Fecha de Egreso — opcional</label>
                    <asp:TextBox runat="server" ID="txtFechaEgreso" CssClass="form-control" TextMode="Date" />
                </div>
            </div>

            <asp:Button runat="server" Text="+ Nuevo Engorde" CssClass="btn btn-primary btn-lg py-3" OnClick="NuevoEngordeAnimal_Click" />
            <asp:Label ID="lblEngordeAnimalMensaje" runat="server" CssClass="ms-3"></asp:Label>
        </div>
    </section>

</asp:Content>
