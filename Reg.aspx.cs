using System;
using System.Data.SqlClient;
using System.IO;

namespace ElectronicManagementSystem
{
    public partial class Reg : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                int n = Convert.ToInt32(DB.Val("SELECT COUNT(*) FROM tblCustomer WHERE Email=@e",
                    new[] { new SqlParameter("@e", txtEmail.Text.Trim()) }));
                if (n > 0) { lblMsg.Text = "<span class='badmsg'>This email is already registered!</span>"; return; }

                // Assignment 5: Upload profile picture to Uploads folder
                string picPath = null;
                if (fuPic.HasFile)
                {
                    string ext = Path.GetExtension(fuPic.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png")
                    {
                        string dir = Server.MapPath("~/Uploads/");
                        if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                        string fn = "cust_" + DateTime.Now.Ticks + ext;
                        fuPic.SaveAs(Path.Combine(dir, fn));
                        picPath = "Uploads/" + fn;
                        imgPreview.ImageUrl = ResolveUrl("~/" + picPath);
                        imgPreview.Visible  = true;
                    }
                    else { lblMsg.Text = "<span class='badmsg'>Only JPG or PNG allowed!</span>"; return; }
                }

                // Confirm password NOT saved in DB (Assignment 3)
                DB.Run(@"INSERT INTO tblCustomer(Name,Email,Phone,Address,Password,City,picture)
                         VALUES(@n,@e,@ph,@ad,@pw,@ct,@pic)",
                    new[] {
                        new SqlParameter("@n",   txtName.Text.Trim()),
                        new SqlParameter("@e",   txtEmail.Text.Trim()),
                        new SqlParameter("@ph",  txtPhone.Text.Trim()),
                        new SqlParameter("@ad",  txtAddress.Text.Trim()),
                        new SqlParameter("@pw",  txtPassword.Text),
                        new SqlParameter("@ct",  txtCity.Text.Trim()),
                        new SqlParameter("@pic", (object)picPath ?? DBNull.Value)
                    });

                lblMsg.Text = "<span class='okmsg'>Registration successful! <a href='Login.aspx'>Click here to Login</a></span>";
                ClearForm();
            }
            catch (Exception ex) { lblMsg.Text = "<span class='badmsg'>Error: " + ex.Message + "</span>"; }
        }

        protected void btnReset_Click(object sender, EventArgs e) { ClearForm(); lblMsg.Text = ""; }

        void ClearForm()
        {
            txtName.Text = ""; txtEmail.Text = ""; txtPhone.Text = "";
            txtAddress.Text = ""; txtCity.Text = ""; txtPassword.Text = ""; txtConfirm.Text = "";
            imgPreview.Visible = false;
        }
    }
}
