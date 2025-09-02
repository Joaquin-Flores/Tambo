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
    public partial class recria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTablaTerneros();
            }
        }
        private void CargarTablaTerneros()
        {
            DataTable dt = TamboDB.GetTernerosRecria();
            string html = "";
            foreach (DataRow row in dt.Rows)
            {
                string madre = row["MadreID"] == DBNull.Value || string.IsNullOrEmpty(row["MadreID"].ToString()) ? "-" : $"<a href='fichaAnimal.aspx?id={row["MadreID"]}'>{row["MadreID"]}</a>";
                string padre = row["PadreID"] == DBNull.Value || string.IsNullOrEmpty(row["PadreID"].ToString()) ? "-" : $"<a href='fichaAnimal.aspx?id={row["PadreID"]}'>{row["PadreID"]}</a>";

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
                        <a href='fichaAnimal.aspx?id={row["ID"]}' class='btn btn btn-outline-light'><i class='fa fa-eye'></i></a>
                    </td>
                </tr>";
            }
            tablaBodyLiteral.Text = html;
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
            CargarTablaTerneros();
        }
        protected void clickCrearLote(object sender, EventArgs e)
        {
            //TamboDB.CrearLote(
            //    DateTime.Parse(inputLoteEntryDate.Value),
            //    int.Parse(inputLoteFeedingTypeId.Value),
            //    DateTime.Parse(inputLoteExitDate.Value)
            //    );
        }
    }
}