using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Tambo.Code;
namespace App
{
    public partial class Products : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllProducts();
            }
        }

        private void LoadAllProducts()
        {
            DataTable dt = TamboDB.GetAllProducts();
            BuildProductsTable(dt);
        }
        private void BuildProductsTable(DataTable dt)
        {
            StringBuilder html = new StringBuilder();

            html.Append("<table id='myTable' class='display' style='width:100%'>");
            html.Append("<thead><tr>");
            foreach (DataColumn column in dt.Columns)
            {
                html.AppendFormat("<th>{0}</th>", column.ColumnName);
            }
            html.Append("</tr></thead>");
            html.Append("<tbody>");
            foreach (DataRow row in dt.Rows)
            {
                html.Append("<tr>");
                foreach (var item in row.ItemArray)
                {
                    html.AppendFormat("<td>{0}</td>", item);
                }
                html.Append("</tr>");
            }
            html.Append("</tbody></table>");

            ltTable.Text = html.ToString(); // ltTable = Literal control in your .aspx page
        }
        protected void AddProduct_Click(object sender, EventArgs e)
        {
            // Get data from form fields
            string name = productName.Value;
            string description = productDescription.Value;
            decimal unitPrice = Convert.ToDecimal(productPrice.Value);
            int stockQuantity = Convert.ToInt32(productStock.Value);
            string category = productCategory.Value;
            string shape = productShape.Value;

            // Call the TamboDB method to insert the product into the database
            bool success = TamboDB.CreateProduct(name, description, unitPrice, stockQuantity, category, shape);

            if (success)
            {
                // If successful, reload the products
                LoadAllProducts();
            }
            else
            {
                // If failed, show an error message
                Response.Write("<script>alert('Error adding product. Please try again.');</script>");
            }
        }
    }
}