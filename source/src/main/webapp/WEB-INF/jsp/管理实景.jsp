<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title></title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=3e10f9c6f9">
    <link rel="stylesheet" type="text/css" href="/resources/common/custom-widget.css?v=317bd77da5">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">

    <link rel="stylesheet" type="text/css" href="/resources/easyui/webuploader.css">


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
            z-index: 12;
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
        .form-horizontal .control-label, .form-horizontal .radio, .form-horizontal .checkbox, .form-horizontal .radio-inline, .form-horizontal .checkbox-inline{
            padding-top:0;
        }
        .control-label-mark:before{
            content: '*';
            color:red;
            margin-right:5px;
            font-size:12px;
        }

    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/easyui/pace.min.js?v=fe5e2eaca6"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/business/base_new.js?v=1191ae2bcdf"></script>
    <script src="/resources/easyui/validate.min.js"></script>
</head>

<body class="modal-page" style="padding:0!important;">
<div
        style="    padding: 70px 0 0 0;" class="main"
>




    <div class="fixheader">
        <%--<button type="button" onclick="saveAll(this)" class="btn btn-primary copyMain " style="width:90px;margin:4px 8px 10px 0px">保存--%>
        <%--</button>--%>
        <button type="button"  onclick="saveDraft(this)" class="btn  cancelOpp"
                style="font-size:14px;height:30px;margin:5px 8px 10px 20px;background:#fff;color:#7e92ab;padding:0;">
            <i class="iconfont_new " style="font-size:26px;position:relative;top:4px;"></i>取消
        </button>
    </div>


    <div class="row" style="margin:0 50px 20px;line-height: 30px;">
        <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-bottom: 40px;
    /*margin-left: -25px;*/
    margin-top: 20px;
    font-weight: 700;">管理实景</h1>

        <div class="page-container">
            <div id="uploader" class="wu-example">
                <div class="queueList">
                    <div id="dndArea" class="placeholder">
                        <div id="filePicker"></div>
                        <p>或将照片拖到这里</p>
                    </div>
                </div>
                <div class="statusBar" style="display:none">
                    <%--<div class="progress">--%>
                        <%--<span class="text">0%</span>--%>
                        <%--<span class="percentage"></span>--%>
                    <%--</div>--%>
                    <div class="info"></div>
                    <div class="btns">
                        <div id="filePicker2"></div>
                        <div class="uploadBtn">开始上传</div>
                    </div>
                </div>
            </div>
        </div>

    </div>


</div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:1;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<script type="text/javascript" src="/resources/easyui/webuploader.min.js"></script>
<%--<script type="text/javascript" src="/resources/easyui/extend-webuploader.js"></script>--%>
<script type="text/javascript">
    init();
    function init(){
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = "/resources/easyui/extend-webuploader.js";
        document.body.appendChild(script);
        window.webuploader = {
            config:{
                thumbWidth: 300, //缩略图宽度，可省略，默认为110
                thumbHeight: 300, //缩略图高度，可省略，默认为110
                btnName:'点击添加实景图片',
                wrapId: 'uploader', //必填
            },
            formData:{pointNo: "212123"},
            //处理客户端新文件上传时，需要调用后台处理的地址, 必填
            uploadUrl: '/mediaresource/fileUpload',
            //处理客户端原有文件更新时的后台处理地址，必填
            updateUrl: 'fileupdate.php',
            //当客户端原有文件删除时的后台处理地址，必填
            removeUrl: 'filedel.php',
            //初始化客户端上传文件，从后台获取文件的地址, 可选，当此参数为空时，默认已上传的文件为空
            initUrl: '/mediaresource/listPictureFile',
        }

    }

</script>
</body>

</html>