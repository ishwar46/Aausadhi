<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="ViewOrder.aspx.cs" Inherits="EPharma.Managements.ViewOrder" %>

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
    </style>
    <script>
        function pageLoad() {
            $(".datepicker").datepicker({
                autoclose: true
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:UpdatePanel ID="updForm" runat="server" UpdateMode="Conditional">

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
            <fieldset>
                <div class="row">
                    <br />
                    <div class="col-xs-12">
                        <div class="col-xs-2 pm">
                            <label>From Date</label>
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control datepicker" placeholder="DD/MM/YYYY"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>To Date</label>
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control datepicker" placeholder="DD/MM/YYYY"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>User</label>
                            <asp:DropDownList ID="ddlUser" runat="server" Width="100%" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-xs-2">
                            <label>Status</label><br />
                            <asp:DropDownList ID="ddlStatus" runat="server" Width="100%" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <br />
                        <asp:Button runat="server" ID="btnView" Text="View" CssClass="btn btn-primary" OnClick="btnView_Click" />
                        <asp:HiddenField ID="hdID" runat="server" />
                        <br />
                    </div>
                </div>
            </fieldset>
            <div class="clear">
            </div>
            <div style="height: 500px; overflow: scroll">
                <br />
                <asp:GridView ID="gvOrders" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="true" ShowHeaderWhenEmpty="true">
                    <HeaderStyle CssClass="StickyHeader thead-light”" />
                    <Columns>
                    </Columns>
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
