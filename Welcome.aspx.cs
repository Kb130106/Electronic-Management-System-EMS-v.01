using System;
using System.Data;
using System.Data.SqlClient;

namespace ElectronicManagementSystem
{
    public partial class Welcome : System.Web.UI.Page
    {
        protected bool HasImg(object v)
        { return v != null && v != DBNull.Value && v.ToString().Trim() != ""; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Email"] == null) Response.Redirect("Login.aspx");
            if (!IsPostBack) { LoadCustomer(); BindDevices(); }
        }

        void LoadCustomer()
        {
            lblSessionEmail.Text = Session["Email"].ToString();

            SqlConnection con;
            SqlDataReader dr = DB.Reader(
                "SELECT Name,Email,Phone,Address,City,picture FROM tblCustomer WHERE Email=@e",
                new[] { new SqlParameter("@e", Session["Email"].ToString()) }, out con);

            if (dr.Read())
            {
                lblWelcomeName.Text = dr["Name"].ToString();
                lblName.Text    = dr["Name"].ToString();
                lblEmail.Text   = dr["Email"].ToString();
                lblPhone.Text   = dr["Phone"].ToString();
                lblAddress.Text = dr["Address"].ToString();
                lblCity.Text    = dr["City"].ToString();

                string pic = dr["picture"] == DBNull.Value ? "" : dr["picture"].ToString().Trim();
                if (pic != "") Session["Picture"] = pic;

                string picPath = Session["Picture"] != null ? Session["Picture"].ToString().Trim() : "";

                if (picPath != "")
                {
                    imgProfilePic.ImageUrl = ResolveUrl("~/" + picPath);
                    imgProfilePic.Width    = new System.Web.UI.WebControls.Unit(90);
                    imgProfilePic.Height   = new System.Web.UI.WebControls.Unit(90);
                    imgProfilePic.Style["object-fit"]    = "cover";
                    imgProfilePic.Style["border"]        = "2px solid #003399";
                    imgProfilePic.Style["border-radius"] = "5px";
                    imgProfilePic.Visible   = true;
                    pnlNoPic.Visible        = false;
                    lblPicCaption.Text      = "Profile Photo";
                }
                else
                {
                    imgProfilePic.Visible = false;
                    pnlNoPic.Visible      = true;
                    lblPicCaption.Text    = "No photo uploaded";
                }
            }
            dr.Close();
        }

        void BindDevices()
        {
            DataTable dt = DB.GetTable(
                @"SELECT d.d_id,b.BrandName,d.model,d.description,
                         d.Price,d.quantity,d.color,d.accessories,d.img
                  FROM tblDevice d INNER JOIN tblBrand b ON d.b_id=b.b_id ORDER BY d.d_id");
            rptDevices.DataSource = dt; rptDevices.DataBind();
            dlDevices.DataSource  = dt; dlDevices.DataBind();
        }
    }
}
