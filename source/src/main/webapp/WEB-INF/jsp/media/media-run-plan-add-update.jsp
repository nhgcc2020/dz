<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>投放计划新建及修改页面</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=95d4665fda">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">
    <style>
        .dropdown-menu {
            min-width: 40px !important;
        }

        .btn-group.open .dropdown-toggle, .btn-group.currentVersion .dropdown-toggle {
            -webkit-box-shadow: none;
            border: 1px solid #4284d9;
            color: #4284d6;
        }

        .btn-group.currentVersion .dropdown-toggle .caret {
            border-top-color: #4284d9;
        }

        .datagrid-cell input {
            line-height: 35px;
            height: 35px;
        }

        .totalpriceChange,
        #priceText,
        #totalPriceText,
        #receivablesMoneyText {
            color: #ff2f02;
        }

        .contentTemplate {
            -webkit-user-select: none;
        }

        .autocomplete-suggestions {
            max-height: 270px !important;
        }

        .btnGrp {
            margin-top: 13px;
        }

        .datagrid-cell-c1-priceWayDesc:hover input {
            color: #4284d9;
        }

        .select2-container {
            margin-top: -3px;
        }

        .btnGrp button {
            margin-left: 6px;
        }

        .contentTemplate:hover {
            color: #4284d9 !important;
        }

        .datagrid-cell-c1-priceWayDesc input:before {
            background: #ffffcc !important;
            border-color: #ffcc00;
            box-shadow: 1px 1px 0px 0px #ffcc00;
            content: '';
            width: 0.75em;
            position: absolute;
            height: 0.75em;
            background: #FFFFFF;
            -webkit-transform: rotate(225deg);
            z-index: 2;
            left: 48%;
            top: 3px;
        }

        .datagrid-cell-c1-priceWayDesc {
            position: relative;
        }

        .datagrid-cell-c1-priceWayDesc input {
            text-align: center;
            cursor: pointer;
        }

        .datagrid-cell-c1-quantity input,
        .datagrid-cell-c1-unitPrice input,
        .datagrid-cell-c1-totalPrice input {
            text-align: left;
        }

        * {
            outline: none;
            outline-color: #fff;
        }

        .ui.segment.custom-table .ui.widget-table table td,
        .ui.segment.custom-table .ui.widget-table table th {
            position: relative;
        }

        .ui.calendar.mild .date-table-wrapper .date-table td.selected div.label {
            background: #2e8ae6
        }

        .ui.calendar.mild .date-table-wrapper .date-table > tbody > tr > td:first-child,
        .ui.calendar.mild .date-table-wrapper .date-table > tbody > tr > td:last-child {
            background: rgba(46, 138, 230, .1)
        }

        .ui.calendar.mild .date-table-wrapper .date-table td:hover:not(.selected) div.label {
            background: rgba(46, 138, 230, .5)
        }

        .ui.positive.button,
        .ui.positive.buttons .button {
            background-color: #2185D0 !important;
            background-image: none;
            color: #FFF;
            text-shadow: none
        }

        ul li label {
            display: inline-block;
            overflow: hidden;
            width: 250px;
            height: 22px;
            line-height: 22px
        }

        .ui.button {
            padding: 0 30px
        }

        .moneyInput input {
            height: initial !important;
            line-height: initial !important
        }

        .ui.input.error input {
            border-width: 1px !important;
            border-radius: 2px !important
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 50%;
            z-index: 9999;
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

        .ui.input input {
            padding: 0 10px !important
        }

        .add_tips {
            position: relative;
            padding: 10px 0 10px 26px;
            width: 100px;
            color: #999;
            font-size: 12px;
            cursor: pointer
        }

        .add_tips:hover,
        .add_tips:hover i {
            color: #2e8ae6
        }

        .add_tips i {
            position: absolute;
            top: 4px;
            left: 0;
            color: #999;
            font-size: 1.8rem
        }

        .secondary,
        .secondary i {
            color: #2e8ae6
        }

        .ui.list-view .items {
            max-width: 215px;
        }

        .ui.segment.custom-table .ui.widget-table table thead th {
            background-color: transparent;
        }

        #clientsDp,
        #planStatus,
        #saleManDp {
            margin: 0em;
            outline: none;
            -webkit-appearance: none;
            tap-highlight-color: rgba(255, 255, 255, 0);
            line-height: 30px;
            padding: 0em 1em;
            height: 30px;
            font-size: 1em;
            background: #FFFFFF;
            border: 1px solid rgba(34, 36, 38, 0.15);
            color: rgba(0, 0, 0, 0.87);
            border-radius: 0.28571429rem;
            box-shadow: 0em 0em 0em 0em transparent inset;
            -webkit-transition: color 0.1s ease, border-color 0.1s ease;
            transition: color 0.1s ease, border-color 0.1s ease;
        }

        #tableWrap .datagrid-row-selected {
            background: none !important;
        }

        .datagrid-cell-c1-businessDesc,
        .datagrid-cell-c1-requirements {
            padding: 0 20px 0 10px !important;
        }

        .topbarCss {
            display: none;
            position: absolute;
            top: 0px;
            left: 0px;
            background: rgb(255, 255, 255);
            min-height: 550px;
            border-bottom: 1px solid rgb(204, 204, 204);
            width: 100%;
            box-shadow: 0px 0px 20px rgba(34, 36, 38, 0.15);
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

        #createOrderPop {
            display: none;
            z-index: 99999;
            width: 660px;
            height: 480px;
            position: absolute;
            top: 50%;
            left: 50%;
            background: #fff;
            margin-top: -120px;
            margin-left: -330px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
        }

        .v-box,
        .h-box {
            display: -webkit-box;
        }

        .datagrid-body td:first-child,
        .datagrid-header td:first-child {
            border-left-width: 1px;
        }

        #file_div > div {
            padding-top: 4px;
        }

        .header {
            margin: 11px 0 36px -10px;
            font-size: 16px;
            color: #ff3333;
            height: 30px;
            line-height: 40px;
        }

        .header > img {
            margin-top: -10px;
            margin-right: 10px;
        }

        .col-xs-2 {
            margin-left: -8px;
        }

        .right-summary > .h-box {
            padding-left: 14px;
        }

        .col-xs-1 {
            color: #666 !important;
        }

        input::-webkit-input-placeholder,
        textarea::-webkit-input-placeholder {
            color: #ccc !important;
        }

        .cover {
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
            width: 930px;
            margin-top: -270px;
            left: 55%;
            margin-left: -550px;
            background: #fff;
        }

        .alart_img {
            width: 300px;
            height: 201px;
            position: absolute;
            top: 0;
            left: -80px;
        }

        .official {
            width: 68%;
            margin: 40px auto 40px;
            font-size: 15px;
        }

        .official li {
            margin: 35px 0;
        }

        .alart_last {
            width: 310px;
            height: 45px;
            margin: 0 auto !important;
            line-height: 45px;
            text-align: center;
            background: #ff3300;
            border-radius: 5px;
            color: #fff;
            cursor: pointer;
        }

        .callback {
            font-size: 45px;
            right: 0px;
            top: 2px;
            position: absolute;
            color: #a5a5a5;
            cursor: pointer;
        }
    </style>
    <style>
        .categoryDescEdit {
            position: relative;
            overflow: hidden;
            margin-right: 15px;
            cursor: pointer
        }

        .categoryDescEdit > span {
            position: absolute;
            top: 1px;
            right: 1px;
            display: none;
            cursor: pointer
        }

        .categoryDescEdit:hover > span {
            display: block
        }

        .ui.widget-table table tbody td > div {
            overflow: hidden;
            padding: .2em .4em
        }

        .ui.input input {
            padding: .5em .3em;
            text-align: left
        }

        .ui.widget-table table thead th {
            background: #fff
        }

        .ui.widget-table > .fixed-footer, .ui.widget-table > .fixed-header {
            z-index: 99
        }

        .closeMore {
            position: absolute;
            top: 0;
            right: 0;
            width: 20px;
            height: 20px;
            text-indent: 0;
            cursor: pointer
        }

        .closeMore:after, .closeMore:before {
            position: absolute;
            top: 50%;
            width: 20px;
            height: 1px;
            background-color: #888;
            content: '';
            -webkit-transform: rotate(45deg);
            transform: rotate(45deg)
        }

        .closeMore:after {
            -webkit-transform: rotate(-45deg);
            transform: rotate(-45deg)
        }

        #learnMore .closeMore:hover {
            -webkit-transform: rotate(90deg)
        }

        .partner_tips_2:before {
            position: relative
        }

        .checkbox, .radio {
            margin: 0
        }

        .items tr td:nth-child(2) input {
            text-align: left
        }

        .items tr td:nth-child(3) input, .items tr td:nth-child(4) input {
            border: none
        }

        .items tr:nth-child(even) td:nth-child(3) input, .items tr:nth-child(even) td:nth-child(4) input {
            background: #f5f7fa
        }

        .ui.list-view .items {
            height: 260px
        }

        .ui.list-view .list.item:hover {
            background: #4284d9;
            color: #fff
        }

        .btn {
            font-size: 9pt
        }

        .btn-default {
            color: #999
        }

        .ui.items-view table tbody tr:nth-child(even) {
            background: 0 0 !important
        }

        .ui.items-view .item {
            cursor: default
        }

        #order .table-wrapper > table thead th:nth-child(1), #order .table-wrapper > table thead th:nth-child(2), #order .table-wrapper > table thead th:nth-child(11), #order .table-wrapper > table thead th:nth-child(12) {
            font-weight: 700
        }

        .pagination table {
            float: right;
            height: 50px;
            line-height: 50px
        }

        .pagination {
            border-radius: 0
        }

        .datagrid .datagrid-pager {
            border-color: #2e8ae6;
            border-top-width: 2px
        }

        .datagrid-header td.datagrid-header-over, .datagrid-row-over {
            background: none;
            color: #000;
            cursor: default
        }

        .datagrid-header, .datagrid-td-rownumber {
            background: #eff1f3
        }

        .datagrid-header {
            border-width: 0
        }

        .datagrid-header .datagrid-cell span {
            font-size: 12px
        }

        .btn-primary, .btn-primary.active, .btn-primary:active, .btn-primary:focus, .btn-primary:hover, .open .dropdown-toggle.btn-primary {
            border-color: #2e8ae6;
            background-color: #2e8ae6
        }

        .datagrid-row-selected {
            background: #d6e8f3;
            color: #000
        }

        .datagrid .panel-body, .window .window-body {
            border: none !important
        }

        .window .window-body {
            padding: 50px 10px 0;
            border-width: 0 !important;
            border-radius: 0;
            background: #fff
        }

        .datagrid-header, .datagrid-header-row, .datagrid-row {
            height: 40px
        }

        .window-shadow {
            background: 0 0
        }

        table, td, th {
            vertical-align: middle
        }

        #taxPointWin {
            width: 700px
        }

        #modifyMenuWin, #taxPointWin, .priceDetailWin {
            position: absolute;
            z-index: 99;
            display: none;
            min-height: 290px;
            border: none;
            background: #fff;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, .2);
            -webkit-transition: all .2s 0s linear;
            transition: all .2s 0s linear
        }

        .h10 {
            clear: both;
            height: 10px
        }

        select option {
            margin: 5px auto;
            height: 30px;
            line-height: 30px
        }

        .btn.smcolor {
            border-color: #2e8ae6;
            background-color: #2e8ae6;
            color: #fff
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
            height: 5pc;
            border-radius: 5px;
            background: rgba(0, 0, 0, .8);
            color: #fff;
            text-align: center;
            line-height: 5pc
        }

        .pagination {
            display: none
        }

        .select2-results__options li {
            position: relative
        }

        .datagrid-body .datagrid-cell {
            padding: 0 10px
        }

        .datagrid-htable .datagrid-cell {
            padding-left: 10px
        }

        .datagrid-header .datagrid-cell span {
            color: #666
        }

        .form-control {
            display: block;
            padding: 6px 10px 6px 9pt;
            width: 100%;
            height: 30px;
            background-color: #fff;
            color: #555;
            vertical-align: middle;
            line-height: 1.428571429
        }

        .form-control, .input-group-addon {
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 12px
        }

        .input-group-addon {
            padding: 5px 9pt;
            background-color: transparent !important;
            text-align: center;
            font-weight: 400;
            line-height: 1
        }

        .panel {
            box-shadow: 0 0 0
        }
    </style>
    <style>
        #modifyYdzMenuWin {
            z-index: 12;
        }

        #msgwindow {
            z-index: 9999;
            height: 0;
            left: 0;
            border: none;
            top: -70px;
            width: 100%;
            box-shadow: 0px 0px 7px #999;
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
        }

        #autoEditOnceWin {
            z-index: 11;
        }

        #deleteYdzWin {
            z-index: 13;
        }

        #versionControlWin {
            z-index: 14;
        }

        #autoEditOnceWin, #modifyYdzMenuWin, #deleteYdzWin, #versionControlWin {
            border: none;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }

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

        .ydz_select2 {
            cursor: default !important;
            background-color: #fff !important;
        }

        .ydz_select2 ~ .ydz_select_a {
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-top: 5px solid #786f6f;
            position: absolute;
            right: 21px;
            top: 50%;
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
            overflow-x: hidden;
            overflow-y: auto;

            position: absolute;
            width: 170px;
            z-index: 1000;
        }

        .ydz_select_menu li {
            line-height: 21px;
            padding-bottom: 0 !important
        }

        .ydz_select_menu_ul2 li {
            letter-spacing: 2px;
            position: relative;
            cursor: pointer;
            padding-right: 55px;
            padding-left: 10px;
            /*border-bottom: 1px solid #eaeaea;*/
            overflow: hidden;
            color: #333;
            line-height: 27px;
            -ms-text-overflow: ellipsis;
            white-space: nowrap;
            text-overflow: ellipsis;
            font-size: 14px;
        }

        .open .ydz_select_menu {
            display: block
        }

        .ydz_select_menu_ul {
            max-height: 140px;
            overflow: auto;
        }

        .ydz_select_menu_ul2 {
            height: 265px;
            overflow: auto;
        }

        .autoEdit {
            text-align: center;
            height: 30px;
            clear: both;
            border-top: 1px solid #ccc;
            cursor: pointer;
            line-height: 30px;
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

        .requireYdzMenu {
            color: #da4654;
        }

        .ydz_select_menu_ul2 li a {
            clear: both;
            text-align: left;
            color: #323232;
            display: block;
            font-size: 12px;
            line-height: 27px;
            white-space: nowrap
        }

        .ydz_select_menu li a:hover {
            background: none repeat scroll 0 0 #5897fb;
            color: #FFF;
            text-decoration: none
        }

        .ydz_select_menu_ul2 li:hover {
            background: none repeat scroll 0 0 #eff1f3;
            color: #333;
            text-decoration: none
        }

        .ydz_select_menu_ul2 > li > span {
            color: #8cb5e5;
            font-size: 12px;
            position: absolute;
            right: 3px;
            top: 0;
            visibility: hidden;
        }

        .ydz_select_menu_ul2 > li.active {
            background: #eff1f3;
        }

        .ydz_select_menu_ul2 > li:hover > span {
            visibility: visible;
            cursor: pointer;
        }

        .main .fixheader {
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
            z-index: 10;
            overflow: hidden;
        }

        .main {
            height: 100%;
        }

        .main {
            /*margin-top: 70px;*/
        }

        .control-label-mark:before {
            content: '*';
            color: red;
            margin-right: 5px;
            font-size: 12px;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/easyui/pace.min.js?v=fe5e2eaca6"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=df96034f1e"></script>
    <script src="/resources/business/base_new.js?v=1191ae2bcdf"></script>

</head>

<body class="modal-page" style="padding:0!important;">
<div
        style="    padding: 70px 50px 0 50px;" class="main"
>


    <div class="fixheader">
        <button type="button" onclick="saveAll(this)" class="btn btn-primary copyMain "
                style="width:90px;margin:4px 8px 10px 0px">保存
        </button>
        <button type="button" onclick="forwardMainOpp()" class="btn  cancelOpp"
                style="font-size:14px;height:30px;margin:5px 8px 10px 20px;background:#fff;color:#7e92ab;padding:0;">
            <i class="iconfont_new " style="font-size:26px;position:relative;top:4px;"></i>取消
        </button>
    </div>

    <div class="row" style="margin-bottom: 20px;line-height: 30px;">

        <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-bottom: 40px;
    /*margin-left: -25px;*/
    margin-top: 20px;
    font-weight: 700;">新建投放计划</h1>

        <label style="padding-right:0;width:90px;" class="col-xs-1 control-label control-label-mark">广告名称 :</label>
        <div class="col-xs-3 ">
            <input id="adName" class="form-control" style="" type="text" placeholder="请填写">
            <input value="" id="planNo" type="hidden">
        </div>

        <label style="padding-right:0;width:90px;" class="col-xs-1 control-label control-label-mark">客户 :</label>
        <div class="col-xs-3" style="width:200px;padding:0 5px 0 0">
            <%--<input type="text" class="form-control" placeholder="选择客户">--%>
            <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
            </select>
        </div>


        <label style="padding-right:0;width:90px;" class="col-xs-1 control-label control-label-mark">档期状态 :</label>
        <div class="col-xs-3 " style="width:130px;padding:0 5px ">
            <select class="form-control input-xs" id="planStatus">
            </select>
        </div>

    </div>

    <div style="margin-top: 11px" id="tableWrap">
        <table id="createOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [arrclo_addList],

          onLoadSuccess:onLoadS" class="easyui-datagrid" style="width:100%;height:auto;">
            <thead>


            </thead>
            <tbody>

            </tbody>

        </table>
    </div>

</div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:1;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<div id="msgwindow" style="padding-top:60px;border:none;"></div>
<div id="autoEditOnceWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
    margin-top:-175px;
    margin-left:-150px;
    width: 300px;
    height: 350px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">
        编辑自定义分类 </p>

    <span class="autoEditWinClose"
          style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"><img
            src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">

        <ul class="ydz_select_menu_ul2">

            <li><a rel="现金" href="javascript:;">现金</a><span csid="d">删除</span><span csid="m"
                                                                                    style="right: 36px;">修改</span></li>
            <li><a rel="现金" href="javascript:;">现金</a><span>删除</span><span style="right: 36px;">修改</span></li>
            <li><a rel="现金" href="javascript:;">现金</a><span>删除</span><span style="right: 36px;">修改</span></li>

        </ul>
        <div class="autoEdit autoEditTwice">添加自定义分类</div>

    </div>
</div>
<div id="modifyYdzMenuWin"
     style="      padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
        margin-top:-176px;
    margin-left:-150px;
    width: 300px;
    height: 250px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="menuTitle">修改自定义分类</p>
    <span class="autoEditWinClose2"
          style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"><img
            src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style="    margin-top: 50px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group">
                <label style="    padding-right: 0;
    text-align: left;" class="col-sm-4 control-label">自定义分类:</label>
                <div class="col-sm-7 " style="
    padding: 0;
    margin-bottom: 10px;
    text-align: right;">
                    <input type="text" class="form-control" maxlength="40" id="menu1" placeholder="请输入分类名称"/>
                </div>
            </div>
            <div style="clear: both;" class="col-sm-12 hide requireYdzMenu">类型不能为空</div>
        </div>
        <div style="clear: both; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default autoEditWinClose2" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:14px;width:92px;font-size:12px;"
                    id="saveYdzMenu">保存
            </button>
        </div>
    </div>
</div>
<div id="deleteYdzWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
         margin-top:-176px;
    margin-left:-150px;
    width: 300px;
    height: 206px;">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 18px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;">
        删除自定义分类</p>
    <span class="closetranform" style="    position: absolute;
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
    font-size: 22px;
    font-weight: normal;
    color: #44ae80;
    height: 30px;
    line-height: 30px;">确定要删除吗？</span>
        <div style="clear: both;margin-top:45px;">
            <button type="button" class="btn  btn-default closetranform" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    id="deleteYdzMenu">确认
            </button>
        </div>
    </div>
</div>
<div id="versionControlWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: absolute;
         margin-top:-176px;
    margin-left:-150px;
    width: 300px;
    height: 206px;">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 18px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;">提示</p>
    <span class="closetranform" style="    position: absolute;
    top: 14px;
    right: 1px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
    margin: 40px auto;">
        <span class="customerjc" style="    position: relative;
    text-align: center;
    margin: 0 auto;
    font-size: 20px;
    font-weight: normal;
    color: #44ae80;
    height: 30px;
    line-height: 30px;"></span>
        <div style="clear: both;margin-top:45px;">
            <button type="button" class="btn  btn-default versionControlCancel" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    id="versionControlBtn">确认
            </button>
        </div>
    </div>
</div>
<div class="ydz_select_menu">
    <ul class="ydz_select_menu_ul recpayAccountList">
        <li><a rel="现金" href="javascript:;">现金</a></li>
    </ul>
    <div class="autoEdit autoEditOnce">编辑自定义分类</div>
</div>
<script id="tpl-print" type="text/html">
    {{each orders as item i}}
    <div id="{{item.quotationNo}}" class="btn-group  {{item.isDefault=='1'?'currentVersion':''}}">
        <button type="button" class="btn btn-default dropdown-toggle"
                data-toggle="dropdown"><span class=" {{item.isDefault=='1'?'':'hide'}} iconfont_new" style="       font-size: 24px;
    color: #4e8ae6;
    position: absolute;
    right: -4px;
    top: -8px;">&#xe720;</span>
            {{item.versionName}}<span class="caret"></span>
        </button>
        <ul class="dropdown-menu" role="menu">
            <li><a cid="{{item.quotationNo}}" href="javascript:void(0)"
                   class="changeVersionFun {{item.isDefault=='1'?'curVersion':''}}">切换版本</a></li>
            <li><a cid="{{item.quotationNo}}" href="javascript:void(0)" class="defaultFun">设为默认</a></li>
            <li><a cid="{{item.quotationNo}}" class="delVersionFun" href="javascript:void(this)">删除</a></li>
        </ul>
    </div>
    {{/each}}
    <div class="btn-group">
        <button type="button" id="print" class="btn dropdown-toggle addVersionFun" style=""> 新增版本
        </button>
    </div>
</script>
<script>

    (function (window, $, undefined) {
        var globVar = {};
        var planNo = '${planNo}';// 商机号
//        planNo = '6592955198';// 商机号
        var globDataGrid =
            [{
                "days": 0, //投放天数
                "endDate": "", //结束日期
//            "itemNo": 0, //序号
                "pointCode": "222", //点位编码
                "pointName": "", //点位名称
                "pointNo": "9325581825", //点位ID
                "remarks": "", //备注
                "startDate": "" //开始日期
            }
            ];
        var objSelMenu;// 临时保存页面共享下拉框的对象
        var oppProjectType = [];
        //是否确认现金订单
        window.arrclo_addList = cloList();
        window.saveAll = function (self, fun) {

            if ($("#adName").val() == "") {
                $.mytoast({text: "请填写广告名称"});
                return;
            } else if ($("#customerDat").val() == "ALL") {
                $.mytoast({text: "请选择客户"});
                return;
            } else if ($("#planStatus").val() == "") {
                $.mytoast({text: "请选择档期状态"});
                return;
            }
            saveOrder(self, "", "dd", fun);
        }
        window.saveDraft = function (self) {
//        window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
        }
        window.onLoadS = function () {
            initDat();
        }
        window.openProReq = function (o) {
            //没有主键 上述方法会有问题
            globVar.con = $(o).parents("tr").index();
            glContractFun();
        }
        window.hideMsg = function () {
            $(".window-mask").hide();
            $("#msgwindow").css({height: "0"}).removeClass("activ");
        }
        window.relateOpp = function (ids) {
            var arr = [];
            ids.forEach(function (item, value) {
                arr.push(item.pointNo);
            })
            testHard2(ids);
            hideMsg();
        }
        window.addRow = function (o) {
            var rindex = $(o).parents("tr").index() + 1;
            $('#createOrder').datagrid('insertRow', {
                index: rindex, row: {
                    "pointCode": "", //点位编码
                    "pointName": "", //点位名称
                    "pointNo": "", //点位ID
                    "days": 0, //投放天数
                    "endDate": "", //结束日期
//                "itemNo": 0, //序号
                    "remarks": "", //备注
                    "startDate": "" //开始日期

                }
            });
            onLoadS();
        }
        window.delRow = function (o) {
            var rindex = $(o).parents("tr").index();
            if ($('#createOrder').datagrid("getRows").length > 1) {
                $('#createOrder').datagrid('deleteRow', rindex);
            }


        }
        window.copyRow = function (o) {
            var i = $(o).parents("tr").index();
            var rows = $('#createOrder').datagrid("getRows");
            var row = {};


            row.pointName = $("input.inputTemplatepointName")[i].value;
            row.pointCode = $($("input.inputTemplatepointName")[i]).attr("cid");
            row.pointNo = $($("input.inputTemplatepointName")[i]).attr("nid");


            row.days = $("input.inputTemplatedays")[i].value;
            row.endDate = $("input.inputTemplateEnd")[i].value;
            row.remarks = $("input.inputTemplateRemarks")[i].value;
            row.startDate = $("input.inputTemplateStart")[i].value;

            $('#createOrder').datagrid('insertRow', {
                index: i + 1,	// index start with 0
                row: row
            });
            onLoadS();
        }
        function cloList() {
            var arrclo_addList = [];
            arrclo_addList.push({
                field: 'pointName',
                title: '投放点位',
                width: 150,
                formatter: function (value, row, index) {
                    return inputTemplatepointName(value, index, row)
                }
            });
            arrclo_addList.push({
                field: 'startDate',
                title: '投放开始日期',
                width: 150,
                formatter: function (value, row, index) {
                    return inputTemplateStart(value, index, row)
                }
            });
            arrclo_addList.push({
                field: 'endDate',
                title: '投放结束日期',
                width: 150,
                formatter: function (value, row, index) {
                    return inputTemplateEnd(value, index, row)
                }
            });
            arrclo_addList.push({
                field: 'days', title: '投放天数', width: 150, formatter: function (value, row, index) {
                    return inputTemplatedays(value, index, row)
                }
            });

            arrclo_addList.push({
                field: 'remarks', title: '备注', width: 50, formatter: function (value, row, index) {
                    return inputTemplateRemarks(value, index, row, 'remarks')
                }
            });
                arrclo_addList.push({
                    field: 'btn',
                    title: '操作',
                    width: 40,
                    formatter: function (value, row, index) {
                        return '<i class="iconfont_new contentTemplate" title="增加" onclick="addRow(this)">&#xe6a1;</i>&nbsp;<i title="复制" class="iconfont_new contentTemplate" onclick="copyRow(this)" >&#xe69d;</i>&nbsp;<i title="删除" class="iconfont_new contentTemplate" onclick="delRow(this)" >&#xe6f2;</i>';
                    }
                });
            return arrclo_addList;
        }


        var initSelData = function (obj) {


            $.ajax({
                url: "/system/partner/dropdownPartner?partnerType=1",
                dataType: "json",
                success: function (data) {
                    var returnopt = function (data) {
                        var opt = "";
                        for (var i = 0; i < data.length; i++) {
                            var dt = data[i];
                            var dtn = "";
                            dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                            opt += '<option data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
                        }
                        return opt;
                    }
                    var formatState = function (state) {
                        var p = $(state.element).attr("data-p");
                        var mark = "";
                        var css = "  font-style:normal;font-size: 8px !important;background: #e9dfdf;color: #b89a9a;border-radius: 3px;height: 20px;margin-left: 10px;line-height: 20px;padding: 0 2px;position: absolute;right: 3px;top: 5px;";
                        var cs = "   position: absolute;right: 4px;top: 8px;border: 6px solid #f2711c;width: 0;height: 0;border-radius: 50%;";
                        if (p == undefined || p == "" || p == null) {
                            mark = '';
                        } else if (p == "1") {
                            mark = '<i  class="tips_sale" >好友</i>';
                        }
                        var $state = $(
                            '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:160px;display: block;">' + state.text + '</span>' + mark

//                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
                        );
                        return $state;
                    }


                    if (obj) {
                        var cstval = obj.order.partnerKey;
                        $("#customerDat").html(returnopt(data)).val(cstval);
                    } else {
                        $("#customerDat").html(returnopt(data))
                    }

                    $("#customerDat").select2({
//                        maximumInputLength:2,
                        templateResult: formatState
                    });
                }
            })
            var rto2 = function () {
                var dtn = '<option value="">排期状态</option>'
                    + '<option value="1L">锁定</option>'
                    + '<option value="2S">售出</option>';
                return dtn;
            }
            if (obj) {
                var platval = obj.order.planStatus;
                $("#planStatus").html(rto2()).val(platval).select2({minimumResultsForSearch: Infinity});
            } else {
                $("#planStatus").html(rto2()).select2({minimumResultsForSearch: Infinity});
            }


        }
        window.datedifference = function (sDate1, sDate2) {
            var dateSpan,
                iDays;
            sDate1 = Date.parse(sDate1);
            sDate2 = Date.parse(sDate2);
            dateSpan = sDate2 - sDate1;
            dateSpan = Math.abs(dateSpan);
            iDays = Math.floor(dateSpan / (24 * 3600 * 1000));
            if (isNaN(Number(iDays))) {
                return 0
            }
            return Number(iDays) + 1
        }
        function initDat() {
            $('.datetimepickers').datetimepicker({
                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true, bootcssVer: 3,
                minView: 'month'
            }).on("click", function (ev) {
                var rindex = $(ev.target).parents("tr").index();
                var endtime = $("input.datetimepickere")[rindex].value;
                $(".datetimepickers").datetimepicker("setEndDate", endtime)
            }).on('changeDate', function (ev) {
                event.preventDefault();
                event.stopPropagation();
                var rindex = $(ev.target).parents("tr").index();
                var starttime = $(ev.target).val();
                var endtime = $("input.datetimepickere")[rindex].value;
                var valtime = 0;
                if (!endtime || endtime == "" || endtime === null) {
                    valtime = 0;
                } else {
                    valtime = datedifference(starttime, endtime)
                }
                $("input.inputTemplatedays")[rindex].value = valtime;
            });
            $('.datetimepickere').datetimepicker({
                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true, bootcssVer: 3,
                minView: 'month'
            }).on("click", function (ev) {
                var rindex = $(ev.target).parents("tr").index();
                var endtime = $("input.datetimepickers")[rindex].value;
                $(".datetimepickere").datetimepicker("setStartDate", endtime)
            }).on('changeDate', function (ev) {
                event.preventDefault();
                event.stopPropagation();
                var rindex = $(ev.target).parents("tr").index();
                var starttime = $(ev.target).val();
                var endtime = $("input.datetimepickers")[rindex].value;
                var valtime = 0;
                if (!endtime || endtime == "" || endtime === null) {
                    valtime = 0;
                } else {
                    valtime = datedifference(starttime, endtime)
                }
                $("input.inputTemplatedays")[rindex].value = valtime;
            });
        }

        function initPageTwoData(d) {
            var salesOrderDetail = d.details;
            $("#createOrder").datagrid("loadData", salesOrderDetail);
            var fun = function () {
                $("#adName").val(d.order.adName);
                $("#planNo").val(d.order.planNo);
                onLoadS();
            }
            fun();

        }

        var initFunPage = function () {
            if (planNo == null || planNo == "") {  //新建
                $("#createOrder").datagrid("loadData", globDataGrid);
                var fun = function () {
                    $("#adName").val("");
                    $("#versionDate").val(new Date().Format("yyyy-MM-dd"));
                    $("#remarkInput").val("");
                    $("#depositRequested").val("");
                    $("#preferentialVal").val("");
                    $("#salesCount").val("");
                    onLoadS();
                }
                fun();
                initSelData();
            }
            else {
                $.ajax({
                    url: "/ydz/mediaresource/getMediaRunPlansAndDetail?planNo=" + planNo,
                    type: 'GET',
                    dataType: "json",
                    success: function (dt) {
                        if (dt.code == "1") {
                            initPageTwoData(dt);
                            initSelData(dt);

                        }
                    }
                });
            }

        }
        // 页面入口处
        var initFunPageMain = function () {
            initFunPage();
        }
        $(function () {

//        var date = JSON.parse(data);
            initFunPageMain();
        })


        window.forwardMainOpp = function () {
            window.location.href = "/openPage?pageName=media_media-run-plan-list";
        }
        function readyData() {
            var rows = $('#createOrder').datagrid("getRows");
            console.log(rows);
            var rowArr = [];
            for (var i = 0; i < rows.length; i++) {
                var rowT = {};
                rowT.pointName = $("input.inputTemplatepointName")[i].value;
                rowT.pointCode = $($("input.inputTemplatepointName")[i]).attr("cid");
                rowT.pointNo = $($("input.inputTemplatepointName")[i]).attr("nid");
                rowT.days = $("input.inputTemplatedays")[i].value;
                rowT.endDate = $("input.inputTemplateEnd")[i].value;
                rowT.remarks = $("input.inputTemplateRemarks")[i].value;
                rowT.startDate = $("input.inputTemplateStart")[i].value;
                rowArr.push(rowT);
            }
            var saveData = {};
            saveData.details = rowArr;
            var quotNo = "";
            var order =
                {
                    "adName": $("#adName").val(),  //广告名称
//                "endDate": null, //结束日期
                "partnerKey": $("#customerDat").val(), //客户编码
//                "partnerName": "", //客户名称
//                "partnerShortname": "", //客户简称
                "planNo": $("#planNo").val(), //投放计划单号
                "planStatus": $("#planStatus").val(), //档期状态 1L锁定 2S售出
//                "pointNum": 0, //点位数量
//                "remarks": "", //备注
//                "startDate": null //开始日期
            }
            saveData.mediaRunPlan = order;
            return saveData;
        }



        function inputTemplatedays(v, i, f) {
            return '<input readonly class="inputTemplatedays"  style="width: 100%;" value="' + v + '" type="text">'
        }

        function inputTemplatepointName(v, i, row) {
            var j = 0;
            var arr = [""];
            return '<div onclick="openProReq(this)"><input type="hidden" value="" class="autocomplete_workingProcedure" /><input readonly class="inputTemplatepointName" nid="' + row.pointNo + '" cid="' + row.pointCode + '"  style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new contentTemplate" onclick="openProReq(this)" style="font-size: 14px;color:#ccc">&#xe6eb;</i></div>'
        }

        function saveOrder(o, url, tp, fun) {
            var self = $(o);
            self.attr("disabled", true);
            var urlt = "", type = "";
            if (planNo == null || planNo == "") {
                urlt = "/ydz/mediaresource/insertNewMediaRunPlan";
                type = "post";

            } else {
                urlt = "/ydz/mediaresource/updateMediaRunPlan";
                type = "PUT";
            }
            $.ajax({
                url: urlt,
                type: type,
                data: JSON.stringify(readyData()),
//            dataType: "json",
                contentType: "application/json",
                success: function (callBack) {
                    if (callBack.code == '1') {
                        $.mytoast({text: callBack.msg});
                        self.attr("disabled", false);
                        setTimeout(function () {
                            if (typeof fun == "function") {
                                fun();
//                        initFunPageMain();
                            } else {
                                forwardMainOpp();
                            }
                        }, 1000);
                    } else {
                        $.mytoast({text: callBack.msg});
                        self.attr("disabled", false);
                    }
                }, error: function () {
                    $.mytoast({text: "添加出错,请联系管理员"});
                    self.attr("disabled", false);
                }
            });
        }

        function showMessageDialog(url, title, width, height, shadow) {
            var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
            $("#msgwindow").empty();
            $("#msgwindow").css({height: "550px"});
            $(".window-mask").hide();
            msg(content);
        }

        function msg(content) {
            $("#msgwindow").html(content).addClass("activ");
        }

        function testHard2(currentItem) {
            if (currentItem == null) {
                return;
            }
            var total = $('#createOrder').datagrid('getRows').length;
            var ttNum = Number(currentItem.length) + Number(globVar.con);
            var gNum = 0;
            var forNum = 0;
            if (ttNum > total) {
                forNum = total;
            } else {
                forNum = ttNum
            }
            ;
            for (var i = globVar.con; i < forNum; i++, gNum++) {
                // $('#createOrder').datagrid('updateRow',{index:rowIndex,row:{requirements:currentItem.categoryDesc}});
                var cur = currentItem[gNum];
//
                $("input.inputTemplatepointName")[i].value = cur.pointName;
                $($("input.inputTemplatepointName")[i]).attr("cid", cur.pointCode);
                $($("input.inputTemplatepointName")[i]).attr("nid", cur.pointNo);
            }
            if (ttNum > total) {
                for (var j = total; j < ttNum; j++, gNum++) {
                    var cur = currentItem[gNum];


                    $('#createOrder').datagrid('insertRow', {
                        index: j, row: {
                            "pointCode": cur.pointCode, //点位编码
                            "pointName": cur.pointName, //点位名称
                            "pointNo": cur.pointNo, //点位ID
                            "days": 0, //投放天数
                            "endDate": "", //结束日期
//                        "itemNo": 0, //序号
                            "remarks": "", //备注
                            "startDate": "" //开始日期

                        }
                    });
                    $("input.inputTemplatepointName")[j].value = cur.pointName;
                    $($("input.inputTemplatepointName")[j]).attr("cid", cur.pointCode);
                    $($("input.inputTemplatepointName")[j]).attr("nid", cur.pointNo);
                }
            }

            $(".window-mask").hide();
            $("#topBarPR").hide();
            onLoadS();
        }

        function glContractFun() {
            var url = "/openPage?pageName=media_media-point-list-simple";
            showMessageDialog(url, "", "84%", "100%", true);
        }

        function inputTemplateRemarks(v, i, row, f) {
            return '<input placeholder="" class="inputTemplateRemarks"    style="width: 100%;" value="' + v + '" type="text">'
        }

        function inputTemplateStart(v, i, f) {
            v = v === null ? "" : v;
            return '<input readonly class="datetimepickers inputTemplateStart "  style="width: 100%;" value="' + v + '" type="text">'
        }

        function inputTemplateEnd(v, i, f) {
            v = v === null ? "" : v;
            return '<input readonly class="datetimepickere inputTemplateEnd " style="width: 100%;" value="' + v + '" type="text">'
        }


    })(window, jQuery);


</script>

</body>

</html>