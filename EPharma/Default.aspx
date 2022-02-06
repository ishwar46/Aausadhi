<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EPharma._Default" %>

<%@ Register Src="~/Managements/CategoryCard.ascx" TagName="CategoryCard" TagPrefix="UC1" %>
<%@ Register Src="~/Managements/ProductCard.ascx" TagName="ProductCard" TagPrefix="UC2" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Button ID="aaaa" runat="server" OnClick="aaaa_Click" Visible="false" />
    <div id="myCarousel" class="carousel slide" data-ride="carousel" style="margin-top: 3px;">
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
        </ol>

        <!-- Wrapper for slides -->
        <div class="carousel-inner">
            <div class="item active">
                <asp:Image runat="server" ID="FirstSlide" AlternateText="First Slide" Width="100%" Height="400px" />
            </div>
            <div class="item">
                <asp:Image runat="server" ID="SecondSlide" AlternateText="Second Slide" Width="100%" Height="400px" />
            </div>
            <div class="item">
                <asp:Image runat="server" ID="ThirdSlide" AlternateText="Third Slide" Width="100%" Height="400px" />
                <img src="ny.jpg">
            </div>
        </div>

        <!-- Left and right controls -->
        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="right carousel-control" href="#myCarousel" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <br />
    <br />
    <br />
    <div class="row">
        <div>
            <b style="font-size: 25px;">Categories</b>
            <asp:Panel ID="pnlCategory" runat="server">
                <UC1:CategoryCard runat="server" ID="CategoryCard1"></UC1:CategoryCard>
            </asp:Panel>
            <div style="text-align: right; width:100%">
                  <br />
                <asp:Button runat="server" ID="btnMoreCat" Text="More >>>>" CssClass="btn" BackColor="#7AE582" OnClick="btnMoreCat_Click" />
            </div>
        </div>
        <div>
            <b style="font-size: 25px;">Products</b>
            <asp:Panel ID="pnlProduct" runat="server">
                <UC2:ProductCard runat="server" ID="ProductCard1"></UC2:ProductCard>
            </asp:Panel>
            <div style="text-align: right; width:100%">
                <br />
                <asp:Button runat="server" ID="btnMore" Text="More >>>>" CssClass="btn" BackColor="#7AE582" OnClick="btnMore_Click" />
            </div>
        </div>
    </div>
</asp:Content>
