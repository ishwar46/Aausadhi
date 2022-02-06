<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="EPharma.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <div class="form-horizontal" style="text-align:center;">
        <h4>Create a new account</h4>
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
            <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="The email field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="The password field is required." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Confirm password</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The confirm password field is required." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="The password and confirmation password do not match." />
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
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Register" CssClass="btn btn-primary" />
            </div>
        </div>
        <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
    </div>
</asp:Content>
