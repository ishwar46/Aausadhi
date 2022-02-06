using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace EPharma
{
    public class DatabaseConnection
    {
        public static SqlConnection Connection()
        {
            SqlConnection con = null;
            try
            {
                con = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                if (con.State == ConnectionState.Open)
                    con.Close();
                con.Open();
                return con;
            }
            catch(Exception ex)
            {
                throw new ArgumentException(ex.Message);
            }
        }
    }
}
