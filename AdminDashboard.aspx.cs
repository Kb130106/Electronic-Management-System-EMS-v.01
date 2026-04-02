using System;
namespace ElectronicManagementSystem
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected bool HasImg(object v)
        { return v != null && v != System.DBNull.Value && v.ToString().Trim() != ""; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null) Response.Redirect("AdminLogin.aspx");
            lblAdmin.Text = Session["Admin"].ToString();
            if (!IsPostBack) Load();
        }

        void Load()
        {
            try
            {
                lblDev.Text   = DB.Val("SELECT COUNT(*) FROM tblDevice").ToString();
                lblBrand.Text = DB.Val("SELECT COUNT(*) FROM tblBrand").ToString();
                lblCust.Text  = DB.Val("SELECT COUNT(*) FROM tblCustomer").ToString();
                lblLow.Text   = DB.Val("SELECT COUNT(*) FROM tblDevice WHERE quantity<5").ToString();

                gvCustomers.DataSource = DB.GetTable(
                    "SELECT Name,Email,Phone,City,Address,picture FROM tblCustomer ORDER BY Name");
                gvCustomers.DataBind();

                gvDevices.DataSource = DB.GetTable(
                    @"SELECT d.d_id,b.BrandName,d.model,d.Price,d.quantity,d.color,d.accessories,d.img
                      FROM tblDevice d INNER JOIN tblBrand b ON d.b_id=b.b_id ORDER BY d.d_id DESC");
                gvDevices.DataBind();
            }
            catch (Exception ex) { lblAdmin.Text += " | Error: " + ex.Message; }
        }
    }
}
