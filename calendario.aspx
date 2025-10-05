<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="calendario.aspx.cs" Inherits="Tambo.calendario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Title Section -->
    <section class="p-4 pb-0">
        <div>
            <h1><i class="fa fa-calendar"></i> Calendario</h1>
        </div>
    </section>

    <!-- Calendario -->
    <section class="p-4 pt-0">
        <div class="row">
            <div class="col-md-12">
                <div class="card bg-card p-3 shadow-sm">
                    <div style="z-index: 0; max-height: 65vh;" id="calendar"></div>
                </div>
            </div>
        </div>
    </section>
    
    <script src="Content/FullCalendar/dist/index.global.min.js"></script>
    <script src="Content/FullCalendar/core/index.global.min.js"></script>
    <script src="Content/FullCalendar/core/locales/es.global.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var calendarEl = document.getElementById('calendar');
            var calendar = new FullCalendar.Calendar(calendarEl, {
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
                },
                navLinks: true, // can click day/week names to navigate views
                editable: false,
                selectable: true,
                initialView: 'dayGridMonth',
                locale: 'es'
            });
            calendar.render();
        }); 

    </script>
</asp:Content>
