using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
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
            }
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
        }
    }
}