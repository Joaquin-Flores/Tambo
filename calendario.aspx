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
                locale: 'es',
                events: [
                    {
                        title: 'Pagar nuevos terneros',
                        start: '2025-10-03T13:00:00',
                        constraint: 'businessHours'
                    },
                    {
                        title: 'Recibir al veterinario',
                        start: '2025-10-13T11:00:00',
                        constraint: 'availableForMeeting', // defined below
                        color: '#257e4a'
                    },
                    {
                        title: 'Comienza la parición',
                        start: '2025-10-18',
                        end: '2025-01-20'
                    },
                    {
                        title: 'Vacunar lote #3',
                        start: '2025-10-29T20:00:00'
                    },

                    // areas where "Meeting" must be dropped
                    {
                        groupId: 'availableForMeeting',
                        start: '2025-10-11T10:00:00',
                        end: '2025-10-11T16:00:00',
                        display: 'background'
                    },
                    {
                        groupId: 'availableForMeeting',
                        start: '2025-10-13T10:00:00',
                        end: '2025-10-13T16:00:00',
                        display: 'background'
                    },

                    // red areas where no events can be dropped
                    {
                        start: '2025-10-24',
                        end: '2025-10-28',
                        overlap: false,
                        display: 'background',
                        color: '#ff9f89'
                    },
                    {
                        start: '2025-10-06',
                        end: '2025-10-08',
                        overlap: false,
                        display: 'background',
                        color: '#ff9f89'
                    }
                ]
            });
            calendar.render();
        }); 

    </script>
</asp:Content>
