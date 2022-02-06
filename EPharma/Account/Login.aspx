<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EPharma.Account.Login" Async="true" EnableEventValidation="false" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">


    <div class="row" style="margin-top: 20px;">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <section id="loginForm">
                <div class="box-login" style="box-shadow: 0px 2px 5px 3px #020d05; height: 500px; background-color: #a8dcf7">
                    <form class="form-login">
                        <fieldset style="margin: 0 0 0 0; padding: 5px;">
                            <br />
                            <br />
                            <br />
                            <br />

                            <div class="form-group">
                                <label></label>
                                <div class="col-md-10" style="text-align: center;">
                                    <img src="../Icons/logo.png" height="40" alt="Logo" loading="lazy" />
                                </div>
                            </div>
                            <br />
                            <br />
                            <br />
                            <div style="clear: both"></div>
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
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                                </div>
                            </div>
                            <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                                <p class="text-danger" style="text-align: center;">
                                    <asp:Literal runat="server" ID="FailureText" />
                                </p>
                            </asp:PlaceHolder>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <div class="checkbox">
                                        <asp:CheckBox runat="server" ID="RememberMe" />
                                        <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-md-offset-2 col-md-10">
                                    <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-primary" />
                                </div>
                            </div>
                            <p style="text-align: center; margin-top: 20px">
                                <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                            </p>

                            <p>
                                <%-- Enable this once you have account confirmation enabled for password reset functionality
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                                --%>
                            </p>
                        </fieldset>
                    </form>
                </div>
            </section>
        </div>
        <div class="col-md-3"></div>
    </div>
</asp:Content>
