<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="ElectronicManagementSystem.AdminLogin" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Login</title>
<style>
body { font-family: Arial; background: #f5f5f5; }
.box { width: 380px; margin: 80px auto; background: white; padding: 28px; border: 1px solid #cccccc; }
h2 { text-align: center; color: #003399; margin-bottom: 6px; }
.hint { background: #fffbe6; border: 1px solid #ddcc00; padding: 7px; font-size: 12px; text-align: center; margin-bottom: 14px; }
table { border-collapse: collapse; width: 100%; }
td { padding: 7px 5px; }
.lbl { font-weight: bold; width: 120px; }
input[type=text], input[type=password] { padding: 5px; border: 1px solid #bbbbbb; font-size: 13px; width: 210px; }
input[type=submit] { background: #003399; color: white; padding: 7px 20px; border: 1px solid #003399; font-size: 13px; cursor: pointer; }
.btngray { background: #eeeeee; border: 1px solid #999999; padding: 7px 16px; font-size: 13px; cursor: pointer; }
.errmsg { color: red; font-size: 12px; }
.badmsg { color: red; font-weight: bold; }
.lnk { text-align: center; margin-top: 12px; font-size: 13px; }
.lnk a { color: #003399; }
</style>
</head>
<body>
<div class="box">
    <h2>Admin Login</h2>
    <div class="hint">Username : <b>admin</b> &nbsp;|&nbsp; Password : <b>admin123</b></div>
    <form id="form1" runat="server">
        <asp:Label ID="lblError" runat="server" CssClass="badmsg" />
        <table>
            <tr>
                <td class="lbl">Username :</td>
                <td>
                    <asp:TextBox ID="txtUser" runat="server" Width="210px" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUser"
                        ErrorMessage="* required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">Password :</td>
                <td>
                    <asp:TextBox ID="txtPass" runat="server" TextMode="Password" Width="210px" /><br />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPass"
                        ErrorMessage="* required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="padding-top:10px;">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" ValidationGroup="vg" />
                    &nbsp;
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btngray" OnClick="btnClear_Click" CausesValidation="false" />
                </td>
            </tr>
        </table>
        <div class="lnk"><a href="Login.aspx">Customer Login</a></div>
    </form>
</div>
</body>
</html>
