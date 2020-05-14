<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>媒体资源列表</title>

        <meta name="renderer" content="webkit">
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
        <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=95d4665fda">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">
        <style>
            .w1200alt {
                width: 120px;
            }

            .w1200input {
                width: 150px;
            }

            .w1200ipt150 {
                width: 180px;
            }

            .w1200hide {
                display: inline-block;
            }

            .w1200show {
                display: inline-block;
            }

            @media only screen and (max-width: 1280px) {
                .w1200input {
                    width: 120px;
                }

                .w1200ipt150 {
                    width: 150px;
                }

                .w1200hide {
                    display: none;
                }

                .w1200show {
                    display: inline-block;
                }
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

            /* chrome */
            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button {
                -webkit-appearance: none !important;
                margin: 0;
            }

            /* Firefox */
            input[type=number] {
                -moz-appearance: textfield;
            }

            input, textarea {
                outline: none;
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
                background: #eff1f9;
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
                border-color: #eff1f9;
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
                transform: translate(83px, 0);
            }

            .nav-tabs li:nth-child(3).smcolor ~ .block {
                transform: translate(173px, 0);
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

            .telColor {
                color: #ff9200
            }

            .bigCls {
                color: #009900;
            }

            .smallCls {
                color: #ff9200;
            }
        </style>
        <style>
            .prettyck label:before {
            }

            .prettyck {
                position: relative;
            }

            .prettyck {
                display: inline-table;
                margin-right: 10px;
                overflow: hidden;
                height: 30px;
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

            #receivablesBar {
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

            #receivablesBar2 {
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

            .nav-tabs li:nth-child(4).smcolor ~ .block {
                transform: translate(273px, 0);
            }

            .nav-tabs li:nth-child(5).smcolor ~ .block {
                transform: translate(350px, 0);
            }

            .telColor {
                color: #ff9200
            }
        </style>
        <style type="text/css">
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
            #modifyYdzMenuWin {
                z-index: 12;
            }

            #autoEditOnceWin {
                z-index: 11;
            }

            #deleteYdzWin {
                z-index: 13;
            }

            #autoEditOnceWin, #modifyYdzMenuWin, #deleteYdzWin {
                border: none;
                width: 700px;
                box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
                background: #fff;
                transition: all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
                display: none;
            }

        </style>

        <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
        <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
        <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
        <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
        <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>
        <%--<script src="/resources/jquery-ui.min.js?v=191ae2bcdf"></script>--%>

    </head>
<body class="easyui-layout" style="border:none !important;">


<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:10;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.6;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">
    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class=" row" style="margin:0;">
                <%--<div class="col-xs-2" style="width:200px;padding:0 5px 0 0">--%>
                <%--&lt;%&ndash;<input type="text" class="form-control" placeholder="选择客户">&ndash;%&gt;--%>
                <%--<select class="form-control input-xs" id="clientsDp" placeholder="媒体类型">--%>
                <%--</select>--%>
                <%--</div>--%>

                <div class="col-xs-2" style="">
                    <input type="hidden" name="mediaType">
                    <input type="text" style="" did="1" class="form-control ydz_select2" readonly name="mediaTypeDesc"
                           placeholder="媒体类型"/><span class="ydz_select_a"></span>
                </div>
                <div class="col-xs-2" style="">
                    <input type="hidden" name="showType">
                    <input type="text" style="" did="2" class="form-control ydz_select2" readonly name="showTypeDesc"
                           placeholder="表现形式"/><span class="ydz_select_a"></span>
                </div>
                <button type="button" id="" class="btn  btn-primary searchBtn "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>



                <button type="button" class="btn btn-primary pull-right receivableBtn "
                        style="margin-right:15px;height:30px;line-height:1;"
                        onclick="openReceivablesBar()">新建媒体
                </button>

            </div>
        </form>
    </div>

</div>
<div data-options="region:'center'" style="border:none !important;padding:10px;padding-top: 0;">

    <table id="order" style="height: 100%" class="easyui-datagrid"
           data-options="remoteSort:false,fit:true,
           nowrap:true,singleSelect:false,checkOnSelect:false">
    </table>
</div>
<%--<div id="pageToolbar"--%>
<%--style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">--%>


<%--</div>--%>
<div id="autoEditOnceWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    position: fixed;
    margin-left: -150px;
    width: 300px;
    margin-top: -175px;
    height: 350px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">
        编辑自定义分类 </p>

    <span class="autoEditWinClose"
          style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"><img
            src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">

        <ul class="ydz_select_menu_ul2">


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
<div class="ydz_select_menu">
    <ul class="ydz_select_menu_ul recpayAccountList">

    </ul>
    <%--<div class="autoEdit autoEditOnce">编辑自定义分类</div>--%>
</div>
<script>
    (function(window,$,undefined){
        var reloadUrl="/ydz/mediaresource/listMediaResources";
        var objSelMenu;// 临时保存页面共享下拉框的对象
        var kehuselDat=[],kehuselDat2=[],objSelType,kehuUrl,addUrl,updateUrl,delUrl,queryParamsUpdate={},queryParamsSel={};
        var kehuselUrl="/ydz/common/listComSettingClass?settingClass=MEDIA_TYPE";//媒体
        var kehuselUrl2="/ydz/common/listComSettingClass?settingClass=MEDIA_SHOW";//表现形式
        var kehuAddUrl="/ydz/common/insertComSettingClass";//媒体
        var kehuAddUrl2="/ydz/common/insertComSettingClass";//表现形式
        var kehuDelUrl="/ydz/common/deleteComSettingClass?settingClass=MEDIA_TYPE&typeCode=";//媒体
        var kehuDelUrl2="/ydz/common/deleteComSettingClass?settingClass=MEDIA_SHOW&typeCode=";//表现形式
        var kehuUpateUrl="/ydz/common/updateComSettingClass";//媒体
        var kehuUpateUrl2="/ydz/common/updateComSettingClass";//表现形式
        function selectOptOppFun() {
            $(".ydz_select2").off("click").on("click", function (e) {
//              页面有几个可编辑下拉框,就有几个分支，数据不一致
                if($(this).attr("did")=="1"){
                    oppProjectFun(kehuselDat);
                    kehuUrl=kehuselUrl;
                    objSelType="1";
                    addUrl=kehuAddUrl,delUrl=kehuDelUrl,updateUrl=kehuUpateUrl;
                    queryParamsSel.settingClass="MEDIA_TYPE";  //自定义的类型参数 可修改
                    queryParamsUpdate.settingClass="MEDIA_TYPE";//自定义的类型参数 可修改
                }  else if($(this).attr("did")=="2"){
                    queryParamsSel.settingClass="MEDIA_SHOW";//自定义的类型参数 可修改
                    queryParamsUpdate.settingClass="MEDIA_SHOW";//自定义的类型参数 可修改
                    oppProjectFun2(kehuselDat2);
                    kehuUrl=kehuselUrl2;
                    objSelType="2";
                    addUrl=kehuAddUrl2,delUrl=kehuDelUrl2,updateUrl=kehuUpateUrl2;
                }
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

        function initselOption(url,type){
            $.ajax({
                url: url,
                dataType: "json",
                success: function (projectTp) {
                    if(type=="1"){
                        kehuselDat=projectTp;
                    }else if(type=="2"){
                        kehuselDat2=projectTp;
                    }
                    oppProjectFun(projectTp);
                },
                error: function () {
                    kehuselDat=[],kehuselDat2=[];
                    oppProjectFun([]);
                }
            });

        }
        function oppProjectFun2(data) {
            var optInit = '<li><a rel="" href="javascript:;">全部表现形式</a></li>';
            var returnopt = function (data, type) {
                var opt = "";

                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    var dtn = "";
                    if (type == 4) {
                        opt += '<li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a></li>';
                    } else if (type == 5) {

                        opt += ' <li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a><span nid="' + dt.typeDesc + '" cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" csid="d">删除</span><span cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" style="right: 36px;">修改</span></li>';
                    }
                }
                return opt;
            }
            $(".recpayAccountList").empty().html(optInit+returnopt(data, 4));
//            $(".ydz_select_menu_ul2").empty().html(returnopt(data, 5));
        }
        function oppProjectFun(data) {
            var optInit = '<li><a rel="" href="javascript:;">全部媒体类型</a></li>';
            var returnopt = function (data, type) {
                var opt = "";

                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    var dtn = "";
                    if (type == 4) {
                        opt += '<li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a></li>';
                    } else if (type == 5) {

                        opt += ' <li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a><span nid="' + dt.typeDesc + '" cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" csid="d">删除</span><span cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" style="right: 36px;">修改</span></li>';
                    }
                }
                return opt;
            }
            $(".recpayAccountList").empty().html(optInit+returnopt(data, 4));
//            $(".ydz_select_menu_ul2").empty().html(returnopt(data, 5));
        }
        $(function () {
            reload();
            selectOptOppFun();
            initselOption(kehuselUrl,1);
            initselOption(kehuselUrl2,2);
            $(".ydz_select_menu_ul").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").text());
                }
            })
            $(".autoEditOnce").on("click", function () {
                $("#autoEditOnceWin").show();
                $(".window-mask").show();
//            $("#autoEditOnceWin").draggable({ cursor: "move", containment: "parent"});
            })
            $(".searchBtn").on("click", function () {
                reload();
            })
            $(".autoEditTwice").on("click", function () {
                $("#menuTitle").text("添加自定义分类");
                $("#menu1").val("");
                $(".requireYdzMenu").hide();
                $("#modifyYdzMenuWin").show();
                $("#saveYdzMenu").unbind("click").bind("click", function () {
                    var $that=$(this);
                    var menu2 = $("#menu1").val();
                    if ($.trim(menu2) == "") {
                        $(".requireYdzMenu").show().removeClass("hide");
                        return;
                    } else {
                        $(".requireYdzMenu").hide().addClass("hide");
                    }
                    queryParamsSel.typeDesc=menu2;
                    $that.attr("disabled", true);
                    $.ajax({
                        url:addUrl ,
                        type: 'post',
                        contentType: 'application/json',
                        data: JSON.stringify(queryParamsSel),
                        dataType: "json",
                        success: function (dt) {
                            $.mytoast({text: dt.msg, time: 1000});
                            $("#menu1").val("");
                            $("#modifyYdzMenuWin").hide();
                            initselOption(kehuUrl,objSelType);
                            $that.attr("disabled", false);
                        },error:function () {
                            $that.attr("disabled", false);
                        }
                    })

                })
            })

            $(".ydz_select_menu_ul2").on("click", "li>span", function (e) {
                var $th = $(this);
                if ($th.attr("csid") == "d") {
                    $("#deleteYdzWin").css({display: 'block'});
                    $("#deleteYdzMenu").attr("cid", $th.attr("cid"));
                    $("#deleteYdzMenu").off().on("click", function () {
                        var $that=$(this);
                        $that.attr("disabled", true);
                        $.ajax({
                            url:  delUrl+ $th.attr("cid"),
                            dataType: "json",
                            success: function (dt) {
                                $.mytoast({text: dt.msg, time: 1000});
                                $("#deleteYdzWin").css({display: 'none'});
                                initselOption(kehuUrl,objSelType);
                                $that.attr("disabled", false);
                            },error:function () {
                                $that.attr("disabled", false);
                            }
                        })
                    })
                } else {
                    $("#menuTitle").text("修改自定义分类");
                    $("#menu1").val($th.attr("nid"));
                    $(".requireYdzMenu").hide();
                    $("#modifyYdzMenuWin").css({display: 'block'});
                    $("#saveYdzMenu").attr("cid", $th.attr("cid"));
                    $("#saveYdzMenu").unbind("click").bind("click", function () {
                        var $that=$(this);
                        $that.attr("disabled", true);
                        var menu2 = $("#menu1").val();
                        if ($.trim(menu2) == "") {
                            $(".requireYdzMenu").show().removeClass("hide");
                            $that.attr("disabled", false);
                            return;
                        } else {
                            $(".requireYdzMenu").hide().addClass("hide");
                        }

                        queryParamsUpdate.typeCode=$th.attr("cid");
                        queryParamsUpdate.typeDesc=menu2;

                        $.ajax({
                            url: updateUrl,
                            type: 'post',
                            contentType: 'application/json',
                            data: JSON.stringify(queryParamsUpdate),
                            dataType: "json",
                            success: function (dt) {
                                $.mytoast({text: dt.msg, time: 1000});
                                $("#menu1").val("");
                                $("#modifyYdzMenuWin").css({display: 'none'});
                                initselOption(kehuUrl,objSelType);
                                $that.attr("disabled", false);
                            },error:function () {
                                $that.attr("disabled", false);
                            }
                        })
                    })
                }
                e.stopPropagation();
            })


            $(".autoEditWinClose").on("click", function () {
                $("#autoEditOnceWin,#modifyYdzMenuWin,#deleteYdzWin").hide();
                $(".window-mask").hide();
            })
            $(".autoEditWinClose2").on("click", function () {
                $("#modifyYdzMenuWin").hide();

            })
            $(".closetranform").on("click", function () {
                $("#deleteYdzWin").hide();
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
        window.openReceivablesBar=function () {
            var turl = "/openPage?pageName=media_media-resource-add";
            window.location.href = turl;
        }
        var param = getRequestParam.GetRequest();
        var yucunKuan = 0, yucunKuanSubmit = true;
        var oppColumnFun = {
            openReceivablesWin: function (id) {
                var turl = "/ydz/contract/forward-contract-detail?contractNo=" + id;
                window.location.href = turl;
            },

            closeReceivablesBar: function () {
                $("#invoiceAlready").addClass("hide");
                $(".recpayDiscount,.orderCycleCls,.recpayAccountCls").text("");
                $(".checkingNoCls").val("");
                $("input[name='recpayMoney']").val("");
//            $("input[name='recpayName']").val("");
                $("#remarks").val("");
                $("input[name='invoiceNo']").val("");
                $("input[name='invoiceContent']").val("");
                $("input[name='recipient']").val("");
                $("input[name='ceremarks']").val("");
                $("input[name='cecheckingNo']").val("");
                $("input[name='invoiceType']").val("");
                $("input[name='recpayAccount']").val("");
                $("input[name='invoiceAmount']").val("");
                $(".yucunKuanShow").val("");
                $(".yucunKuanCls").text("").hide();
                $("#receivablesBar,#receivablesBar2,.yucunkuan2,.yucunkuanCls").hide();
            },
        };
        function openDt(obj) {
            oppColumnFun.openReceivablesWin($(obj).attr("data-id"));
        }
        function oppColumn() {
            var arrclo = [];
            arrclo.push({
                field: 'index', title: '序号', width: 50, align: 'center', formatter: function (val, row, index) {
                    return index + 1;
                }
            });
            arrclo.push({
                field: 'mediaDesc', width: 250, title: '媒体名称'
            });
            arrclo.push({field: 'mediaTypeDesc', width: 150, align: 'center', title: '类型'});
            arrclo.push({field: 'showTypeDesc', width: 150, align: 'center', title: '表现形式'});
            arrclo.push({field: 'pointNum', width: 90, align: 'center', title: '点位数量'});
            arrclo.push({field: 'remarks', width: 150, align: 'center', title: '备注'});
            arrclo.push({field: 'btn', width: 90, align: 'center', title: '操作',
                formatter: function (value, row) {
                var md=row.mediaNo;
                    return '<a style="cursor: pointer" onclick="openProReq(\''+md+'\')">修改</a>';
//                return '<a style="cursor: pointer" onclick="openProReq(\'' + row.salesNo + '\')">修改</a>';
                }});

            return arrclo;
        }
        window.openProReq=function (id) {
            window.location.href="/ydz/mediaresource/forward-mediaresource-update?mediaNo="+id;
        }
        function reload() {
            var status = $("#navCondition").find(".smcolor").attr("data-s");
            var arrclo = [], url = "", pageSize = 30, pageList = [30, 40];
            arrclo = oppColumn();

            pageSize = 30;
            pageList = [30, 40];
            $('#order').datagrid({
                url: reloadUrl,
                fit: true,
                onLoadSuccess: onLoadSuccess,
                pagination: true,
                method:'get',
                pageSize: pageSize,
                pageList: pageList,
                columns: [arrclo],
                queryParams: {
                    "showType": $('input[name="showType"]').val(),
                    "searchKey": $('#searchKey').val(),
                    "mediaType":  $('input[name="mediaType"]').val()

                }
            });
            var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
            pager.pagination({
                layout: ['first', 'links', 'last'],
                showRefresh: false,
                displayMsg: ''
            });
            $(".pagination").show();

        }
        function onLoadSuccess(data) {
            if (data.rows.length > 0) {
            } else {
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        }

    })(window,jQuery);

</script>

</body>
</html>