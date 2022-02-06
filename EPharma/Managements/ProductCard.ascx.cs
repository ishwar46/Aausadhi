using EPharma.Models;
using ProudMonkey.Common.Controls;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class ProductCard : System.Web.UI.UserControl
    {
        public MessageBox msgBox { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msgBox = new MessageBox();
            this.pnlMsgBox2.Controls.Clear();
            this.pnlMsgBox2.Controls.Add(msgBox);
        }

        public void LoadData(DataTable dt)
        {
            dataListProduct.DataSource = dt;
            dataListProduct.DataBind();
        }

        protected void AddToCart_Click(object sender, EventArgs e)
        {
            try
            {
                Button btn = (Button)sender;
                string rawId = btn.CommandArgument.ToString();
                int productId;
                if (!String.IsNullOrEmpty(rawId) && int.TryParse(rawId, out productId))
                {
                    using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
                    {
                        usersShoppingCart.AddToCart(Convert.ToInt16(rawId));
                    }
                }
                else
                {
                    throw new Exception("ERROR : It is illegal to load AddToCart.aspx without setting a ProductId.");
                }
                Response.Redirect("~/Managements/ShoppingCart.aspx");
            }
            catch (Exception ex)
            {
                msgBox.ShowError(ex.Message);
            }
        }
    }
}