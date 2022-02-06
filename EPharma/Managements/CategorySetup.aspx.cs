using Microsoft.AspNet.Identity;
using ProudMonkey.Common.Controls;
using System;
using System.IO;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class CategorySetup : System.Web.UI.Page
    {
        public MessageBox msgBox { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            msgBox = new MessageBox();
            this.pnlMsgBox.Controls.Clear();
            this.pnlMsgBox.Controls.Add(msgBox);

            if (!IsPostBack)
            {
                FILLGRID();
                FillDropDown();
            }
        }

        private void FillDropDown()
        {
            ddlParentId.FillDropDownSample("SELECT ID, [NAME] FROM CATEGORY WITH(NOLOCK)").Select();
        }

        private void FILLGRID()
        {
            var sql = "SP_CATEGORY_SETUP @FLAG='S'";
            var ds = ExecuteQuery.Execute_Query(sql);
            gvCategory.DataSource = ds.Tables[0];
            gvCategory.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Clear();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrEmpty(txtCatName.Text))
                {
                    msgBox.ShowWarning("Enter Report Name");
                    return;
                }
                if (string.IsNullOrEmpty(txtLevels.Text))
                {
                    msgBox.ShowWarning("Enter Level");
                    return;
                }

                var filePath = "";
                if (flUpload.HasFile)
                {
                    var fileName = Guid.NewGuid().ToString();
                    var dataDrive = GeneralClass.GetStaticValue("DataDrive") ?? @"C:\";
                    var filePathWithoutFilename = Path.Combine(dataDrive, "Categories");
                    filePath = Path.Combine(filePathWithoutFilename, $"{fileName}{Path.GetExtension(flUpload.FileName)}");
                    if (!Directory.Exists(filePathWithoutFilename))
                        Directory.CreateDirectory(filePathWithoutFilename);
                    flUpload.SaveAs(filePath);
                }

                var sql = "SP_CATEGORY_SETUP @FLAG='" + (btnSave.Text == "Save" ? "I" : "U") + "', @NAME=" + txtCatName.GetValueQ() +
                    ",@LEVELS=" + txtLevels.GetValueQ() +
                    ",@ISACTIVE=" + chkActive.Checked +
                    ", @PARENTID=" + ddlParentId.GetValueQ() +
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

        private void Clear()
        {
            txtCatName.Text = "";
            txtLevels.Text = "";
            hdID.Value = "0";
            ddlParentId.ClearSelection();
            chkActive.Checked = false;
            flUpload.Dispose();
            btnSave.Text = "Save";
        }

        protected void gvCategory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName.Equals("EditData"))
                {
                    int ID = Convert.ToInt32(e.CommandArgument);
                    hdID.Value = ID.ToString();
                    var sql = "SP_CATEGORY_SETUP @FLAG='E', @ID=" + ID;
                    var dt = ExecuteQuery.Execute(sql);
                    if (dt.Rows.Count > 0)
                    {
                        txtCatName.Text = dt.Rows[0]["Name"].ToString();
                        txtLevels.Text = dt.Rows[0]["Levels"].ToString();
                        ddlParentId.SetValue(dt.Rows[0]["ParentID"].ToString());
                        chkActive.Checked = bool.Parse(dt.Rows[0]["Active"].ToString());
                        btnSave.Text = "Update";
                    }
                }
                else if (e.CommandName.Equals("DeleteData"))
                {
                    int S_No = Convert.ToInt32(e.CommandArgument);
                    var sql = "SP_CATEGORY_SETUP @FLAG='D', @ID=" + S_No;
                    var dt = ExecuteQuery.Execute(sql);
                    msgBox.ShowSuccess(dt.Rows[0]["MSG"].ToString());
                    FILLGRID();
                    Clear();
                }
            }
            catch (Exception ex)
            {
                msgBox.ShowError(ex.Message);
            }
        }
    }
}