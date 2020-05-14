<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>采购对账单详情</title>
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.min.css?v=c509be79d3">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.min.css?v=294128f84a">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/order-table_c.css?v=fbd662cafa">
    <style>
        /*     @media only screen and (max-width: 1050px)  {
         #tableContainer table {
             width: 1050px;
             overflow: scroll;
             margin-bottom: 10px;
         }
     }*/
        /*@media only screen and (min-width: 1051px) {*/
        .ui.button {
            cursor: pointer;
            display: inline-block;
            min-height: 1em;
            outline: none;
            border: none;
            vertical-align: baseline;
            background: #E0E1E2 none;
            color: rgba(0, 0, 0, 0.6);
            font-family: Arial, "Microsoft YaHei", '宋体';
            margin: 0em 0.25em 0em 0em;
            font-size: 12px !important;
            height: 30px;
            line-height: 30px;
            padding:0px 30px;
            text-transform: none;
            text-shadow: none;
            font-weight: bold;
            font-style: normal;
            text-align: center;
            text-decoration: none;
            border-radius: 0.28571429rem;
            box-shadow: 0px 0px 0px 1px transparent inset, 0px 0em 0px 0px rgba(34, 36, 38, 0.15) inset;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            -webkit-transition: opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease;
            transition: opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease;
            will-change: '';
            -webkit-tap-highlight-color: transparent;
        }
        #tableContainer table {
            width: 100%;
            overflow: scroll;
            margin-bottom: 10px;
        }

        /*}*/

        .business-desc {
            color: #337AB7;
            padding: 0 0.4em;
        }

        .ui.items-view table tbody tr:nth-child(even) {
            background: none !important;
        }

        .Customer-address {
            height: 10px;
            line-height: normal;
            color: #666;
        }
         .coverage{
            font-size: 12px;
            float: right;
            color: #eb6877;
            cursor: pointer;
            position: relative;
        }
        .coverage span{
            color:#4284D9; 
        }
        .cover:hover{
            color: #4284D9!important;
        }
        label{
           font-weight: normal!important;
           color: #000!important;
        }
        .fieldsec{
            font-size: 14px;
            color:#666;
            margin-bottom: 20px;
        }
        .ui.form .inline.fields{
            margin: 0;
        }
        .coveres {
            display: none;
            position: fixed;
            top: 0;
            width: 100%;
            height: 100%;
            background: #000;
            opacity: 0.7;
            z-index: 1000;
        }
     .alart_one {
            display: none;
            position: fixed;
            top: 50%;
            z-index: 2000;
            width: 1100px;
            margin-top: -270px;
            left: 60%;
            margin-left: -550px;
        }
    .callback {
            font-size: 45px;
            right: 180px;
            top: 0px;
            position: absolute;
            color: #fff;
            cursor: pointer;
        }
        .fixheader {
            background: #fff;
            height: 55px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            border-bottom: 1px solid #dddddd;
            padding: 8px 20px 0 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 99;
        }
        .fixheader button{
            margin:12px 0px 9px 0px !important;
        }
        #tableContainer{
            padding-top:80px !important;
            /*border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);*/
        }
        /*cola-ui样式去掉*/
        .ui.widget-table .table.item:hover:not(.current){
            background: transparent;
        }
    </style>
</head>
<body style="padding:0 2%;background: url('/images/backlogo.png') repeat;">
<div class="coveres"></div>
<div class="alart_one">
    <div class="callback iconfont">&#xe6a0;</div>
    <img src="../../images/print.png" alt="">
</div>
<div id="datagrid-mask-msg" class="datagrid-mask-msg loading_box" style="display:none;left:50%"><span></span></div>
<div class="fixheader">
    <div style="font-size:12px!important;width:90px;padding:0;" c-widget="button;caption:关闭页面;click:closeRightWin"></div>
    <div class="cover" c-widget="button;" id="print" style="font-size:14px!important;height:30px;width:68px;line-height:1;background:#fff;color:#7e92ab;padding:0;margin-left:15px;font-weight:normal!important;"><i class="iconfont"  style="font-size:26px;position:relative;top:4px;font-weight:normal;">&#xe6e8;</i> 打印</div>
    <div class="cover" c-widget="button;class:primary;" id="qrCodeData" style="font-size:14px!important;height:30px;width:122px;line-height:1;background:#fff;color:#7e92ab;padding:0;margin-left:6px;margin-left:10px;font-weight:normal!important;"><i class="iconfont"  style="font-size:26px;position:relative;top:4px;font-weight:normal;">&#xe6e9;</i> 微信/QQ转发</div>
    <div title="点击查看如何另存为PDF" class="coverage"><i class="iconfont" style="font-size:30px;position:relative;top:7px;">&#xe6ed;</i> 友情提示：你可以在打印页将订单另存为PDF文件 <span>查看<i class="iconfont" style="font-weight:900;font-size:14px;position:relative;top:1px;">&#xe68b;</i></span></div>
    <div class="ui custom popup" style="padding: 0;width: 280px;height: 260px;">
        <p style="margin-top: 20px;text-align: center">扫一扫，转发给供应商做确认</p>
        <div style="margin-top: 30px ;text-align: center;" id="qrCodeDataMid"></div>
    </div>
</div>
<div id="tableContainer">

    <div class="ui form" style="position:relative;">
        <div style="position: absolute;top:5px;right: 0px;font-size:12px !important;color:#13c19f;font-weight:900;">
            <p c-display="purchasecheckingOrder.purchasecheckingNo!=''">采购对账单：<span
                    c-bind="purchasecheckingOrder.purchasecheckingNo"></span></p>
            <p c-display="purchasecheckingOrder.salescheckingNo!=''">销售对账单：<span
                    c-bind="purchasecheckingOrder.salescheckingNo"></span></p>
        </div>
        <div class="inline fields" style="text-align: center; display: block;">
            <div class="field" style="margin-left: 20px;display: inline-block;font-size: 18px;">
                <label style="margin-right:2px;">${sessionScope.sessionUser.comName}</label>
                <label>采购对账单</label>
               （<label style="font-size:16px;" c-bind="purchasecheckingOrder.orderCycle"></label>）
                <div c-widget="divider" style="margin-left:-40px;margin-right:-40px;"></div>
            </div>
        </div>

        <div style="text-align: center;font-size:14px;color:#666; margin-bottom: 15px;">
            <div style="display: inline-block">供应商 : <span style="font-weight:400"
                                                           c-bind="purchasecheckingOrder.partnerShortname"></span></div>
            &#x3000;
            <div style="display: inline-block"><span style="font-weight:400"
                                                                               c-bind="purchasecheckingOrder.contactName"></span> (<span style="font-weight:400"
                                                            c-bind="purchasecheckingOrder.contactTel"></span>)</div>
        </div>
    </div>
        <!--<div c-widget="divider"></div>-->
        <div class="ui form" style="position:relative;">
            <div id="tableData"></div>
            <div class="total-drive">
                <div>
                    <ul class="total_right">
                        <li>合&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;计：<span
                                c-bind="formatNumber(purchasecheckingOrder.price,'#,##0.00')"></span></li>
                        <li class="zhe">折&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;扣：<span> - <i
                                c-bind="formatNumber(purchasecheckingOrder.discount,'#,##0.00')"></i> </span></li>
                        <li class="jian">减&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;免：<span> - <i
                                c-bind="formatNumber(purchasecheckingOrder.preferential,'#,##0.00')"></i> </span></li>
                        <li>税&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;款：<span
                                c-bind="formatNumber(purchasecheckingOrder.taxPrice,'#,##0.00')"></span></li>
                        <div c-widget="divider"></div>
                    </ul>
                    <div style="clear:both;"></div>
                </div>
                <div style="position:relative;">
                    <ul class="total_right">
                        <li style="margin-bottom:8px;">对账单金额：<span 
                                c-bind="formatNumber(purchasecheckingOrder.totalPrice,'#,##0.00')"></span></li>
                        <li style="margin-bottom:2px;">预&#x3000;&#x3000;&#x3000;付：<span> - <i
                                c-bind="formatNumber(purchasecheckingOrder.depositRequested,'#,##0.00')"></i> </span>
                        </li>
                        <li style="margin-bottom:2px;" c-display="purchasecheckingOrder.orderStatus=='09'">应&#x3000;&#x3000;&#x3000;付：<span style="color:#eb6877;font-weight:900;"
                                c-bind="formatNumber(purchasecheckingOrder.receivablesMoney,'#,##0.00')"></span></li>
                        <li c-display="purchasecheckingOrder.orderStatus=='10'">实&#x3000;&#x3000;&#x3000;付：<span style="color:#eb6877;font-weight:900;"
                                c-bind="formatNumber(purchasecheckingOrder.paidUp,'#,##0.00')"></span></li>
                    </ul>
                    
                    <div style="clear:both;"></div>
                </div>
            </div>
            <div c-widget="divider"></div>
            <div class="Customer-address">
                <div style="float:left;"> 电话 : <span c-bind="bottomComInfo.comTel"></span> QQ : <span
                        c-bind="bottomComInfo.comQQ"></span><span class="relation">联系人 : <span c-bind="bottomComInfo.realName" style="margin:0;"></span> (<span c-bind="bottomComInfo.userId" style="margin:0;"></span>)</span> 
                     <span class="addr">地址 : <span>
                            <b c-bind="bottomComInfo.comAddress"></b>
                        </span></span>
                        </div>
                         <span style="float:right;margin:0;">制单人 ：<span c-bind="purchasecheckingOrder.creatorName" style="margin:0;"></span> (<span      style="margin:0;" c-bind="purchasecheckingOrder.createTime"></span>)</span>
            </div>
        </div>
</div>
<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a"></script>
<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
<script src="/resources/baseData.js?v=799c10f914"></script>
<script src="/resources/business/accounting.min.js?v=79a4c7c7db"></script>
<script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
<script type="text/javascript">
    cola(function (model) {
        var orders, createTable;

        var industryId = '${param.industryId}';
        var tags = {};
        model.describe("tags", {
            provider: {
                //                url: "/order/listBusinessTypeVO?industryId=" + industryId + "&way=detail"
                url: "/json/table_detail_cg.json"
            }
        });
        model.get("tags", "sync").each(function (element, index) {
            //tags.push(element._data);
            tags[element.get("modelName")] = element._data;
        });


        var orderNo = "${orderNo}";

        model.describe("allOrders", {
            provider: "/ydz/purchasechecking/orderDetailData?orderNo=" + orderNo + "&industryId=" + industryId
        });

        var allOrders = model.get("allOrders", "sync");
       
       if (allOrders.get("shareUrl")) {
           $('#qrCodeDataMid').qrcode({width: 160, height: 160, text: allOrders.get("shareUrl")});
       }
        model.set("orders", allOrders.get("orders"));
        model.set("purchasecheckingOrder", allOrders.get("purchasecheckingOrder"));
        orders = model.get("orders");
        model.set("bottomComInfo", allOrders.get("bottomComInfo"));
        if(allOrders.get("bottomComInfo")._data.realName=="-"&&allOrders.get("bottomComInfo")._data.userId=="-"){
            $(".relation").hide();
        }
        if(allOrders.get("bottomComInfo")._data.comAddress=="-"){
            $(".addr").hide();
        }
        model.describe("tables", {
            provider: "/json/tables.json"
        });


        createTable = function (definition) {
            var $inputTemplate, column, columns, config, j, len1, ref, table;
            columns = [];
            ref = definition.columns;
            for (j = 0, len1 = ref.length; j < len1; j++) {
                column = ref[j];
                config = fields[column];
                columns.push(fields[column]);
            }
            table = new cola.Table({
                bind: "item in " + definition.modelName, /*" + definition.modelName + ".items*/
                highlightCurrentItem: true,
                changeCurrentItem: true,
                currentPageOnly: true,
                sortable: false,
                columns: columns,
                renderCell: function (self, arg) {
                    if (arg.column.get("property") === "totalPrice") {
                        $(arg.dom).html(accounting.formatNumber(arg.item.get("totalPrice"), 2));
                        return false;
                    } else if (arg.column.get("property") === "unitPrice") {
                        $(arg.dom).html(accounting.formatNumber(arg.item.get("unitPrice"), 2));
                        return false;
                    } else if (arg.column.get("property") === "purchaseOrderPrice") {
                        $(arg.dom).html(accounting.formatNumber(arg.item.get("purchaseOrderPrice"), 2));
                        return false;
                    }else if (arg.column.get("property") === "purchaseNo") {
                        var isReceived=arg.item.get("isReceived")=="0"?"":"已收货";
                        $(arg.dom).html(arg.item.get("purchaseNo")+"<span style='color:#01a09a'>&#x3000;"+isReceived+"</span>");
                        return false;
                    }
                }

            });

            $inputTemplate = $.xCreate({
                tagName: "div",
                "c-widget": "input; bind:$default; class:fluid;"
            });
            table.regTemplate("input-column", $inputTemplate);
            //                $(container).prepend(table.getDom());
            return table.getDom();
        };


        var tablesDemo = new Array();
        orders.each(function (order, index) {
            var path = "model0_01";
            var demo_id = "model01";
            var temp = model.get(path);
            if (!temp) {
                temp = [];
                model.set(path, temp);
                temp = model.get(path);
                var demo = {};
                demo.demo_id = demo_id;
                demo.table_id = path;
                tablesDemo.push(demo);
            }
            temp.insert(order.toJSON());
        });
        var tag1 = tags["model01"];
        var tagObj = {};
        tagObj.columns = tag1.columns;
        tagObj.modelName = tablesDemo[0].table_id;
        var tabel = createTable(tagObj);
        $("#tableData").append(tabel);
        //合并单元格
        $("#tableData .table-wrapper>table>tbody").rowspan(1);
        $("#tableData .table-wrapper>table>tbody").rowspan2(0);
        $("#tableData .table-wrapper>table>tbody").rowspan2(10);
        model.action({
            closeRightWin: function () {
                window.parent.hideMsg();
            }
        });
        $(".frame_box").removeClass("loadingssss");
    });
    $(function () {
        var a = $(".zhe i").text();
        var b = $(".jian i").text();
        console.log(a)
        if (a == "0.00") {
            $(".zhe").hide();
        }
        if (b == "0.00") {
            $(".jian").hide();
        }
        //备注
        var shifouweikong = $("#shifouweikong").html();
        if (shifouweikong == "") {
            $(".total_beizhu").html("");
        }
        //显示地址
        var sheng = $("#sheng").val();
        var shi = $("#shi").val();
        var xian = $("#xian").val();

        $.each(ProvinceJson, function (key, val) {
            if (val.provinceId == sheng) {
                $("#sheng1").html(val.provinceName);return false;
            }
        });

        $.each(CityJson, function (key, val) {
            if (val.provinceId == sheng && val.cityId == shi) {
                $("#shi1").html(val.cityName);return false;
            }
        });

        $.each(CountryJson, function (key, val) {
            if (val.cityId == shi && val.countryId == xian) {
                $("#xian2").html(val.countryName);return false;
            }
        });
        //打印
        $("#print").click(function () {
            window.parent.parent.open("/print/purchasechecking-order-detail-print.html?orderNo=${orderNo}&industryId=${param.industryId}");
        })
        // $('#qrCodeDataMid').qrcode({ width: 160, height: 160, text: "" });
        // 二维码展示 
        $('#qrCodeData')
            .popup({
                popup: $('.custom.popup'),
                on: 'hover'
            })


        $(".coverage").click(function(){
            $(".coveres").show();
            $(".alart_one").show();
        });
        $(".callback").click(function(){
            $(".coveres").hide();
            $(".alart_one").hide();
        });
    })
</script>
</body>

       
