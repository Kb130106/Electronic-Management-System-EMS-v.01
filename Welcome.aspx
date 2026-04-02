<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Welcome.aspx.cs" Inherits="ElectronicManagementSystem.Welcome" %>
<!DOCTYPE html>
<html>
<head>
<title>Welcome - EMS</title>
<style>
body{font-family:Arial;background:#f5f5f5;margin:0;}
.topbar{background:#003399;color:white;padding:10px 20px;overflow:hidden;}
.topbar .lft{float:left;font-size:15px;font-weight:bold;}
.topbar .rgt{float:right;font-size:13px;line-height:1.8;}
.topbar a{color:#ffff99;text-decoration:none;margin-left:14px;}
.pg{width:960px;margin:14px auto;}
.bx{background:white;border:1px solid #ccc;padding:16px;margin-bottom:14px;}
.bx h3{margin:0 0 12px;color:#003399;border-bottom:1px solid #ccc;padding-bottom:5px;font-size:15px;}
.prow{overflow:hidden;}
.ppic{float:left;margin-right:18px;text-align:center;}
.ppic img{width:90px;height:90px;object-fit:cover;border:2px solid #003399;border-radius:5px;}
.nopic{width:90px;height:90px;background:#ddeeff;border:2px solid #003399;border-radius:5px;line-height:90px;text-align:center;font-size:34px;}
.pinfo table{border-collapse:collapse;}
.pinfo td{padding:4px 10px;border-bottom:1px solid #eee;font-size:13px;}
.pinfo td:first-child{font-weight:bold;width:80px;color:#003399;background:#f0f5ff;}
table.reptbl{width:100%;border-collapse:collapse;font-size:12px;}
table.reptbl th{background:#003399;color:white;padding:8px 7px;text-align:left;border:1px solid #002288;}
table.reptbl td{padding:6px 7px;border:1px solid #ddd;vertical-align:middle;}
table.reptbl tr.alt td{background:#f0f5ff;}
.dimg{width:50px;height:50px;object-fit:cover;border:1px solid #ccc;border-radius:3px;}
.noimg{width:50px;height:50px;background:#eee;border:1px solid #ccc;display:inline-block;text-align:center;line-height:50px;font-size:10px;color:#aaa;}
.dlcard{display:inline-block;width:145px;border:1px solid #ccc;background:white;padding:9px 7px;text-align:center;font-size:12px;margin:4px;vertical-align:top;}
.dlcard img{width:80px;height:80px;object-fit:cover;border:1px solid #ccc;border-radius:3px;}
.dlcard .noimg2{width:80px;height:80px;background:#eee;border:1px solid #ccc;line-height:80px;font-size:11px;color:#aaa;margin:auto;}
.dlcard b{display:block;color:#003399;margin:6px 0 3px;font-size:12px;}
.dlcard span{display:block;color:#555;margin-bottom:2px;}
</style>
</head>
<body>
<div class="topbar">
  <div class="lft">Electronics Management System</div>
  <div class="rgt">
    Logged in as :&nbsp;<b><asp:Label ID="lblSessionEmail" runat="server" /></b>
    <a href="Logout.aspx">Logout</a>
  </div>
</div>
<div class="pg">
<form id="form1" runat="server">

  <div class="bx">
    <h3>Welcome, <asp:Label ID="lblWelcomeName" runat="server" />!</h3>
    <div class="prow">
      <div class="ppic">
        <asp:Image ID="imgProfilePic" runat="server" Visible="false" />
        <asp:Panel ID="pnlNoPic" runat="server">
          <div class="nopic">&#128100;</div>
        </asp:Panel>
        <br /><small style="color:#888;font-size:11px;"><asp:Label ID="lblPicCaption" runat="server" /></small>
      </div>
      <div class="pinfo">
        <table>
          <tr><td>Name</td>    <td><asp:Label ID="lblName"    runat="server" /></td></tr>
          <tr><td>Email</td>   <td><asp:Label ID="lblEmail"   runat="server" /></td></tr>
          <tr><td>Phone</td>   <td><asp:Label ID="lblPhone"   runat="server" /></td></tr>
          <tr><td>Address</td> <td><asp:Label ID="lblAddress" runat="server" /></td></tr>
          <tr><td>City</td>    <td><asp:Label ID="lblCity"    runat="server" /></td></tr>
        </table>
      </div>
    </div>
  </div>

  <div class="bx">
    <h3>All Devices &mdash; Repeater Control</h3>
    <asp:Repeater ID="rptDevices" runat="server">
      <HeaderTemplate>
        <table class="reptbl">
          <tr><th>Image</th><th>ID</th><th>Brand</th><th>Model</th><th>Description</th><th>Price(Rs.)</th><th>Qty</th><th>Color</th><th>Accessories</th></tr>
      </HeaderTemplate>
      <ItemTemplate>
        <tr>
          <td>
            <asp:Image runat="server" CssClass="dimg"
                ImageUrl='<%# HasImg(Eval("img")) ? ResolveUrl("~/" + Eval("img").ToString()) : "" %>'
                Visible='<%# HasImg(Eval("img")) %>' />
            <asp:Label runat="server" CssClass="noimg" Text="No Img" Visible='<%# !HasImg(Eval("img")) %>' />
          </td>
          <td><%# Eval("d_id") %></td>
          <td><%# Eval("BrandName") %></td>
          <td><b><%# Eval("model") %></b></td>
          <td style="max-width:170px;font-size:11px;color:#555;"><%# Eval("description") %></td>
          <td><b><%# string.Format("{0:N0}",Eval("Price")) %></b></td>
          <td><%# Eval("quantity") %></td>
          <td><%# Eval("color") %></td>
          <td style="font-size:11px;"><%# Eval("accessories") %></td>
        </tr>
      </ItemTemplate>
      <AlternatingItemTemplate>
        <tr class="alt">
          <td>
            <asp:Image runat="server" CssClass="dimg"
                ImageUrl='<%# HasImg(Eval("img")) ? ResolveUrl("~/" + Eval("img").ToString()) : "" %>'
                Visible='<%# HasImg(Eval("img")) %>' />
            <asp:Label runat="server" CssClass="noimg" Text="No Img" Visible='<%# !HasImg(Eval("img")) %>' />
          </td>
          <td><%# Eval("d_id") %></td>
          <td><%# Eval("BrandName") %></td>
          <td><b><%# Eval("model") %></b></td>
          <td style="max-width:170px;font-size:11px;color:#555;"><%# Eval("description") %></td>
          <td><b><%# string.Format("{0:N0}",Eval("Price")) %></b></td>
          <td><%# Eval("quantity") %></td>
          <td><%# Eval("color") %></td>
          <td style="font-size:11px;"><%# Eval("accessories") %></td>
        </tr>
      </AlternatingItemTemplate>
      <FooterTemplate></table></FooterTemplate>
    </asp:Repeater>
  </div>

  <div class="bx">
    <h3>All Devices &mdash; DataList Control</h3>
    <asp:DataList ID="dlDevices" runat="server"
        RepeatDirection="Horizontal" RepeatColumns="6" RepeatLayout="Flow">
      <ItemTemplate>
        <div class="dlcard">
          <asp:Image runat="server"
              ImageUrl='<%# HasImg(Eval("img")) ? ResolveUrl("~/" + Eval("img").ToString()) : "" %>'
              Visible='<%# HasImg(Eval("img")) %>'
              Width="80px" Height="80px" style="object-fit:cover;border:1px solid #ccc;border-radius:3px;" />
          <div class="noimg2" style='<%# HasImg(Eval("img")) ? "display:none;" : "" %>'>No Image</div>
          <b><%# Eval("model") %></b>
          <span><%# Eval("BrandName") %></span>
          <span>Rs. <%# string.Format("{0:N0}",Eval("Price")) %></span>
          <span>Qty: <%# Eval("quantity") %></span>
        </div>
      </ItemTemplate>
    </asp:DataList>
  </div>

</form>
</div>
</body>
</html>
