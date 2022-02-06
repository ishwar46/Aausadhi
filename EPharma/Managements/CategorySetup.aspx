<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CategorySetup.aspx.cs" Inherits="EPharma.Managements.CategorySetup" ValidateRequest="false" %>

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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:UpdatePanel ID="updForm" runat="server">
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
                        <br />
                        <br />
                        <div class="col-xs-2 pm">
                            <label>Category Name</label>
                            <asp:TextBox ID="txtCatName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 ">
                            <label>Icon</label>
                            <asp:FileUpload ID="flUpload" runat="server" />
                        </div>
                        <div class="col-xs-1">
                            <label>Active</label>
                            <br />
                            <asp:CheckBox ID="chkActive" runat="server" />
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Levels</label>
                            <asp:TextBox ID="txtLevels" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-xs-2 pm">
                            <label>Parent Id</label>
                            <asp:DropDownList ID="ddlParentId" runat="server" Width="100%" CssClass="form-control"></asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <asp:HiddenField ID="hdnf1" runat="server" />
                        <asp:Button runat="server" ID="btnSave" Text="Save" CssClass="btn btn-primary" OnClick="btnSave_Click" OnClientClick="return confirm('Are you sure?');" />
                        <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="btn btn-danger" OnClick="btnCancel_Click" />
                        <asp:HiddenField ID="hdID" runat="server" />
                    </div>
                    <br />
                    <br />
                </div>
            </fieldset>
            <div class="clear">
            </div>
            <br />
            <br />
            <br />
            <div style="height: 500px; overflow: scroll">
                <asp:GridView ID="gvCategory" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="gvCategory_RowCommand">
                    <HeaderStyle CssClass="StickyHeader thead-light”" BackColor="#7AE582" />
                    <Columns>
                        <asp:TemplateField HeaderText="S.No" HeaderStyle-Width="2%" HeaderStyle-HorizontalAlign="Left">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Category Name">
                            <ItemTemplate>
                                <asp:Label ID="lblCategoryName" runat="server" Text='<%# Bind("Name")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Icon">
                            <ItemTemplate>
                                <asp:Label ID="lblIcon" runat="server" Text='<%# Bind("Icon")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Active">
                            <ItemTemplate>
                                <asp:Label ID="lblActive" runat="server" Text='<%# Bind("Active")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Levels">
                            <ItemTemplate>
                                <asp:Label ID="lblLevels" runat="server" Text='<%# Bind("Levels")%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Parent Id">
                            <ItemTemplate>
                                <asp:Label ID="lblParent" runat="server" Text='<%# Bind("Parent")%>'></asp:Label>
                                <asp:Label ID="lblParentId" runat="server" Text='<%# Bind("ParentID")%>' Visible="false"></asp:Label>
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

