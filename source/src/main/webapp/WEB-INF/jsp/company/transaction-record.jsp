<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <link rel="stylesheet" type="text/css" href="/../resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/../resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
    <script src="/resources/cola-ui/i18n/zh-CN/cola.js?v=40433415fd"></script>
    <script type="text/javascript">
        cola(function (model) {
            model.describe("records", {
                provider: {
                    url: '<c:url value="/payment/listRentalTrade"/>',
                    pageSize: 30
                }
            });

            /*model.set("messages_bak",[
             {
             title: "有员工申请加入您公司",
             sender: "易对账",
             sendTime: "2016-05-5 15:16:23"
             }
             ])*/

            model.widgetConfig({
                messagePager: {
                    $type: "Pager",
                    bind: "records"
                },
                messageTable: {
                    $type: "Table",
                    bind: "item in records",
                    showHeader: true,
                    currentPageOnly: true,
                    "class": "selectable compact",
                    columns: [{
                        bind:".createTime",
                        caption: "交易时间",
                        align:'center'
                    }, {
                        bind: ".duration",
                        caption: "服务时长（天）",
                        align:'center'
                    }, {
                        bind: ".endDate",
                        caption: "到期时间",
                        align:'center'
                    }, {
                        bind: ".statusPeriodValue",
                        caption: "交易类型",
                        align:'center'
                    }, {
                        bind: ".rentalMoney",
                        caption: "产品单价(年)",
                        align:'right'
                    }, {
                        bind: ".payedMoney",
                        caption: "实付金额",
                        align:'right',
                    }, {
                        bind: ".deductionMoney",
                        caption: "代金券金额",
                        align:'right'
                    }, {
                        bind: ".voucherNo",
                        caption: "代金券码",
                        align:'center'
                    }]
                }
            });
            $(".ui.dropdown").dropdown();
            $('.table_contant, .table_contant>table').height($(document.body).height()-140);
            $('.table_contant>table').css('overflow-x','scroll');
            $(window).bind("resize", function(e){
                $('.table_contant, .table_contant>table').height($(document.body).height()-140)
            });
        });
    </script>

</head>
<body style="padding: 10px;">



<div class="table_contant">
    <div id="messageTable"></div>
</div>

<div class="page_fix">
    <div id="messagePager" class="order-Pager"></div>
</div>

<%--<table id="messageTable" style="margin: 30px 0px;"></table>--%>

<%--<div c-widget="Pager; bind:messages">
    <a page-code="pages" class="item"></a>
</div>--%>


</body>
</html>