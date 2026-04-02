using System;
using System.Data.SqlClient;

namespace ElectronicManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Email"] != null) Response.Redirect("Welcome.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con;
                // Assignment 4: Verify credentials from tblCustomer using DataReader
                SqlDataReader dr = DB.Reader(
                    "SELECT Name,Email,Phone,Address,City,picture FROM tblCustomer WHERE Email=@e AND Password=@p",
                    new[] {
                        new SqlParameter("@e", txtEmail.Text.Trim()),
                        new SqlParameter("@p", txtPassword.Text.Trim())
                    }, out con);

                if (dr.Read())
                {
                    // Assignment 4: Store Email in session, redirect to Home page
                    Session["Email"]   = dr["Email"].ToString();
                    Session["Name"]    = dr["Name"].ToString();
                    Session["Phone"]   = dr["Phone"].ToString();
                    Session["Address"] = dr["Address"].ToString();
                    Session["City"]    = dr["City"].ToString();
                    Session["Picture"] = dr["picture"] == DBNull.Value ? "" : dr["picture"].ToString();
                    dr.Close();
                    Response.Redirect("Welcome.aspx");
                }
                else { dr.Close(); lblError.Text = "Invalid email or password!"; }
            }
            catch (Exception ex) { lblError.Text = "Error: " + ex.Message; }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        { txtEmail.Text = ""; txtPassword.Text = ""; lblError.Text = ""; }
    }
}
