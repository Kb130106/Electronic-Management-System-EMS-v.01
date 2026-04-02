<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="ElectronicManagementSystem.AdminDashboard" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>
<style>
body{font-family:Arial;background:#f5f5f5;margin:0;}
.hdr{background:#003399;color:white;padding:10px 20px;overflow:hidden;}
.hdr .lft{float:left;font-size:15px;font-weight:bold;}
.hdr .rgt{float:right;font-size:13px;}
.hdr a{color:#ffff99;text-decoration:none;margin-left:14px;}
.pg{width:980px;margin:14px auto;}
.bx{background:white;border:1px solid #ccc;padding:16px;margin-bottom:14px;}
.bx h3{margin:0 0 12px;color:#003399;border-bottom:1px solid #ccc;padding-bottom:5px;font-size:15px;}
.srow{overflow:hidden;margin-bottom:14px;}
.scard{float:left;width:200px;background:white;border:1px solid #ccc;text-align:center;padding:14px 8px;margin-right:14px;}
.scard .num{font-size:36px;font-weight:bold;color:#003399;}
.scard .lbl{font-size:12px;color:#666;margin-top:3px;}
.qrow{overflow:hidden;margin-bottom:14px;}
.qrow a{float:left;background:white;border:1px solid #ccc;padding:9px 16px;margin-right:10px;text-decoration:none;color:#003399;font-size:13px;font-weight:bold;}
.qrow a:hover{background:#e0ecff;}
table.gv{width:100%;border-collapse:collapse;font-size:12px;}
table.gv th{background:#003399;color:white;padding:8px 7px;text-align:left;border:1px solid #002288;}
table.gv td{padding:6px 7px;border:1px solid #ddd;vertical-align:middle;}
table.gv tr:nth-child(even) td{background:#f0f5ff;}
</style>
</head>
<body>
<div class="hdr">
  <div class="lft">Admin Dashboard - EMS</div>
  <div class="rgt">
    Admin: <b><asp:Label ID="lblAdmin" runat="server" /></b>
    <a href="WebForm1.aspx">Manage Devices</a>
    <a href="AdminLogin.aspx">Logout</a>
  </div>
</div>
<div class="pg">
<form id="form1" runat="server">

  <div class="srow">
    <div class="scard"><div class="num"><asp:Label ID="lblDev" runat="server">0</asp:Label></div><div class="lbl">Total Devices</div></div>
    <div class="scard"><div class="num"><asp:Label ID="lblBrand" runat="server">0</asp:Label></div><div class="lbl">Total Brands</div></div>
    <div class="scard"><div class="num"><asp:Label ID="lblCust" runat="server">0</asp:Label></div><div class="lbl">Customers</div></div>
    <div class="scard"><div class="num"><asp:Label ID="lblLow" runat="server">0</asp:Label></div><div class="lbl">Low Stock (&lt;5)</div></div>
  </div>

  <div class="qrow">
    <a href="WebForm1.aspx">+ Add/Edit Device</a>
    <a href="Reg.aspx">+ Register Customer</a>
    <a href="Login.aspx">Customer Login</a>
  </div>

  <div class="bx">
    <h3>All Customers (tblCustomer)</h3>
    <asp:GridView ID="gvCustomers" runat="server"
        AutoGenerateColumns="false" EmptyDataText="No customers."
        GridLines="Both" Width="100%" Font-Size="12px">
      <HeaderStyle BackColor="#003399" ForeColor="White" Font-Bold="true" />
      <AlternatingRowStyle BackColor="#f0f5ff" />
      <Columns>
        <asp:BoundField DataField="Name"    HeaderText="Name" />
        <asp:BoundField DataField="Email"   HeaderText="Email" />
        <asp:BoundField DataField="Phone"   HeaderText="Phone"   ItemStyle-Width="90px" />
        <asp:BoundField DataField="City"    HeaderText="City"    ItemStyle-Width="80px" />
        <asp:BoundField DataField="Address" HeaderText="Address" />
        <asp:TemplateField HeaderText="Photo" ItemStyle-Width="60px">
          <ItemTemplate>
            <asp:Image runat="server"
                ImageUrl='<%# HasImg(Eval("picture")) ? ResolveUrl("~/" + Eval("picture").ToString()) : "" %>'
                Visible='<%# HasImg(Eval("picture")) %>'
                Width="45px" Height="45px"
                style="object-fit:cover;border:1px solid #ccc;border-radius:50%;" />
            <asp:Label runat="server" Text="No Photo"
                Visible='<%# !HasImg(Eval("picture")) %>'
                style="font-size:10px;color:#aaa;" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>

  <div class="bx">
    <h3>All Devices (tblDevice)</h3>
    <asp:GridView ID="gvDevices" runat="server"
        AutoGenerateColumns="false" EmptyDataText="No devices."
        GridLines="Both" Width="100%" Font-Size="12px">
      <HeaderStyle BackColor="#003399" ForeColor="White" Font-Bold="true" />
      <AlternatingRowStyle BackColor="#f0f5ff" />
      <Columns>
        <asp:BoundField DataField="d_id"        HeaderText="ID"    ItemStyle-Width="30px" />
        <asp:BoundField DataField="BrandName"   HeaderText="Brand" ItemStyle-Width="80px" />
        <asp:BoundField DataField="model"       HeaderText="Model" ItemStyle-Width="140px" />
        <asp:BoundField DataField="Price"       HeaderText="Price(Rs.)"
            DataFormatString="{0:N0}" HtmlEncode="false" ItemStyle-Width="70px" />
        <asp:BoundField DataField="quantity"    HeaderText="Qty"   ItemStyle-Width="35px" />
        <asp:BoundField DataField="color"       HeaderText="Color" ItemStyle-Width="70px" />
        <asp:BoundField DataField="accessories" HeaderText="Accessories" />
        <asp:TemplateField HeaderText="Image" ItemStyle-Width="58px">
          <ItemTemplate>
            <asp:Image runat="server"
                ImageUrl='<%# HasImg(Eval("img")) ? ResolveUrl("~/" + Eval("img").ToString()) : "" %>'
                Visible='<%# HasImg(Eval("img")) %>'
                Width="45px" Height="45px"
                style="object-fit:cover;border:1px solid #ccc;" />
            <asp:Label runat="server" Text="No Image"
                Visible='<%# !HasImg(Eval("img")) %>'
                style="font-size:10px;color:#aaa;" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>

</form>
</div>
</body>
</html>
