using System;
using System.Data;
using System.Data.SqlClient;

namespace EPharma
{
    public class ExecuteQuery
    {
        public static DataTable Execute(string query)
        {
            try
            {
                var dt = new DataTable();
                var cmd = new SqlCommand(query, DatabaseConnection.Connection()) { CommandType = CommandType.Text };
                cmd.CommandTimeout = 0;
                IDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
                cmd.Dispose();
                return dt;
            }
            catch (Exception ex)
            {
                throw;
            }
            finally
            {
                DatabaseConnection.Connection().Close();
            }
        }
        public static DataSet Execute_Query(string query)
        {
            var cmd = new SqlCommand();
            var ds = new DataSet();
            try
            {
                cmd.CommandText = query;
                cmd.Connection = DatabaseConnection.Connection();
                var da = new SqlDataAdapter(cmd.CommandText, cmd.Connection);
                cmd.CommandTimeout = 0;
                da.SelectCommand = cmd;
                da.Fill(ds);
                cmd.Dispose();
                da.Dispose();
                return ds;
            }
            catch (Exception ex)
            {
                throw new ArgumentException(ex.Message);
            }
            finally
            {
                DatabaseConnection.Connection().Close();
            }
        }
    }
}
