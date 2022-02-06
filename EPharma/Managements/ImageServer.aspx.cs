using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EPharma.Managements
{
    public partial class ImageServer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.ContentType = "image/jpeg";
            string imagePath = Request.QueryString["imagePath"];

            if (File.Exists(imagePath))
            {
                Response.WriteFile(imagePath);
            }
            else
            {
                Response.ContentType = "text/HTML";
                Response.Write("File Not Found");
            }
        }
    }
}