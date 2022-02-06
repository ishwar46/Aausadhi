using EPharma.Models;
using ProudMonkey.Common.Controls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class ProductDetails : System.Web.UI.Page
    {
        public MessageBox msgBox { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msgBox = new MessageBox();
            this.pnlMsgBox.Controls.Clear();
            this.pnlMsgBox.Controls.Add(msgBox);

            if (!IsPostBack)
            {
                var ProductID = Request.QueryString["ProductID"];
                if (!string.IsNullOrEmpty(ProductID))
                {
                    LoadProductDetails(ProductID);
                }
            }
        }

        private void LoadProductDetails(string productID)
        {
            var sql = "SP_PRODUCT_DETAILS @FLAG='S', @ProductID=" + productID.SingleQuote();
            var dt = ExecuteQuery.Execute(sql);
            if (dt.Rows.Count > 0)
            {
                ProductImage.ImageUrl = "~/Managements/ImageServer.aspx?imagePath=" + dt.Rows[0]["Icon"].ToString();
                ProudctTitle.Text = dt.Rows[0]["NAME"].ToString();
                ProudctPrice.Text = "Rs. " + dt.Rows[0]["SellPrice"].ToString();
                ProductKeyFeatures.Text = dt.Rows[0]["KeyFeatures"].ToString();
                ProductDescriptions.Text = dt.Rows[0]["Descriptions"].ToString();
                ProductCategories.Text = dt.Rows[0]["Categories"].ToString();
                ProductID.Value = dt.Rows[0]["ID"].ToString();
            }
        }

        protected void AddToCart_Click(object sender, EventArgs e)
        {
            try
            {
                string rawId = ProductID.Value;
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
                Response.Redirect("ShoppingCart.aspx");
            }
            catch (Exception ex)
            {
                msgBox.ShowError(ex.Message);
            }
        }
    }
}