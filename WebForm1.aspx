<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="ElectronicManagementSystem.WebForm1" %>
<!DOCTYPE html>
<html>
<head>
<title>Device Management</title>
<style>
body{font-family:Arial;background:#f5f5f5;margin:0;}
.hdr{background:#003399;color:white;padding:10px 20px;font-size:15px;font-weight:bold;}
.hdr a{color:#ffff99;text-decoration:none;font-size:13px;margin-left:18px;font-weight:normal;}
.pg{width:1000px;margin:14px auto;}
.bx{background:white;border:1px solid #ccc;padding:18px;margin-bottom:16px;}
.bx h3{margin:0 0 12px;color:#003399;border-bottom:1px solid #ccc;padding-bottom:5px;font-size:15px;}
table.ftbl{border-collapse:collapse;}
table.ftbl td{padding:5px 7px;vertical-align:top;}
table.ftbl td.lb{font-weight:bold;width:140px;padding-top:9px;}
input[type=text],textarea,select{padding:5px 6px;border:1px solid #bbb;font-size:13px;}
.bblu{background:#003399;color:white;padding:7px 20px;border:1px solid #003399;font-size:13px;cursor:pointer;}
.bgry{background:#eee;border:1px solid #999;padding:7px 18px;font-size:13px;cursor:pointer;}
.errmsg{color:red;font-size:12px;}
.okmsg{color:green;font-weight:bold;}
.badmsg{color:red;font-weight:bold;}
.outbx{background:#eef5ff;border:1px solid #003399;padding:12px;margin-top:12px;font-size:13px;}
.outbx table td{padding:3px 8px;}
.outbx table td:first-child{font-weight:bold;color:#003399;width:110px;}
table.gv{width:100%;border-collapse:collapse;font-size:12px;}
table.gv th{background:#003399;color:white;padding:8px 7px;text-align:left;border:1px solid #002288;}
table.gv td{padding:6px 7px;border:1px solid #ddd;vertical-align:middle;}
table.gv tr:nth-child(even) td{background:#f0f5ff;}
table.gv tr.selrow td{background:#cce0ff!important;}
.devimg{width:50px;height:50px;object-fit:cover;border:1px solid #ccc;}
.imgthumb{width:70px;height:70px;object-fit:cover;border:1px solid #ccc;margin-top:5px;display:block;}
.filtrow{margin-bottom:10px;font-size:13px;}
</style>
</head>
<body>
<div class="hdr">Electronics Management System - Admin
  <a href="AdminDashboard.aspx">Dashboard</a>
  <a href="AdminLogin.aspx">Logout</a>
</div>
<div class="pg">
<form id="form1" runat="server">
<asp:HiddenField ID="hfDid" runat="server" Value="0" />

<div class="bx">
  <h3><asp:Label ID="lblFormTitle" runat="server" Text="Add New Device" /></h3>
  <asp:Label ID="lblMsg" runat="server" /><br />
  <table class="ftbl">
    <tr>
      <td class="lb">Type :</td>
      <td>
        <asp:DropDownList ID="ddlType" runat="server" Width="200px"
            AutoPostBack="true" OnSelectedIndexChanged="ddlType_Changed">
          <asp:ListItem Value="">-- Select Type --</asp:ListItem>
          <asp:ListItem Value="1">Mobile</asp:ListItem>
          <asp:ListItem Value="2">Laptop</asp:ListItem>
          <asp:ListItem Value="3">Tablet</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlType" InitialValue=""
            ErrorMessage=" * Select type" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
      </td>
    </tr>
    <tr>
      <td class="lb">Brand :</td>
      <td>
        <asp:DropDownList ID="ddlBrand" runat="server" Width="200px">
          <asp:ListItem Value="">-- Select Brand --</asp:ListItem>
        </asp:DropDownList>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlBrand" InitialValue=""
            ErrorMessage=" * Select brand" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
      </td>
    </tr>
    <tr>
      <td class="lb">Model :</td>
      <td>
        <asp:TextBox ID="txtModel" runat="server" Width="260px" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtModel"
            ErrorMessage=" * required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
      </td>
    </tr>
    <tr>
      <td class="lb">Description :</td>
      <td><asp:TextBox ID="txtDesc" runat="server" TextMode="MultiLine" Rows="3" Width="320px" /></td>
    </tr>
    <tr>
      <td class="lb">Price (Rs.) :</td>
      <td>
        <asp:TextBox ID="txtPrice" runat="server" Width="130px" TextMode="Number" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPrice"
            ErrorMessage=" * required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
        <asp:CompareValidator runat="server" ControlToValidate="txtPrice"
            Operator="GreaterThan" ValueToCompare="0" Type="Double"
            ErrorMessage=" * must be &gt; 0" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
      </td>
    </tr>
    <tr>
      <td class="lb">Quantity :</td>
      <td>
        <asp:TextBox ID="txtQty" runat="server" Width="80px" TextMode="Number" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtQty"
            ErrorMessage=" * required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
        <asp:CompareValidator runat="server" ControlToValidate="txtQty"
            Operator="GreaterThan" ValueToCompare="0" Type="Integer"
            ErrorMessage=" * must be &gt; 0" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
      </td>
    </tr>
    <tr>
      <td class="lb">Colors :</td>
      <td>
        <asp:RadioButtonList ID="rblColor" runat="server" RepeatDirection="Horizontal" RepeatColumns="4">
          <asp:ListItem Value="Blue">Blue</asp:ListItem>
          <asp:ListItem Value="Black" Selected="True">Black</asp:ListItem>
          <asp:ListItem Value="Gold">Gold</asp:ListItem>
          <asp:ListItem Value="Rose Gold">Rose Gold</asp:ListItem>
        </asp:RadioButtonList>
      </td>
    </tr>
    <tr>
      <td class="lb">Accessories :</td>
      <td>
        <asp:CheckBoxList ID="cblAcc" runat="server" RepeatDirection="Horizontal" RepeatColumns="4">
          <asp:ListItem Value="Charger">Charger</asp:ListItem>
          <asp:ListItem Value="Headphones">Headphones</asp:ListItem>
          <asp:ListItem Value="Touch Pen">Touch Pen</asp:ListItem>
          <asp:ListItem Value="Wireless Mouse">Wireless Mouse</asp:ListItem>
        </asp:CheckBoxList>
      </td>
    </tr>
    <tr>
      <td class="lb">Device Image :</td>
      <td>
        <asp:FileUpload ID="fuImg" runat="server" /><br />
        <small style="color:#888;">JPG / PNG only (optional)</small><br />
        <asp:Image ID="imgThumb" runat="server" CssClass="imgthumb" Visible="false" />
        <asp:Label ID="lblImgStatus" runat="server" style="color:green;font-size:12px;" />
      </td>
    </tr>
    <tr>
      <td></td>
      <td style="padding-top:10px;">
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="bblu"
            OnClick="btnSubmit_Click" ValidationGroup="vg" />
        &nbsp;&nbsp;
        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="bgry"
            OnClick="btnReset_Click" CausesValidation="false" />
      </td>
    </tr>
  </table>
  <asp:Panel ID="pnlOutput" runat="server" Visible="false">
    <div class="outbx">
      <b>Submitted Device Details :</b>
      <asp:Label ID="lblOutput" runat="server" />
    </div>
  </asp:Panel>
</div>

<div class="bx">
  <h3>Device List &nbsp;<small style="font-size:12px;font-weight:normal;color:#666;">(Click Select to edit a row)</small></h3>
  <div class="filtrow">
    <b>Filter by Brand :</b>&nbsp;
    <asp:DropDownList ID="ddlFilter" runat="server" Width="180px"
        AutoPostBack="true" OnSelectedIndexChanged="ddlFilter_Changed">
      <asp:ListItem Value="0">-- All Brands --</asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;<asp:Label ID="lblGridMsg" runat="server" />
  </div>
  <div style="overflow-x:auto;">
    <asp:GridView ID="gvDevices" runat="server"
        AutoGenerateColumns="false"
        AutoGenerateSelectButton="true"
        AutoGenerateDeleteButton="true"
        DataKeyNames="d_id"
        OnRowDeleting="gvDevices_RowDeleting"
        OnSelectedIndexChanged="gvDevices_SelectedIndexChanged"
        EmptyDataText="No devices found."
        GridLines="Both" Width="100%" Font-Size="12px" CssClass="gv">
      <HeaderStyle BackColor="#003399" ForeColor="White" Font-Bold="true" />
      <AlternatingRowStyle BackColor="#f0f5ff" />
      <SelectedRowStyle BackColor="#cce0ff" ForeColor="Black" />
      <Columns>
        <asp:BoundField DataField="d_id"        HeaderText="ID"           ItemStyle-Width="30px" />
        <asp:BoundField DataField="BrandName"   HeaderText="Brand"        ItemStyle-Width="90px" />
        <asp:BoundField DataField="model"       HeaderText="Model"        ItemStyle-Width="150px" />
        <asp:BoundField DataField="description" HeaderText="Description" />
        <asp:BoundField DataField="Price"       HeaderText="Price(Rs.)"
            DataFormatString="{0:N0}" HtmlEncode="false"  ItemStyle-Width="75px" />
        <asp:BoundField DataField="quantity"    HeaderText="Qty"          ItemStyle-Width="35px" />
        <asp:BoundField DataField="color"       HeaderText="Color"        ItemStyle-Width="70px" />
        <asp:BoundField DataField="accessories" HeaderText="Accessories"  ItemStyle-Width="120px" />
        <asp:TemplateField HeaderText="Image" ItemStyle-Width="60px">
          <ItemTemplate>
            <asp:Image runat="server"
                ImageUrl='<%# HasImg(Eval("img")) ? ResolveUrl("~/" + Eval("img").ToString()) : "" %>'
                Visible='<%# HasImg(Eval("img")) %>'
                CssClass="devimg" />
            <asp:Label runat="server" Text="No Img"
                Visible='<%# !HasImg(Eval("img")) %>'
                style="font-size:10px;color:#aaa;" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>
  </div>
</div>

</form>
</div>
</body>
</html>
