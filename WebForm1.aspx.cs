using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web.UI.WebControls;

namespace ElectronicManagementSystem
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected bool HasImg(object v)
        { return v != null && v != DBNull.Value && v.ToString().Trim() != ""; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null) Response.Redirect("AdminLogin.aspx");
            if (!IsPostBack) { fnBindGrid(); BindFilterDDL(); }
        }

        protected void ddlType_Changed(object sender, EventArgs e)
        {
            ddlBrand.Items.Clear();
            ddlBrand.Items.Add(new ListItem("-- Select Brand --", ""));
            if (ddlType.SelectedValue != "")
            {
                DataTable dt = DB.GetTable(
                    "SELECT b_id,BrandName FROM tblBrand WHERE t_id=@t ORDER BY BrandName",
                    new[] { new SqlParameter("@t", ddlType.SelectedValue) });
                foreach (DataRow r in dt.Rows)
                    ddlBrand.Items.Add(new ListItem(r["BrandName"].ToString(), r["b_id"].ToString()));
            }
        }

        private void fnBindGrid(string bid = "0")
        {
            try
            {
                int b = 0; int.TryParse(bid, out b);
                gvDevices.DataSource = DB.GetTable(
                    @"SELECT d.d_id,b.BrandName,d.model,d.description,d.Price,
                             d.quantity,d.color,d.accessories,d.img
                      FROM tblDevice d INNER JOIN tblBrand b ON d.b_id=b.b_id
                      WHERE (@b=0 OR d.b_id=@b) ORDER BY d.d_id DESC",
                    new[] { new SqlParameter("@b", b) });
                gvDevices.DataBind();
            }
            catch (Exception ex)
            { lblGridMsg.Text = "<span class='badmsg'>"+ex.Message+"</span>"; }
        }

        private void BindFilterDDL()
        {
            ddlFilter.Items.Clear();
            ddlFilter.Items.Add(new ListItem("-- All Brands --","0"));
            DataTable dt = DB.GetTable("SELECT b_id,BrandName FROM tblBrand ORDER BY BrandName");
            foreach (DataRow r in dt.Rows)
                ddlFilter.Items.Add(new ListItem(r["BrandName"].ToString(), r["b_id"].ToString()));
        }

        protected void ddlFilter_Changed(object sender, EventArgs e)
        { fnBindGrid(ddlFilter.SelectedValue); }

        protected void gvDevices_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int did = Convert.ToInt32(gvDevices.DataKeys[gvDevices.SelectedIndex].Value);
                DataTable dt = DB.GetTable(
                    @"SELECT d.*,b.t_id FROM tblDevice d
                      INNER JOIN tblBrand b ON d.b_id=b.b_id WHERE d.d_id=@did",
                    new[] { new SqlParameter("@did", did) });
                if (dt.Rows.Count == 0) return;
                DataRow r = dt.Rows[0];

                hfDid.Value = r["d_id"].ToString();
                lblFormTitle.Text = "Edit Device (ID: " + did + ")";

                ddlType.SelectedValue = r["t_id"].ToString();
                ddlBrand.Items.Clear();
                ddlBrand.Items.Add(new ListItem("-- Select Brand --",""));
                DataTable brands = DB.GetTable(
                    "SELECT b_id,BrandName FROM tblBrand WHERE t_id=@t ORDER BY BrandName",
                    new[] { new SqlParameter("@t", r["t_id"].ToString()) });
                foreach (DataRow b in brands.Rows)
                    ddlBrand.Items.Add(new ListItem(b["BrandName"].ToString(), b["b_id"].ToString()));
                ddlBrand.SelectedValue = r["b_id"].ToString();

                txtModel.Text = r["model"].ToString();
                txtDesc.Text  = r["description"].ToString();
                txtPrice.Text = r["Price"].ToString();
                txtQty.Text   = r["quantity"].ToString();

                rblColor.ClearSelection();
                foreach (ListItem li in rblColor.Items)
                    if (li.Value == r["color"].ToString()) { li.Selected = true; break; }

                string sa = r["accessories"].ToString();
                cblAcc.ClearSelection();
                foreach (ListItem li in cblAcc.Items)
                    if (sa.Contains(li.Value)) li.Selected = true;

                if (r["img"] != DBNull.Value && r["img"].ToString() != "")
                {
                    imgThumb.ImageUrl  = "~/" + r["img"].ToString();
                    imgThumb.Visible   = true;
                    lblImgStatus.Text  = "Current image shown above";
                }
                else { imgThumb.Visible = false; lblImgStatus.Text = ""; }

                pnlOutput.Visible = false;
                Page.ClientScript.RegisterStartupScript(GetType(), "scrollTop", "window.scrollTo(0,0);", true);
                lblMsg.Text = "<span style='color:blue;font-weight:bold;'>Editing ID "+did+" - change values and click Submit.</span>";
            }
            catch (Exception ex)
            { lblMsg.Text = "<span class='badmsg'>Error: "+ex.Message+"</span>"; }
        }

        protected void gvDevices_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int did = Convert.ToInt32(gvDevices.DataKeys[e.RowIndex].Value);
                DB.Run("DELETE FROM tblDevice WHERE d_id=@did",
                    new[] { new SqlParameter("@did", did) });
                lblGridMsg.Text = "<span class='okmsg'>Device deleted.</span>";
                fnBindGrid(ddlFilter.SelectedValue);
            }
            catch (Exception ex)
            { lblGridMsg.Text = "<span class='badmsg'>Delete error: "+ex.Message+"</span>"; }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                var acc = new StringBuilder();
                foreach (ListItem li in cblAcc.Items)
                    if (li.Selected) { if (acc.Length>0) acc.Append(","); acc.Append(li.Value); }

                string imgPath = null;
                if (fuImg.HasFile)
                {
                    string ext = Path.GetExtension(fuImg.FileName).ToLower();
                    if (ext==".jpg"||ext==".jpeg"||ext==".png"||ext==".gif")
                    {
                        string dir = Server.MapPath("~/Uploads/");
                        if (!Directory.Exists(dir)) Directory.CreateDirectory(dir);
                        string fn = "dev_" + DateTime.Now.Ticks + ext;
                        fuImg.SaveAs(Path.Combine(dir, fn));
                        imgPath = "Uploads/" + fn;
                        imgThumb.ImageUrl = "~/" + imgPath;
                        imgThumb.Visible  = true;
                        lblImgStatus.Text = "Uploaded: " + fuImg.FileName;
                    }
                    else { lblMsg.Text="<span class='badmsg'>Only JPG or PNG allowed!</span>"; return; }
                }

                int did = Convert.ToInt32(hfDid.Value);
                if (did == 0)
                {
                    DB.Run(@"INSERT INTO tblDevice(b_id,model,description,Price,quantity,color,accessories,img)
                             VALUES(@bid,@m,@d,@p,@q,@c,@a,@img)",
                        new[] {
                            new SqlParameter("@bid", int.Parse(ddlBrand.SelectedValue)),
                            new SqlParameter("@m",   txtModel.Text.Trim()),
                            new SqlParameter("@d",   txtDesc.Text.Trim()),
                            new SqlParameter("@p",   decimal.Parse(txtPrice.Text)),
                            new SqlParameter("@q",   int.Parse(txtQty.Text)),
                            new SqlParameter("@c",   rblColor.SelectedValue),
                            new SqlParameter("@a",   acc.ToString()),
                            new SqlParameter("@img", (object)imgPath ?? DBNull.Value)
                        });
                    lblMsg.Text = "<span class='okmsg'>Device added!</span>";
                }
                else
                {
                    if (imgPath != null)
                        DB.Run(@"UPDATE tblDevice SET b_id=@bid,model=@m,description=@d,
                                 Price=@p,quantity=@q,color=@c,accessories=@a,img=@img WHERE d_id=@did",
                            new[] {
                                new SqlParameter("@bid", int.Parse(ddlBrand.SelectedValue)),
                                new SqlParameter("@m",   txtModel.Text.Trim()),
                                new SqlParameter("@d",   txtDesc.Text.Trim()),
                                new SqlParameter("@p",   decimal.Parse(txtPrice.Text)),
                                new SqlParameter("@q",   int.Parse(txtQty.Text)),
                                new SqlParameter("@c",   rblColor.SelectedValue),
                                new SqlParameter("@a",   acc.ToString()),
                                new SqlParameter("@img", imgPath),
                                new SqlParameter("@did", did)
                            });
                    else
                        DB.Run(@"UPDATE tblDevice SET b_id=@bid,model=@m,description=@d,
                                 Price=@p,quantity=@q,color=@c,accessories=@a WHERE d_id=@did",
                            new[] {
                                new SqlParameter("@bid", int.Parse(ddlBrand.SelectedValue)),
                                new SqlParameter("@m",   txtModel.Text.Trim()),
                                new SqlParameter("@d",   txtDesc.Text.Trim()),
                                new SqlParameter("@p",   decimal.Parse(txtPrice.Text)),
                                new SqlParameter("@q",   int.Parse(txtQty.Text)),
                                new SqlParameter("@c",   rblColor.SelectedValue),
                                new SqlParameter("@a",   acc.ToString()),
                                new SqlParameter("@did", did)
                            });
                    lblMsg.Text = "<span class='okmsg'>Device updated!</span>";
                }

                string a2 = "";
                foreach (ListItem li in cblAcc.Items)
                    if (li.Selected) a2 += (a2==""?"":", ") + li.Value;
                lblOutput.Text =
                    "<table><tr><td>Type</td><td>"+Server.HtmlEncode(ddlType.SelectedItem.Text)+"</td></tr>"+
                    "<tr><td>Brand</td><td>"+Server.HtmlEncode(ddlBrand.SelectedItem.Text)+"</td></tr>"+
                    "<tr><td>Model</td><td>"+Server.HtmlEncode(txtModel.Text)+"</td></tr>"+
                    "<tr><td>Description</td><td>"+Server.HtmlEncode(txtDesc.Text)+"</td></tr>"+
                    "<tr><td>Price</td><td>Rs. "+txtPrice.Text+"</td></tr>"+
                    "<tr><td>Quantity</td><td>"+txtQty.Text+"</td></tr>"+
                    "<tr><td>Color</td><td>"+rblColor.SelectedValue+"</td></tr>"+
                    "<tr><td>Accessories</td><td>"+(a2==""?"None":a2)+"</td></tr></table>";
                pnlOutput.Visible = true;

                fnBindGrid(ddlFilter.SelectedValue);
                BindFilterDDL();
                ClearForm();
            }
            catch (Exception ex)
            { lblMsg.Text = "<span class='badmsg'>Error: "+ex.Message+"</span>"; }
        }

        protected void btnReset_Click(object sender, EventArgs e) { ClearForm(); }

        private void ClearForm()
        {
            hfDid.Value = "0";
            lblFormTitle.Text = "Add New Device";
            ddlType.SelectedIndex = 0;
            ddlBrand.Items.Clear();
            ddlBrand.Items.Add(new ListItem("-- Select Brand --",""));
            txtModel.Text=""; txtDesc.Text=""; txtPrice.Text=""; txtQty.Text="";
            rblColor.ClearSelection(); rblColor.Items[1].Selected = true;
            cblAcc.ClearSelection();
            imgThumb.Visible=false; lblImgStatus.Text="";
            pnlOutput.Visible=false; lblMsg.Text="";
        }
    }
}
