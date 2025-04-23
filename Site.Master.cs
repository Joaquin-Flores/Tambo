using Antlr.Runtime.Tree;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace App
{
    public partial class SiteMaster : MasterPage
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {
            // Upon first load
            if (!IsPostBack)
            {
                if (Session["DataSource"] == null)
                    Session["DataSource"] = "PC-MEGA-GAMER\\OLIMPO";

                string selected = Session["DataSource"].ToString();

                // Ensure the item exists before assigning it
                if (dropdownDB.Items.FindByValue(selected) != null)
                    dropdownDB.SelectedValue = selected;
            }

            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath);
            switch (currentPage.ToLower())
            {
                case "livestock":
                    livestockLink.Attributes["class"] += " active";
                    break;
                case "products":
                    productsLink.Attributes["class"] += " active";
                    break;
                case "bills":
                    billsLink.Attributes["class"] += " active";
                    break;
                case "deliveries":
                    deliveriesLink.Attributes["class"] += " active";
                    break;
                case "chickens":
                    chickensLink.Attributes["class"] += " active";
                    break;
                case "settings":
                    settingsLink.Attributes["class"] += " active";
                    break;
                default:
                    dashboardLink.Attributes["class"] += " active";
                    break;
            }
        }

        protected void dropdownDB_SelectedIndexChanged(object sender, EventArgs e)
        {
            Session["DataSource"] = dropdownDB.SelectedValue;
            Response.Redirect(Request.RawUrl); // Refresh to apply new source
        }
    }
}