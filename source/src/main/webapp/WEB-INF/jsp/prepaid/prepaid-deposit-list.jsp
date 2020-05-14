<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>预存款账户录入</title>
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <style>
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
    </style>
    <style type="text/css">

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
            opacity: 0;
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

        .datagrid-header, .datagrid-td-rownumber {
            background: #eff1f3;
        }

        .datagrid-header {
            border-width: 0;
        }

        .datagrid-header .datagrid-cell span {
            font-size: 14px;
        }

        .btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
            font-size: 14px;
        }

        .btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open .dropdown-toggle.btn-primary {
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

        .datagrid-header-row, .datagrid-row, .datagrid-header {
            height: 50px;

        }

        .datagrid-header .datagrid-cell {
            /*height:40px;*/
            /*line-height: 40px;*/
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
            padding: 2%;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }

        #taxPointWin {
            border: none;
            z-index: 98;
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

        .pagination {
            display: none;
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
            font-size: 14px;
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
    </style>
    <style>
        .datagrid-header td, .datagrid-body td, .datagrid-footer td {
            border-width: 0;
        }
        .select2-container--default .select2-selection--single{
            border:1px solid #f2f2f2;
        }
        .select2-selection__rendered{
            text-align: left;
        }
        .select2-container .select2-selection--single,.select2-container--default .select2-selection--single .select2-selection__rendered{
            line-height: 34px;
            height: 34px;
        }
        .datagrid-header td, .datagrid-body td, .datagrid-footer td {
            border-style: solid;
            border-color: #e4e4e4;
        }

        .datagrid-body td {
            border-bottom: 1px solid #f2f2f2;
        }

        .pagination-btn-separator {
            display: none;
        }

        #order .table-wrapper > table thead th:nth-child(1) {
            text-align: left;
        }

        .qqhover:hover, .telhover:hover {
            color: #2e8ae6 !important;
        }

        .datagrid-cell, .datagrid-cell-group, .datagrid-header-rownumber, .datagrid-cell-rownumber {
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

        .namebd {
            margin: 9px 0;
            font-size: 14px;
            color: #000;
        }

        .contactbd {
            /*height: 50px;*/
            color: #999;
            font-size: 12px;
            margin-bottom: 9px;
            /*line-height: 45px;*/
        }

        .namebdsml {
            font-size: 12px;
            color: #999;
            margin-left: 15px;
        }

        .telhover, .qqhover {
            margin-left: 8px;
            vertical-align: middle;
        }

        .contacthover {
            margin-right: 14px;
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

        .nav > li > a:hover, .nav > li > a:focus {
            text-decoration: none;
            background: none !important;
        }

        #navCondition li {
            margin-right: 10px;
        }

        .navMoney li {
            width: 250px;
            float: left;
        }

        #deleteWin {
            border: none;
            z-index: 9999;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            /*min-height:290px;*/
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }

        .nav-tabs li:nth-child(1) ~ .block {
            position: absolute;
            bottom: -2px;
            left: 5px;
            width: 75px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .datagrid-cell-c2-cke {
            color: #ccc;
        }

        .datagrid-header-inner {
            background: #eff1f9;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <style>
        .ydz_select {
            display: inline-block;
            font-size: 0;
            position: relative;
            vertical-align: middle;
            white-space: nowrap;
        }

        .ydz_select_txt {
            background: none repeat scroll 0 0 #FFF;
            border: 1px solid #f2f2f2;
            cursor: pointer;
            display: inline-block;
            font-size: 12px;
            line-height: 34px !important;
            height: 34px !important;
            overflow: hidden;
            text-align: left;
            border-radius: 3px;
            padding: 0 5px 0 10px;
            text-overflow: ellipsis;
            vertical-align: top;
            white-space: nowrap;
            width: 170px;
        }

        .ydz_select_a {
            width: 0;
            height: 0;
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            border-top: 5px solid #786f6f;
            position: absolute;
            right: 5px;
            top: 15px;
        }

        .ydz_select_menu {
            background: none repeat scroll 0 0 #FFF;
            /*border: 1px solid #f2f2f2;*/
            border-top: none;
            border-radius: 2px;
            padding: 4px 0;
            display: none;
            border: 1px solid #e0dfdf;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.175);
            float: left;
            left: 0;
            overflow-x: hidden;
            overflow-y: auto;
            position: absolute;
            top: 100%;
            width: 170px;
            z-index: 1000;
        }

        .ydz_select_menu li {
            line-height: 21px;
            padding-bottom: 0 !important
        }

        .open .ydz_select_menu {
            display: block
        }

        .open .ydz_select_a {
            border-bottom: 5px solid #786f6f;
            border-top: transparent;
        }

        .ydz_select_menu li a {
            clear: both;
            text-align: left;
            color: #323232;
            display: block;
            font-size: 12px;
            line-height: 21px;
            padding: 3px 5px;
            white-space: nowrap
        }

        .ydz_select_menu li a:hover {
            background: none repeat scroll 0 0 #5897fb;
            color: #FFF;
            text-decoration: none
        }

    </style>
    <script>
        $(function () {
            $("body").bind('click', function () {
                $(".ydz_select").removeClass("open");
            });
            $(".ydz_select").on("click", function (e) {
                e.stopPropagation();
                if ($(this).hasClass("open")) {
                    $(this).removeClass("open");
                } else {
                    $(".ydz_select").removeClass("open");
                    $(this).addClass("open");
                }
            });
            $(".ydz_select_menu").on("click", "li", function () {
                $(this).closest(".ydz_select").find("input[type='hidden']").val($(this).find("a").attr("rel"));
                $(this).closest(".ydz_select").find("span").text($(this).find("a").text());

            })
        })
    </script>
</head>
<body class="easyui-layout" style=" overflow: hidden; ;border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="orderProcedure"
     style="box-shadow: rgba(0, 0, 0, 0.2) 1px 3px 10px 2px;width:580px;-webkit-animation-fill-mode:both;-webkit-animation-duration: 1s;display: none;
 background: rgb(255, 255, 255); position: absolute; z-index: 9999; top: 50%; left: 50%; margin-left: -435px; margin-top: -286px; ">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #e4e4e4; padding-left: 15px;">
        加好友
    </div>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>

    <div style="margin: 0 auto; width:490px;">
        <div style="background: url('/resources/images/addfriend.png') 10px no-repeat;margin-top:10px;height: 66px;width:490px;"></div>
        <div style="font-size: 12px;color:#666;background-color: #f5f5f5; text-align: center;margin: 20px auto; line-height: 30px;">
            作为好友，你给对方建的销售单，对方可以通过采购菜单查看！
        </div>
        <div style=" padding: 0 20px;">
            <div class="invite_content" style="
          margin-top:2rem;
    text-align: center;">
                <p id="inviteCom" style="font-size:16px; margin: 1rem auto 2rem;"></p>
                <p id="inviteName" style="color:#ccc; margin: 1rem auto 2rem;"></p>
                <input type="hidden" value="" id="partnerKeyPop">
                <input name="sendPhone" id="sendPhone" maxlength="11" placeholder="请填写手机号码" style="
            margin: 0em;
    -webkit-box-flex: 1;
    -webkit-flex: 1 0 auto;
    -ms-flex: 1 0 auto;
    flex: 1 0 auto;
    -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
    text-align: left;
    padding: 0px 30px 0px 10px;
    height: 30px;
    line-height: 30px;
    background: #FFFFFF;
    border: 1px solid #adadad;
    color: #999;
    border-radius: 3px;
    transition: box-shadow 0.1s ease, border-color 0.1s ease;
            width:250px;" onkeyup="checkPhone()">
                <p style="color: #ff9900;margin: 1rem auto 2rem;font-size: 12px;width: 250px;text-align: right;"
                   c-bind="tips" id="tips">请再次确认,发送后手机号将无法修改</p>
            </div>
        </div>
        <div style="clear: both; padding-bottom: 20px; text-align: center">
            <button type="button" class="btn  btn-default" onclick="closeOverFlow()" style="width:100px;">取消</button>
            <button type="button" id="sendMsgBtn" disabled class="btn btn-primary"
                    style="margin-left:15px;width:100px;font-size:12px;" onclick="sendMsg(this)">发送短信
            </button>
        </div>
    </div>

</div>
<div id="deleteWin"
     style="    padding-top: 5px;
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
    <span id="closetranform" style="    position: absolute;
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
            <button type="button" class="btn  btn-default" onclick="closeTaxPoint()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="delOrderConfirm(this)">确认
            </button>
        </div>
    </div>
</div>
<div id="taxPointWin"
     style="top: 50%;left: 50%;margin-left: -420px;margin-top: -320px;position: absolute;width: 760px;height: 500px;">
    <span style="    position: absolute;
    top: 12px;
    left: 20px;
    display: block;
    font-size: 16px;
    height: 30px;
    color: #fff;
    z-index: 99;">账户充值</span>
    <p style="position:relative;font-weight: 100;text-align: center;height: 50px;font-size: 14px;background:#4284d9;margin: 0px auto;padding: 10px 20px;border-bottom: 1px solid #e4e4e4;line-height: 30px;"
       id="orderTitWin">
    </p>
    <span style="    position: absolute;
    top: 1px;
    right: 10px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;" onclick="prepaidFun.closeTaxPoint()"><i class="iconfont_new"
                                                              style="color:#fff;font-size:32px;"></i></span>
    <div style="width: 640px;margin: 0 auto;position: relative;">

        <div style="margin:-1px auto;/* width:500px; */border-top: 1px solid #f2f2f2;"></div>

        <div style="/* width:552px; */margin:35px auto;">
            <div style="width:265px;display: inline-block;position:relative;margin-right: 67px;text-align: right;margin-bottom: 20px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">充值账户：</label>
                <div >
                    <select style="width:170px;" class="form-control input-xs" id="customerDat" placeholder="">
                    </select>
                </div>
            </div>

            <div style="width: 265px;display: inline-block;text-align: right;height: 34px;line-height: 34px;margin-bottom: 22px;">

                <label style="float: left;float: left;font-size: 14px;color: #333;width: 70px;font-weight: normal;">账户余额：</label>
                <input type="hidden" name="balanceMoney">
                <input type="text" value="" name="balanceMoneyText"  readonly
                       style="padding: 5px;outline:none;text-align:right;width: 170px;height: 34px;border: none;">元
            </div>
            <div style="width:265px;display: inline-block;text-align: right;height: 34px;margin-right: 67px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">充值金额：</label>
                <input type="text" name="rechargeMoney" onkeyup="value=value.replace(/[^\d.]/g, '').replace(/^\./g, '')" value=""
                       style="padding: 5px;width:170px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">


            </div>
            <div style="width: 265px;display: inline-block;height: 34px;position:relative;line-height: 34px;margin-bottom: 22px;text-align: right;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">充值日期：</label>
                <input id="recpayDate" name="recpayDate" type="text"
                       style="padding: 5px 5px 5px 10px;width:170px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                <span onclick="$('#recpayDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
"><i class="iconfont_new" style="font-size: 18px;"></i></span>
            </div>

            <div style="width:265px;display: inline-block;text-align: right;height: 34px;margin-right: 67px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">赠送金额：</label>
                <input type="text" name="presentMoney" value=""
                       style="padding: 5px;width:170px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
            </div>
            <div style="width: 265px;display: inline-block;height: 34px;position:relative;line-height: 34px;margin-bottom: 22px;text-align: right;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">&#x3000;&#x3000;备注：</label>
                <textarea rows="4" id="remarks" name="remarks"
                          style="resize: none;padding: 5px;border: 1px solid #f2f2f2;border-radius: 3px;width: 170px; /* *//* height:68px; */"></textarea>
            </div>

            <div style="width:265px;display: inline-block;text-align: right;height: 34px;margin-right: 67px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">充值方式：</label>
                <div class="ydz_select">
                    <div class="">
                        <span class="ydz_select_txt recpayNameShow"></span>
                        <input type="hidden" value="" name="recpayName">
                        <a class="ydz_select_a" href="javascript:;"></a>
                    </div>
                    <ul class="ydz_select_menu recpayAccountList">
                    </ul>
                </div>
            </div>
            <div style="width:265px;display: inline-block;text-align: right;height: 34px;margin-right: 67px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">
                    &#x3000;付款人：</label>
                <input type="text" name="paymentName" value=""
                       style="padding: 5px;width:170px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
            </div>
            <div style="width:265px;display: inline-block;text-align: right;height: 34px;margin-right: 67px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">
                    &#x3000;短信通知：</label>
                <input type="text" name="paymentTel" value="" placeholder="请填写付款人手机号码"
                       style="padding: 5px;width:170px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
            </div>
        </div>


    </div>
    <div style="    position: absolute;
    bottom: 70px;
    right: 106px;" class="telSelMesWin  prettyck"><input id="telSelMes" checked type="checkbox" name="ck"
                                                         value=""><label for="telSelMes"
                                                                         style="vertical-align:middle;font-weight: normal;">发送充值入账短信</label>
    </div>
    <div style="clear: both;position:absolute;bottom:30px;right: 105px;">
        <button type="button" class="btn " onclick="prepaidFun.closeTaxPoint(this)" style="width:100px;">取消</button>
        <button type="button" class="btn btn-primary sureReceivables"
                style="margin-left:15px;width:100px;font-size:12px;" onclick="prepaidFun.sureReceivables(this)"
                id="orderMake">确认
        </button>
    </div>
</div>
<div data-options="region:'north'"
     style="border:none !important;padding:10px 10px 0;margin-right: 10px;overflow: hidden;">

    <ul class="navMoney" style="    height: 50px;
    line-height: 50px;padding-left:50px;
    background: #f2f2f2;">
        <li style="position:relative;" id="sumLi1">预存款总金额：</li>
        <li style="position:relative;" id="sumLi2">充值总金额：</li>
        <li style="position:relative;" id="sumLi3">赠送总金额：</li>
        <li style="position:relative;" id="sumLi4">消费总金额：</li>
    </ul>


    <div class="h10"></div>
    <div style="    padding: 6px 10px 12px;
    border-bottom: 1px solid #f2f2f2;">
        <form role="form">
            <div class="row" style="margin:0;">

                <div class="col-xs-2" style="padding-left:1px;">
                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchKey" placeholder="搜索客户名称" style="      width: 208px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
                        <!--<span class="input-group-btn" id="searchBtn"  style="        cursor: pointer;
    position: absolute;
    top: 2px;
    width: 20px;
    right: 8px;
    font-size: 20px;
    transform: rotate(-5deg);
    color: #b3b3b3;">-->
                        <button class="btn btn-primary" id="searchBtn" type="button" style="height:30px; line-height:1;cursor: pointer;
    position: absolute;
    top: 0px;
    right: -62px;font-size:12px;">
                            搜索
                        </button>
                        <!--</span>-->
                    </div>
                </div>
                <button type="button" class="btn btn-primary pull-right modifyOrder "
                        style="font-size: 12px;margin-left:10px;height:30px;line-height:1;"
                        onclick="prepaidFun.chongzhi()">充值
                </button>

            </div>
        </form>
    </div>


</div>
<div id="regionCon" data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;">

    <table id="order" style="width: 100%;" class="easyui-datagrid order"
           data-options="remoteSort:false,

           nowrap:true,singleSelect:false,
           fitColumns:true,
           checkOnSelect:false,onLoadSuccess:onLoadSuccess,fit:true">
        <thead>
        <tr>
            <th data-options="field:'cke',fixed:true,align:'center',width:60,formatter: function(value, row,index) {
          			return (index+1);
          		}"></th>
            <th data-options="field:'orderDate',fixed:true,width:400,align:'left',formatter: function(value, row) {
            return prepaidFun.partnerInfoCall(row);

          		}">概要
            </th>
            <th data-options="field:'no',width:40,align:'left'"></th>
            <th data-options="field:'balanceMoney',align:'left',width:400,formatter: function(value, row) {
          			return accounting.formatNumber(value,2);
          		}">账户余额</th>
            <th data-options="field:'partnerKey',align:'left',width:200,formatter: function(value, row) {
          			return prepaidFun.partnerAddress(value);
          		}">充值记录
            </th>
            <th id="relation" data-options="field:'partnerStatus',width:200,resizable:false,align:'center',formatter: function(value, row,index) {
          			return prepaidFun.formatStatus(row.partnerKey);
          		}">消费记录</th>
        </tr>
        </thead>
    </table>
</div>
<div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 40px; overflow: hidden;">
    客户数 :
    <span style="color: red;margin-right: 15px;" id="order2PagerPrice">0</span>
</div>
<script>
    var numGlobal = 0;

    var pageListUrl="/system/partner/recharge/customerList"; // 预存款客户列表
    var pageRechargeUrl="/system/partner/recharge/in-recharge";// 充值
    var pageChargeListUrl="/system/partner/recharge/listrechargelog";// 充值记录
    var pageDetailListUrl="/system/partner/recharge/forward-listrechargelog";//   partnerKey
    var pageDetailListUrl2="/system/partner/recharge/forward-listconsumelog";//   partnerKey
    var pageSumListUrl="/system/partner/recharge/sumTotalVo";

    function funOpenUrl(v) {
        window.location.href =pageDetailListUrl+"?partnerKey="+v;
    }
    function funOpenUrl1(v) {
        window.location.href =pageDetailListUrl2+"?partnerKey="+v;
    }
    var prepaidFun = {
        chongzhi: function () {
            $("#taxPointWin").show();
        },
        formatState:function  (state) {
            var p=$(state.element).attr("data-p");
            var mark="";
            var css="  font-style:normal;font-size: 8px !important;background: #e9dfdf;color: #b89a9a;border-radius: 3px;height: 20px;margin-left: 10px;line-height: 20px;padding: 0 2px;position: absolute;right: 3px;top: 5px;";
            var cs="   position: absolute;right: 4px;top: 8px;border: 6px solid #f2711c;width: 0;height: 0;border-radius: 50%;";

            var $state = $(
                '<span data-p="'+p+'" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:160px;display: block;">'+state.text + '</span>' +mark

//                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
            );
            return $state;
        },
        openTaxPoint:function () {
            var App = window.parent.App;
            var config = {
                path: "/ydz/expensebook/forward-add?expenseType=0"
            };
            App.open(config.path, config);
        },


        sureReceivables:function (bt) {
            if($("#customerDat").val()==""){
                $.mytoast({text:"请选择充值账户"});
                return;
            }
            if($("input[name='rechargeMoney']").val()==""){
                $.mytoast({text:"请填写充值金额"});
                return;
            }
//        if($(".recpayNameShow").text()==""){
//            $.mytoast({text:"请选择充值方式"});
//            return;
//        }
            var btn=$(bt);
            btn.attr("disabled",true);
            $.ajax({
                type: "POST",
                url:pageRechargeUrl ,
                data:{
                    "partnerKey":$("#customerDat").val(),
                    "rechargeMoney":$("input[name='rechargeMoney']").val(),
                    "balanceMoney":$("input[name='balanceMoney']").val(),
                    "rechargeDate":new Date($("input[name='recpayDate']").val()),
                    "presentMoney":$("input[name='presentMoney']").val(),
                    "presentRate":"",
                    "isSms":$("#telSelMes").prop("checked")?"1":"0",//是否发送短信
                    "rechargeType":$(".recpayNameShow").text(),
                    "paymentName":$("input[name='paymentName']").val(),
                    "paymentTel":$("input[name='paymentTel']").val(),
                    "remarks":$("#remarks").val()
                },
                dataType: "json",
                success:function(callback){
                    if(callback.code =="1"){
                        window.location.reload();
                        $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                        prepaidFun.closeReceivablesBar();
                        btn.attr("disabled",false);
                    }else{
                        btn.attr("disabled",false);
                        $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(500).fadeOut(250).appendTo('body');
                        prepaidFun.closeReceivablesBar();
                    }
                },
                error:function(){
                    btn.attr("disabled",false);
                    $("<div class='tips_contants'>").fadeIn(250).html("添加失败").delay(500).fadeOut(250).appendTo('body');
                }
            })

        },

        closeReceivablesBar:function () {
            $(".recpayDiscount,.orderCycleCls").text("");
            $(".checkingNoCls").val("");
            $("input[name='recpayMoney']").val("");
            $("#remarks").val("");
            $("input[name='invoiceNo']").val("");
            $("input[name='invoiceContent']").val("");
            $("input[name='recipient']").val("");
            $("input[name='ceremarks']").val("");
            $("input[name='cecheckingNo']").val("");
            $("input[name='invoiceType']").val("");
            $("input[name='invoiceAmount']").val("")
            $("#receivablesBar,#taxPointWin").hide();
        },
        partnerInfoCall: function (row) {
            var qq = '', tel = '', partnerTel = "", contacterName = "";
            if (row.contacterName == "" || row.contacterName == null) {
                contacterName = "<span style='color:#ccc;'>未填写</span>"
            } else {
                contacterName = row.contacterName;
            }

            return "<div class='namebd'><span >" + row.partnerShortname + "</span><span class='namebdsml'>" + row.partnerName + "</span></div>" ;
//                "<div class='contactbd'><span class='contacthover'>" + contacterName + "</span>" + tel + qq + "</div>";

        },
        formatStatus: function (value) {
            return '<a href="##" onclick="funOpenUrl1(\''+value+'\')"  style="color: #4284d9;">点击查看</a>';
        },
        partnerAddress: function (value) {
            return '<a href="##" onclick="funOpenUrl(\''+value+'\')" style="color:#4284d9;">点击查看</a>';
        },

        returnopt: function (data, type) {
            var opt = "";
            for (var i = 0; i < data.length; i++) {
                var dt = data[i];
                var dtn = "";
                if (type == 1) {
//                    if(dt.partnerShortname==undefined){continue;}
//                dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                    if(dt.partnerKey!="ALL"){
                        opt += '<option title="' + dt.balanceMoney + '" did="' + dt.balanceMoney + '" value="' + dt.partnerKey + '">' + dt.partnerShortname + '</option>';
                    }

                }
                else if (type == 2) {
                    dtn = dt.show;
                    opt += '<option value="' + dt.key + '">' + dtn + '</option>';
                } else if (type == 3) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                    opt += '<li><a rel="' + dt.employeeId + '" href="javascript:;">' + dt.realName + '</a></li>';
                }
                else if (type == 4) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                    opt += '<li><a rel="' + dt.id + '" href="javascript:;">' + dt.text + '</a></li>';
                }

            }
            return opt;
        },
        closeTaxPoint: function () {
            $(".window-mask").hide();
            $("#deleteWin,#taxPointWin").css({display: 'none'});
        }
    }

    function showModPartner(partnerMod) {

        if (partnerMod["partnerKey"] == "temp-customer") {
            $("<div class='tips_contants'>").fadeIn(250).html("过路客不可修改").delay(3000).fadeOut(250).appendTo('body');
            return false;
        }
        //公司
        if (partnerMod["partnerAttr"] == "1") {
            url = "/system/partner/modPageCom?partnerKey=" + partnerMod["partnerKey"];
        } else {
            //个人
            url = "/system/partner/modPagePerson?partnerKey=" + partnerMod["partnerKey"];
        }
        var url;

        showMessageDialog(url, "", "84%", "100%", true);
    }

    function closeModPartner(type) {
        $(".window-mask").hide();
        $("#msgwindow").css({left: "100%"}).removeClass("activ");
        if (type == 0) {
            location.reload();
        }
    }
    function msg(content) {
        $("#msgwindow").html(content).addClass("activ");
    }
    function showMessageDialog(url, title, width, height, shadow) {
        var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
        $("#msgwindow").empty();
        $("#msgwindow").css({left: "16%"});
        $(".window-mask").hide();
        var last = Date.now();
        setTimeout(function () {
            // 监听动画完成时间
            if ($("#msgwindow").hasClass("activ")) {
                msg(content);
            } else {
                $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function () {
                    if (Date.now() - last < 3000) {
                        msg(content);
                    }
                }, false);
            }
        }, 0);
    }
    function showOverFlow(obj) {
//        partnerName  partnerAttr tel1  contacterName partnerKey
//        data-kid='+row.partnerKey+'data-pid='+row.tel1+' data-cid='+row.contacterName+' data-id='+row.partnerName+' data-did='+row.partnerAttr+';
        var partner = $(obj);
        var partnerAttr = partner.data("did");
        //1 公司
        if (partnerAttr == "1") {
            $("#inviteCom").html(partner.data("id"));
        } else {
            $("#inviteCom").html("个人伙伴");
        }
        $("#sendPhone").html(partner.data("pid"));
        $("#inviteName").html(partner.data("cid"));
        $("#partnerKeyPop").val(partner.data("kid"));
        $("#orderProcedure").css({display: 'block'});
//        $("#orderProcedure").addClass(" flipInY").removeClass("flipOutY");
        $(".window-mask").show();
//        flipInY flipOutY
    }
    function closeOverFlow() {
//        $("#orderProcedure").addClass(" flipOutY").removeClass("flipInY");//css({display:'none'});
        $("#orderProcedure").css({display: 'none'});//css({display:'none'});
        $("#sendPhone").val("");
        $("#partnerKeyPop").val("");
        $("#sendMsgBtn").prop("disabled", true);
        $(".window-mask").hide()
    }

    $(function () {
        $("#searchBtn").click(function () {
            reload("");
        })
//        datagrid-body
        $.ajax({
            type: "POST",
            url:pageSumListUrl ,
            dataType: "json",
            success:function(callback){
               $("#sumLi1").text("预存款余额："+accounting.formatNumber(callback.sumBalanceMoney,2));
               $("#sumLi2").text("充值总金额："+accounting.formatNumber(callback.sumRechargeMoney,2));
               $("#sumLi3").text("赠送总金额："+accounting.formatNumber(callback.sumPresentMoney,2));
               $("#sumLi4").text("消费总金额："+accounting.formatNumber(callback.sumConsumeMoney,2));
            },
            error:function(){
                $("#sumLi1").text("预存款余额：0.00");
                $("#sumLi2").text("充值总金额：0.00");
                $("#sumLi3").text("赠送总金额：0.00");
                $("#sumLi4").text("消费总金额：0.00");
            }
        })
    });


    function onLoadSuccess(data) {
        //     try{

        // }catch(e){

        //     $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        // }
        $("#order2PagerPrice").text(data.total)
        try {
            if (numGlobal == 0) {
                $("#message-num-circle0").text(data.nowTotal);
                $("#message-num-circle1").text(data.total);
                numGlobal++;
            }

            if (data.rows.length > 0) {
                $("[data-toggle='tooltip']").tooltip();

//                $("#regionCon").niceScroll({
                /*             $(".datagrid-body:last").niceScroll({
                 cursorcolor: "#aaa", // change cursor color in hex
                 cursorwidth:"12px",
                 autohidemode:"leave",
                 //                    hidecursordelay:9000,
                 cursorborderradius:"6px"



                 });*/
            } else {
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        } catch (e) {

//            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }

    }

    function GetQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)return unescape(r[2]);
        return null;
    }

    function reload() {

        $('#order').datagrid({
            url: pageListUrl,
            pagination: true,
            queryParams: {
                "isRecharge":"1",
                "searchKey": $('#searchKey').val()
            }
        });
//        $('#order').datagrid('loadData', JSON.parse(msg));
        /*      $('#order').datagrid({
         data: [
         {f1:'value21', f2:'value22'}
         ]
         });*/
        var pager = $("#order").datagrid('getPager');
        pager.pagination({
            layout: ['first', 'links', 'last'],
            showRefresh: false,
            displayMsg: ''
        });
        $(".pagination").show();
    }
    $(function () {
        reload();



        $('#recpayDate').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
            minView: 'month'
        });
        $('#recpayDate').val(new Date().Format("yyyy-MM-dd"));
        $(".recpayAccountList").html(prepaidFun.returnopt(globeConfigData.recpayAccountList, 4));
        $.ajax({
            url: pageListUrl+"?page=1&rows=1000",
            dataType: "json",
            timeout: "8000",
            success: function (data) {
                $("#customerDat").html(prepaidFun.returnopt(data, 1)).val("").trigger("change");
                $("#customerDat").select2({
                    templateResult: prepaidFun.formatState
                }).on("select2:select", function(evt) {
                    if (evt) {
                        $("input[name='balanceMoney']").val(evt.params.data.title);
                        $("input[name='balanceMoneyText']").val(accounting.formatNumber(evt.params.data.title,2));
                    }else{
                        $("input[name='balanceMoneyText']").val("");
                        $("input[name='balanceMoney']").val("");
                    }
                })
            }
        });
    });
</script>
</body>
</html>