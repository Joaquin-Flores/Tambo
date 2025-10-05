using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;

namespace Tambo
{
    public partial class FichaTernero : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string animalId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(animalId))
                {
                    Response.Redirect("cria.aspx");
                    return;
                }

                CargarFicha(animalId);
                CargarPesajes();
                CargarEventos();
                CargarDDL();
            }
        }
        private void CargarDDL()
        {
            ddlTipoEvento.DataSource = TamboDB.GetAnimalEventTypes();
            ddlTipoEvento.DataTextField = "animal_event_name";
            ddlTipoEvento.DataValueField = "animal_event_type_id";
            ddlTipoEvento.DataBind();
        }
        private void CargarPesajes()
        {
            DataTable dt = TamboDB.GetPesajesTernero(Request.QueryString["id"]);
            string html = "";
            foreach (DataRow row in dt.Rows)
            {
                html += $@"
                <tr>
                    <td>{Convert.ToDateTime(row["measurement_date"]).ToString("yyyy-MM-dd")}</td>
                    <td>{row["weight_kg"]}</td>
                    <td>{row["notes"]}</td>
                </tr>";
            }
            tablaPesajesLiteral.Text = html;
        }
        private void CargarEventos()
        {
            DataTable dt = TamboDB.GetEventosTernero(Request.QueryString["id"]);
            string html = "";
            foreach (DataRow row in dt.Rows)
            {
                html += $@"
                <tr>
                    <td>{row["event_id"]}</td>
                    <td>{Convert.ToDateTime(row["event_date"]).ToString("yyyy-MM-dd")}</td>
                    <td>{row["animal_event_name"]}</td>
                    <td>{row["description"]}</td>
                    <td>
                        <button class='btn btn btn-outline-light'><i class='fa fa-eye'></i></a>
                    </td>
                </tr>";
            }
            tablaEventosLiteral.Text = html;
        }
        private void CargarFicha(string animalId)
        {
            var row = TamboDB.GetAnimalById(animalId);
            if (row == null)
            {
                // Si no existe el animal, volver
                Response.Redirect("cria.aspx");
                return;
            }

            // Título
            fichaTitulo.InnerText = $"Animal #{row["ID"]}";

            // Datos principales
            animalEspecie.InnerText = row["Especie"].ToString();
            animalSexo.InnerText = row["Sexo"].ToString();
            animalTipo.InnerText = row["Tipo"].ToString();
            animalEstado.InnerText = row["Estado"].ToString();
            animalNacimiento.InnerText = Convert.ToDateTime(row["Nacimiento"]).ToString("yyyy-MM-dd");
            animalOrigen.InnerText = row["Origen"].ToString();
            animalNotas.InnerText = row["Notas"].ToString();
            CargarLoteActual();
            // Genealogía
            string madre = string.IsNullOrEmpty(row["MadreID"].ToString())
                ? "-"
                : $"<a href='FichaAnimal.aspx?id={row["MadreID"]}'>{row["MadreID"]}</a>";
            string padre = string.IsNullOrEmpty(row["PadreID"].ToString())
                ? "-"
                : $"<a href='FichaAnimal.aspx?id={row["PadreID"]}'>{row["PadreID"]}</a>";

            genealogiaLiteral.InnerHtml = $"<p><strong>Madre:</strong> {madre}</p><p><strong>Padre:</strong> {padre}</p>";
        }
        private void CargarLoteActual()
        {
            int lote = TamboDB.GetLoteActualTernero(Request.QueryString["id"]);
            if (lote != -1)
            {
                lblLoteActual.InnerHtml = $"<a href='FichaLote.aspx?id={lote}'>Lote #{lote}</a>";
            }
            else
            {
                lblLoteActual.InnerText = "Sin lote asignado";
            }
        }
        protected void clickAñadirPesaje (object sender, EventArgs e)
        {

            DateTime fecha = DateTime.Parse(inputFechaPesaje.Value);
            decimal peso = decimal.Parse(inputPesoPesaje.Value);
            string notas = string.IsNullOrWhiteSpace(inputNotasPesaje.Value) ? null : inputNotasPesaje.Value.ToString();
            TamboDB.InsertPesaje(Request.QueryString["id"], fecha, peso, notas);
            CargarPesajes();
        }
        protected void clickAñadirEvento(object sender, EventArgs e)
        {
            int tipo = int.Parse(ddlTipoEvento.SelectedValue);
            DateTime fecha = DateTime.Parse(inputFechaEvento.Value);
            string desc = string.IsNullOrWhiteSpace(inputDescripcionEvento.Value) ? null : inputDescripcionEvento.Value;
            TamboDB.InsertEvento(Request.QueryString["id"], tipo, fecha, desc);
            CargarEventos();
        }
    }
}