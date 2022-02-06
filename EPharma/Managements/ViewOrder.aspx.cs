using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class ViewOrder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                ddlUser.Users().All();
                ddlStatus.FillDropDownSample("select id,Name from OrderStatus with(nolock)").All();
                FILLGRIDVIEW();
            }
        }

        private void FILLGRIDVIEW()
        {
            var sql = "SP_VIEW_ORDER @FLAG='S',@FROMDATE="+txtFromDate.GetValueQ()+
                ", @TODATE = "+txtToDate.GetValueQ() +
                ",@USERID = " + ddlUser.GetValueQ() +
                ", @STATUS = " +ddlStatus.GetValueQ();
            var ds = ExecuteQuery.Execute_Query(sql);
            gvOrders.DataSource = ds.Tables[0];
            gvOrders.DataBind();
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            FILLGRIDVIEW();
        }
    }
}