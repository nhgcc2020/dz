<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <title>制作派工-工序任务列表</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <style type="text/css">
        .tbWk td {
            border: 1px solid #000 !important;
            padding: 10px;
        }

        .tbWk {
            border: 1px solid #000;
            color: #000;
        }

        .tbWk caption {
            padding: 10px;
            font-size: 43px;
        }

        .datagrid-body td {
            position: relative;
        }

        .tbList li {
            text-align: center;
            color: #666;
            height: 180px;
            margin-bottom: 10px;
            position: relative;
            padding: 0 30px;
            cursor: pointer;
            transition: margin-top 0.3s 0s linear;
            box-shadow: 0 1px 2px 0px rgba(0, 0, 0, 0.12);
            cursor: pointer;
            overflow: hidden;
            border: 1px solid #ccc;
            float: left;
            width: 19%;
            margin-right: 0;
            margin-left: 1%;
        }

        /*.tbList li {
            text-align: center;
            color: #4284d9;
            height: 220px;
            position: relative;
            padding: 0 30px;
            cursor: pointer;
            overflow: hidden;
            border: 1px solid #e8e8e8;
            float: left;
            width: 250px;
            font-size: 22px;
            line-height: 220px;
            margin-right: 20px;
            margin-top:26px;
        }*/

        .wk {
            color: #4284d9;
            font-size: 28px;
            line-height: 60px;
        }

        .wkNum {
            font-size: 18px;
            font-weight: 700;
            margin-top: -5px;
            vertical-align: bottom;
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

        .ui.input.drop > .value-content {
            top: -3px;
        }

        table,
        th,
        td {
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

        #order .table-wrapper > table thead th:nth-child(11),
        #order .table-wrapper > table thead th:nth-child(1),
        #order .table-wrapper > table thead th:nth-child(12),
        #order .table-wrapper > table thead th:nth-child(2) {
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

        .datagrid-header,
        .datagrid-td-rownumber {
            background: #eff1f3;
        }

        .datagrid-header .datagrid-cell span {
            font-size: 14px;
        }

        .btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
            font-size: 14px;
        }

        .btn-primary:hover,
        .btn-primary:focus,
        .btn-primary:active,
        .btn-primary.active,
        .open .dropdown-toggle.btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
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

        .datagrid-header-row,
        .datagrid-row,
        .datagrid-header {
            height: 50px;
        }

        .datagrid-header .datagrid-cell {
            /*height:40px;*/
            /*line-height: 40px;*/
        }

        .window-shadow {
            background: none;
        }

        table,
        th,
        td {
            vertical-align: middle;
        }

        #msgwindow {
            border: none;
            z-index: 9999;
            width: 84%;
            height: 100%;
            left: 100%;
            box-shadow: 0px 0px 7px #999;
            padding: 2%;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
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

        .btn.smcolor {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
            color: #fff;
        }

        .datagrid-header .datagrid-cell {
            /*text-align: center !important;*/
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

        /*    .datagrid-header td,.datagrid-body td{
                padding:5px;
            }*/

        .select2-results__options li {
            position: relative;
        }

        .datagrid-body .datagrid-cell {
            padding: 10px;
        }

        .datagrid-htable .datagrid-cell {
            padding-left: 10px;
        }

        .datagrid-header .datagrid-cell span {
            color: #666;
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

        .panel {
            box-shadow: 0 0 0;
        }

        .datagrid-body td {
            border-bottom: 1px solid #eae8e8;
        }

        .pagination-btn-separator {
            display: none;
        }

        #order .table-wrapper > table thead th:nth-child(1) {
            text-align: left;
        }

        .qqhover:hover,
        .telhover:hover {
            color: #2e8ae6 !important;
        }

        .datagrid-cell,
        .datagrid-cell-group,
        .datagrid-header-rownumber,
        .datagrid-cell-rownumber {
            font-size: 12px;
        }

        .remarkbd {
            height: 30px;
            margin-top: 10px;
            line-height: 30px;
            padding-top: 5px;
            color: #b3b3b3;
            font-size: 12px;
            border-top: 1px solid #f2f2f2;
            text-overflow: ellipsis;
            overflow: hidden;
        }

        /*.namebd {
            height: 40px;
            line-height: 30px;
            cursor: pointer;
            font-size: 14px;
            color: #000;
        }*/

        .contactbd {
            cursor: pointer;
            color: #b3b3b3;
            font-size: 12px;
            /*line-height: 45px;*/
        }

        .namebdsml {
            font-size: 12px;
            color: #b3b3b3;
            margin-left: 15px;
        }

        .namebd {
            font-size: 12px;
            cursor: pointer;
            color: #4284d9;
            margin-left: 15px;
            cursor: pointer;
        }

        .nameb {
            font-size: 12px;
            cursor: pointer;
            color: #4284d9;
            cursor: pointer;
        }

        .telhover,
        .qqhover {
            margin-left: 8px;
            vertical-align: middle;
        }

        .contacthover {
            margin-right: 20px;
        }

        .tooltip {
            border: none !important;
            background: transparent !important;
        }

        .tooltip-arrow {
            display: none;
        }

        .tooltip-inner {
            opacity: 1;
            color: rgb(102, 102, 102);
            background-color: rgb(255, 255, 204);
            border: 1px solid #ffcc00;
        }

        .font12 {

            color: #999;
            margin-bottom: 10px;
            font-size: 12px;
        }

        .font18 {
            font-size: 18px;
            color: #000;
            /*height:50px;*/
            /*line-height:45px;*/
        }

        .fontColor3c {
            color: #ccc;
        }

        #msgwindow {
            border: none;
            z-index: 9999;
            width: 84%;
            height: 100%;
            left: 100%;
            box-shadow: 0px 0px 7px #999;
            padding: 2%;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }

        .nicescroll-rails-vr,
        .nicescroll-rails-hr {
            /*display: block !important;*/
        }

        .nav-tabs > li > a {
            color: #3f3e3e;
            border: none;
        }

        .nav-tabs,
        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:hover,
        .nav-tabs > li.active > a:focus {
            border: none;
            font-size: 14px;
        }

        .nav-tabs > li.active > a,
        .nav-tabs > li.active > a:hover,
        .nav-tabs > li.active > a:focus {
            /*border-bottom: 2px solid #2e8ae6;*/
            color: #2e8ae6;
            padding-bottom: 5px;
        }

        .nav-tabs > li > a:hover {
            border: none;
        }

        .nav > li > a:hover,
        .nav > li > a:focus {
            text-decoration: none;
            background: none !important;
        }

        #navCondition li {
            margin-right: 10px;
        }

        /*#navCondition li{
           padding: 36px 0 9px 0;
           border-bottom: 1px solid #e4e4e4;
           width: 1060px;
        }*/

        .nav-tabs {
            position: relative;
        }

        .nav-tabs li:nth-child(1) ~ .block {
            position: absolute;
            bottom: 3px;
            left: 8px;
            width: 55px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .nav-tabs li:nth-child(2).active ~ .block {
            transform: translate(84px, 0);
        }

        .nav-tabs li:nth-child(3).active ~ .block {
            transform: translate(168px, 0);
        }

        #taxPointWin {
            border: none;
            z-index: 99;
            width: 556px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            min-height: 484px;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
            margin-left: -288px;
            margin-top: -242px;
        }

        .labelCon {
            display: inline-block;
            background: #800080;
            color: #fff;
            padding: 1px 10px;
            margin: 0 5px;
            border-radius: 2px;
        }

        /*制作车间列表样式*/

        .tbList li:nth-child(4n) {
            margin-right: 0;
        }

        .datagrid-htable .datagrid-cell {
            text-align: center !important;
        }

        .plistmarkSale {
            width: 38px;
            height: 18px;
            text-align: center;
            line-height: 16px;
            right: 10px;
        }

        .selfmessage {
            margin-top: 10px;
            height: 190px;
        }

        .selfmessage p {
            color: #000;
            line-height: 25px;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script src="/resources/business/work-my-task.js?v=4546a17f5a"></script>
    <script>
        var workingProcedure = "${workingProcedure}";
        $(function () {
            $("#navCondition").on("click", "li", function () {
                $(this).addClass("active").siblings().removeClass("active");
                reloadWk("");
            });
        })
    </script>
    <script id="tpl-wangong" type="text/html">
        <h2></h2>
        <div class="table_one" style="width:400px;">
            <table class="tbWk">
                <caption style=" ">{{partnerShortname}}</caption>
                <col width="400"/>
                <tr>
                    <td>{{contacterName}} {{mobile}}</td>
                </tr>
                <tr>
                    <td>{{businessDesc}}</td>
                </tr>
                <tr>
                    <td>{{specification}} 数量 {{quantity}}</td>
                </tr>
                <tr>
                    <td colspan="3">{{requirement}}</td>
                </tr>
                <tr>
                    <td>{{address}}</td>
                </tr>
            </table>
            <div class="selfmessage">
                <p>{{comShortname}}</p>
                <div id="qrCodeDataMid" style="float:right;"></div>
            </div>
        </div>
    </script>
</head>

<body class="easyui-layout" style="border:none !important;">
<!--<body>-->
<div id="taxPointWin" style="padding-top:5px;top:40%;left:50%;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">
        任务完工</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="orderTableWs.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div class="table" id="wangong"
             style="    width: 400px;margin: 30px auto 25px;position: relative; text-align: left;">

        </div>
        <div style="clear: both; padding-bottom: 10px; position:absolute;bottom:10px;right:80px;">
            <button type="button" class="btn  btn-default" onclick="orderTableWs.closeTaxPoint()" style="width:100px;">
                取消
            </button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;"
                    onclick="orderTableWs.saveTable()">完工
            </button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;"
                    onclick="orderTableWs.finishTaskPrt()">完工并打印
            </button>
        </div>
    </div>
</div>
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:9;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>

<div data-options="region:'north'"
     style="height:165px;border:none !important;padding:10px 10px 0;margin-right: 10px;overflow: hidden;">
    <div class="header_text" style="border:1px solid #ccc;font-size:1.6rem;color:#000;padding:1.2rem;">写真打印</div>
    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" data-s="5" class="active"><a href="#">制作中</a></li>
        <li style="position:relative;" data-s="2" class=""><a href="#">已完工</a></li>
        <li style="position:relative;" data-s="c" class=""><a href="#">已作废</a></li>
        <li class="block"></li>
    </ul>
    <div class="h10"></div>
    <div class="condidtionMy " style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">
                <!--<div class="col-xs-2" style="width:150px;padding:0 5px">
            <select class="form-control input-xs" id="makeProcess">
        <option value=""></option>
    </select>
        </div>-->
                <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                </div>

                <div class="col-xs-2 " style="width:180px;padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:150px">
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
                <div class="col-xs-2 " style="width:150px;padding:0 5px">

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
                               onkeypress="if(event.keyCode == 13) {reload('');return false;}" id="searchK"
                               placeholder="输入单号、项目名称、业务内容"
                               style="      width: 212px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">

                    </div>
                </div>
                <button type="button" id="searchBtn" class="btn btn-primary "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>
                <button type="button" id="complete" class="btn btn-primary "
                        style="font-size:12px;height:30px;line-height:1;float:right;">完工
                </button>
            </div>
        </form>
    </div>

</div>

<div data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;">
    <table id="orderWk" style="width: 100%;" class="easyui-datagrid order"
           data-options="remoteSort:false,
           nowrap:true,singleSelect:false,checkOnSelect:false,fit:true">
    </table>
</div>
</body>

</html>