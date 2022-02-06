<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="EPharma.Managements.Categories" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .box {
            background-color: white;
            width: 100%;
            height: 100px;
            margin-top: 10px;
            display: block;
            text-align: center;
        }

            .box span {
                width: 80%;
                height: 70%;
                background-color: black;
                display: block;
                border: 2px #000000 solid;
                margin-left: 15%;
            }

        .TemplateDesign {
            width: 100%;
            height: 100%;
            background-color: white;
            display: block;
            border: 2px #000000 solid;
            padding: 5px;
            margin: 5px;
        }

        .TextDesign {
            font-size: 18px;
            font-family: "Monaco" monospace;
        }

        .TextDesignCompanyName {
            font-size: 18px;
            font-family: "Monaco" monospace;
        }

        .TextSecondary {
            font-size: 13px;
            font-family: "Monaco" monospace;
            line-height: -2px;
        }

        .WholeCard {
            margin-left: 10px;
            margin-right: 10px;
            padding: 5px;
            border-radius: 5px;
        }

        .ourcard {
            box-shadow: 0 3px 3px 3px #7AE582;
            max-width: 330px;
            padding: 15px;
            border-radius: 8px;
            margin: 5px;
            text-align: center;
            background-color: #FFFFFF;
            height: 300px;
            border: 1px #64f54c;
        }
    </style>
    <div style="width: 100%;">
        <h4 style="text-align: center;"><b>CATEGORIES</b></h4>
        <asp:Panel ID="pnlMsgBox2" runat="server">
        </asp:Panel>
        <asp:Panel ID="panelprint" runat="server">
            <asp:DataList ID="dataListCategory" runat="server" RepeatColumns="5" RepeatDirection="Horizontal" CellSpacing="1" CssClass="WholeCard">
                <ItemTemplate>
                    <span>
                        <div class="ourcard">
                            <asp:LinkButton runat="server" PostBackUrl='<%# ResolveUrl("~/Managements/Products.aspx?CategoryID=") + Eval("ID")%>'>
                                <div class="col-md-8">
                                    <asp:Image runat="server" ID="ProductImage" Width="180" Height="180" ImageUrl='<%# "~/Managements/ImageServer.aspx?imagePath=" + Eval("Icon")%>' />
                                </div>
                                <div style="clear:both"></div>
                                <div style="text-align: center; font-size: 18px;">
                                    <u><b>
                                        <asp:Label runat="server" ID="lblCategory" Text='<%# Bind("Name")%>'></asp:Label></b></u>
                                </div>
                                <br />
                            </asp:LinkButton>
                            <div style="clear: both"></div>
                        </div>
                    </span>
                </ItemTemplate>
            </asp:DataList>
        </asp:Panel>
    </div>
</asp:Content>


