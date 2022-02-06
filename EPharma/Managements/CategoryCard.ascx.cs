using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class CategoryCard : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void LoadData(DataTable dt)
        {
            dataListCategory.DataSource = dt;
            dataListCategory.DataBind();
        }
    }
}