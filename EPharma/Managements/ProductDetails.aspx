<%@ Page MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="EPharma.Managements.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
        * {
            color: black;
        }

        label {
            color: black;
            font-weight: bold;
        }

        .pm {
            padding-left: 2px;
            padding-right: 2px;
            margin-bottom: 5px;
        }

        image {
            border: 1px solid #eee;
        }
    </style>
    <script>
        function DecreaseQuantity() {
            if (parseInt($("#ProductQuantity").val()) == 0){
                return;
            }
            $("#ProductQuantity").val(parseInt($("#ProductQuantity").val() - 1));
        }

        function IncreaseQuantity() {
            $("#ProductQuantity").val(parseInt($("#ProductQuantity").val()) + 1);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:UpdatePanel ID="updForm" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="updProgess" runat="server" AssociatedUpdatePanelID="updForm">
                <ProgressTemplate>
                    <div class="outerDiv">
                    </div>
                    <div class="innerDiv" title="Processing...">
                        Processing...
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Panel ID="pnlMsgBox" runat="server">
            </asp:Panel>
            <br />
            <br />
            <div class="container" style="box-shadow: 0px 2px 5px 3px #020d05;">
                <br />
                <br />
                <br />
                <div class="row">
                    <asp:HiddenField ID="ProductID" runat="server" />
                    <div class="col-md-6">
                        <asp:Image runat="server" ID="ProductImage" Width="400px" Height="400px" />
                    </div>
                    <div class="col-md-6">
                        <h1>
                            <u><asp:Label runat="server" ID="ProudctTitle"></asp:Label></u></h1>
                        <br />
                        <b>
                             <asp:Label runat="server" ID="ProudctPrice"></asp:Label></b><br />
                        <asp:Label runat="server" ID="ProductKeyFeatures"></asp:Label><br />
                          <br />
                          <br />
                        Categories: <b><asp:Label runat="server" ID="ProductCategories"></asp:Label></b>
                        <br />
                        <br />
                        <div class="quantity">
                            <input type="button" value="-" class="minus" onclick="DecreaseQuantity();">
                            <asp:TextBox TextMode="Number" ID="ProductQuantity" ClientIDMode="Static" runat="server">1</asp:TextBox>
                            <%--<input type="number" id="ProductQuantity" step="1" min="1" max="" name="quantity" value="1" title="Qty" size="4" placeholder="" inputmode="numeric">--%>
                            <input type="button" value="+" class="plus" onclick="IncreaseQuantity();">
                        </div>
                        <br />
                         <br />
                         <br />
                        <asp:Button ID="AddToCart" runat="server" CssClass="btn btn-danger" Text="Add to cart" OnClick="AddToCart_Click" />
                    </div>
                    <div class="col-md-12">
                        <h3><u>Description</u></h3>
                        <asp:Label runat="server" ID="ProductDescriptions"></asp:Label>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

