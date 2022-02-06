<%@ Page MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="EPharma.Managements.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="<%# ResolveUrl("~/Scripts/chart.min.js") %>" type="text/javascript"></script>
    <script src="<%# ResolveUrl("~/Scripts/palette.js") %>" type="text/javascript"></script>
   <style>

        * {
            font-family: 'Open Sans', sans-serif;
            font-size: 12px;
        }

        .container2 {
        }

        .tile {
            width: 400px;
            border-radius: 4px;
            box-shadow: 2px 2px 4px 0 rgba(0,0,0,0.15);
            margin: 5px;
            float: left;
        }

            .tile.wide {
                width: 340px;
            }

            .tile .header {
                height:160px;
                background-color: #f4f4f4;
                border-radius: 4px 4px 0 0;
                color: white;
                font-weight: 300;
            }

            .tile.wide .header .left, .tile.wide .header .right {
                width: 160px;
                float: left;
            }

            .tile .header .count {
                font-size: 48px;
                text-align: center;
                padding: 10px 0 0;
            }

            .tile .header .title {
                font-size: 16px;
                text-align: center;
            }

            .tile .title {
                text-align: center;
                font-size: 20px;
                padding-top: 2%;
            }

            .tile.wide .title {
                padding: 4%;
            }

            .tile.job .header {
                background: linear-gradient(to bottom right, #609931, #87bc27);
            }

            .tile.job {
                color: #609931;
            }

            .tile.resource .header {
                background: linear-gradient(to bottom right, #ef7f00, #f7b200);
            }


            .tile.quote .header {
                background: linear-gradient(to bottom right, #1f6abb, #4f9cf2);
            }

            .tile.quote {
                color: #1f6abb;
            }

           .tile.invoice .header {
               background: linear-gradient(to bottom right, #0aa361, #1adc88);
           }

       .counts {
           font-size: 20px;
       }
   </style>


    <script>
        function pageLoad(sender, args) {
            ShowdashBoard();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
        <fieldset class="fs-s1" style="width: 100%; display: block">
            <div class="container2">
                <div class="tile job">
                    <div class="header">
                        <div class="count">
                            <asp:Label runat="server" ID="TOTAL_USERS" CssClass="counts">0</asp:Label>
                        </div>
                        <div class="title">Total Users</div>
                    </div>
                </div>
                <div class="tile resource">
                    <div class="header">
                        <div class="count">
                            <asp:Label runat="server" ID="TOTAL_PRODUCTS" CssClass="counts">0</asp:Label>
                        </div>
                        <div class="title">Total Products</div>
                    </div>
                </div>
                <div class="tile job">
                    <div class="header">
                        <div class="count">
                            <asp:Label runat="server" ID="TOTAL_ORDERS_MONTH" CssClass="counts">0</asp:Label>
                        </div>
                        <div class="title">Total Orders This Month</div>
                    </div>
                </div>
                <div class="tile resource">
                    <div class="header">
                        <div class="count">
                            <asp:Label runat="server" ID="TOTAL_ORDERS_TODAY" CssClass="counts">0</asp:Label>
                        </div>
                        <div class="title">Total Orders Today</div>
                    </div>
                </div>
            </div>
        </fieldset>
        <div id="graphs">
            <fieldset class="fs-s1" style="width: 1000px; height: 500px;">
                <canvas id="GetNewUsersThisMonth" width="1000" height="400"></canvas>
            </fieldset>
            <fieldset class="fs-s1" style="width: 1000px; height: 500px;">
                <canvas id="GetOrdersThisMonth" width="1000" height="400"></canvas>
            </fieldset>
            <fieldset class="fs-s1" style="width: 1000px; height: 500px;">
                <canvas id="GetOrderStatusThisMonth" width="1000" height="400"></canvas>
            </fieldset>
        </div>
    <script>
        function ShowdashBoard() {
            ShowBarGraph('GetNewUsersThisMonth', "Dashboard/GetNewUsersThisMonth", 'Date', 'Counts', 'New Users This Month');
            ShowBarGraph('GetOrdersThisMonth', "Dashboard/GetOrdersThisMonth", 'Date', 'Counts', 'Orders This Month');
            ShowPieChart('GetOrderStatusThisMonth', "Dashboard/GetOrderStatusThisMonth", 'X', 'Y', 'Order Status This Month');
        }

        function ShowBarGraph(chartId, url, xLabel, yLabel, title) {
            $.ajax({
                url: url,
                crossDomain: true,
                type: 'POST',
                dataType: 'json',
                contentType: "application/json",
                data: '',
                success: function (result) {
                    onSucess(result.d);
                }
            });
            function onSucess(data) {
                var ctx = document.getElementById(chartId).getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: data[xLabel],
                        datasets: [{
                            label: title,
                            data: data[yLabel],
                            backgroundColor: [
                                'steelblue'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }
        }

        function ShowPieChart(chartId, url, xLabel, yLabel, title) {
            $.ajax({
                url: url,
                crossDomain: true,
                type: 'POST',
                dataType: 'json',
                contentType: "application/json",
                data: '',
                success: function (result) {
                    onSucess(result.d);
                }
            });
            function onSucess(data) {
                var ctx = document.getElementById(chartId).getContext('2d');
                var myChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: data[xLabel],
                        datasets: [{
                            label: title,
                            data: data[yLabel],
                            backgroundColor: palette('tol', data[yLabel].length).map(function (hex) {
                                return '#' + hex;
                            })
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }
        }
    </script>
</asp:Content>
