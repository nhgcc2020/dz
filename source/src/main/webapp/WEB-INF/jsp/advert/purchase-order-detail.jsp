<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>采购单详情</title>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.min.css?v=c509be79d3">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.min.css?v=294128f84a">
    <link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/order-table_c.css?v=fbd662cafa">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/animate.css?v=044dba19fd">
    <style>

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
        .ui.form {
            font-size: 12px;
        }

        .ui.items-view.widget-table {
            margin-top: 15px;
        }

        @media only screen and (max-width: 1050px) {
            #tableContainer table {
                width: 1050px;
                overflow: scroll;
                margin-bottom: 10px;
            }
        }

        @media only screen and (min-width: 1051px) {
            #tableContainer table {
                width: 100%;
                overflow: scroll;
                margin-bottom: 10px;
            }
        }

        .business-desc {
            color: #337AB7;
            padding: 0 0.4em;
        }

        .order {
            position: absolute;
            right: 10px;
            top: 5px;
        }

        #taxPointWin {
            border: none;
            z-index: 9999;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }

        .Customer-address {
            height: 10px;
            line-height: normal;
            color: #666;
        }

        .plistmarkSale {
            width: 20px;
            height: 18px;
            text-align: center;
            position: absolute;
            line-height: 16px;
            right: -8px;
            background: #FF5858;
            color: #fff;
            transform: scale(0.9);
            border-radius: 3px;
        }

        .plistmarkSale:before {
            content: "急";
        }

        #cancelWin {
            border: none;
            z-index: 9999;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            min-height: 290px;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
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
            color: #3385ff!important;
        }
        label{
           font-weight: normal!important;
           color: #000!important;
        }
        .fieldsec{
            font-size: 14px;
            color:#666;
            margin-bottom: 15px;
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
     .btn-default{
        background: #fff;
        line-height: 30px;
        border:1px solid #ccc;
        color: #999;
        border-radius: 5px;
        outline: none;
     }
     .btn-primary{
         border: none;
         background: #4284D9;
         color: #fff;
         line-height: 30px;
         border-radius: 5px;
         outline: none;
     } 
     .received{
         float: right;
         color: #01a09a;
         top:7px;
         font-size: 12px;
         margin-right: 24px;
         position: relative;
         display: none;
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
            visibility: hidden;
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
    </style>
</head>
<body style="padding:0 2%;overflow:visible; background: url('/images/backlogo.png') repeat;">
<div class="coveres"></div>
<div class="deleteW" style="display:none; padding-top: 5px;
    top: 50%;
    left: 45%;
    margin-left: -125px;
    margin-top: -93px;
    position: fixed;
    width: 330px;
    height: 197px;z-index: 2000;background: #fff;box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 22px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;">
        确认收货</p>
    <span  class="abolish" style="    position: absolute;
    top: 20px;
    right: 1px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
    margin: 20px auto;">
            <span class="customerjc" style="    position: relative;
    text-align: center;
    margin: 0 auto;
    font-size: 13px;
    font-weight: normal;
    color: #666;
    height: 40px;
    line-height: 40px;">收货信息将会记录在订单/对账单详情中</span>
        <div style="clear: both;margin-top:45px;">
            <button type="button" class="btn-default abolish" style="width:102px;">取消</button>
            <button type="button" class="btn-primary notarize" style="margin-left:16px;width:102px;font-size:12px;">确认</button>
        </div>
    </div>
</div>
<div class="alart_one">
    <div class="callback iconfont">&#xe6a0;</div>
    <img src="../../images/print.png" alt="">
</div>
<div id="cancelWin" class="segment show-on-ready"
     style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-214px;position:absolute; width: 660px;height:428px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        订单作废</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;">
            请谨慎操作,被作废的订单将不能再进行任何操作</p>
        <span class="customerjc"
              style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
              c-bind="purchaseOrder.partnerShortname"></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单金额：</span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;"><em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;"
                    id="totalPrice" c-bind="formatNumber(purchaseOrder.totalPrice,'#,##0.00')"></em></span>
        </div>
        <%--<input type="hidden" name="totalPriceWithTaxHid" id="totalPriceWithTaxHid">--%>

        <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>

        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 预付金额：</span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;"><em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;color:#ff0000;"
                    id="" c-bind="formatNumber(purchaseOrder.depositRequested,'#,##0.00')"></em></span>
        </div>

        <div style="clear: both;margin: 20px 0 20px 280px; padding-bottom: 20px; position:absolute;bottom:10px;right:80px;">
            <div c-widget="button;caption:取消" onclick="closeTaxPoint()" style="width:100px;"></div>
            <div c-widget="button;caption:作废;class:primary;click:cancelOrderLast"
                 style="margin-left:15px;font-size:12px;"></div>
        </div>
    </div>
</div>
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<div id="taxPointWin" class=" animated flipInY" style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -125px;
    margin-top: -93px;
    position: absolute;
    width: 330px;
    height: 187px;">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 22px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;">
        提示</p>
    <span  style="    position: absolute;
    top: 20px;
    right: 1px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;" onclick="closeTaxPoint()"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
    margin: 20px auto;">
            <span class="customerjc" style="    position: relative;
    text-align: center;
    margin: 0 auto;
    font-size: 22px;
    font-weight: normal;
    color: #44ae80;
    height: 30px;
    line-height: 30px;">确定要删除吗？</span>
        <div style="clear: both;margin-top:45px;">
            <div c-widget="button;caption:取消" onclick="closeTaxPoint()" style="width:100px;"></div>
            <div c-widget="button;caption:确认;class:primary;click:deleteOrderLast"
                 style="margin-left:15px;font-size:12px;"></div>
        </div>
    </div>
</div>


<div class="fixheader">
    <div style="font-size:12px!important;width:50px;padding:0;" c-widget="button;caption:关闭;click:closeRightWin"></div>
    <div class="receiving" style="font-size:12px!important;width:50px;padding:0;margin-left:5px;background:#4284D9;color:#fff;" c-widget="button;caption:收货;"></div>
    <div class="cover" c-widget="button;click:modifyBtn" style="font-size:14px!important;height:30px;width:68px;line-height:1;background:#fff;color:#7e92ab;padding:0;font-weight:normal!important;"><i class="iconfont"  style="font-size:26px;position:relative;top:4px;font-weight:normal;">&#xe6e6;</i> 修改</div>
    <div class="cover" c-widget="button;" id="print" style="font-size:14px!important;height:30px;width:68px;line-height:1;background:#fff;color:#7e92ab;padding:0;font-weight:normal!important;"><i class="iconfont"  style="font-size:26px;position:relative;top:4px;font-weight:normal;">&#xe6e8;</i> 打印</div>
    <div class="cover" c-widget="button;class:primary;" id="qrCodeData" style="font-size:14px!important;height:30px;width:122px;line-height:1;background:#fff;color:#7e92ab;padding:0;margin-left:6px;margin-left:10px;font-weight:normal!important;"><i class="iconfont"  style="font-size:26px;position:relative;top:4px;font-weight:normal;">&#xe6e9;</i> 微信/QQ转发</div>
      <div class="cover" style="font-size:14px!important;height:30px;width:68px;line-height:1;background:#fff;color:#7e92ab;padding:0;margin-left:10px;font-weight:normal!important;" c-display="purchaseOrder.orderStatus=='04' && purchaseOrder.salesNo=='' "
         c-widget="button;click:cancelOrder"><i class="iconfont"  style="font-size:26px;position:relative;top:4px;font-weight:normal;">&#xe6c4;</i> 作废</div>
    <%--<div c-display="purchaseOrder.orderStatus=='04' && purchaseOrder.salesNo=='' " c-widget="button;caption:删除;click:deleteOrder"></div>--%>
    <div title="点击查看如何另存为PDF" class="coverage"><i class="iconfont" style="font-size:30px;position:relative;top:7px;">&#xe6ed;</i> 友情提示：你可以在打印页将订单另存为PDF文件 <span>查看<i class="iconfont" style="font-weight:900;font-size:14px;position:relative;top:1px;">&#xe68b;</i></span></div>
    <div class="received">已收货&#x3000;<span></span></div>
    <div class="ui custom popup" style="padding: 0;width: 280px;height: 260px;"><p
            style="margin-top: 20px;text-align: center">扫一扫，转发给供应商做确认</p>
        <div style="margin-top: 30px ;text-align: center;" id="qrCodeDataMid"></div>
    </div>
</div>


<div id="tableContainer" >
    <div class="ui form">
        <div class="order" style="color:#13c19f;font-weight:900;">
            <p class="cai">采购单号 : <span id="orderNum" c-bind="purchaseOrder.purchaseNo"></span></p>
            <p class="xiao">销售单号 : <span id="saleorderNum" c-bind="purchaseOrder.salesNo"></span></p>
        </div>
        <div class="inline fields" style="text-align: center; display: block;">
            <div class="field" style="margin-left: 20px;display: inline-block;font-size: 18px;">
                <label style="margin-right:2px;">${sessionScope.sessionUser.comName}</label>
                <label>采购单</label>
                （<label c-bind="purchaseOrder.orderDate"></label>）
                <div c-widget="divider" style="margin-left:-40px;margin-right:-40px;"></div>
            </div>
        </div>

        <div class="fieldsec">
            供应商 : <span style="font-weight:400" c-bind="purchaseOrder.partnerShortname"></span>
            <span style="font-weight:400;margin:0;" c-bind="purchaseOrder.contactName"></span> (<span style="font-weight:400;margin:0px;" c-bind="purchaseOrder.contactTel"></span>)
            
        </div>
    </div>
    <!--<div c-widget="divider"></div>-->
    <div class="ui form" style="position:relative;">
        <div id="tableData" class="field" style="margin-bottom: 10px;"></div>
        <div class="total-drive">
            <div>
                <div class="total-left">
                    <div>备注：<span c-bind="purchaseOrder.remarks" id="shifouweikong"></span></div>
                </div>
                <ul class="total_right">
                    <li>合&#x3000;&#x3000;计 :<span c-bind="formatNumber(purchaseOrder.price,'#,##0.00')"></span></li>
                    <li class="zhe">折&#x3000;&#x3000;扣 :<span> - <i
                            c-bind="formatNumber(purchaseOrder.discount,'#,##0.00')"></i></span></li>
                    <li class="jian">减&#x3000;&#x3000;免 :<span> - <i
                            c-bind="formatNumber(purchaseOrder.preferential,'#,##0.00')"></i></span></li>
                    <div c-widget="divider"></div>
                </ul>
                <div style="clear:both;"></div>
            </div>
            <div style="position:relative;">
                <ul class="total_right">
                    <li style="margin-bottom:8px;">订单金额 :<span style="color:#eb6877;font-weight:900;"
                            c-bind="formatNumber(purchaseOrder.totalPrice,'#,##0.00')"></span></li>
                    <li>预&#x3000;&#x3000;付 :<span>- <i
                            c-bind="formatNumber(purchaseOrder.depositRequested,'#,##0.00')"></i> </span></li>
                </ul>
                <div style="clear:both;"></div>
            </div>
        </div>
    </div>
    <div c-widget="divider"></div>
    <div class="Customer-address">
        电话 : <span c-bind="bottomComInfo.comTel"></span>
        QQ : <span c-bind="bottomComInfo.comQQ"></span>
        <span class="relation">联系人 : <span style="margin:0;" c-bind="bottomComInfo.realName"></span> (<span style="margin:0;" c-bind="bottomComInfo.userId"></span>)</span>
        <span class="addr"> 地址 : <span>
                        <b c-bind="bottomComInfo.comAddress"></b>
                    </span></span>
       
        <span style="float:right;margin:0;">制单人 ：<span c-bind="purchaseOrder.creatorName" style="margin:0;"></span> (<span
                           style="margin:0;" c-bind="purchaseOrder.createTime"></span>)</span>
    </div>
</div>



<script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
<script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
<script src="/resources/cola-ui/3rd.min.js?v=59f8ac5b1a"></script>
<script src="/resources/cola-ui/semantic.min.js?v=ce263d5009"></script>
<script src="/resources/cola-ui/cola.min.js?v=96274d219a"></script>
<script src="/resources/mathutil.js?v=a8d38923c8"></script>
<script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
<script src="/resources/business/accounting.min.js?v=79a4c7c7db"></script>
<script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>

<script type="text/javascript">
    var pageDelOrder = "/ydz/purchaseorder/deletePurchaseOrder";// 删除订单请求url
    var pageCancelOrder = "/ydz/purchaseorder/cancelPurchaseOrder";// 作废订单请求url 
    function closeTaxPoint() {
        $(".window-mask").hide();
        $("#taxPointWin,#cancelWin").css({display: 'none'});
    }
    cola(function (model) {
        var fields, tablesDemo, orders, createTable;
        fields = {
            itemNo: {property: "itemNo", caption: "行序号"},
            businessType: {property: "businessType", caption: "业务类型"},
            businessDesc: {property: "businessDesc", caption: "业务内容", align: "left"},
            requirements: {property: "requirements", caption: "制作物料", width: "245px", align: "left"},
            workingStatus: {property: "workingStatus", caption: "制作进度", width: "136px", align: "center"},
            priceWay: {property: "totalArea", caption: "面积(㎡)", width: "81px", align: "center"},
            length: {property: "specification", caption: "规格(m)", width: "136px", align: "center"},
            colorSize: {property: "colorSize", caption: "色数", width: "60px", align: "center"},
            pairsNum: {property: "pairsNum", caption: "付数", width: "60px", align: "center"},
            quantity: {property: "quantity", caption: "数量", width: "81px", align: "center"},
            unit: {property: "unit", caption: "单位", width: "81px", align: "center"},
            unitPrice: {property: "unitPrice", caption: "单价", width: "81px", align: "right"},
            totalPrice: {property: "totalPrice", caption: "行小计", width: "81px", align: "right"},
            orderStatus: {property: "orderStatus", caption: "订单状态", width: "60px", align: "center"},
            isUrgent: {property: "isUrgent", caption: "是否加急", width: "60px", align: "center"},
            isValid: {property: "isValid", caption: "是否有效", width: "60px", align: "center"},
            isDel: {property: "isDel", caption: "是否删除", width: "60px", align: "center"},
            creator: {property: "creator", caption: "创建者", width: "81px", align: "center"},
            createTime: {property: "createTime", caption: "创建时间", width: "81px", align: "center"},
            operation: {caption: "操作", width: "60px", align: "center"}
        };
        var industryId = '${param.industryId}';
        var tags = {};
        model.describe("tags", {
            provider: {
                url: "/order/listBusinessTypeVO?industryId=" + industryId + "&way=detail"
            }
        });
        model.get("tags", "sync").each(function (element, index) {
            tags[element.get("modelName")] = element._data;
        });
        var purchaseNo = '${param.purchaseNo}';
        model.describe("bothData", {
            provider: "/ydz/purchaseorder/orderDetailData?orderNo=" + purchaseNo + "&industryId=" + industryId
        });
        model.describe("tables", {
            provider: "/json/tables.json"
        });
        tablesDemo = new Array();
        var bothData = model.get("bothData", "sync");
        model.set("orders", bothData.get("orders"));
        model.set("purchaseOrder", bothData.get("purchaseOrder"));
        model.set("bottomComInfo", bothData.get("bottomComInfo"));
        if(model.get("purchaseOrder")._data.isReceived=="1"){
            $(".receiving").hide();
            $(".received").show();
            $(".received span").text(model.get("purchaseOrder")._data.receivedTime);
        }
        if(model.get("bottomComInfo")._data.realName=="-"&&model.get("bottomComInfo")._data.userId=="-"){
            $(".relation").hide()
        }
        if(model.get("bottomComInfo")._data.comAddress=="-"){
            $(".addr").hide()
        }
       if (bothData.get("shareUrl")) {
           $('#qrCodeDataMid').qrcode({width: 160, height: 160, text: bothData.get("shareUrl")});
       }
        orders = model.get("orders");
        
        orders.each(function (order) {
            var path = "model" + order.get("businessType");
            var tableId = "model" + order.get("businessType");
            var temp = model.get(path);
            if (!temp) {
                temp = [];
                model.set(path, temp);
                temp = model.get(path)
                tablesDemo.push(tableId);
            }
            temp.insert(order.toJSON());
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
                    } else if (arg.column.get("property") === "length") {
                        $(arg.dom).html(arg.item.get("length") + "*" + arg.item.get("width"));
                        return false;
                    } else if (arg.column.get("property") === "workingStatus") {
                        $(arg.dom).html('<div style="position: relative;">' + arg.item.get("workingStatus") + '</div>');
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
        var tables = model.get("tables", "sync");
        var tables = tables.toJSON();

        for (var i = 0; i < tablesDemo.length; i++) {

            var tag1 = tags[tablesDemo[i]];
            var tabel = createTable(tag1);
            $("#tableData").append(tabel);
        }
        ;
        model.action({
            closeRightWin: function () {
                window.parent.hideMsg();
            },
            deleteOrder: function () {
                $("#taxPointWin").css({display: 'block'});
            },
            cancelOrder: function () {
                $("#cancelWin").css({display: 'block'});
            },
            modifyBtn: function () {
                var sno=$("#saleorderNum").text();
                if(sno===null || sno===""){
                    window.parent.modifyOrderIframe('${param.purchaseNo}');
                }else{
                    $("<div class='tips_contants'>").fadeIn(250).html("此单为协同订单，只能由销售方进行修改").delay(4000).fadeOut(250).appendTo('body');
                }

            },
            deleteOrderLast: function (self) {
                self.set("disabled", true);
                $.ajax({
                    type: "POST",
                    url: pageDelOrder,
                    data: {purchaseNo: $("#orderNum").text()},
                    dataType: "json",
                    success: function (dt) {
                        $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(2000).fadeOut(250).appendTo('body');
                        setTimeout(function () {
                            parent.hideMsg();
                            window.parent.location.reload();
                        }, 2000);
                    },
                    error: function () {
                        self.set("disabled", false);
                        $("<div class='tips_contants'>").fadeIn(250).html("删除失败").delay(2000).fadeOut(250).appendTo('body');
                    }
                })
            },
            cancelOrderLast: function (self) {
                self.set("disabled", true);
                $.ajax({
                    type: "POST",
                    url: pageCancelOrder,
                    data: {purchaseNo: $("#orderNum").text()},
                    dataType: "json",
                    success: function (dt) {
                        $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(2000).fadeOut(250).appendTo('body');

                        setTimeout(function () {
                            parent.hideMsg();
                            window.parent.location.reload();
                        }, 2000);
                    },
                    error: function () {
                        self.set("disabled", false);
                        $("<div class='tips_contants'>").fadeIn(250).html("作废失败").delay(2000).fadeOut(250).appendTo('body');

                    }
                })
            }
        });
    });

    $(function () {
        $(".fixheader").css("visibility","visible");
        // 收货
        $(".receiving").click(function(){
            $(".deleteW").show();
        })
        $(".abolish").click(function(){
            $(".deleteW").hide();
        })
         $(".notarize").click(function(){
            $(".deleteW").hide();
             $.ajax({
                type: "GET",
                url: "/ydz/purchaseorder/delivery",
                data: {purchaseNo: $("#orderNum").text()},
                dataType: "json",
                success: function (dt) {
                   $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(2000).fadeOut(250).appendTo('body');
                   setTimeout(function(){
                    window.location.reload();
                   },2000)
                },
                error: function () {
                   

                }
             })
        })



        var dan = $(".xiao span").text();
        var a = $(".zhe i").text();
        var b = $(".jian i").text();
        if (a == "0.00") {
            $(".zhe").hide();
        }
        if (b == "0.00") {
            $(".jian").hide();
        }
        if (dan == "" || dan == "null") {
            $(".xiao").hide();
            $(".receiving").hide();
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
                $("#sheng1").html(val.provinceName);
                return false;
            }
        });

        $.each(CityJson, function (key, val) {
            if (val.provinceId == sheng && val.cityId == shi) {
                $("#shi1").html(val.cityName);
                return false;
            }
        });

        $.each(CountryJson, function (key, val) {
            if (val.cityId == shi && val.countryId == xian) {
                $("#xian2").html(val.countryName);

            }
        });
        //打印
        $("#print").click(function () {
            window.parent.parent.open("/print/purchase-order-detail-print.html?purchaseNo=${param.purchaseNo}" + "&industryId=${param.industryId}");

        })
        $("#modifyBtn").click(function () {
            window.parent.parent.open("/print/purchase-order-detail-print.html?purchaseNo=${param.purchaseNo}" + "&industryId=${param.industryId}");

        })

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
</html>
