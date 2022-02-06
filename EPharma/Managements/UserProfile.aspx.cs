using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using EPharma.Models;

namespace EPharma.Managements
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!User.Identity.IsAuthenticated)
            {
                IdentityHelper.RedirectToReturnUrl("Account/Login.aspx", Response);
            }

            if (!IsPostBack)
            {
                LoadUserProfile();
                Gender.Genders();
            }
        }

        private void LoadUserProfile()
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                FirstName.Text = user.FirstName;
                MiddleName.Text = user.MiddleName;
                LastName.Text = user.LastName;
                Gender.SetValue(user.GenderID?.ToString());
                Address.Text = user.Address;
                PhoneNo.Text = user.PhoneNumber;
            }
        }

        protected void Update_Click(object sender, EventArgs e)
        {
            var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            ApplicationUser user = manager.FindById(User.Identity.GetUserId());
            if (user != null)
            {
                user.FirstName = FirstName.Text;
                user.MiddleName = MiddleName.Text;
                user.LastName = LastName.Text;
                user.GenderID = Gender.GetValue();
                user.Address = Address.Text;
                user.PhoneNumber = PhoneNo.Text;
                IdentityResult result = manager.Update(user);
                if (result.Succeeded)
                {
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else
                {
                    ErrorMessage.Text = result.Errors.FirstOrDefault();
                }
            }
        }
    }
}