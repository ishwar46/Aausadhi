<%@ Page MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="ShoppingCart.aspx.cs" Inherits="EPharma.Managements.ShoppingCart" Culture="en-IN" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
                <asp:Panel ID="pnlMsgBox" runat="server">
            </asp:Panel>
    <div id="ShoppingCartTitle" runat="server" class="ContentHead">
        <h1>Shopping Cart</h1>
    </div>
    <asp:GridView ID="CartList" runat="server" AutoGenerateColumns="False" ShowFooter="True" GridLines="Vertical" CellPadding="4"
        ItemType="EPharma.Models.CartItem" SelectMethod="GetShoppingCartItems"
        CssClass="table table-striped table-bordered">
        <Columns>
            <asp:BoundField DataField="ProductID" HeaderText="ID" SortExpression="ProductID" />
            <asp:BoundField DataField="Product.Name" HeaderText="Name" />

            <asp:TemplateField HeaderText="Price (each)">
                <ItemTemplate>
                    Rs. <asp:Label ID="ProductPrice" Width="100" runat="server" Text="<%#:  Item.Product.SellPrice %>">0</asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Quantity">
                <ItemTemplate>
                    <asp:TextBox ID="PurchaseQuantity" Width="40" runat="server" Text="<%#: Item.Quantity %>"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Item Total">
                <ItemTemplate>
                    <%#: "Rs. " + ((Convert.ToDouble(Item.Quantity)) *  Convert.ToDouble(Item.Product.SellPrice))%>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Remove Item">
                <ItemTemplate>
                    <asp:CheckBox ID="Remove" runat="server"></asp:CheckBox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <div>
        <p></p>
        <strong>
            <asp:Label ID="LabelTotalText" runat="server" Text="Order Total: "></asp:Label>
            <asp:Label ID="lblTotal" runat="server" EnableViewState="false"></asp:Label>
        </strong>
    </div>
    <br />
    <table>
        <tr>
            <td>
                <asp:Button ID="UpdateBtn" runat="server" Text="Update" OnClick="UpdateBtn_Click" CssClass="btn btn-primary" />
            </td>
            <td>&nbsp;</td>
            <td>
                <asp:Button ID="btnOrder" runat="server" Text="Order Now" OnClick="btnOrder_Click" CssClass="btn btn-primary" />
            </td>
        </tr>
    </table>
</asp:Content>
