using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class Categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var sql = "SP_CATEGORIES @FLAG='S'";
            var ds = ExecuteQuery.Execute_Query(sql);
            dataListCategory.DataSource = ds;
            dataListCategory.DataBind();
        }
        
            
    }
}