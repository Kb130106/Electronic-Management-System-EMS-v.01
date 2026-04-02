using System;
namespace ElectronicManagementSystem
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        { if (Session["Admin"] != null) Response.Redirect("AdminDashboard.aspx"); }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtUser.Text.Trim() == "admin" && txtPass.Text.Trim() == "admin123")
            { Session["Admin"] = "admin"; Response.Redirect("AdminDashboard.aspx"); }
            else
            { lblError.Text = "Invalid username or password!"; }
        }
        protected void btnClear_Click(object sender, EventArgs e)
        { txtUser.Text = ""; txtPass.Text = ""; lblError.Text = ""; }
    }
}
