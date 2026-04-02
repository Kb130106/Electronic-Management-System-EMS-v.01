<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reg.aspx.cs" Inherits="ElectronicManagementSystem.Reg" %>
<!DOCTYPE html>
<html>
<head>
<title>Customer Registration</title>
<style>
body { font-family: Arial; background: #f5f5f5; }
.box { width: 520px; margin: 30px auto; background: white; padding: 25px; border: 1px solid #cccccc; }
h2 { text-align: center; color: #003399; margin-bottom: 16px; }
/* No table border - Assignment 1 style */
table { border-collapse: collapse; width: 100%; }
td { padding: 6px 6px; vertical-align: top; }
.lbl { font-weight: bold; width: 155px; padding-top: 9px; }
input[type=text], input[type=password], textarea
    { padding: 5px; border: 1px solid #bbbbbb; font-size: 13px; width: 220px; }
textarea { height: 55px; resize: vertical; }
input[type=submit] { background: #003399; color: white; padding: 7px 20px; border: 1px solid #003399; font-size: 13px; cursor: pointer; }
input[type=button], .btngray { background: #eeeeee; border: 1px solid #999999; padding: 7px 18px; font-size: 13px; cursor: pointer; }
.errmsg { color: red; font-size: 12px; display: block; }
.okmsg  { color: green; font-weight: bold; font-size: 13px; }
.badmsg { color: red;   font-weight: bold; font-size: 13px; }
.lnk { text-align: center; margin-top: 12px; font-size: 13px; }
.lnk a { color: #003399; }
.picpreview { width: 75px; height: 75px; object-fit: cover; border: 1px solid #cccccc; margin-top: 5px; display: block; }
</style>
</head>
<body>
<div class="box">
    <h2>Customer Registration</h2>
    <form id="form1" runat="server">

        <asp:Label ID="lblMsg" runat="server" /><br />

        <table>
            <tr>
                <td class="lbl">Full Name :</td>
                <td>
                    <asp:TextBox ID="txtName" runat="server" Width="220px" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtName"
                        ErrorMessage="* Name required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">Email :</td>
                <td>
                    <asp:TextBox ID="txtEmail" runat="server" Width="220px" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                        ErrorMessage="* Email required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                    <!-- Assignment 3: RegularExpressionValidator for Email -->
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail"
                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        ErrorMessage="* Invalid email format" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">Phone :</td>
                <td>
                    <asp:TextBox ID="txtPhone" runat="server" Width="220px" MaxLength="10" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone"
                        ErrorMessage="* Phone required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                    <!-- Assignment 3: RegularExpressionValidator [0-9]{10} -->
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone"
                        ValidationExpression="[0-9]{10}"
                        ErrorMessage="* Must be 10 digits only" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">Address :</td>
                <td>
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Width="220px" Rows="3" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtAddress"
                        ErrorMessage="* Address required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">City :</td>
                <td>
                    <asp:TextBox ID="txtCity" runat="server" Width="220px" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtCity"
                        ErrorMessage="* City required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">Password :</td>
                <td>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Width="220px" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="* Password required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <tr>
                <td class="lbl">Confirm Password :</td>
                <td>
                    <!-- Assignment 3: Confirm Password - NOT stored in DB -->
                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" Width="220px" />
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirm"
                        ErrorMessage="* Confirm password required" CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                    <!-- Assignment 3: CompareValidator ControlToCompare property -->
                    <asp:CompareValidator runat="server"
                        ControlToValidate="txtConfirm" ControlToCompare="txtPassword"
                        Operator="Equal" ErrorMessage="* Passwords do not match"
                        CssClass="errmsg" ValidationGroup="vg" Display="Dynamic" />
                </td>
            </tr>
            <!-- Assignment 5: Profile picture upload field -->
            <tr>
                <td class="lbl">Profile Picture :</td>
                <td>
                    <asp:FileUpload ID="fuPic" runat="server" /><br />
                    <small style="color:#888;">JPG / PNG only (optional)</small><br />
                    <!-- Assignment 5: Display uploaded profile picture -->
                    <asp:Image ID="imgPreview" runat="server" CssClass="picpreview" Visible="false" />
                </td>
            </tr>
            <tr>
                <td></td>
                <td style="padding-top:10px;">
                    <asp:Button ID="btnSave"  runat="server" Text="Save"  OnClick="btnSave_Click"  ValidationGroup="vg" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnReset" runat="server" Text="Reset" OnClick="btnReset_Click" CssClass="btngray" CausesValidation="false" />
                </td>
            </tr>
        </table>

        <div class="lnk">Already registered? <a href="Login.aspx">Login here</a></div>
    </form>
</div>
</body>
</html>
