using EPharma.Models;
using Microsoft.AspNet.Identity;
using ProudMonkey.Common.Controls;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class ShoppingCart : System.Web.UI.Page
    {
        public MessageBox msgBox { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msgBox = new MessageBox();
            this.pnlMsgBox.Controls.Clear();
            this.pnlMsgBox.Controls.Add(msgBox);

            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                decimal cartTotal = 0;
                cartTotal = usersShoppingCart.GetTotal();
                if (cartTotal > 0)
                {
                    // Display Total.
                    lblTotal.Text = "Rs. " + cartTotal;
                }
                else
                {
                    LabelTotalText.Text = "";
                    lblTotal.Text = "";
                    ShoppingCartTitle.InnerText = "Shopping Cart is Empty";
                    UpdateBtn.Visible = false;
                }
            }
            btnOrder.Visible = false;
            UpdateBtn.Visible = false;
            if (CartList.Rows.Count>0) {
                btnOrder.Visible = true;
                UpdateBtn.Visible = true;
            }
        }

        public List<CartItem> GetShoppingCartItems()
        {
            ShoppingCartActions actions = new ShoppingCartActions();
            return actions.GetCartItems();
        }

        public List<CartItem> UpdateCartItems()
        {
            using (ShoppingCartActions usersShoppingCart = new ShoppingCartActions())
            {
                String cartId = usersShoppingCart.GetCartId();

                ShoppingCartActions.ShoppingCartUpdates[] cartUpdates = new ShoppingCartActions.ShoppingCartUpdates[CartList.Rows.Count];
                for (int i = 0; i < CartList.Rows.Count; i++)
                {
                    IOrderedDictionary rowValues = new OrderedDictionary();
                    rowValues = GetValues(CartList.Rows[i]);
                    cartUpdates[i].ProductId = Convert.ToInt32(rowValues["ProductID"]);

                    CheckBox cbRemove = new CheckBox();
                    cbRemove = (CheckBox)CartList.Rows[i].FindControl("Remove");
                    cartUpdates[i].RemoveItem = cbRemove.Checked;

                    TextBox quantityTextBox = new TextBox();
                    quantityTextBox = (TextBox)CartList.Rows[i].FindControl("PurchaseQuantity");
                    cartUpdates[i].PurchaseQuantity = Convert.ToInt16(quantityTextBox.Text.ToString());
                }
                usersShoppingCart.UpdateShoppingCartDatabase(cartId, cartUpdates);
                CartList.DataBind();
                lblTotal.Text = "Rs. " + usersShoppingCart.GetTotal();
                return usersShoppingCart.GetCartItems();
            }
        }

        public static IOrderedDictionary GetValues(GridViewRow row)
        {
            IOrderedDictionary values = new OrderedDictionary();
            foreach (DataControlFieldCell cell in row.Cells)
            {
                if (cell.Visible)
                {
                    // Extract values from the cell.
                    cell.ContainingField.ExtractValuesFromCell(values, cell, row.RowState, true);
                }
            }
            return values;
        }

        protected void UpdateBtn_Click(object sender, EventArgs e)
        {
            UpdateCartItems();
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                IdentityHelper.RedirectToReturnUrl("~/Account/Login.aspx", Response);
            }
            var sql = "SP_Order @FLAG='I'"
            +", @UserID=" + User.Identity.GetUserId().SingleQuote();

            var dt = ExecuteQuery.Execute(sql);
            msgBox.ShowSuccess(dt.Rows[0]["MSG"].ToString());
            ShoppingCartActions actions = new ShoppingCartActions();
            actions.EmptyCart();
            CartList.DataBind();
            btnOrder.Visible = false;
            UpdateBtn.Visible = false;
        }
    }
}