using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;

namespace Tambo
{
    public partial class cria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTabla();
            }
        }

        private void CargarTabla()
        {
            DataTable dt = TamboDB.GetVacasCria();

            // Generar HTML para tbody
            string html = "";   
            foreach (DataRow row in dt.Rows)
            {
                string madre = row["MadreID"] == DBNull.Value || string.IsNullOrEmpty(row["MadreID"].ToString()) ? "-" : $"<a href='FichaAnimal.aspx?id={row["MadreID"]}'>{row["MadreID"]}</a>";
                string padre = row["PadreID"] == DBNull.Value || string.IsNullOrEmpty(row["PadreID"].ToString()) ? "-" : $"<a href='FichaAnimal.aspx?id={row["PadreID"]}'>{row["PadreID"]}</a>";
                
                html += $@"
                <tr>
                    <td>{row["ID"]}</td>
                    <td>{row["Especie"]}</td>
                    <td>{row["Tipo"]}</td>
                    <td>{row["Origen"]}</td>
                    <td>{Convert.ToDateTime(row["Nacimiento"]).ToString("yyyy-MM-dd")}</td>
                    <td>{madre} | {padre}</td>
                    <td>{row["Estado"]}</td>
                    <td>
                        <button class='btn btn-sm btn-outline-light'><i class='fa fa-edit'></i></button>
                        <button class='btn btn-sm btn-outline-danger'><i class='fa fa-trash'></i></button>
                    </td>
                </tr>";
            }

            // Insertar HTML en el literal
            tablaBodyLiteral.Text = html;
        }

        protected void agregarVaca(object sender, EventArgs e)
        {
            TamboDB.addAnimal(
                    idVaca.Value,
                    int.Parse(especie.Value),
                    int.Parse(tipo.Value),
                    int.Parse(tipo.Value) == 2 ? 2 : 1,
                    DateTime.Parse(nacimiento.Value),
                    string.IsNullOrWhiteSpace(selector_madre.Value) ? null : selector_madre.Value,
                    string.IsNullOrWhiteSpace(selector_padre.Value) ? null : selector_padre.Value,
                    int.Parse(origen.Value),
                    int.Parse(estado.Value),
                    notas.Value
                );
            CargarTabla();
        }
    }
}