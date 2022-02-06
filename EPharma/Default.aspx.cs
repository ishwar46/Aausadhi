using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) {
                FirstSlide.ImageUrl = Page.ResolveClientUrl("~/Icons/bannernew.png");
                SecondSlide.ImageUrl = Page.ResolveClientUrl("~/Icons/drugs.png");
                ThirdSlide.ImageUrl = Page.ResolveClientUrl("~/Icons/shopping.JPG");


                var sql = "SP_HOME @FLAG='S'";
                var ds = ExecuteQuery.Execute_Query(sql);

                CategoryCard1.LoadData(ds.Tables[0]);
                ProductCard1.LoadData(ds.Tables[1]);
            }
        }

        protected void btnMoreCat_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Managements/Categories.aspx");
        }

        protected void btnMore_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Managements/Products.aspx");
        }

        protected void aaaa_Click(object sender, EventArgs e)
        {

        }
    }
}