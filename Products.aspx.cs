using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
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
            gvProducts.DataSource = dt;
            gvProducts.DataBind();
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

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            // Parse values safely
            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            string category = txtCategory.Text.Trim();
            string shape = txtShape.Text.Trim();

            decimal? minPrice = TryParseDecimal(txtMinPrice.Text);
            decimal? maxPrice = TryParseDecimal(txtMaxPrice.Text);
            int? minStock = TryParseInt(txtMinStock.Text);
            int? maxStock = TryParseInt(txtMaxStock.Text);

            DataTable dt = TamboDB.GetFilteredProducts(
                nameContains: name,
                descriptionContains: description,
                category: category,
                shape: shape,
                minPrice: minPrice,
                maxPrice: maxPrice,
                minStock: minStock,
                maxStock: maxStock
            );

            gvProducts.DataSource = dt;
            gvProducts.DataBind();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtName.Text = "";
            txtDescription.Text = "";
            txtCategory.Text = "";
            txtShape.Text = "";
            txtMinPrice.Text = "";
            txtMaxPrice.Text = "";
            txtMinStock.Text = "";
            txtMaxStock.Text = "";

            LoadAllProducts();
        }

        // Helpers to parse nullable values
        private decimal? TryParseDecimal(string input)
        {
            return decimal.TryParse(input, out var value) ? value : (decimal?)null;
        }

        private int? TryParseInt(string input)
        {
            return int.TryParse(input, out var value) ? value : (int?)null;
        }
    }
}