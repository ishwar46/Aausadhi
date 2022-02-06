<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductSetup.aspx.cs" Inherits="EPharma.Managements.ProductSetup" %>

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
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
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
                    <div class="col-xs-12">
                        <div class="col-xs-2 pm">
                            <label>Product Name</label>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Category</label>
                            <asp:DropDownList ID="ddlCateogy" runat="server" Width="100%" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Original Price</label>
                            <asp:TextBox ID="txtOrgPrice" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Sell Price</label>
                            <asp:TextBox ID="txtSellPrice" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Discount</label>
                            <asp:TextBox ID="txtDiscount" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Icon</label>
                            <asp:FileUpload ID="flUpload" runat="server" />
                        </div>
                        <div class="col-xs-2 pm clear">
                            <label>Expiry Date</label>
                            <asp:TextBox ID="txtExpiryDate" runat="server" CssClass="form-control datepicker" placeholder="DD/MM/YYYY"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Measurement Type</label>
                            <asp:DropDownList ID="ddlMeasurement" runat="server" Width="100%" CssClass="form-control"></asp:DropDownList>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Measurement Type Quantity</label>
                            <asp:TextBox ID="MeasurementTypeQuantity" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-1">
                            <label>Active</label><br />
                            <asp:CheckBox ID="chkActive" runat="server" />
                        </div>
                        <div class="col-xs-2 pm">
                            <label>KeyFeatures</label>
                            <asp:TextBox ID="txtKeyFeature" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2"></asp:TextBox>
                        </div>
                        <div class="col-xs-4 pm">
                            <label>Description</label>
                            <asp:TextBox ID="txtDesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <br />
                        <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return confirm('Are you sure?');" />
                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" />
                        <asp:HiddenField ID="hdID" runat="server" />
                    </div>
                </div>
            </fieldset>
            <div class="clear">
            </div>
            <div style="height: 500px; overflow: scroll">
                <asp:GridView ID="gvProducts" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="gvProducts_RowCommand">
                    <HeaderStyle CssClass="StickyHeader thead-light”" />
                    <Columns>
                        <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="2%" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblProductName" runat="server" Text='<%# Bind("NAME")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Original Price">
                            <ItemTemplate>
                                <asp:Label ID="lblOriginalPrice" runat="server" Text='<%# Bind("ORIGINALPRICE")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sell Price">
                            <ItemTemplate>
                                <asp:Label ID="lblSellPrice" runat="server" Text='<%# Bind("SellPrice")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Discounts">
                            <ItemTemplate>
                                <asp:Label ID="lblDiscounts" runat="server" Text='<%# Bind("Discount")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Key Features">
                            <ItemTemplate>
                                <asp:Label ID="lblKeyFeatures" runat="server" Text='<%# Bind("KeyFeatures")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Description">
                            <ItemTemplate>
                                <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("Descriptions")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Icon">
                            <ItemTemplate>
                                <asp:Label ID="lblIcon" runat="server" Text='<%# Bind("Icon")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Expiry Date">
                            <ItemTemplate>
                                <asp:Label ID="lblExpirydate" runat="server" Text='<%# Bind("ExpiryDate")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <asp:Label ID="lblCategoryName" runat="server" Text='<%# Bind("Category")%>'></asp:Label>
                                <asp:Label ID="lblCategory" runat="server" Text='<%# Bind("CategoryID")%>' Visible="false" ></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <asp:Label ID="lblActive" runat="server" Text='<%# Bind("Active")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Measurement Type">
                            <ItemTemplate>
                                <asp:Label ID="lblMeasurement" runat="server" Text='<%# Bind("MeasurementType")%>'></asp:Label>
                                <asp:Label ID="lblMeasurementType" runat="server" Text='<%# Bind("MeasurementTypeID")%>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Created By">
                            <ItemTemplate>
                                <asp:Label ID="lblCreatedBy" runat="server" Text='<%# Bind("CreatedBy")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Created Date">
                            <ItemTemplate>
                                <asp:Label ID="lblCreatedDate" runat="server" Text='<%# Bind("CreatedDate")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditData"
                                    CommandArgument='<%#Bind("ID") %>'>
                                               Edit
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteData" OnClientClick="return confirm('confirm to Delete?')"
                                    CommandArgument='<%#Bind("ID") %>'>
                                           Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
