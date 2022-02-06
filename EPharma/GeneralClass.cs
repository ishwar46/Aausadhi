using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web.UI.WebControls;

namespace EPharma
{
    public static class GeneralClass
    {
        public static string SingleQuote(this string str)
        {
            if (str == null)
            {
                return "NULL";
            }
            else if (str.Trim() == "")
            {
                return "NULL";
            }
            else
            {
                return "'" + str.Trim().Replace("'", "''") + "'";
            }
        }

        #region TextBox
        public static void SetText(this TextBox textBox, string text)
        {
            textBox.Text = text;
        }

        public static string GetValue(this TextBox txtBox, char[] mychar = null)
        {
            if (txtBox.Text == null || string.IsNullOrEmpty(txtBox.Text))
            {
                return null;
            }
            else
            {
                return txtBox.Text.Trim().Trim(mychar);
            }
        }

        public static string GetValueQ(this TextBox txtBox, char[] mychar = null)
        {
            return txtBox.GetValue().SingleQuote();
        }

        public static int? GetValueInt(this TextBox txtBox)
        {
            if (txtBox.Text == null || string.IsNullOrEmpty(txtBox.Text))
            {
                return null;
            }
            else
            {
                return int.Parse(txtBox.Text);
            }
        }

        public static decimal? GetValueDecimal(this TextBox txtBox)
        {
            if (txtBox.Text == null || string.IsNullOrEmpty(txtBox.Text))
            {
                return null;
            }
            else
            {
                return decimal.Parse(txtBox.Text);
            }
        }
        #endregion

        #region Label
        public static void SetText(this Label label, string text)
        {
            label.Text = text;
        }

        public static string GetValue(this Label label, char[] mychar = null)
        {
            if (label.Text == null || string.IsNullOrEmpty(label.Text))
            {
                return null;
            }
            else
            {
                return label.Text.Trim().Trim(mychar);
            }
        }

        public static string GetValueQ(this Label label, char[] mychar = null)
        {
            return label.GetValue().SingleQuote();
        }


        public static int? GetValueInt(this Label label)
        {
            if (label.Text == null || string.IsNullOrEmpty(label.Text))
            {
                return null;
            }
            else
            {
                return int.Parse(label.Text);
            }
        }

        public static decimal? GetValueDecimal(this Label label)
        {
            if (label.Text == null || string.IsNullOrEmpty(label.Text))
            {
                return null;
            }
            else
            {
                return decimal.Parse(label.Text);
            }
        }
        #endregion

        public static object ToXML(this DataTable dt, string tableName = "Temp")
        {
            if (dt != null)
            {
                dt.TableName = tableName;
                if (dt.Rows.Count > 0)
                {
                    StringWriter sw = new StringWriter();
                    dt.WriteXml(sw);
                    return sw.ToString();
                }
            }
            return DBNull.Value;
        }

        public static string ToXMLString(this DataTable dt, string tableName = "Temp")
        {
            if (dt != null)
            {
                dt.TableName = tableName;
                if (dt.Rows.Count > 0)
                {
                    StringWriter sw = new StringWriter();
                    dt.WriteXml(sw);
                    return sw.ToString();
                }
            }
            return "";
        }

        #region DropDown
        //DropDown Sample
        public static DropDownList FillDropDownSample(this DropDownList ddl, string sql)
        {
            ddl.Items.Clear();
            var ds = ExecuteQuery.Execute(sql);
            if (ds.Rows.Count > 0)
            {
                ddl.DataSource = ds;
                ddl.DataValueField = ds.Columns[0].ToString();
                ddl.DataTextField = ds.Columns[1].ToString();
                ddl.DataBind();
            }
            return ddl;
        }

        public static DropDownList FillDropDownSampleWithParam(this DropDownList ddl, string sql, string param)
        {
            if (string.IsNullOrEmpty(param))
            {
                ddl.Items.Clear();
                return ddl;
            }
            return ddl.FillDropDownSample(string.Format(sql, param));
        }

        //DropDown Extension Method Select
        public static DropDownList Select(this DropDownList ddl, string defaultValue = "0")
        {
            ddl.Items.Insert(0, new ListItem("Select", defaultValue, true));
            return ddl;
        }

        //DropDown Extension Method All
        public static DropDownList All(this DropDownList ddl, string defaultValue = "-1")
        {
            ddl.Items.Insert(0, new ListItem("All", defaultValue, true));
            return ddl;
        }

        public static DropDownList SetValue(this DropDownList ddl, string value)
        {
            if (ddl.Items.FindByValue(value) != null)
            {
                ddl.SelectedValue = value;
            }
            return ddl;
        }

        public static DropDownList SetValueText(this DropDownList ddl, string value)
        {
            if (ddl.Items.FindByText(value) != null)
            {
                ddl.SelectedIndex = ddl.Items.IndexOf(ddl.Items.FindByText(value));
            }
            return ddl;
        }

        public static string GetValueByText(this DropDownList ddl, string value)
        {
            if (ddl.Items.FindByText(value) != null)
            {
                return ddl.Items.FindByText(value).Value;
            }
            return "";
        }

        //Class
        public static int? GetValue(this DropDownList dropDownList)
        {
            if (dropDownList.SelectedValue.Trim() == "0" || dropDownList.SelectedValue.Trim() == "" || dropDownList == null || dropDownList.SelectedValue == null)
            {
                return null;
            }
            else
            {
                return int.Parse(dropDownList.SelectedValue.Trim());
            }
        }

        public static string GetValueQ(this DropDownList dropDownList)
        {
            return dropDownList.GetValue().ToString().SingleQuote();
        }

        public static string GetText(this DropDownList dropDownList)
        {
            if (dropDownList.SelectedValue.Trim() == "0" || dropDownList.SelectedValue.Trim() == "" || dropDownList == null || dropDownList.SelectedValue == null)
            {
                return null;
            }
            else
            {
                return dropDownList.SelectedItem.Text;
            }
        }

        public static string GetTextQ(this DropDownList dropDownList)
        {
            return dropDownList.GetText().SingleQuote();
        }

        ///Relation Dropdown extension
        public static DropDownList Users(this DropDownList ddl)
        {
            var sql = "SELECT ID, FullName FROM USERS WITH(NOLOCK)";
            return ddl.FillDropDownSample(sql);
        }

        ///Relation Dropdown extension
        public static DropDownList Genders(this DropDownList ddl)
        {
            var sql = "SELECT ID, [NAME] FROM Genders WITH(NOLOCK)";
            return ddl.FillDropDownSample(sql);
        }

        ///Categories Dropdown extension
        public static DropDownList Category(this DropDownList ddl)
        {
            var sql = "SELECT ID, [NAME] FROM Category WITH(NOLOCK) WHERE ISNULL([Active], 0)=1 ORDER BY Levels";
            return ddl.FillDropDownSample(sql);
        }
        #endregion

        //Generate Thumbnail
        public static string GenerateThumbnail(string image, int Width = 40, int Height = 40)
        {
            if (!string.IsNullOrEmpty(image))
            {
                if (image.Substring(0, 1) == "/")
                {
                    Bitmap sourceImage;
                    byte[] imageBytes = Convert.FromBase64String(image);
                    using (var ms = new MemoryStream(imageBytes))
                    {
                        sourceImage = new Bitmap(ms);
                    }

                    using (Bitmap objBitmap = new Bitmap(Width, Height))
                    {
                        objBitmap.SetResolution(sourceImage.HorizontalResolution, sourceImage.VerticalResolution);
                        using (Graphics objGraphics = Graphics.FromImage(objBitmap))
                        {
                            // Set the graphic format for better result cropping   
                            objGraphics.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.AntiAlias;

                            objGraphics.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                            objGraphics.DrawImage(sourceImage, 0, 0, Width, Height);
                            System.IO.MemoryStream ms = new MemoryStream();
                            objBitmap.Save(ms, ImageFormat.Jpeg);
                            byte[] byteImage = ms.ToArray();
                            image = Convert.ToBase64String(byteImage);
                        }
                    }
                }
            }
            return image;
        }

        //StaticVariable
        public static decimal GetStaticValueDecimal(string StaticVariable, decimal DefaultValue = 0)
        {
            var conn = DatabaseConnection.Connection();
            var cmd = new SqlCommand("SELECT TOP 1 ISNULL((SELECT [Value] FROM StaticVariables WITH(NOLOCK) WHERE [Text] = @StaticVariable), @DefaultValue) VALUE", conn);
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@StaticVariable", StaticVariable);
                cmd.Parameters.AddWithValue("@DefaultValue", DefaultValue);
                var adr = cmd.ExecuteReader();
                while (adr.Read())
                {
                    return decimal.Parse(adr["VALUE"].ToString());
                }
                cmd.Dispose();
                return DefaultValue;
            }
            catch (Exception ex)
            {
                throw new ArgumentException(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        public static bool GetStaticValueBool(string StaticVariable, bool DefaultValue = false)
        {
            var conn = DatabaseConnection.Connection();
            var cmd = new SqlCommand(string.Format("SELECT TOP 1 ISNULL((SELECT [Value] FROM StaticVariables WITH(NOLOCK) WHERE [Text] = @StaticVariable), {0}) VALUE", Convert.ToInt32(DefaultValue)), conn);
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@StaticVariable", StaticVariable);
                var adr = cmd.ExecuteReader();
                while (adr.Read())
                {
                    if (adr["VALUE"].ToString() == "1")
                    {
                        return true;
                    }
                    else if (adr["VALUE"].ToString() == "0")
                    {
                        return false;
                    }
                    else
                    {
                        return DefaultValue;
                    }
                }
                cmd.Dispose();
                return DefaultValue;
            }
            catch (Exception ex)
            {
                throw new ArgumentException(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        public static string GetStaticValue(string StaticVariable, string DefaultValue = "0")
        {
            var conn = DatabaseConnection.Connection();
            var cmd = new SqlCommand("SELECT TOP 1 ISNULL((SELECT [Value] FROM StaticVariables WITH(NOLOCK) WHERE [Text] = @StaticVariable), @DefaultValue) VALUE", conn);
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@StaticVariable", StaticVariable);
                cmd.Parameters.AddWithValue("@DefaultValue", DefaultValue);
                var adr = cmd.ExecuteReader();
                while (adr.Read())
                {
                    return adr["VALUE"].ToString();
                }
                cmd.Dispose();
                return DefaultValue;
            }
            catch (Exception ex)
            {
                throw new ArgumentException(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }

        public static string[] GetStaticMultipleValue(string StaticVariable, string defaultValue = "All")
        {
            var conn = DatabaseConnection.Connection();
            var cmd = new SqlCommand("SELECT TOP 1 ISNULL((SELECT [Value] FROM StaticVariables WITH(NOLOCK) WHERE [Text] = @StaticVariable), @defaultValue) VALUE", conn);
            try
            {
                cmd.CommandType = CommandType.Text;
                cmd.Parameters.AddWithValue("@StaticVariable", StaticVariable);
                cmd.Parameters.AddWithValue("@defaultValue", defaultValue);
                var adr = cmd.ExecuteReader();
                while (adr.Read())
                {
                    return adr["VALUE"].ToString().Split(',');
                }
                cmd.Dispose();
                string[] value = { "All" };
                return value;
            }
            catch (Exception ex)
            {
                throw new ArgumentException(ex.Message);
            }
            finally
            {
                conn.Close();
            }
        }
    }
}