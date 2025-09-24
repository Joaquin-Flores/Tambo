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
                return $"Data Source={dataSource};Initial Catalog=Tambo;Integrated Security=True;encrypt=False;MultipleActiveResultSets=True;App=EntityFramework";
            }
        }

        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Ficha Animal  --- //////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static DataRow GetAnimalById(string animalId)
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT 
                        a.animal_id AS ID,
                        s.species_name AS Especie,
                        sx.sex_name AS Sexo,
                        t.type_name AS Tipo,
                        st.animal_status_name AS Estado,
                        a.birth_date AS Nacimiento,
                        o.origin_name AS Origen,
                        a.notes AS Notas,
                        m.animal_id AS MadreID,
                        p.animal_id AS PadreID
                    FROM Animals a
                    INNER JOIN AnimalSpecies s ON a.species_id = s.species_id
                    INNER JOIN Sexes sx ON a.sex_id = sx.sex_id
                    INNER JOIN AnimalTypes t ON a.type_id = t.type_id
                    INNER JOIN Origins o ON a.origin_id = o.origin_id
                    INNER JOIN AnimalStatuses st ON a.animal_status_id = st.animal_status_id
                    LEFT JOIN Animals m ON a.mother_id = m.animal_id
                    LEFT JOIN Animals p ON a.father_id = p.animal_id
                    WHERE a.animal_id = @animal_id
                    ORDER BY a.animal_id DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }

        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Cría  --- //////////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static void addAnimal(
            string animal_id,
            int species_id,
            int type_id,
            int sex_id,
            DateTime birth_date,
            string mother_id,
            string father_id,
            int origin_id,  
            int animal_status_id,
            string notes = ""
            )
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO Animals (animal_id, species_id, type_id, sex_id, birth_date, mother_id, father_id, origin_id, animal_status_id, notes) VALUES (@animal_id, @species_id, @type_id, @sex_id, @birth_date, @mother_id, @father_id, @origin_id, @animal_status_id, @notes)", conn);
                cmd.Parameters.AddWithValue("@animal_id", animal_id);
                cmd.Parameters.AddWithValue("@species_id", species_id);
                cmd.Parameters.AddWithValue("@type_id", type_id);
                cmd.Parameters.AddWithValue("@sex_id", sex_id);
                cmd.Parameters.AddWithValue("@birth_date", birth_date);
                cmd.Parameters.AddWithValue("@mother_id", (object)mother_id ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@father_id", (object)father_id ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@origin_id", origin_id);
                cmd.Parameters.AddWithValue("@animal_status_id", animal_status_id);
                cmd.Parameters.AddWithValue("@notes", notes);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static DataTable GetVacasCria()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                SELECT 
                    a.animal_id AS ID,
                    s.species_name AS Especie,
                    t.type_name AS Tipo,
                    o.origin_name AS Origen,
                    a.birth_date AS Nacimiento,
                    m.animal_id AS MadreID,
                    p.animal_id AS PadreID,
                    st.animal_status_name AS Estado
                FROM Animals a
                INNER JOIN AnimalSpecies s ON a.species_id = s.species_id
                INNER JOIN AnimalTypes t ON a.type_id = t.type_id
                INNER JOIN Origins o ON a.origin_id = o.origin_id
                INNER JOIN AnimalStatuses st ON a.animal_status_id = st.animal_status_id
                LEFT JOIN Animals m ON a.mother_id = m.animal_id
                LEFT JOIN Animals p ON a.father_id = p.animal_id
                WHERE t.type_name IN ('Vaca', 'Toro')
                ORDER BY a.animal_id ASC
            ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        public static DataRow GetEstadisticasCria()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
            SELECT
                SUM(CASE WHEN t.type_name = 'Vaca' AND st.animal_status_name = 'Vivo' THEN 1 ELSE 0 END) AS VientresEnServicio,
                SUM(CASE WHEN t.type_name = 'Vaca' AND st.animal_status_name = 'Preñada' THEN 1 ELSE 0 END) AS VacasPreniadas,
                SUM(CASE WHEN st.animal_status_name = 'Muerto' THEN 1 ELSE 0 END) AS Mortandad,
                AVG(DATEDIFF(YEAR, a.birth_date, GETDATE())) AS EdadPromedio
            FROM Animals a
            INNER JOIN AnimalTypes t ON a.type_id = t.type_id
            INNER JOIN AnimalStatuses st ON a.animal_status_id = st.animal_status_id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt.Rows.Count > 0 ? dt.Rows[0] : null;
        }


        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Recría --- ///////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static int CrearLote(DateTime entryDate, int feedingTypeId, DateTime? exitDate = null)
        {
            int newLotId = 0;

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO FatteningLots (entry_date, exit_date, feeding_type_id)
                    OUTPUT INSERTED.lot_id
                    VALUES (@entry_date, @exit_date, @feeding_type_id)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@entry_date", entryDate);
                    cmd.Parameters.AddWithValue("@feeding_type_id", feedingTypeId);

                    if (exitDate.HasValue)
                        cmd.Parameters.AddWithValue("@exit_date", exitDate.Value);
                    else
                        cmd.Parameters.AddWithValue("@exit_date", DBNull.Value);

                    conn.Open();
                    newLotId = (int)cmd.ExecuteScalar();
                }
            }
            return newLotId;
        }

        public static void AsignarLote(string animalId, int lotId, decimal initialWeight, DateTime entryDate, decimal? finalWeight = null, DateTime? exitDate = null)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO AnimalFattening (animal_id, lot_id, initial_weight, final_weight, entry_date, exit_date)
                    VALUES (@animal_id, @lot_id, @initial_weight, @final_weight, @entry_date, @exit_date)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    cmd.Parameters.AddWithValue("@lot_id", lotId);
                    cmd.Parameters.AddWithValue("@initial_weight", initialWeight);
                    cmd.Parameters.AddWithValue("@entry_date", entryDate);

                    if (finalWeight.HasValue)
                        cmd.Parameters.AddWithValue("@final_weight", finalWeight.Value);
                    else
                        cmd.Parameters.AddWithValue("@final_weight", DBNull.Value);

                    if (exitDate.HasValue)
                        cmd.Parameters.AddWithValue("@exit_date", exitDate.Value);
                    else
                        cmd.Parameters.AddWithValue("@exit_date", DBNull.Value);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public static DataTable GetTernerosRecria()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                SELECT 
                    a.animal_id AS ID,
                    s.species_name AS Especie,
                    sx.sex_name AS Sexo,
                    o.origin_name AS Origen,
                    a.birth_date AS Nacimiento,
                    m.animal_id AS MadreID,
                    p.animal_id AS PadreID,
                    st.animal_status_name AS Estado
                FROM Animals a
                INNER JOIN AnimalSpecies s ON a.species_id = s.species_id
                INNER JOIN Sexes sx ON a.sex_id = sx.sex_id
                INNER JOIN Origins o ON a.origin_id = o.origin_id
                INNER JOIN AnimalStatuses st ON a.animal_status_id = st.animal_status_id
                INNER JOIN AnimalTypes t ON a.type_id = t.type_id
                LEFT JOIN Animals m ON a.mother_id = m.animal_id
                LEFT JOIN Animals p ON a.father_id = p.animal_id
                WHERE t.type_name IN ('Ternero')
                ORDER BY a.animal_id DESC
            ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }
        public static DataTable GetLotesEngorde()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                SELECT 
                    l.lot_id      AS [ID Lote],
                    l.entry_date  AS [Fecha Ingreso],
                    l.exit_date   AS [Fecha Egreso],
                    f.feeding_type_name AS [Alimentación],
                    l.active      AS [Activo]
                FROM FatteningLots l
                INNER JOIN FeedingTypes f 
                    ON l.feeding_type_id = f.feeding_type_id
                WHERE l.active = 1
                ORDER BY l.entry_date DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Contabilidad --- ///////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static decimal GetCapitalVacas()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
            SELECT COUNT(*) 
            FROM Animals a
            INNER JOIN AnimalTypes t ON a.type_id = t.type_id
            WHERE t.type_name IN ('Vaca','Toro')
              AND a.animal_status_id IN (
                    SELECT animal_status_id 
                    FROM AnimalStatuses 
                    WHERE animal_status_name NOT IN ('Muerto')
              )";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    int cantidad = Convert.ToInt32(cmd.ExecuteScalar());
                    return cantidad * 1000m;
                }
            }
        }



        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Viejo --- ///////////////////////////////
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