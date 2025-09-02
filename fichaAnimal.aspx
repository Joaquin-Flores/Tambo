<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="fichaAnimal.aspx.cs" Inherits="Tambo.FichaAnimal" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="p-4">
        <!-- Title Section -->
        <section>
                <h1 class="pb-3"><i class="fa fa-cow"></i> Ficha Animal</h1>
        </section>

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
                                <p><strong>Tipo:</strong> <span runat="server" id="animalTipo2"></span></p>
                                <p><strong>Estado:</strong> <span runat="server" id="animalEstado"></span></p>
                            </div>
                            <div class="col-4">
                                <p><strong>Nacimiento:</strong> <span runat="server" id="animalNacimiento"></span></p>
                                <p><strong>Sexo:</strong> <span runat="server" id="animalSexo"></span></p>
                                <p><strong>Origen:</strong> <span runat="server" id="animalOrigen"></span></p>
                            </div>
                            <div class="col-4">
                                <p><strong>Notas:</strong> <span runat="server" id="animalNotas"></span></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-4">
                <!-- Genealogía o Parentezco-->
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

        <!-- Actividad de la vaca -->
        <div class="card bg-card shadow-sm mb-4 light-text">
            <div class="card-header">Actividad</div>
            <div class="card-body">
                <!-- Acá va un row con botones para agregar eventos, por ejemplo Vacunación, Enfermedad, Nacimiento, Inseminación, Destete, Venta -->
                <!-- Abajo irá una tabla con todas las actividades de la vaca. -->
                <!-- Acá irá el formulario para agregar AnimalEvent. Hay algunos eventos que además de la descripción toman otros datos, por ejemplo Inseminación crea un nuevo BreedingAttempt. -->
            </div>
        </div>

        <!-- Botón volver -->
        <div class="text-center">
            <a href="cria.aspx" class="btn btn-lg btn-outline-light"><i class="fa fa-arrow-left"></i> Ir a Cría</a>
            <a href="recria.aspx" class="btn btn-lg btn-outline-light"><i class="fa fa-arrow-left"></i> Ir a Recría</a>
        </div>
    </div>

</asp:Content>
