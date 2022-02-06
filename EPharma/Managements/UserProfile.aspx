<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="EPharma.Managements.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
     <div class="form-horizontal" style="text-align:center;">
        <h4>User Profile</h4>
        <hr />
        <div class="form-group" style="text-align:center">
            <asp:Label runat="server" AssociatedControlID="FirstName" CssClass="col-md-2 control-label">First Name</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="FirstName" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="FirstName"
                    CssClass="text-danger" ErrorMessage="The First Name field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="MiddleName" CssClass="col-md-2 control-label">Middle Name</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="MiddleName" CssClass="form-control" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="LastName" CssClass="col-md-2 control-label">Last Name</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="LastName" CssClass="form-control" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Gender" CssClass="col-md-2 control-label">Gender</asp:Label>
            <div class="col-md-3">
                <asp:DropDownList runat="server" ID="Gender" CssClass="form-control"></asp:DropDownList>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Gender"
                    CssClass="text-danger" ErrorMessage="Select Gender" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="PhoneNo" CssClass="col-md-2 control-label">Phone No</asp:Label>
            <div class="col-md-3">
                <asp:TextBox runat="server" ID="PhoneNo" CssClass="form-control" TextMode="Number" />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Address" CssClass="col-md-2 control-label">Address</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Address" CssClass="form-control" />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="Update_Click" Text="Update" CssClass="btn btn-primary" />
            </div>
        </div>
        <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
    </div>
</asp:Content>


