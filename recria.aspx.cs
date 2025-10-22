using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;

namespace Tambo
{
    public partial class recria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTerneros();
                CargarLotes();
            }
        }
        private void CargarTerneros()
        {
            DataTable dt = TamboDB.GetTernerosRecria();
            string html = "";
            foreach (DataRow row in dt.Rows)
            {
                string madre = row["MadreID"] == DBNull.Value || string.IsNullOrEmpty(row["MadreID"].ToString()) ? "-" : $"<a href='FichaVaca.aspx?id={row["MadreID"]}'>{row["MadreID"]}</a>";
                string padre = row["PadreID"] == DBNull.Value || string.IsNullOrEmpty(row["PadreID"].ToString()) ? "-" : $"<a href='FichaVaca.aspx?id={row["PadreID"]}'>{row["PadreID"]}</a>";

                html += $@"
                <tr>
                    <td>{row["ID"]}</td>
                    <td>{row["Especie"]}</td>
                    <td>{row["Sexo"]}</td>
                    <td>{row["Origen"]}</td>
                    <td>{Convert.ToDateTime(row["Nacimiento"]).ToString("yyyy-MM-dd")}</td>
                    <td>{madre} | {padre}</td>
                    <td>{row["Estado"]}</td>
                    <td>
                        <a href='FichaTernero.aspx?id={row["ID"]}' class='btn btn btn-outline-light'><i class='fa fa-eye'></i></a>
                    </td>
                </tr>";
            }
            tablaBodyLiteral.Text = html;
            
            ddlTerneroId.Items.Clear();
            // Insertamos opción por defecto
            ddlTerneroId.Items.Add(new ListItem("-- Seleccione --", ""));

            foreach (DataRow row in dt.Rows)
            {
                string id = row["ID"].ToString();
                // si querés mostrar algo extra, se puede cambiar el text
                ddlTerneroId.Items.Add(new ListItem(id, id));
            }
        }
        private void CargarLotes()
        {
            DataTable dt = TamboDB.GetLotesEngorde();
            string html = "";
            foreach (DataRow row in dt.Rows)
            {
                html += $@"
                <tr>
                    <td>{row["ID Lote"]}</td>
                    <td>{Convert.ToDateTime(row["Fecha Ingreso"]).ToString("yyyy-MM-dd")}</td>
                    <td>{row["Alimentación"]}</td>
                    <td>{Convert.ToDateTime(row["Fecha Egreso"]).ToString("yyyy-MM-dd")}</td>
                    <td>
                        <a href='FichaLote.aspx?id={row["ID Lote"]}' class='btn btn btn-outline-light'><i class='fa fa-eye'></i></a>
                    </td>
                </tr>";
            }
            tablaLotesBodyLiteral.Text = html;

            ddlLoteId.Items.Clear();

            ddlLoteId.Items.Add(new ListItem("-- Seleccione --", ""));

            foreach (DataRow row in dt.Rows)
            {
                string lotId = row["ID Lote"].ToString();
                ddlLoteId.Items.Add(new ListItem(lotId, lotId));
            }
        }
        protected void agregarVaca(object sender, EventArgs e)
        {
            TamboDB.addAnimal(
                    idVaca.Value,
                    int.Parse(especie.Value),
                    1,
                    int.Parse(sexo.Value),
                    DateTime.Parse(nacimiento.Value),
                    string.IsNullOrWhiteSpace(selector_madre.Value) ? null : selector_madre.Value,
                    string.IsNullOrWhiteSpace(selector_padre.Value) ? null : selector_padre.Value,
                    int.Parse(origen.Value),
                    int.Parse(estado.Value),
                    notas.Value
                );
            CargarTerneros();
        }
        protected void clickCrearLote(object sender, EventArgs e)
        {
            DateTime entryDate = DateTime.Parse(inputLoteEntryDate.Value);
            int feedingTypeId = int.Parse(inputLoteFeedingTypeId.Value);

            DateTime? exitDate = null;
            if (!string.IsNullOrWhiteSpace(inputLoteExitDate.Value))
            {
                exitDate = DateTime.Parse(inputLoteExitDate.Value);
            }

            TamboDB.CrearLote(entryDate, feedingTypeId, exitDate);
            CargarLotes();
        }
        protected void NuevoEngordeAnimal_Click(object sender, EventArgs e)
        {
            try
            {
                // Validaciones básicas
                if (string.IsNullOrEmpty(ddlTerneroId.SelectedValue))
                {
                    lblEngordeAnimalMensaje.CssClass = "text-danger";
                    lblEngordeAnimalMensaje.Text = "Seleccioná un ternero.";
                    return;
                }
                if (string.IsNullOrEmpty(ddlLoteId.SelectedValue))
                {
                    lblEngordeAnimalMensaje.CssClass = "text-danger";
                    lblEngordeAnimalMensaje.Text = "Seleccioná un lote.";
                    return;
                }

                string animalId = ddlTerneroId.SelectedValue;
                int lotId = int.Parse(ddlLoteId.SelectedValue);

                decimal? initialWeight = null;
                if (!string.IsNullOrWhiteSpace(txtPesoInicial.Text) && decimal.TryParse(txtPesoInicial.Text, out decimal ip))
                    initialWeight = ip;

                decimal? finalWeight = null;
                if (!string.IsNullOrWhiteSpace(txtPesoFinal.Text) && decimal.TryParse(txtPesoFinal.Text, out decimal fp))
                    finalWeight = fp;

                if (!DateTime.TryParse(txtFechaIngreso.Text, out DateTime entryDate))
                {
                    lblEngordeAnimalMensaje.CssClass = "text-danger";
                    lblEngordeAnimalMensaje.Text = "Fecha de ingreso inválida.";
                    return;
                }

                DateTime? exitDate = null;
                if (!string.IsNullOrWhiteSpace(txtFechaEgreso.Text))
                {
                    if (DateTime.TryParse(txtFechaEgreso.Text, out DateTime ed))
                        exitDate = ed;
                    else
                    {
                        lblEngordeAnimalMensaje.CssClass = "text-danger";
                        lblEngordeAnimalMensaje.Text = "Fecha de egreso inválida.";
                        return;
                    }
                }

                // Llamada a DB
                bool ok = TamboDB.AsociarTerneroLote(animalId, lotId, initialWeight, entryDate, finalWeight, exitDate);

                if (ok)
                {
                    lblEngordeAnimalMensaje.CssClass = "text-success";
                    lblEngordeAnimalMensaje.Text = "✅ Ternero asociado al lote correctamente.";

                    // Recargar selects/tabla para reflejar cambios
                    CargarTerneros();
                    CargarLotes();
                }
                else
                {
                    lblEngordeAnimalMensaje.CssClass = "text-danger";
                    lblEngordeAnimalMensaje.Text = "No se pudo asociar el ternero. Reintentá.";
                }
            }
            catch (Exception ex)
            {
                lblEngordeAnimalMensaje.CssClass = "text-danger";
                lblEngordeAnimalMensaje.Text = "Error: " + ex.Message;
            }
        }
        protected void ExportarTernerosRecria(object sender, EventArgs e)
        {
            DataTable dt = TamboDB.GetTernerosRecria();
            using (XLWorkbook workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add(dt, "Terneros");
                worksheet.Columns().AdjustToContents();

                using (MemoryStream stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    stream.Position = 0;

                    // 3. Descargar el archivo en el navegador
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Terneros.xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();
                }
            }
        }
        protected void ExportarLotesEngorde(object sender, EventArgs e)
        {
            DataTable dt = TamboDB.GetLotesEngorde();
            using (XLWorkbook workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add(dt, "Lotes de Engorde");
                worksheet.Columns().AdjustToContents();

                using (MemoryStream stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    stream.Position = 0;

                    // 3. Descargar el archivo en el navegador
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Lotes de engorde.xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();
                }
            }
        }
    }
}