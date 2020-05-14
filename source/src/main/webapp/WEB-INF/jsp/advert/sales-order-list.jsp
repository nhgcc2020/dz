<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>销售订单列表</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script src="/resources/business/dzorder/sales-order/order-list.js?v=1241291d842"></script>
    <style>
        /*max-width 请根据页面一级导航实时调整*/
        .w1200alt {
            width: 120px;
        }

        .w1200input {
            width: 150px;
        }

        .w1200ipt150 {
            width: 180px;
        }

        /*.w1200hide {*/
            /*display: inline-block;*/
        /*}*/

        /*.w1200show {*/
            /*display: none;*/
        /*}*/

        @media only screen and (max-width: 1366px) {
            .w1200input {
                width: 120px;
            }

            .w1200ipt150 {
                width: 150px;
            }

            /*.w1200hide {*/
                /*display: none;*/
            /*}*/

            /*.w1200show {*/
                /*display: inline-block;*/
            /*}*/
        }

        .conTbText .datagrid-header td, .conTbText .datagrid-body td, .conTbText .datagrid-footer td {
            border-width: 0;
        }

        .conTbText .datagrid-header td, .conTbText.datagrid-body td, .conTbText .datagrid-footer td {
            border-style: solid;
            border-color: #e4e4e4;
        }

        .conTbText .datagrid-body td {
            border-bottom: 1px solid #eae8e8;
        }

        .topbarPrCss {
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            z-index: 999;
            background: rgb(255, 255, 255);
            height: 100%;
            border-bottom: 1px solid rgb(204, 204, 204);
            /*overflow: hidden;*/
            width: 100%;
            box-shadow: rgba(34, 36, 38, 0.14902) 0px 0px 20px;
            box-sizing: border-box;
        }

        .namebdsml {
            font-size: 12px;
            color: #b3b3b3;
            line-height: 23px;
            /*margin-left:15px;*/
        }

        .namebd {
            /*height: 40px;*/
            /*line-height: 30px;*/

            font-size: 12px;
            color: #000;
        }

        .switch_handle_on {
            background: #ccc;
            border-radius: 20px;
            color: #000 !important;

        }

        .ui.input.drop > .value-content {
            top: -3px;
        }

        table, th, td {
            vertical-align: top;
        }

        .btn {
            font-size: 12px;
        }

        .btn-default {
            color: #999;
        }

        .ui.items-view table tbody tr:nth-child(even) {
            background: none !important;
        }

        .ui.items-view .item {
            cursor: default;
        }

        #order .table-wrapper > table thead th:nth-child(11), #order .table-wrapper > table thead th:nth-child(1), #order .table-wrapper > table thead th:nth-child(12), #order .table-wrapper > table thead th:nth-child(2) {
            font-weight: 700;
        }

        .pagination table {
            height: 50px;
            line-height: 50px;
            float: right;
        }

        .pagination {
            border-radius: 0;
        }

        .datagrid .datagrid-pager {
            border-color: #2e8ae6;
            border-top-width: 2px;

        }

        .datagrid-row-over,
        .datagrid-header td.datagrid-header-over {
            background: none !important;
            color: #000;
            cursor: default;
        }

        .datagrid-header .datagrid-cell {
            height: 40px;
            line-height: 40px;
        }

        .datagrid-header, .datagrid-td-rownumber {
            background: #eff1f3;
        }

        .datagrid-header {
            border-width: 0;
            /*border-color:  #2e8ae6;;*/
        }

        .datagrid-header .datagrid-cell span {
            font-size: 12px;
        }

        .btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
        }

        .btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open .dropdown-toggle.btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
        }

        .datagrid-header td, .datagrid-body td, .datagrid-footer td {
            border-style: solid;
            border-color: #e4e4e4;
        }

        .datagrid-row-selected {
            background: none !important;
            color: #000;
        }

        .datagrid .panel-body {
            border: none !important;
        }

        .window .window-body {
            padding: 50px 10px 0;
            border: none !important;
            border-width: 0 !important;
            background: #fff;
            border-radius: 0;
        }

        .datagrid-header-row, .datagrid-row {
            height: 30px;
            line-height: 30px;

        }

        .window-shadow {
            background: none;
        }

        table, th, td {
            vertical-align: middle;
        }

        #msgwindow {
            border: none;
            z-index: 9999;
            width: 84%;
            height: 100%;
            left: 100%;
            box-shadow: 0px 0px 7px #999;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }

        #taxPointWin {
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

        .h10 {
            clear: both;
            height: 10px;
        }

        select option {
            line-height: 30px;
            height: 30px;
            margin: 5px auto;

        }

        .datagrid-header .datagrid-cell {
            text-align: center !important;
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 99999;
            display: none;
            margin-top: -150px;
            margin-left: -150px;
            width: 300px;
            height: 80px;
            border-radius: 5px;
            background: rgba(0, 0, 0, .8);
            color: #fff;
            text-align: center;
            line-height: 80px
        }

        .pagination {
            display: none;
        }

        /*    .datagrid-header td,.datagrid-body td{
                padding:5px;
            }*/

        .datagrid-body .datagrid-cell {
            padding: 10px;
        }

        .form-control {
            display: block;
            width: 100%;
            height: 30px;
            padding: 6px 10px 6px 12px;
            font-size: 12px;
            line-height: 1.428571429;
            color: #555;
            vertical-align: middle;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .input-group-addon {
            padding: 5px 12px;
            font-size: 14px;
            font-weight: normal;
            line-height: 1;
            text-align: center;
            background-color: transparent !important;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .datagrid-body td {
            position: relative;
        }

        .datagrid-cell a:hover, .datagrid-cell a:visited, .datagrid-cell a:link {
            color: #4284d9;
            text-decoration: none;
        }

        .nav-tabs > li > a {
            color: #3f3e3e;
            border: none;
        }

        .nav-tabs, .nav-tabs > li.smcolor > a, .nav-tabs > li.smcolor > a:hover, .nav-tabs > li.smcolor > a:focus {
            border: none;
            font-size: 14px;
        }

        .nav-tabs > li.smcolor > a, .nav-tabs > li.smcolor > a:hover, .nav-tabs > li.smcolor > a:focus {
            /*border-bottom: 2px solid #2e8ae6;*/
            color: #2e8ae6;
            padding-bottom: 5px;
        }

        .nav-tabs > li > a:hover {
            border: none;
        }

        .nav > li > a:hover, .nav > li > a:focus {
            text-decoration: none;
            background: none !important;
        }

        #navCondition li {
            margin-right: 10px;
        }

        .nav-tabs {
            position: relative;
        }

        .nav-tabs li:nth-child(2).smcolor ~ .block {
            transform: translate(82px, 0);
        }

        .nav-tabs li:nth-child(3).smcolor ~ .block {
            transform: translate(168px, 0);
        }

        .nav-tabs li:nth-child(4).smcolor ~ .block {
            transform: translate(249px, 0);
        }

        .nav-tabs li:nth-child(5).smcolor ~ .block {
            transform: translate(350px, 0);
        }

        .nav-tabs li:nth-child(1) ~ .block {
            position: absolute;
            bottom: 3px;
            left: 2px;
            width: 70px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .telColor {
            color: #ff9200
        }
    </style>
    <script>

        function closeProReq() {
            $(".window-mask").hide();
            $("#topBarPR").hide();
            reload();
        }
        function twicepaiG(o) {
            var self = $(o);
            self.attr("disabled", true);
            $.ajax({
                url: "/ydz/salesorder/workingAssignTask",
                type: "post",
                data: JSON.stringify(readyDatapg()),
                dataType: "json",
                contentType: "application/json",
                success: function (callBack) {

                    $("<div class='tips_contants'>").fadeIn(250).html(callBack.msg).delay(3000).fadeOut(250).appendTo('body');
                    closeProReq();
                    self.attr("disabled", false);
                }, error: function () {
                    $("<div class='tips_contants'>").fadeIn(250).html("添加出错,请联系管理员").delay(3000).fadeOut(250).appendTo('body');

                    self.attr("disabled", false);
                }
            });
        }

        function readyDatapg() {
            var rows = $('#orderPg').datagrid("getRows");
            var saveData = [];
            for (var i = 0; i < rows.length; i++) {
                rows[i].createTime = null;
            }
            saveData = rows;
            return saveData;
        }
        function testHard1(btn) {
            $(".window-mask").hide();
            $("#topBarPR").hide();
        }

        function openProReq(salesno) {

            $(".window-mask").show();
            $("#topBarPR").show();
            $(".loading_box").removeClass("loadingssss");
            reloadPg(salesno);
        }
        function arrFunPg() {
            var arrclo = [];

            arrclo.push({
                field: 'businessDesc', width: 200, title: '业务内容', formatter: function (value, row) {

                    return value;
                }
            });
            arrclo.push({field: 'requirements', width: 200, title: '物料/制作/说明'});

            arrclo.push({field: 'specification', width: 100, align: 'center', title: '规格(m)'});
            arrclo.push({field: 'quantity', width: 60, align: 'center', title: '数量'});
            arrclo.push({field: 'totalArea', width: 60, align: 'center', title: '面积(㎡)'});
            arrclo.push({
                field: 'cz',
                width: 60,
                align: 'center',
                title: '<div style="" id="caozuoTip"  data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom" data-html="true"        data-content="用于标记加急的制作物料,便于员工优先制作" >加急<span  class="iconfont_new" style="color: #ff9900;position: relative;top:-1px;vertical-align: middle;font-size: 20px">&#xe6b8;</span></div>',
                formatter: function (value, row) {
                    if (row.isUrgent == "1") {
                        return ' <div style="width: 40px;    display: inline-block;" class="checkbox checkbox-slider--b-flat "><label><input onclick="checkChange(this)" value="1" checked type="checkbox"><span></span></label></div>'
                    } else {
                        return ' <div style="width: 40px;    display: inline-block;" class="checkbox checkbox-slider--b-flat "><label><input onclick="checkChange(this)" value="1"  type="checkbox"><span></span></label></div>'
                    }

                }
            });

            return arrclo;
        }
        function checkChange(o) {
            var rindex = $(o).parents("tr").index();
            var pageCheckbox = $('#orderPg').datagrid('getRows')[rindex];
            var f;
            if (pageCheckbox.isUrgent == "1") {
                f = 0
            } else {
                f = 1
            }

            $('#orderPg').datagrid('updateRow', {
                index: rindex, row: {
                    "isUrgent": f
                }
            });
        }
        function reloadPg(salesno) {
            var queryParams = {};
            var arrclo = arrFunPg();
            var status = $("#navCondition").find(".smcolor").attr("data-s");
            var pageSize = 30, pageList = [30, 40];

            var queryParams = {
                "orderStatus": status,
                "page": 1,
                "rows": 30,
                "partnerKey": "ALL",
                "endTime": "",
                "searchKey": salesno,
                "startTime": ""
            }
            $.ajax({
                url: "ydz/salesorder/listPageTotalDetailByOrder",
                data: queryParams,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (dt) {
                    $('#orderPg').datagrid({
                        data: dt.rows,
                        columns: [arrclo]
                    });
                }
            })

            $('[data-toggle="popover"]').popover();
        }
        function openDtParent(txt) {
            var url = "/ydz/salesorder/updatePage?salesNo=" + txt;
            $("#msgwindow").css({left: "0%", width: "100%"});
            $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function () {
                $("#msgF").attr("src", url);
            })

        }
    </script>
</head>
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">
    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" data-s="01" onclick="cgx(this,'2');" class=" order2"><a href="#">草稿箱</a></li>
        <li style="position:relative;" data-s="04" onclick="cgx(this,'4');" class="order4 smcolor"><a href="#">待对账</a>
        </li>
        <li style="position:relative;" data-s="05" onclick="cgx(this,'5');" class=" order5"><a href="#">已对账</a></li>
        <li style="position:relative;" data-s="CC" onclick="cgx(this,'6');" class=" order6"><a href="#">已作废</a></li>
        <li style="position:relative;" data-s="" onclick="cgx(this,'');" class="order"><a href="#">全部销售单</a></li>
        <li class="block"></li>
    </ul>
    <div id="switch_order" style="    border-radius: 20px;
    border: 1px solid #ccc;
    width: 150px;
    height: 30px;
    position: absolute;
    left: 455px;
    top: 15px;">
        <span class="switch_handle_on" style="
          -webkit-transition: margin-left 0.5s;
    transition: margin-left 0.5s;
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
 box-sizing: border-box;
    cursor: pointer;
    display: inline-block !important;
    height: 100%;
    color:#ccc;
    padding: 6px 12px;
    font-size: 12px;
">明细展现</span>
        <span class="" style="
             -webkit-transition: margin-left 0.5s;
    transition: margin-left 0.5s;
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
           box-sizing: border-box;
    cursor: pointer;
    display: inline-block !important;
    height: 100%;
    padding: 6px 12px;
    color:#ccc;
    font-size: 12px;
">汇总展现</span>
    </div>
    <div id="overFlow" style="color: #ff9900;
             position: absolute;
               left: 620px;
    top: 25px;
            cursor: pointer;" onclick="showOverFlow()">查看订单流程>>
    </div>
    <div onclick="window.parent.salesOrderAdd();" style="color:#7E92AB;    position: absolute;
    cursor: pointer;
    right: 190px;
             top: 25px;"><i class="iconfont_new" style="color:#4284d6;position:absolute;top:-4px;font-size:18px;">
        &#xe6a5;</i><span style="color:#4e8ae6;font-size:14px;">&#x3000;&#x3000;销售开单</span>
    </div>
    <div class="jump" style="color:#7E92AB;    position: absolute;
    cursor: pointer;font-size:14px;
    right: 30px;
             top: 25px;"><i class="iconfont_new" style="color:#7E92AB;position:absolute;top:-4px;font-size:18px;">
        &#xe6f5;</i>&#x3000;&#x3000;手动同步好友订单
    </div>


    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:200px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                </div>
                <div class="col-xs-2 w1200alt" style="padding:0 5px ">
                    <select class="form-control input-xs" id="contacterDp" >
                    </select>
                </div>
                <div class="col-xs-2 w1200alt" style="padding:0 5px">
                    <select class="form-control input-xs" id="dateDat">
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-xs-2 w1200ipt150" style="padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="w1200input">
                                <input type="text" style="" class="form-control" id="datetimepickers"
                                       data-format="yyyy-MM-dd" placeholder="订单日期">
                                <span onclick="$('#datetimepickers').datetimepicker('show');" class="" style="
    position: absolute;
    right: 30px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span><span style="
    position: absolute;
    right: 5px;
    top: 7px;
">至</span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2 w1200input" style="padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:100%">
                                <input type="text" style="" class="form-control" id="datetimepickere"
                                       data-format="yyyy-MM-dd" placeholder="订单日期">
                                <span onclick="$('#datetimepickere').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2" style="width: 242px;">

                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchK" placeholder="输入单号、项目名称、业务内容" style="      width: 212px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
                        <%--<span class="input-group-btn iconfont_new w1200show searchBtn" style="        cursor: pointer;--%>
    <%--position: absolute;--%>
    <%--top: 2px;--%>
    <%--width: 20px;--%>
    <%--right: 8px;--%>
    <%--font-size: 20px;--%>
    <%--transform: rotate(-5deg);--%>
    <%--color: #b3b3b3;">&#xe6df;</span>--%>
                    </div>
                </div>
                <button type="button" id="" class="btn  btn-primary searchBtn "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>

                <button type="button" class="btn btn-primary pull-right generatorBill hide"
                        style="font-size:12px;height:30px;line-height:1;" onclick="openTaxPoint('1')">生成对账单
                </button>
                <%--<button type="button" class="btn btn-primary pull-right generatorBill hide"--%>
                        <%--style="margin-right:10px;font-size:12px;height:30px;line-height:1;" onclick="openTaxPoint('2')">--%>
                    <%--生成对账单并收款--%>
                <%--</button>--%>
                <%--<button type="button" class="btn btn-warning pull-right modifyOrder hide"--%>
                <%--style="margin-right:15px;height:30px;line-height:1;" onclick="modifyOrder()">修改--%>
                <%--</button>--%>
            </div>
        </form>
    </div>

</div>
<div data-options="region:'center'" style="border:none !important;padding:10px;padding-top: 0;">

    <table id="order" style="height: 100%" class="easyui-datagrid"
           data-options="remoteSort:false,
           nowrap:true,singleSelect:false,checkOnSelect:false">
    </table>
</div>
<div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">
    <span class="total_all">合计:</span>
    <span id="totalTextSpan">行小计金额(元)：</span>
    <span style="color: red;margin-right: 15px;" id="order2PagerPrice">0.00</span>
    订单金额(元)：
    <span style="color: red;margin-right: 15px;" id="orderPrice">0.00</span>
    订单数(笔)：
    <span style="color: red;margin-right: 15px;" id="order2PagerNum">0</span>
</div>
<div id="orderProcedure"
     style="box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2); background: #fff; position: absolute;z-index: 9999;top:50%;left:50%;margin-left:-435px;margin-top:-286px; display: none;">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #e4e4e4; padding-left: 15px;">
        快速了解订单流程
    </div>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="font-size: 12px;color:#666;background-color: #f5f5f5; text-align: center; width: 500px; margin: 20px auto; line-height: 30px;">
        颜色区块表示系统对应操作 ! 灰色区块为辅助操作
    </div>
    <div style="margin: 70px auto 60px; padding: 0 20px;"><img src="../../images/orderflow.png" alt="订单流程图"></div>
    <div style="text-align: center;border:1px solid #ccc; border-radius: 3px;font-size: 12px;color: #ccc; height: 30px; width: 120px;line-height: 30px;margin: 0 auto 30px;cursor: pointer; "
         onclick="closeOverFlow()">我知道了
    </div>
</div>
<div id="topBarPR" class="topbarPrCss" style="height: 700px;width:100%;">
    <%--这个是加载框，切勿修改--%>
    <article style="    text-align: left;
    font-size: 1.6rem;
    padding: 1.2rem;
    border: 1px solid #dadadf;
    margin: 1.2rem;">
        启用派工
        <div class="col-xs-6 pull-right" style="text-align:right;top:-5px;">
            <button type="button" class="btn " onclick="closeProReq()" style="background: #DEE1E2;">返回</button>
            <button type="button" class="btn btn-primary " onclick="twicepaiG(this)" style="">派工</button>
        </div>
    </article>

    <div class="conTbText panel layout-panel layout-panel-center" style="width: 100%;
    height: 600px;clear: both;
    padding: 0 13px;">
        <table id="orderPg" style="width:100%;margin-top:50px;    height: 600px;" class="easyui-datagrid "
               data-options="remoteSort:false,
fitColumns : true,fit:true,
           nowrap:true,singleSelect:true,checkOnSelect:false">
        </table>
    </div>
</div>
<div id="taxPointWin"
     style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-286px;position:absolute; width: 660px;height:568px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="orderTitWin">
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;"
           id="orderdescWin">
        </p>
        <span class="customerjc"
              style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
              data-title="客户简称" id="partnerShortname"></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单总数(笔)：<em
                    style="font-family:Arial;font-weight: 100;    font-style: normal; font-size: 22px;"
                    id="numIndex"></em></span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;">订单总金额：<em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;"
                    id="totalPrice"></em></span>
            <i style="color: #2e8ae6;font-size: 12px;margin-left: 10px;position: absolute;right: -70px;font-style: normal;cursor: pointer;"
               onclick="addShuiDian()" id="shuidainBtn">添加税点</i>
        </div>
        <input type="hidden" name="depositRequestedHid" id="depositRequestedHid">
        <input type="hidden" name="totalPriceHid" id="totalPriceHid">
        <input type="hidden" name="receivePriceHid" id="receivePriceHid">
        <%--<input type="hidden" name="taxPriceHid" id="taxPriceHid">--%>
        <%--<input type="hidden" name="totalPriceWithTaxHid" id="totalPriceWithTaxHid">--%>
        <div id="shuiDianCtrl"
             style="display:none;clear:both;border:1px solid #ccc;width:400px;padding:20px 20px 0 20px;margin:0 auto;">
            <p style="width:360px;margin:0 auto ;height:35px;
            clear:both;"><span style="float:left;color:#666;font-size:14px;">税率：</span><span
                    style="float:right;color:#666;font-size:26px;">
                    <input type="text"
                           style="font-size:14px;border:1px solid #ccc;text-indent: 10px;border-radius:2px;width:60px;height:25px;vertical-align:middle"
                           onkeyup="inputCalMoney(this)"
                           id="taxRateView"
                           id="rateNum" value="0"><i
                    style="font-family: Arial;font-style:normal;margin-left:5px;font-size: 16px;">%</i></span></p>
            <p style="width:360px;margin:0 auto ;height:35px;
            clear:both;"><span style="float:left;color:#666;font-size:14px;">税额：</span>
                <span style=";float:right;color:#666;font-size:16px;" id="taxPrice"></span></p>
            <p style="width:360px;margin:0 auto ;height:35px;
            clear:both;"><span style="float:left;color:#666;font-size:14px;">对账总金额（含税）：
        </span><span style="font-family: Arial;font-style:normal;float:right;color:#666;font-size:16px;"
                     id="totalPriceWithTax"></span></p>
        </div>
        <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>
        <div style="      width: 400px; margin: 0 auto; padding: 30px 20px 0; position: relative;">
            <p style="text-align: right;  height: 30px;  color: #666;font-size: 14px;font-weight: 700;"><span
                    style="float:left;">预收总金额：</span><em
                    style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100">-</em>
                <em style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100"
                    id="depositRequested"></em></p>
            <p style="text-align: right; height: 30px;   margin-top:15px; color: #666;font-size: 14px;font-weight: 700;">
                <span style="float:left;">应收总金额：</span><em
                    style="font-weight:100;font-family: Arial; font-style:normal;font-size: 22px;color:#ff0000;"
                    id="receivePrice"></em></p>
        </div>
        <div style="    position: absolute;
    bottom: 70px;
    right: 80px;" class="telSelMesWin  prettyck"><input id="telSelMes"  type="checkbox" name="ck" value=""><label
                for="telSelMes" style="vertical-align:middle;font-weight: normal;">给该客户发送附带有账单详情链接的通知短信【手机号：<i
                class="telNumberShow telColor"></i>】</label></div>

        <div style="clear: both; position:absolute;bottom:25px;right:80px;">
            <button type="button" class="btn " onclick="closeTaxPoint()" style="width:100px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;"
                    id="orderMake">
            </button>
        </div>
    </div>
</div>
</body>
</html>