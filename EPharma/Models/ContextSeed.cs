using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace EPharma.Models
{
    public enum Roles
    {
        Admin,
        User
    }
    public static class ContextSeed
    {
        public static  void SeedRoles(UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            if (roleManager == null)
            {
                throw new ArgumentNullException(nameof(roleManager));
            }
            //Seed Roles
             roleManager.Create(new IdentityRole(Roles.Admin.ToString()));
             roleManager.Create(new IdentityRole(Roles.User.ToString()));
        }

        public static void SeedAdmin(UserManager<ApplicationUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            if (roleManager == null)
            {
                throw new ArgumentNullException(nameof(roleManager));
            }
            if (userManager == null)
            {
                throw new ArgumentNullException(nameof(userManager));
            }
            //Seed Admin
            var admin = new ApplicationUser();
            admin.FirstName = "Admin";
            admin.Email = "admin@admin.com";
            admin.GenderID = 1;
            admin.UserName = "admin@admin.com";
            admin.Active = true;
            var Admin = userManager.FindByName("admin@admin.com");
            if (Admin == null)
            {
                IdentityResult result = userManager.Create(admin, "Admin@1");
                if (result.Succeeded)
                {
                    userManager.AddToRole(admin.Id, "Admin");
                }
                else
                {
                    throw new ArgumentNullException(result.Errors.FirstOrDefault());
                }
            }
        }
    }
}