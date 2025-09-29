using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;

namespace Tambo
{
    public partial class FichaVaca : System.Web.UI.Page
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
            }
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
            animalOrigen.InnerText = row["Tipo"].ToString();
            animalEstado.InnerText = row["Estado"].ToString();
            animalNacimiento.InnerText = Convert.ToDateTime(row["Nacimiento"]).ToString("yyyy-MM-dd");
            animalOrigen.InnerText = row["Origen"].ToString();
            animalNotas.InnerText = row["Notas"].ToString();

            // Genealogía
            string madre = string.IsNullOrEmpty(row["MadreID"].ToString())
                ? "-"
                : $"<a href='FichaAnimal.aspx?id={row["MadreID"]}'>{row["MadreID"]}</a>";
            string padre = string.IsNullOrEmpty(row["PadreID"].ToString())
                ? "-"
                : $"<a href='FichaAnimal.aspx?id={row["PadreID"]}'>{row["PadreID"]}</a>";

            genealogiaLiteral.InnerHtml = $"<p><strong>Madre:</strong> {madre}</p><p><strong>Padre:</strong> {padre}</p>";
        }
    }
}