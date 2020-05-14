<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>报价单新建及修改</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=3e10f9c6f9">
    <link rel="stylesheet" type="text/css" href="/resources/common/custom-widget.css?v=317bd77da5">
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
        #contacterDp,
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

        #msgwindow {
            position: absolute;
            left: 100%;
            z-index: 9999;
            padding: 2%;
            width: 84%;
            height: 100%;
            border: none;
            background: #fff;
            box-shadow: 0 0 7px #999;
            -webkit-transition: all .2s 0s linear;
            transition: all .2s 0s linear
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
            z-index: 3;
        }

        #autoEditOnceWin {
            z-index: 2;
        }

        #deleteYdzWin {
            z-index: 4;
        }

        #versionControlWin {
            z-index: 5;
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

<div style="padding: 1em 42px !important;">
    <div class="header" id="header">
    </div>
    <div class="window-mask"
         style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:1;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
    <div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

    <div class="row" style="margin-bottom: 20px;line-height: 30px;">
        <label style="padding-right:0;width:70px;" class="col-xs-1 control-label">版本名称 :</label>
        <div class="col-xs-3 ">
            <input maxlength="15" id="caseDesc" class="form-control" style="border-color: #d7d7d7;" type="text"
                   placeholder="内容简述">
        </div>
        <label style="padding-right:0;width:70px;" class="col-xs-1 control-label">报价日期 :</label>
        <div class="col-xs-3" style="">
            <input type="text" style="" data-provide="datetimepicker-inline" name="versionDate" data-format="yyyy-MM-dd"
                   class="form-control"
                   id="versionDate">
            <i onclick="$('#versionDate').datetimepicker('show')" class="iconfont_new" style="    font-size: 18px;
    top: 1px;
    position: absolute;
    right: 20px;">&#xe6a6;</i>
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
    <div id="bottomBox">
        <div class="h-box" style="height:204px;">
            <div class="flex-box">
                <div class="v-box">
                    <div class="flex-box">
                        <div class="remark-container">
                            <div id="remarkBtn" class="add_tips" onclick="showRemark(this)"><i class="iconfont_new">
                                &#xe6ca;</i>添加备注
                            </div>
                            <textarea placeholder="备注……" id="remarkInput" class="form-control"
                                      style="resize:none;max-width:669px;height: 60px;display:none;border-color:#d7d7d7;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box right-summary" style="width:300px;">
                <div class="h-box">
                    <div class="box">合&#x3000;计</div>
                    <div class="flex-box">
                        <div>
                            <div name="sales" class="sales-btn font-btn active">折</div>
                            <div name="earnest" class="earnest-btn font-btn active">税</div>
                            <div name="minus" class="minus-btn font-btn active">减</div>
                        </div>
                    </div>
                    <div class="box price">
                        <span id="priceText">0.00</span>
                        <input type="hidden" id="priceTextVal" value="0">
                    </div>
                </div>
                <div class="h-box sales-box">
                    <div class="box">折&#x3000;扣</div>
                    <div class="flex-box">
                        <div>

                            <div class="moneyInput ui input icon" style="width: 80px;"><input id="salesCount"
                                                                                              maxlength="4" value="0"
                                                                                              onkeyup="priceCountTwo()"
                                                                                              type="text">
                                <i class="percent icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="box price">-<span id="discountText">0.00</span>
                        <input type="hidden" id="discountVal" value="0">
                    </div>
                </div>
                <div class="h-box earnest-box">
                    <div class="box">税&#x3000;点</div>
                    <div class="flex-box">


                        <div class="moneyInput ui input icon" style="width: 80px;">
                            <input onkeyup="priceCountTwo()" value="0" id="depositRequested" type="text"><i
                                class="percent icon"></i></div>
                    </div>
                    <div class="box price"><span id="depositRequestedText">0.00</span></div>
                </div>
                <div style="height:30px;" class="h-box minus-box">
                    <div class="box">减&#x3000;免</div>
                    <div class="flex-box">
                        <div>

                            <div class="moneyInput ui input" style="width: 80px;"><input id="preferentialVal" value="0"
                                                                                         onkeyup="priceCountTwo()"
                                                                                         type="text"></div>
                        </div>
                    </div>
                    <div class="box price">
                        -<span id="preferentialText">0.00</span>

                    </div>
                </div>
                <div class="h-box">
                    <div class="box">总金额</div>
                    <div class="flex-box"></div>
                    <div class="box price">
                        <span id="totalPriceText">0.00</span>
                        <input type="hidden" id="totalPriceVal" value="0">
                    </div>
                </div>
                <div class="ui divider" style="border-color:#f2f2f2;border-bottom:none;"></div>


            </div>
        </div>
        <div class="ui divider" style="border-color:#e4e4e4;"></div>
        <div class="h-box actions">
            <div class="flex-box"></div>
            <div class="box">
                <div class="btnGrp ui segment basic">


                    <button type="button" dat="0" style="width: 104px;border-color:#d7d7d7;color:#999;"
                            onclick="saveDraft(this)" class="btn btn-info">取消
                    </button>
                    <button type="button" dat="0" style="width: 100px" userdata="1" onclick="saveAll(this)"
                            class="btn saveBtnOpp btn-primary">保存
                    </button>

                </div>
            </div>
        </div>
    </div>
</div>
<div id="autoEditOnceWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: absolute;
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
    position: absolute;
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


<script>
    var globVar={};
    var oppoNo = '${oppoNo}';// 商机号
</script>
<script>
    var globDataGrid =
        [
            {
                "businessDesc": "",
                "classCode": "",
                "classDesc": "",
                "itemNo": 0,
                "oppoNo": "",
                "quantity": 0,
                "quotationNo": "",
                "remarks": "",
                "specification": "",
                "totalPrice": 0,
                "unit": "",
                "unitPrice": 0
            }, {
            "businessDesc": "",
            "classCode": "",
            "classDesc": "",
            "itemNo": 0,
            "oppoNo": "",
            "quantity": 0,
            "quotationNo": "",
            "remarks": "",
            "specification": "",
            "totalPrice": 0,
            "unit": "",
            "unitPrice": 0
        }, {
            "businessDesc": "",
            "classCode": "",
            "classDesc": "",
            "itemNo": 0,
            "oppoNo": "",
            "quantity": 0,
            "quotationNo": "",
            "remarks": "",
            "specification": "",
            "totalPrice": 0,
            "unit": "",
            "unitPrice": 0
        }
        ];
</script>
<script>
    var arrclo_addList = [];
    arrclo_addList.push({
        field: 'btn',
        title: '操作',
        width: 40,
        formatter: function (value, row, index) {
            return '<i class="iconfont_new contentTemplate" title="增加" onclick="addRow(this)">&#xe6a1;</i>&nbsp;<i title="复制" class="iconfont_new contentTemplate" onclick="copyRow(this)" >&#xe69d;</i>&nbsp;<i title="删除" class="iconfont_new contentTemplate" onclick="delRow(this)" >&#xe6f2;</i>';
        }
    });
    arrclo_addList.push({
        field: 'classDesc',
        title: '报价分类',
        width: 150,
        formatter: function (value, row, index) {
            return inputTemplateReq(value, index, row)
        }
    });
    arrclo_addList.push({
        field: 'businessDesc', width: 150, title: '业务内容', formatter: function (value, row, index) {
            return inputTemplate(value, index, 'businessDesc')
        }
    });
    arrclo_addList.push({
        field: 'specification',
        title: '相关描述(规格)',
        width: 150,
        formatter: function (value, row, index) {
            return inputTemplateReq2(value, index, 'unit')
        }
    });
    arrclo_addList.push({
        field: 'quantity',
        title: '数量',
        width: 50,
        formatter: function (value, row, index) {
            return inputTemplateQuantity(value, index, 'quantity')
        }
    });
    arrclo_addList.push({
        field: 'unit',
        title: '单位',
        width: 50,
        formatter: function (value, row, index) {
            return inputTemplateUnit(value, index, 'unit')
        }
    });
    arrclo_addList.push({
        field: 'unitPrice',
        title: '单价',
        width: 50,
        formatter: function (value, row, index) {
            return inputTemplateUnitprice(value, index, 'unitPrice')
        }
    });
    arrclo_addList.push({
        field: 'remarks',
        title: '备注',
        width: 50,
        formatter: function (value, row, index) {
            return inputTemplateRemarks(value, index, row, 'remarks')
        }
    });
    arrclo_addList.push({
        field: 'totalPrice',
        title: '行小计',
        width: 50,
        formatter: function (value, row, index) {
            return inputTemplatePrice(value, index, row, 'totalPrice')
        }
    });
</script>
<script>
    $(function () {
        //折扣优惠
        $(".sales-btn").on("click", function () {
            $("#salesCount").val(0);
            $("#discountText").text("0.00");
            priceCountTwo();
        });
        //减免金额
        $(".minus-btn").on("click", function () {
            //          model.set("salseOrder.preferential",0);
            $("#preferentialVal").val(0);
            $("#preferentialText").text("0.00");
            priceCountTwo();
        });
        //预收金额
        $(".earnest-btn").on("click", function () {
            //          model.set("salseOrder.depositRequested",0);
            $("#depositRequested").val(0);
            $("#depositRequestedText").text("0.00");
            priceCountTwo();
        });
        $("#bottomBox").find(".font-btn").on("click", function () {
            var $dom, box, boxClass, isActive, name;
            $dom = $(this);
            isActive = $dom.hasClass("active");
            name = $dom.attr("name");
            boxClass = "." + name + "-box";
            box = $("#bottomBox").find(boxClass);
            $dom.toggleClass("active", !isActive);
            if (isActive) {
                return box.hide();
            } else {
                return box.show();
            }
        });

    });
</script>
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
    function initPageTwoData(d) {
        var salesOrderDetail = d.details;
        var remarks = d.remarks;
        if (remarks != undefined && remarks != null) {
            $("#remarkBtn").click();
        }
        $("#createOrder").datagrid("loadData", salesOrderDetail);

        var fun = function () {
            $("#caseDesc").val(d.versionDesc);
            $("#versionDate").val(d.versionDate);

            $("#remarkInput").val(d.remarks);
            $("#depositRequested").val(Number(d.taxRate) * 100);
            $("#preferentialVal").val(d.preferential);
            $("#salesCount").val(Number(d.discountRate) * 100);
            onLoadS();
        }
        fun();

    }

    var initFunPage = function () {
        var noPage = $(".currentVersion").attr("id");

        if (noPage == null || noPage == "") {  //新建
            $("#createOrder").datagrid("loadData", globDataGrid);
            selectOptOppFun();
            initPageData();
            var fun = function () {
                $("#caseDesc").val("");
                $("#versionDate").val(new Date().Format("yyyy-MM-dd"));

                $("#remarkInput").val("");
                $("#depositRequested").val("");
                $("#preferentialVal").val("");
                $("#salesCount").val("");
                onLoadS();
            }
            fun();
        }
        else {
            $.ajax({
                url: "/ydz/opportunity/queryOneQuotationOrderAndDetail?oppoNo=" + oppoNo + "&quotationNo=" + noPage,
                type: 'GET',
                dataType: "json",
                success: function (dt) {
                    if (dt.code == "1") {
                        var d = dt.data;
                        initPageTwoData(d);
                    }

                }
            });

        }
    }

    // 页面入口处
    var initFunPageMain = function () {
        document.getElementById("header").innerHTML = "商机报价";
        $.ajax({
            url: "/ydz/opportunity/listVersions?oppoNo=" + oppoNo,
            dataType: "json",
            success: function (d) {
                var dt = {};
                dt.orders = d.data;
                if (d.code == "1") {
                    if (d.data.length == 0) {
                        initFunPage();
                        return;
                    }
                    var html = template('tpl-print', dt);
                    document.getElementById("header").innerHTML = "商机报价" + html;
                    initFunPage();


                    $(".delVersionFun").on("click", function () {
                        $("#versionControlWin").show();
                        var $th = $(this);
                        $(".customerjc").text("删除后将不可恢复，请谨慎操作");
                        $("#versionControlBtn").one("click", function () {

                            $.ajax({
                                url: "/ydz/opportunity/deleteQuotationOrderAndDetail?quotationNo=" + $th.attr("cid"),
                                dataType: "json",
                                success: function (d) {
                                    window.location.reload();
                                },
                                error: function () {
                                }
                            });

                        })
                        $(".versionControlCancel").one("click", function () {
                            $("#versionControlWin").hide();
                        })
                    })
                    $(".changeVersionFun").on("click", function () {
                        var $t = $(this);
                        var $t1 = $t.attr("cid");
                        if ($(this).hasClass("curVersion")) {
                            return;
                        }
                        $("#versionControlWin").show();
                        $(".customerjc").text("刚才修改的数据需要保存吗？");
                        $("#versionControlBtn").one("click", function () {
                            var fun = function () {
                                $(".currentVersion").removeClass("currentVersion");
                                $(".curVersion").removeClass("curVersion");
                                $t.addClass("curVersion").parents(".btn-group").addClass("currentVersion");
                                initFunPage();
                            }
                            saveAll($(".saveBtnOpp")[0], fun);
                            $("#versionControlWin").hide();
                        })
                        $(".versionControlCancel").one("click", function () {
                            $(".currentVersion").removeClass("currentVersion");
                            $(".curVersion").removeClass("curVersion");
                            $t.addClass("curVersion").parents(".btn-group").addClass("currentVersion");
                            $("#versionControlWin").hide();
                            initFunPageMain();
                        })
                    })
                    $(".defaultFun").on("click", function () {
                        var $th = $(this);
                        $("#versionControlWin").show();
                        $(".customerjc").text("启用当前报价");
                        $("#versionControlBtn").one("click", function () {
                            $.ajax({
                                url: "/ydz/opportunity/setDefaultVersion?oppoNo=" + oppoNo + "&quotationNo=" + $th.attr("cid"),
                                dataType: "json",
                                success: function (d) {
//                                var fun=function(){
//                                    $(".currentVersion").removeClass("currentVersion");
//                                    $(".curVersion").removeClass("curVersion");
//                                    $th.addClass("curVersion btn-default").parents(".btn-group").addClass("currentVersion");initFunPage();
//                                }
//                                fun();
                                    window.location.reload();
                                    $("#versionControlWin").hide();
                                },
                                error: function () {
                                }
                            });
                        })
                        $(".versionControlCancel").one("click", function () {
                            $("#versionControlWin").hide();
                        })
                    })
                    $(".addVersionFun").on("click", function () {
                        var $t = $(this);
                        if ($t.hasClass("curVersion")) {
                            return;
                        }
                        $("#versionControlWin").show();
                        $(".customerjc").text("刚才修改的数据需要保存吗？");
                        $("#versionControlBtn").one("click", function () {
                            var fun = function () {
                                $(".currentVersion").removeClass("currentVersion");
                                $(".curVersion").removeClass("curVersion");
                                $t.addClass("curVersion btn-default").parents(".btn-group").addClass("currentVersion");
                                initFunPage();
                            }
                            saveAll($(".saveBtnOpp")[0], fun);
                            $("#versionControlWin").hide();
                        })
                        $(".versionControlCancel").one("click", function () {
                            $("#versionControlWin").hide();
                        })


                    })
                } else {
                }

            },
            error: function () {
                initFunPage();
            }
        })
    }
    $(function () {

//        var date = JSON.parse(data);
        initFunPageMain();
    })
</script>
<script>
    var objSelMenu;// 临时保存页面共享下拉框的对象
    var oppProjectType = [];
    function oppProjectFun() {
        $.ajax({
            url: "/ydz/opportunity/listOpportTypeDesc?settingClass=QUOT_TYPE",
            dataType: "json",
            success: function (projectTp) {
                // 项目类型
                oppProjectType = projectTp;
                var returnopt = function (data, type) {
                    var opt = "";
                    for (var i = 0; i < data.length; i++) {
                        var dt = data[i];
                        var dtn = "";
                        if (type == 4) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                            opt += '<li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a></li>';
                        } else if (type == 5) {

                            opt += ' <li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a><span nid="' + dt.typeDesc + '" cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" csid="d">删除</span><span cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" style="right: 36px;">修改</span></li>';
                        }
                    }
                    return opt;
                }
                $(".recpayAccountList").html(returnopt(projectTp, 4));
                $(".ydz_select_menu_ul2").html(returnopt(projectTp, 5));
            },
            error: function () {
            }
        });
    }
    oppProjectFun();
    function selectOptOppFun() {
        $(".ydz_select2").off("click").on("click", function (e) {

            e.stopPropagation();

            var o = $(this).offset();
            var t = o.top + $(this).outerHeight();
            var l = o.left;
            $(".ydz_select_menu").css({
                "display": "block",
                "top": t,
                "left": l,
                "width": $(this).outerWidth(),
                "z-index": 1000
            });
//            if ($(this).hasClass("open")) {
//                $(this).removeClass("open");
//                $(".ydz_select_menu").hide();
//                objSelMenu=null;
//            } else {
            $(".ydz_select_menu").show();
            objSelMenu = $(this);
            $(this).addClass("open");
//            }
        });
    }
    $(function () {
        selectOptOppFun();
        $(".ydz_select_menu_ul").on("click", "li", function () {
            if (objSelMenu) {
                objSelMenu.val($(this).find("a").text());
//                        objSelMenu.val("sfsfsf");
//                        objSelMenu.prev().val($(this).find("a").attr("rel"));
            }
        })
        $(".autoEditOnce").on("click", function () {
            $("#autoEditOnceWin").show();
        })
        $(".autoEditTwice").off().on("click", function () {
            $("#menuTitle").text("添加自定义分类");
            $("#menu1").val("");
            $(".requireYdzMenu").hide();
            $("#modifyYdzMenuWin").show();
            $("#saveYdzMenu").unbind("click").bind("click", function () {
                var menu2 = $("#menu1").val();
                var categoryId = "", categoryDesc = "", url = "";
                if ($.trim(menu2) == "") {
                    $(".requireYdzMenu").show().removeClass("hide");
                    return;
                } else {
                    $(".requireYdzMenu").hide().addClass("hide");
                }
                var queryParams = {
                    "typeDesc": menu2,
                    "settingClass": "QUOT_TYPE"
                };
                $(this).attr("disabled", true);
                $.ajax({
//                            url:"/ydz/opportunity/updateOpportTypeDesc",
                    url: "/ydz/opportunity/addOpportTypeDesc",
                    type: 'post',
                    contentType: 'application/json',
                    data: JSON.stringify(queryParams),
                    dataType: "json",
                    success: function (dt) {
                        $.mytoast({text: dt.msg, time: 1000});
                        $("#menu1").val("");
                        $("#modifyYdzMenuWin").hide();
                        oppProjectFun();
                    }
                })
                $(this).attr("disabled", false);
            })
        })
        $(".autoEditWinClose").on("click", function () {
            $("#autoEditOnceWin,#modifyYdzMenuWin,#deleteYdzWin").hide();
        })
        $(".autoEditWinClose2").on("click", function () {
            $("#modifyYdzMenuWin").hide();
        })
        $(".closetranform").on("click", function () {
            $("#deleteYdzWin").hide();
        })
        $(".ydz_select_menu_ul2").on("click", "li>span", function (e) {
            var $th = $(this);
            if ($th.attr("csid") == "d") {
                $("#deleteYdzWin").css({display: 'block'});
                $("#deleteYdzMenu").attr("cid", $th.attr("cid"));
                $("#deleteYdzMenu").off().on("click", function () {
                    var queryParams = {};
                    $(this).attr("disabled", true);
                    $.ajax({
                        url: "/ydz/opportunity/deleteOpportTypeDesc?settingClass=QUOT_TYPE&typeCode=" + $th.attr("cid"),
                        dataType: "json",
                        success: function (dt) {
                            $.mytoast({text: dt.msg, time: 1000});
                            $("#deleteYdzWin").css({display: 'none'});
                            oppProjectFun();
                        }
                    })
                    $(this).attr("disabled", false);
                })
            } else {
                $("#menuTitle").text("修改自定义分类");
                $("#menu1").val($th.attr("nid"));
                $(".requireYdzMenu").hide();
                $("#modifyYdzMenuWin").css({display: 'block'});
                $("#saveYdzMenu").attr("cid", $th.attr("cid"));
                $("#saveYdzMenu").unbind("click").bind("click", function () {
                    var menu2 = $("#menu1").val();
                    var categoryId = "", categoryDesc = "", url = "";
                    if ($.trim(menu2) == "") {
                        $(".requireYdzMenu").show().removeClass("hide");
                        return;
                    } else {
                        $(".requireYdzMenu").hide().addClass("hide");
                    }
                    var queryParams = {
                        "typeDesc": menu2,
                        "settingClass": "QUOT_TYPE",
                        "typeCode": $th.attr("cid")
                    };
                    $(this).attr("disabled", true);
                    $.ajax({
                        url: "/ydz/opportunity/updateOpportTypeDesc",
//                                url:"/ydz/opportunity/addOpportTypeDesc",
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify(queryParams),
                        dataType: "json",
                        success: function (dt) {
                            $.mytoast({text: dt.msg, time: 1000});
                            $("#menu1").val("");
                            $("#modifyYdzMenuWin").css({display: 'none'});
                            oppProjectFun();
                        }
                    })
                    $(this).attr("disabled", false);
                })
            }
            e.stopPropagation();
        })
        $(document).bind('click', function () {
            $(".ydz_select2").removeClass("open");
            $(".ydz_select_menu").hide();
        });
        $(".ydz_select_menu").on("click", "li", function () {
            if (objSelMenu) {
                objSelMenu.val($(this).find("a").text());
                objSelMenu.prev().val($(this).find("a").attr("rel"));
            }
        })
    })
</script>
<script>
    function initPageData() {
        $("#versionDate").val(new Date().Format("yyyy-MM-dd"));
    }

    function forwardMainOpp() {
        window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
    }

    function readyData() {

        var rows = $('#createOrder').datagrid("getRows");

        for (var i = 0; i < rows.length; i++) {
            rows[i].specification = $("input.autocomplete_req")[i].value;
            rows[i].unitPrice = $("input.unitPriceChange")[i].value;
            rows[i].totalPrice = $("input.totalpriceChange")[i].value;
            rows[i].unit = $("input.inputTemplateUnit")[i].value;
            rows[i].createTime = "";
            rows[i].remarks = $("input.remarksChange")[i].value;
            rows[i].classCode = $("input.ydz_select2_prev")[i].value;
            rows[i].classDesc = $("input.ydz_select2")[i].value;
            rows[i].quantity = parseFloat($("input.inputTemplateQuantity")[i].value);
        }
        ;

        var saveData = {};
        saveData.details = rows;
        var quotNo = "";
        var noPage = $(".currentVersion").attr("id");
        if (noPage == null || noPage == "") {

        } else {
            quotNo = noPage;
        }
        var order =
            {
                "discount": $("#discountVal").val(),//折扣金额
                "discountRate": globVar.discountRate,//折扣优惠
                "oppoNo": oppoNo,
                "preferential": $("#preferentialVal").val(),// 减免金额
                "price": $("#priceTextVal").val(),
                "quotationNo": quotNo,
                "remarks": $("#remarkInput").val(),
                "taxPrice": accounting.unformat($("#depositRequestedText").text()),
                "taxRate": accounting.formatNumber(Number($("#depositRequested").val()) * 0.01, 2, ""),
                "totalPrice": $("#totalPriceVal").val(),// 订单金额
                "version": "",
                "versionDate": $("#versionDate").val(),
                "versionDesc": $("#caseDesc").val()
            }
        saveData.opportunityQuotation = order;
        return saveData;
    }
    function showRemark() {
        var hasClass;
        var self = $("#remarkBtn");
        hasClass = self.hasClass("secondary");
        self.toggleClass("secondary", !hasClass);
        if (hasClass) {
            self.html("<i class='iconfont_new'>&#xe6ca;</i>添加备注").css("padding", "10px 0px 10px 26px");
            $("#remarkInput").val("").hide();
        } else {
            self.html("备注").css("padding", "5px 0px 10px 0px");
            return $("#remarkInput").show();
        }
    }
    function saveAll(self, fun) {

        saveOrder(self, "", "dd", fun);
    }
    //保存草稿
    function saveDraft(self) {
        window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
    }
    //是否确认现金订单
    function saveOrder(o, url, tp, fun) {
        var self = $(o);
        self.attr("disabled", true);
        var noPage = $(".currentVersion").attr("id");
        var urlt = "";
        if (noPage == null || noPage == "") {
            urlt = "/ydz/opportunity/addOpportQuotation";

        } else {
            urlt = "/ydz/opportunity/updateOpportQuotation";
        }
        $.ajax({
            url: urlt,
            type: "post",
            data: JSON.stringify(readyData()),
            dataType: "json",
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

    function returnopt(data, type) {
        var opt = "";
        var partner = "";
        // if(type=="1"){opt='<option  value="ALL">全部供应商</option>'}
        for (var i = 0; i < data.length; i++) {
            var dt = data[i];
            var dtn = "";
            if (type == 1) {

                // if(dt.partnerComKey==undefined){partner="";}else{partner=dt.partnerComKey};
                dtn = dt.myComShortname == undefined ? "全部供应商" : dt.myComShortname;
                opt += '<option data-s="' + dt.partnerShortname + '" data-n="' + dt.partnerName + '" data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
            }
            if (type == 2) {
                opt += '<option value="' + dt.contacterId + '">' + dt.contacterName + '</option>';
            }
        }
        if (type == "10") {

            opt += ' <li><a href="javascript:;">' + dt.text + '</a><span csid="d">删除</span><span csid="m" style="right: 36px;">修改</span></li>';
        }
        return opt;
    }
    function onLoadS() {
        autocompleteFun();
        priceCount();
    }
    function autocompleteFun() {
        selectOptOppFun();

    }
    function inputTemplate(v, i, f) {
        return '<input  class="" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
    }

    function inputTemplateReq(v, i, row) {
        return '<input type="hidden" value="' + row.classCode + '" class="ydz_select2_prev" /><input readonly  class="ydz_select2"   style="width: 100%;" value="' + v + '" type="text">'
    }
    function inputTemplateReq2(v, i, row) {
        return '<input type="hidden" value="" class="autocomplete_workingProcedure " /><input  class=" autocomplete_req"   style="width: 100%;" value="' + v + '" type="text">'
    }
    function inputTemplatePrice(v, i, row, f) {
        return '<input class="totalpriceChange" readonly    style="width: 100%;" value="' + v + '" type="text">'
    }
    function inputTemplateRemarks(v, i, row, f) {
        return '<input placeholder="" class="remarksChange" onkeyup="modifyValRemarks(this,' + i + ',\'' + f + '\')"   style="width: 100%;" value="' + v + '" type="text">'
    }
    function inputTemplateLength(v, i, f) {
        return '<input class="inputTemplateLength" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
    }

    function inputTemplateWidth(v, i, f) {
        return '<input class="inputTemplateWidth" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
    }

    function inputTemplateQuantity(v, i, f) {
        return '<input class="inputTemplateQuantity" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
    }

    function inputTemplateUnit(v, i, f) {

        return '<input class="inputTemplateUnit" onkeyup="modifyValRemarks(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
    }
    function inputTemplateUnitprice(v, i, f) {

        return '<input data-s="select" class="unitPriceChange" onkeyup="modifyValUP(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
    }
    function modifyValUP(o, i, f) {
        var rindex = $(o).parents("tr").index();
        var ev = arguments.callee.caller.arguments[0] || window.event;
        if ($(ev.target).val() == "undefined") {
            return;
        }
        var row = {};
        // $('#createOrder').datagrid('updateRow',{index:rindex,row:row});
        $('#createOrder').datagrid('getRows')[rindex].unitPrice = $(ev.target).val();
        formula(rindex);
        autocompleteFun();
    }
    function modifyVal(o, i, f) {
        var rindex = $(o).parents("tr").index();
        var ev = arguments.callee.caller.arguments[0] || window.event;
        ///    if($(ev.target).val()=="undefined"){return;}
        $('#createOrder').datagrid('getRows')[rindex][f] = $(ev.target).val();
        if (f == "length" || f == "width" || f == "quantity") {
            formula(rindex);
        }
        autocompleteFun();
    }
    function modifyValRemarks(o, i, f) {
        var rindex = $(o).parents("tr").index();
        var ev = arguments.callee.caller.arguments[0] || window.event;
        ///    if($(ev.target).val()=="undefined"){return;}
        $('#createOrder').datagrid('getRows')[rindex][f] = $(ev.target).val();
    }
    function formula(rindex) {
        var row = $('#createOrder').datagrid('getRows')[rindex];
        var quantity = parseFloat($("input.inputTemplateQuantity")[rindex].value);
        var unitPrice = parseFloat($("input.unitPriceChange")[rindex].value);
        var totalPrice = 0;
        totalPrice = quantity * unitPrice;
        if (isNaN(totalPrice)) {
            $("input.totalpriceChange")[rindex].value = "0.00";
        } else {
            $("input.totalpriceChange")[rindex].value = Number(totalPrice).toFixed(2);
        }
        priceCount();
    }
    function priceCount() {
        var rows = $('#createOrder').datagrid("getRows");
        var tAmount = 0;
        for (var i = 0; i < rows.length; i++) {
            var pr = $.trim($("input.totalpriceChange")[i].value);
            if (isNaN($("input.totalpriceChange")[i].value) || pr == "") {
            } else {
                tAmount = tAmount + parseFloat($("input.totalpriceChange")[i].value);
            }
        }
        $("#priceText").text(accounting.formatNumber(tAmount, 2));
        $("#priceTextVal").val(tAmount);
        priceCountTwo();
    }
    function priceCountTwo() {
        var tAmount = $("#priceTextVal").val();
        var orderSales = $("#salesCount").val();
        var depositRequested = $("#depositRequested").val();
        var preferentialVal = $("#preferentialVal").val();
        if (isNaN(orderSales) || orderSales == "") {
            // $("<div class='tips_contants'>").fadeIn(250).html("折扣优惠为0-100").delay(500).fadeOut(250).appendTo('body');
            $("#salesCount").val(0);
            // return false;
        }
        globVar.discountRate = orderSales / 100;
        globVar.depositRequested = depositRequested / 100;
        var discount = tAmount * (orderSales / 100);
        var discountSd = tAmount * (depositRequested / 100);
        $("#discountText").text(accounting.formatNumber(discount, 2));
        $("#discountVal").val(discount);
        if (isNaN(preferentialVal) || preferentialVal == "") {
            $("#preferentialVal").val(0);
        }
        if (isNaN(depositRequested) || depositRequested == "") {
            $("#depositRequested").val(0);
        }
        var pr = parseFloat($("#priceTextVal").val()) - parseFloat($("#discountVal").val()) - parseFloat($("#preferentialVal").val()); //用到的减免金额

        $("#preferentialText").text(accounting.formatNumber($("#preferentialVal").val(), 2));
        $("#depositRequestedText").text(accounting.formatNumber(discountSd, 2));
//        $("#depositRequestedText").text(accounting.formatNumber($("#depositRequested").val(), 2));
//        $("#totalPriceText").text(accounting.formatNumber(pr, 2));
//        $("#totalPriceVal").val(pr);// 订单金额

        var yspr = pr + parseFloat(discountSd);//用到的预收金额
        $("#totalPriceVal").val(yspr);
        $("#totalPriceText").text(accounting.formatNumber(yspr, 2));
    }
    function addRow(o) {
        var rindex = $(o).parents("tr").index() + 1;
        $('#createOrder').datagrid('insertRow', {
            index: rindex,	// index start with 0
            row: {
                "businessDesc": "",
                "classCode": "",
                "classDesc": "",
                "itemNo": 0,
                "oppoNo": "",
                "quantity": 0,
                "quotationNo": "",
                "remarks": "",
                "specification": "",
                "totalPrice": 0,
                "unit": "",
                "unitPrice": 0
            }
        });
        autocompleteFun();
    }
    function delRow(o) {
        var rindex = $(o).parents("tr").index();
        if ($('#createOrder').datagrid("getRows").length > 1) {
            $('#createOrder').datagrid('deleteRow', rindex);
        }


        priceCount();
        // $("#createOrder").datagrid("reload");
    }
    function copyRow(o) {
        var i = $(o).parents("tr").index();
        var rows = $('#createOrder').datagrid("getRows");
        var row = {};


        row.businessDesc = rows[i].businessDesc;
        row.classDesc = $("input.ydz_select2")[i].value;
        row.classCode = $("input.ydz_select2_prev")[i].value;
//        row.specification = rows[i].specification;
        row.specification = $("input.autocomplete_req")[i].value;
        row.unitPrice = $("input.unitPriceChange")[i].value;
        row.totalPrice = $("input.totalpriceChange")[i].value;
        row.unit = $("input.inputTemplateUnit")[i].value;
        row.remarks = $("input.remarksChange")[i].value;
        row.quantity = $("input.inputTemplateQuantity")[i].value;
        $('#createOrder').datagrid('insertRow', {
            index: i + 1,	// index start with 0
            row: row
        });
        priceCount();
        autocompleteFun();
        // $("#createOrder").datagrid("reload");
    }


</script>

</body>

</html>