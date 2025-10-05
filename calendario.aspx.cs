using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;

namespace Tambo
{
    public partial class calendario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DataTable dt = TamboDB.GetActiveReminders();

                // Convertir DataTable a lista de objetos con fechas en ISO (yyyy-MM-dd)
            }
        }
    }
}