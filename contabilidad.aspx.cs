using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;

namespace Tambo
{
    public partial class contabilidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarCategorias();
                CargarResumenFinanciero();
                CargarTablaGastos();
            }
        }
        private void CargarTablaGastos()
        {
            DataTable gastos = TamboDB.GetGastos();
            StringBuilder html = new StringBuilder();

            foreach (DataRow row in gastos.Rows)
            {
                string id = row["expense_id"].ToString();
                string categoria = row["category_name"].ToString();
                string fecha = Convert.ToDateTime(row["expense_date"]).ToString("yyyy-MM-dd");
                string monto = Convert.ToDecimal(row["amount"]).ToString("N2");
                string descripcion = row["description"].ToString();

                html.Append($@"
                    <tr>
                        <td>{id}</td>
                        <td>{categoria}</td>
                        <td>{fecha}</td>
                        <td>${monto}</td>
                        <td>{descripcion}</td>
                        <td>
                            <a href='#' class='btn btn-sm btn-outline-danger'><i class='fa fa-trash'></i></a>
                        </td>
                    </tr>");
            }

            tablaBodyLiteral.Text = html.ToString();
        }
        private void CargarCategorias()
        {
            using (SqlConnection conn = new SqlConnection(TamboDB.ConnectionString))
            {
                string query = "SELECT expense_category_id, expense_category_name FROM ExpenseCategories ORDER BY expense_category_name";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    ddlCategoriaGasto.DataSource = dr;
                    ddlCategoriaGasto.DataTextField = "expense_category_name";
                    ddlCategoriaGasto.DataValueField = "expense_category_id";
                    ddlCategoriaGasto.DataBind();
                }
            }
        }
        private void CargarResumenFinanciero()
        {
            decimal capitalVacas = TamboDB.GetCapitalVacas();
            decimal egresos = ObtenerTotalEgresos();
            decimal balance = capitalVacas - egresos;

            litIngresos.Text = "$ " + capitalVacas.ToString("N2");
            litEgresos.Text = "$ " + egresos.ToString("N2");
            LitBalance.Text = "$ " + balance.ToString("N2");
        }
        private decimal ObtenerTotalEgresos()
        {
            using (SqlConnection conn = new SqlConnection(TamboDB.ConnectionString))
            {
                string query = "SELECT ISNULL(SUM(amount),0) FROM Expenses WHERE active = 1";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    return Convert.ToDecimal(cmd.ExecuteScalar());
                }
            }
        }
        protected void agregarGasto_Click(object sender, EventArgs e)
        {
            try
            {
                int categoria = int.Parse(ddlCategoriaGasto.SelectedValue);
                DateTime fecha = DateTime.Parse(idFechaGasto.Text);
                decimal monto = decimal.Parse(idMontoGasto.Text);
                string descripcion = idDescripcionGasto.Text.Trim();

                using (SqlConnection conn = new SqlConnection(TamboDB.ConnectionString))
                {
                    string insert = @"
                        INSERT INTO Expenses (expense_category_id, expense_date, description, amount)
                        VALUES (@cat, @fecha, @desc, @monto)";
                    using (SqlCommand cmd = new SqlCommand(insert, conn))
                    {
                        cmd.Parameters.AddWithValue("@cat", categoria);
                        cmd.Parameters.AddWithValue("@fecha", fecha);
                        cmd.Parameters.AddWithValue("@desc", descripcion);
                        cmd.Parameters.AddWithValue("@monto", monto);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMensaje.Text = "✅ Gasto agregado correctamente.";
                CargarResumenFinanciero();
            }
            catch (Exception ex)
            {
                lblMensaje.CssClass = "text-danger";
                lblMensaje.Text = "Error al agregar gasto: " + ex.Message;
            }
            CargarTablaGastos();
        }
        protected void ExportarGastos(object sender, EventArgs e)
        {
            DataTable dt = TamboDB.GetGastos();
            using (XLWorkbook workbook = new XLWorkbook())
            {
                var worksheet = workbook.Worksheets.Add(dt, "Gastos");
                worksheet.Columns().AdjustToContents();

                using (MemoryStream stream = new MemoryStream())
                {
                    workbook.SaveAs(stream);
                    stream.Position = 0;

                    // 3. Descargar el archivo en el navegador
                    Response.Clear();
                    Response.Buffer = true;
                    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                    Response.AddHeader("content-disposition", "attachment;filename=Gastos.xlsx");
                    Response.BinaryWrite(stream.ToArray());
                    Response.End();
                }
            }
        }
    }
}