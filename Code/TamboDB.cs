using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Xml.Linq;

namespace Tambo.Code
{
    public static class TamboDB
    {
        public static string ConnectionString
        {
            get
            {
                string dataSource = HttpContext.Current?.Session?["DataSource"]?.ToString();
                return $"Data Source={dataSource};Initial Catalog=Tambo;Integrated Security=True;";
            }
        }
        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Users --- //////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////
        public static bool EmailExists(string email)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        public static void CreateUser(string email, string password)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Users (Email, PasswordHash) VALUES (@Email, @Hash)", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Hash", Hasher.Hash(password));
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static bool ValidateLogin(string email, string password)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT PasswordHash FROM Users WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string hash = reader["PasswordHash"].ToString();
                    return Hasher.Verify(password, hash);
                }
                return false;
            }
        }


        public static void UpdateLastLogin(string email)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Users SET LastLogin = GETDATE() WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static int? GetUserID(string email)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT UserID FROM Users WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                object result = cmd.ExecuteScalar();
                return result != null ? (int?)Convert.ToInt32(result) : null;
            }
        }

        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Products --- ///////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////
        public static DataTable GetAllProducts()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Products", conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }

        public static bool CreateProduct(string name, string description, decimal unitPrice, int stockQuantity, string category, string shape)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = "INSERT INTO Products (Name, Description, UnitPrice, StockQuantity, ProductCategory, ProductShape) " +
                               "VALUES (@Name, @Description, @UnitPrice, @StockQuantity, @ProductCategory, @ProductShape)";
                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@UnitPrice", unitPrice);
                cmd.Parameters.AddWithValue("@StockQuantity", stockQuantity);
                cmd.Parameters.AddWithValue("@ProductCategory", category);
                cmd.Parameters.AddWithValue("@ProductShape", shape);

                conn.Open();
                int rowsAffected = cmd.ExecuteNonQuery();
                return rowsAffected > 0; // Return true if the insert was successful
            }
        }

        public static DataTable GetFilteredProducts(
            string nameContains = null,
            string descriptionContains = null,
            decimal? minPrice = null,
            decimal? maxPrice = null,
            int? minStock = null,
            int? maxStock = null,
            string category = null,
            string shape = null)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                List<string> conditions = new List<string>();
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;

                // Filter: Name contains keyword (LIKE)
                if (!string.IsNullOrEmpty(nameContains))
                {
                    conditions.Add("Name LIKE @Name");
                    cmd.Parameters.AddWithValue("@Name", $"%{nameContains}%");
                }

                // Filter: Description contains keyword (LIKE)
                if (!string.IsNullOrEmpty(descriptionContains))
                {
                    conditions.Add("Description LIKE @Description");
                    cmd.Parameters.AddWithValue("@Description", $"%{descriptionContains}%");
                }

                // Filter: Minimum price
                if (minPrice.HasValue)
                {
                    conditions.Add("UnitPrice >= @MinPrice");
                    cmd.Parameters.AddWithValue("@MinPrice", minPrice.Value);
                }

                // Filter: Maximum price
                if (maxPrice.HasValue)
                {
                    conditions.Add("UnitPrice <= @MaxPrice");
                    cmd.Parameters.AddWithValue("@MaxPrice", maxPrice.Value);
                }

                // Filter: Minimum stock
                if (minStock.HasValue)
                {
                    conditions.Add("StockQuantity >= @MinStock");
                    cmd.Parameters.AddWithValue("@MinStock", minStock.Value);
                }

                // Filter: Maximum stock
                if (maxStock.HasValue)
                {
                    conditions.Add("StockQuantity <= @MaxStock");
                    cmd.Parameters.AddWithValue("@MaxStock", maxStock.Value);
                }

                // Filter: Product Category (exact match)
                if (!string.IsNullOrEmpty(category))
                {
                    conditions.Add("ProductCategory = @Category");
                    cmd.Parameters.AddWithValue("@Category", category);
                }

                // Filter: Product Shape (exact match)
                if (!string.IsNullOrEmpty(shape))
                {
                    conditions.Add("ProductShape = @Shape");
                    cmd.Parameters.AddWithValue("@Shape", shape);
                }

                // Build final WHERE clause
                string whereClause = conditions.Count > 0
                    ? "WHERE " + string.Join(" AND ", conditions)
                    : "";

                // Final query
                cmd.CommandText = $"SELECT * FROM Products {whereClause}";

                // Execute and return
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }


        //////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Deliveries --- ///////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////

        public static DataTable GetAllDeliveries()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlDataAdapter adapter = new SqlDataAdapter("SELECT * FROM Deliveries", conn);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                return dt;
            }
        }

        public static void CreateDelivery(int clientId, DateTime deliveryDate, string status, string notes)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Deliveries (ClientID, DeliveryDate, Status, Notes) VALUES (@ClientID, @Date, @Status, @Notes)", conn);
                cmd.Parameters.AddWithValue("@ClientID", clientId);
                cmd.Parameters.AddWithValue("@Date", deliveryDate);
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@Notes", notes);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- ProductDelivery --- ////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static void AddProductToDelivery(int productId, int deliveryId, int quantity)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO ProductDelivery (ProductID, DeliveryID, Quantity) VALUES (@ProdID, @DelID, @Qty)", conn);
                cmd.Parameters.AddWithValue("@ProdID", productId);
                cmd.Parameters.AddWithValue("@DelID", deliveryId);
                cmd.Parameters.AddWithValue("@Qty", quantity);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}