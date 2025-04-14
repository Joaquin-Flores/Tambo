using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Tambo.App_Code
{
    public class TamboDB
    {
        public static string ConnectionString { get; set; }
        ///////////////////
        // --- USERS --- //
        ///////////////////
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

        public static void CreateUser(string email, string passwordHash)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Users (Email, PasswordHash) VALUES (@Email, @Hash)", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Hash", passwordHash);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static int? ValidateLogin(string email, string password)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT UserID, PasswordHash FROM Users WHERE Email = @Email", conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    string hash = reader["PasswordHash"].ToString();
                    if (Hasher.Verify(password, hash))
                        return Convert.ToInt32(reader["UserID"]);
                }
                return null;
            }
        }

        public static void UpdateLastLogin(int userId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("UPDATE Users SET LastLogin = GETDATE() WHERE UserID = @ID", conn);
                cmd.Parameters.AddWithValue("@ID", userId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // --- PRODUCTS ---
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

        public static void CreateProduct(string name, string description, int unitPrice, int stock)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Products (Name, Description, UnitPrice, StockQuantity) VALUES (@Name, @Desc, @Price, @Qty)", conn);
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Desc", description);
                cmd.Parameters.AddWithValue("@Price", unitPrice);
                cmd.Parameters.AddWithValue("@Qty", stock);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // --- DELIVERIES ---
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

        // --- PRODUCT DELIVERY ---
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