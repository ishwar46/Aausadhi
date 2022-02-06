using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ShowDashBoard();
        }

        public class Data
        {
            public List<string> X { get; set; }
            public List<string> Y { get; set; }
            public List<string> Counts { get; set; }
            public List<string> Date { get; set; }
            public Data(List<string> Date = null, List<string> Counts = null, List<string> X = null, List<string> Y = null)
            {
                this.Counts = Counts;
                this.Date = Date;
                this.X = X;
                this.Y = Y;
            }
        }

        private static List<string> GetDataFromColumns(DataTable dt)
        {
            List<string> c = new List<string>();
            foreach (DataColumn dc in dt.Columns)
            {
                c.Add(dt.Rows[0][dc.ColumnName].ToString());
            }
            return c;
        }

        protected void ShowDashBoard()
        {
            DataTable cards = GetData('A');
            if (cards.Rows.Count > 0)
            {
                TOTAL_USERS.Text = cards.Rows[0]["TOTAL_USERS"].ToString();
                TOTAL_PRODUCTS.Text = cards.Rows[0]["TOTAL_PRODUCTS"].ToString();
                TOTAL_ORDERS_MONTH.Text = cards.Rows[0]["TOTAL_ORDERS_MONTH"].ToString();
                TOTAL_ORDERS_TODAY.Text = cards.Rows[0]["TOTAL_ORDERS_TODAY"].ToString();
            }
        }

        private static DataTable GetData(char v)
        {
            var sql = "SP_DASHBOARD @FLAG='" + v + "'";
            return ExecuteQuery.Execute(sql);
        }

        [System.Web.Services.WebMethod]
        public static Data GetOrderStatusThisMonth()
        {
            DataTable dt = GetData('V');
            var columnNames = dt.Columns.Cast<DataColumn>()
                                     .Select(x => (string)x.ColumnName)
                                     .ToList();
            List<string> y = GetDataFromColumns(dt);
            return new Data(X: columnNames, Y: y);
        }

        [System.Web.Services.WebMethod]
        public static Data GetNewUsersThisMonth()
        {
            DataTable dt = GetData('Y');
            var counts = dt.AsEnumerable().Select(r => r.Field<string>("Counts")).ToList();
            var date = dt.AsEnumerable().Select(r => r.Field<string>("Days")).ToList();
            return new Data(Counts: counts, Date: date);
        }

        [System.Web.Services.WebMethod]
        public static Data GetOrdersThisMonth()
        {
            DataTable dt = GetData('Z');
            var counts = dt.AsEnumerable().Select(r => r.Field<string>("Counts")).ToList();
            var date = dt.AsEnumerable().Select(r => r.Field<string>("Date")).ToList();
            return new Data(Counts: counts, Date: date);
        }
    }
}