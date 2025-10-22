using ClosedXML.Excel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
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
        /////////////////////////////// --- Fichas Animales  --- //////////////////////////
        ////////////////////////////////////////////////////////////////////////////////
        public static void SoftDeleteAnimal(string animalId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    UPDATE Animals
                    SET active = 0
                    WHERE animal_id = @animal_id
                ";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
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
                    WHERE a.animal_id = @animal_id AND a.active = 1
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

        public static int GetLoteActualTernero(string animalId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                        SELECT TOP 1 af.lot_id
                        FROM AnimalFattening af
                        INNER JOIN FatteningLots fl ON af.lot_id = fl.lot_id
                        WHERE af.animal_id = @animal_id
                          AND af.active = 1
                          AND fl.active = 1
                        ORDER BY af.entry_date DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                    {
                        return Convert.ToInt32(result);
                    }
                    else
                    {
                        return -1;
                    }
                }
            }
        }
        public static DataTable GetPesajesTernero(string animalId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                SELECT measurement_date, weight_kg, notes
                FROM AnimalWeightHistory
                WHERE animal_id = @animal_id
                ORDER BY measurement_date DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static void InsertPesaje(string animalId, DateTime fecha, decimal peso, string notas)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                INSERT INTO AnimalWeightHistory (animal_id, measurement_date, weight_kg, notes)
                VALUES (@animal_id, @fecha, @peso, @notas)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    cmd.Parameters.AddWithValue("@fecha", fecha);
                    cmd.Parameters.AddWithValue("@peso", peso);
                    cmd.Parameters.AddWithValue("@notas", (object)notas ?? DBNull.Value);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public static DataTable GetAnimalEventTypes()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = "SELECT animal_event_type_id, animal_event_name FROM AnimalEventTypes ORDER BY animal_event_name";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }
        public static DataTable GetEventosTernero(string animalId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT e.event_id, e.event_date, t.animal_event_name, e.description
                    FROM AnimalEvents e
                    INNER JOIN AnimalEventTypes t ON e.animal_event_type_id = t.animal_event_type_id
                    WHERE e.animal_id = @animal_id
                    ORDER BY e.event_date DESC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static void InsertEvento(string animalId, int tipoId, DateTime fecha, string descripcion)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
            INSERT INTO AnimalEvents (animal_id, animal_event_type_id, event_date, description)
            VALUES (@animal_id, @tipo_id, @fecha, @desc)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    cmd.Parameters.AddWithValue("@tipo_id", tipoId);
                    cmd.Parameters.AddWithValue("@fecha", fecha);
                    cmd.Parameters.AddWithValue("@desc", (object)descripcion ?? DBNull.Value);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
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
                WHERE t.type_name IN ('Vaca', 'Toro') AND a.active = 1
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
                WHERE t.type_name IN ('Ternero') AND a.active = 1
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
                    f.feeding_type_name AS [Alimentación]
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

        public static bool AsociarTerneroLote(string animalId, int lotId, decimal? initialWeight, DateTime? entryDate, decimal? finalWeight = null, DateTime? exitDate = null)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    INSERT INTO AnimalFattening (animal_id, lot_id, initial_weight, final_weight, entry_date, exit_date)
                    VALUES (@animal_id, @lot_id, @initial_weight, @final_weight, @entry_date, @exit_date);";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@animal_id", animalId);
                    cmd.Parameters.AddWithValue("@lot_id", lotId);

                    if (initialWeight.HasValue)
                        cmd.Parameters.AddWithValue("@initial_weight", initialWeight.Value);
                    else
                        cmd.Parameters.AddWithValue("@initial_weight", DBNull.Value);

                    if (finalWeight.HasValue)
                        cmd.Parameters.AddWithValue("@final_weight", finalWeight.Value);
                    else
                        cmd.Parameters.AddWithValue("@final_weight", DBNull.Value);

                    if (entryDate.HasValue)
                        cmd.Parameters.AddWithValue("@entry_date", entryDate);
                    else
                        cmd.Parameters.AddWithValue("@entry_date", DBNull.Value);

                    if (exitDate.HasValue)
                        cmd.Parameters.AddWithValue("@exit_date", exitDate.Value);
                    else
                        cmd.Parameters.AddWithValue("@exit_date", DBNull.Value);

                    conn.Open();
                    return cmd.ExecuteNonQuery() > 0;
                }
            }
        }

        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Calendario --- /////////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static DataTable GetActiveReminders()
        {
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string sql = @"
                        SELECT 
                            r.task_id,
                            r.title,
                            r.description,
                            r.scheduled_date,
                            r.recurrence_id,
                            rc.recurrence_name,
                            r.reminder_status_id,
                            rs.reminder_status_name,
                            r.active
                        FROM Reminders r
                        LEFT JOIN Recurrence rc ON r.recurrence_id = rc.recurrence_id
                        LEFT JOIN ReminderStatuses rs ON r.reminder_status_id = rs.reminder_status_id
                        WHERE r.active = 1
                        ORDER BY r.scheduled_date
                    ";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    conn.Open();
                    da.Fill(dt);
                }
            }

            return dt;
        }


        ////////////////////////////////////////////////////////////////////////////////
        /////////////////////////////// --- Contabilidad --- ///////////////////////////
        ////////////////////////////////////////////////////////////////////////////////

        public static DataTable GetGastos()
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                string query = @"
                    SELECT 
                        e.expense_id,
                        e.expense_date,
                        e.description,
                        e.amount,
                        e.expense_category_id,
                        ec.expense_category_name AS category_name
                    FROM Expenses e
                    LEFT JOIN ExpenseCategories ec 
                        ON e.expense_category_id = ec.expense_category_id
                    WHERE e.active = 1 
                    ORDER BY e.expense_date DESC, e.expense_id DESC;
                ";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    return dt;
                }
            }
        }

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
    }
}