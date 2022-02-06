using Microsoft.AspNet.Identity;
using ProudMonkey.Common.Controls;
using System;
using System.IO;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class ProductSetup : System.Web.UI.Page
    {
        public MessageBox msgBox { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msgBox = new MessageBox();
            this.pnlMsgBox.Controls.Clear();
            this.pnlMsgBox.Controls.Add(msgBox);

            if (!IsPostBack)
            {
                FillDropDown();
                FILLGRID();
            }
        }

        private void FillDropDown()
        {
            ddlCateogy.Category().Select();
            ddlMeasurement.FillDropDownSample("SELECT ID, [NAME] FROM MeasurementType WITH(NOLOCK)").Select();
        }

        private void FILLGRID()
        {
            var sql = "SP_PRODUCT_SETUP @FLAG='S'";
            var ds = ExecuteQuery.Execute_Query(sql);
            gvProducts.DataSource = ds.Tables[0];
            gvProducts.DataBind();
        }

        private void Clear()
        {
            txtProductName.Text = "";
            txtOrgPrice.Text = "";
            txtExpiryDate.Text = "";
            MeasurementTypeQuantity.Text = "";
            ddlCateogy.ClearSelection();
            ddlMeasurement.ClearSelection();
            chkActive.Checked = false;
            flUpload.Dispose();
            chkActive.Checked = false;
            txtDesc.Text = "";
            txtKeyFeature.Text = "";
            txtDiscount.Text = "";
            txtSellPrice.Text = "";
            hdID.Value = "0";
            btnSave.Text = "Save";
        }
           
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtProductName.Text))
                {
                    msgBox.ShowWarning("Enter Product Name");
                    return;
                }
                if (ddlCateogy.GetValue() == null) {
                    msgBox.ShowWarning("Select Category");
                    return;
                }
                if (string.IsNullOrEmpty(txtOrgPrice.Text))
                {
                    msgBox.ShowWarning("Enter Original price");
                    return;
                }
                if (string.IsNullOrEmpty(txtSellPrice.Text))
                {
                    msgBox.ShowWarning("Enter sell price");
                    return;
                }
                if (string.IsNullOrEmpty(txtKeyFeature.Text))
                {
                    msgBox.ShowWarning("Enter Key Features About Products");
                    return;
                }
                if (string.IsNullOrEmpty(txtDesc.Text))
                {
                    msgBox.ShowWarning("Enter Description about Product");
                    return;
                }
                if (string.IsNullOrEmpty(txtExpiryDate.Text))
                {
                    msgBox.ShowWarning("Enter expiry Date of Product");
                    return;
                }
                if (ddlMeasurement.GetValue() == null)
                {
                    msgBox.ShowWarning("Select Measurement Type");
                    return;
                }
                var filePath = "";
                if (flUpload.HasFile)
                {
                    var fileName = Guid.NewGuid().ToString();
                    var dataDrive = GeneralClass.GetStaticValue("DataDrive") ?? @"C:\";
                    var filePathWithoutFilename = Path.Combine(dataDrive, "Products");
                    filePath = Path.Combine(filePathWithoutFilename, $"{fileName}{Path.GetExtension(flUpload.FileName)}");
                    if (!Directory.Exists(filePathWithoutFilename))
                        Directory.CreateDirectory(filePathWithoutFilename);
                    flUpload.SaveAs(filePath);
                }

                var sql = "SP_PRODUCT_SETUP @FLAG='" + (btnSave.Text == "Save" ? "I" : "U") + "', @NAME=" + txtProductName.GetValueQ() +
                    ",@ORIGINALPRICE=" + txtOrgPrice.GetValueQ() +
                    ",@SELLPRICE=" + txtSellPrice.GetValueQ() +
                    ",@DISCOUNTPRICE=" + txtDiscount.GetValueQ() +
                    ",@KEYFEATURES=" + txtKeyFeature.GetValueQ() +
                    ",@DESCRIPTION=" + txtDesc.GetValueQ() +
                    ",@EXPIRYDATE=" + txtExpiryDate.GetValueQ() +
                    ",@ISACTIVE=" + chkActive.Checked +
                    ", @CATEGORY=" + ddlCateogy.GetValueQ() +
                    ", @MEASUREMENTID=" + ddlMeasurement.GetValueQ() +
                    ", @MeasurementTypeQuantity=" + MeasurementTypeQuantity.GetValueQ() +
                   ", @ICON=" + filePath.SingleQuote()
                    + ", @UserID=" + User.Identity.GetUserId().SingleQuote();

                sql += ",@ID=" + hdID.Value.SingleQuote();
                var dt = ExecuteQuery.Execute(sql);

                msgBox.ShowSuccess(dt.Rows[0]["MSG"].ToString());
                FILLGRID();
                Clear();
            }
            catch (Exception ex)
            {
                msgBox.ShowError(ex.Message);
            }
        }

        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName.Equals("EditData"))
                {
                    int ID = Convert.ToInt32(e.CommandArgument);
                    hdID.Value = ID.ToString();
                    var sql = "SP_PRODUCT_SETUP @FLAG='E', @ID=" + ID;
                    var dt = ExecuteQuery.Execute(sql);
                    if (dt.Rows.Count > 0)
                    {
                        txtProductName.Text = dt.Rows[0]["NAME"].ToString();
                        txtOrgPrice.Text = dt.Rows[0]["ORIGINALPRICE"].ToString();
                        MeasurementTypeQuantity.Text = dt.Rows[0]["MeasurementTypeQuantity"].ToString();
                        txtSellPrice.Text = dt.Rows[0]["SellPrice"].ToString();
                        txtDiscount.Text = dt.Rows[0]["Discount"].ToString();
                        txtKeyFeature.Text = dt.Rows[0]["KeyFeatures"].ToString();
                        txtDesc.Text = dt.Rows[0]["Descriptions"].ToString();
                        txtExpiryDate.Text = dt.Rows[0]["ExpiryDate"].ToString();
                        ddlCateogy.SetValue(dt.Rows[0]["CategoryID"].ToString());
                        ddlMeasurement.SetValue(dt.Rows[0]["MeasurementTypeID"].ToString());
                        chkActive.Checked = bool.Parse(dt.Rows[0]["Active"].ToString());
                        btnSave.Text = "Update";
                    }
                }
                else if (e.CommandName.Equals("DeleteData"))
                {
                    int S_No = Convert.ToInt32(e.CommandArgument);
                    var sql = "SP_PRODUCT_SETUP @FLAG='D', @ID=" + S_No;
                    var dt = ExecuteQuery.Execute(sql);

                    msgBox.ShowSuccess(dt.Rows[0]["MSG"].ToString());
                    FILLGRID();
                }
            }
            catch (Exception ex)
            {
                msgBox.ShowError(ex.Message);
            }
        }
    }
}