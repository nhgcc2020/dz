<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>商机单新建及修改</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
    <%--<link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=95d4665fda">--%>
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">
    <style>
        .table-condensed{width:100%;}
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
            display: none;
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

        #modifyYdzMenuWin {
            z-index: 3;
        }

        #autoEditOnceWin {
            z-index: 2;
        }

        #deleteYdzWin {
            z-index: 4;
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
            transform: translate(245px, 0);
        }

        .nav-tabs li:nth-child(1) ~ .block {
            position: absolute;
            bottom: 3px;
            left: 13px;
            width: 90px;
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
        .select2-selection--multiple {
            height: 31px;
        }

        .select2-selection--multiple ul {
            height: 31px;
            line-height: 31px;
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

        .nav-tabs li:nth-child(2).smcolor ~ .block {
            transform: translate(125px, 0);
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
            left: 7px;
            width: 100px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .telColor {
            color: #ff9200
        }
    </style>
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
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <%--<script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>--%>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=df96034f1e"></script>
    <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>

</head>
<body style="height:100%;position:relative;">
<div id="autoEditOnceWin"
     style="    padding-top: 5px;
    top: 0;
    left: 50%;
    position: absolute;
    /*margin-top:-175px;*/
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
    <div class="autoEdit autoEditOnce">编辑自定义分类</div>
</div>
<div
        style="width:980px;padding-top:50px;padding-left: 50px;"
>
    <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-bottom: 40px;">商机概要</h1>
    <form class="form-horizontal" role="form">

        <div class="form-group">
            <label class="col-sm-2 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">商机：</label>
            <div class="col-sm-4 " style="
">
                <input type="text" style="" class="form-control " name="oppoDesc" placeholder="描述商机"/>

            </div>


            <label class="col-sm-2 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">项目类型：</label>
            <div class="col-sm-4" style="">
                <%--<select class="form-control input-xs " id="projectType" placeholder="请选择">--%>
                <%--</select>--%>
                <input type="hidden" name="oppoTypeHid">
                <input type="text" style="" class="form-control ydz_select2" readonly name="oppoType"
                       placeholder="请选择"/><span class="ydz_select_a"></span>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">客户：</label>
            <div class="col-sm-4" style="">
                <select class="form-control input-xs" id="clientsDp" placeholder="请选择">
                </select>
            </div>


            <label class="col-sm-2 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">联系人：</label>
            <div class="col-sm-4" style="">
                <select class="form-control input-xs" id="contacterDp" placeholder="请选择">
                </select>
            </div>

        </div>
        <div class="form-group">

            <label class="col-sm-2 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开始时间：</label>
            <div class="col-sm-4 ">

                <div class="">
                    <div class="input-icon-group">
                        <div class="" style="width:100%">
                            <input type="text" style="" autocomplete="off" class="form-control" id="startTime"
                                   data-format="yyyy-MM-dd" placeholder="请选择">
                            <span onclick="$('#startTime').datetimepicker('show');" class="" style="
    position: absolute;
    right: 30px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                            </input>
                        </div>
                    </div>
                </div>
            </div>
            <label class="col-sm-2 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">结束时间：</label>
            <div class="col-sm-4 " style="">

                <div class="">
                    <div class="input-icon-group">
                        <div class="" style="width:100%">
                            <input type="text" style="" autocomplete="off" class="form-control" id="endTime"
                                   data-format="yyyy-MM-dd" placeholder="请选择">
                            <span onclick="$('#endTime').datetimepicker('show');" class="" style="
    position: absolute;
    right: 30px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                            </input>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">项目地址：</label>
            <div class="col-sm-10 " style="
">
                <input type="text" style="" class="form-control" name="address" placeholder="请填写项目活动具体地址"/>

            </div>


        </div>
    </form>
    <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-top:50px;
    margin-bottom: 40px;">商机跟进</h1>
    <form class="form-horizontal" role="form">

        <div class="form-group">
            <label class="col-sm-2 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">销售阶段：</label>
            <div class="col-sm-4" style="">
                <select class="form-control input-xs" id="salesProcess" placeholder="请选择">
                </select>
            </div>


            <label class="col-sm-2 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">销售代表：</label>
            <div class="col-sm-4" style="">
                <select class="form-control input-xs" id="saleManDp" placeholder="请选择">
                </select>
            </div>

        </div>
        <div class="form-group">
            <label class="col-sm-2 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">参与人员：</label>
            <div class="col-sm-10 " style="
">
                <select type="text" multiple="multiple" readonly style="" class="form-control" id="gxWaySel"
                        placeholder="请添加">
                </select>

            </div>


        </div>
    </form>
    <div class="form-group pull-right" style="margin-top:50px;">
        <button type="button" dat="0" style="width: 104px;border-color:#d7d7d7;color:#999;" onclick=""
                class="btn btn-info cancelOpp">取消
        </button>
        <button type="button" dat="0" style="width: 118px;margin-left:7px;" onclick="" class="btn  btn-warning saveOpp">
            保存商机
        </button>
        <button type="button" dat="0" style="width: 118px;margin-left:7px;" userdata="1" onclick=""
                class="btn btn-primary continueOpp">管理报价
        </button>
    </div>
</div>
<%--自定义编辑下拉框的js代码--%>
<script>
    var objSelMenu;// 临时保存页面共享下拉框的对象
    var oppProjectType = [];
    function oppProjectFun() {
        $.ajax({
            url: "/ydz/opportunity/listOpportTypeDesc?settingClass=OPPORT_TYPE",
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
//    oppProjectFun();
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
        $(".ydz_select_menu_ul").on("click", "li", function () {
            if (objSelMenu) {
                objSelMenu.val($(this).find("a").text());
            }
        })
        $(".autoEditOnce").on("click", function () {
            $("#autoEditOnceWin").show();
        })
        $(".autoEditTwice").on("click", function () {
            $("#menuTitle").text("添加自定义分类");
            $("#menu1").val("");
            $(".requireYdzMenu").hide();
            $("#modifyYdzMenuWin").show();
            $("#saveYdzMenu").unbind("click").bind("click", function () {
                var $that=$(this);
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
                    "settingClass": "OPPORT_TYPE"
                };
                $that.attr("disabled", true);
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
                        $that.attr("disabled", false);
                    },error:function () {
                        $that.attr("disabled", false);
                    }
                })

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
                    var $that=$(this);
                    var queryParams = {};
                    $that.attr("disabled", true);
                    $.ajax({
                        url: "/ydz/opportunity/deleteOpportTypeDesc?settingClass=OPPORT_TYPE&typeCode=" + $th.attr("cid"),
                        dataType: "json",
                        success: function (dt) {
                            $.mytoast({text: dt.msg, time: 1000});
                            $("#deleteYdzWin").css({display: 'none'});
                            oppProjectFun();
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
                    var categoryId = "", categoryDesc = "", url = "";
                    if ($.trim(menu2) == "") {
                        $(".requireYdzMenu").show().removeClass("hide");
                        $that.attr("disabled", false);
                        return;
                    } else {
                        $(".requireYdzMenu").hide().addClass("hide");
                    }

                    var queryParams = {
                        "typeDesc": menu2,
                        "settingClass": "OPPORT_TYPE",
                        "typeCode": $th.attr("cid")
                    };

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
                            $that.attr("disabled", false);
                        },error:function () {
                            $that.attr("disabled", false);
                        }
                    })
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
    var oppoNo = '${oppoNo}';// 商机号
    var salesProcess = [
        {
            id: "01",
            text: "商机"
        }, {
            id: "02",
            text: "需求报价"
        }, {
            id: "03",
            text: "谈判"
        }, {
            id: "04",
            text: "赢单"
        }, {
            id: "05",
            text: "输单"
        }];
//    页面入口处
    $(function () {
        var noOppoFun = function () {

            $.ajax({
                url: "/ydz/salesorder/listSalesMan",
                dataType: "json",
                success: function (dt) {
                    // dt=[];
                    // $("#saleManDp").html( returnopt(data,2));
                    var dtall = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    // 参与人员
                    $("#gxWaySel").select2({
                        placeholder: "请添加参与人员",
                        minimumResultsForSearch: Infinity,
                        closeOnSelect: false,
                        data: dtall
                    }).val("").trigger("change");
                    var dtal2 = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    $("#saleManDp").select2({data: dtal2, minimumResultsForSearch: Infinity});
                },
                error: function () {
                }
            })
            oppProjectFun();
            selectOptOppFun();

            $("#salesProcess").select2({
                minimumResultsForSearch: Infinity,
                data: salesProcess
            }).val("").trigger("change");
            // 销售代表
            //项目类型
            //人员
            $.ajax({
                url: "/system/partner/simpleCustomerList",
                dataType: "json",
                success: function (data) {

                    $("#clientsDp").html(opportunityFun.returnopt(data, 1)).val("");
                    $("#clientsDp").select2({
                        templateResult: opportunityFun.formatState
                    });
                    $("#contacterDp").select2({minimumResultsForSearch: Infinity});
                    $("#clientsDp").on("change", function (e) {
                        $.ajax({
                            url: "/system/partner/listPartnerContacter",
                            dataType: "json",
                            data: {"partnerKey": $(this).val()},
                            timeout: "8000",
                            success: function (data) {
                                $("#contacterDp").html(opportunityFun.returnopt(data, 2));
                                $("#contacterDp").select2({
                                    minimumResultsForSearch: Infinity
                                });
                            },
                            error: function () {
                            }
                        })
                    });
                },
                error: function () {
                }
            });


            $('#startTime').datetimepicker({
                format: 'yyyy-mm-dd hh:ii:ss',widthCustom:"290px", language: 'zh-CN', autoclose: true, minView: 'hour', todayBtn: true
            }).on("click", function () {
                $("#startTime").datetimepicker("setEndDate", $("#endTime").val())
            });
            $('#endTime').datetimepicker({
                format: 'yyyy-mm-dd hh:ii:ss',widthCustom:"290px", language: 'zh-CN', autoclose: true, minView: 'hour', todayBtn: true
            }).on("click", function () {
                $("#endTime").datetimepicker("setStartDate", $("#startTime").val())
            });


        }
        var oppoFun = function (dopp) {
            $.ajax({
                url: "/ydz/salesorder/listSalesMan",
                dataType: "json",
                success: function (dt) {
                    // dt=[];
                    // $("#saleManDp").html( returnopt(data,2));
                    var dtall = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    // 参与人员
                    $("#gxWaySel").select2({
                        placeholder: "请添加参与人员",
                        minimumResultsForSearch: Infinity,
                        closeOnSelect: false,
                        data: dtall
                    }).val(dopp.participantEmployeeId.split(",")).trigger("change");
                    var dtal2 = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    $("#saleManDp").select2({
                        data: dtal2,
                        minimumResultsForSearch: Infinity
                    }).val(dopp.salesId).trigger("change");
                },
                error: function () {
                }
            })

            $("input[name='address']").val(dopp.address);
            $("#endTime").val(dopp.endDate);
            $("#startTime").val(dopp.startDate);
            $("input[name='oppoDesc']").val(dopp.oppoDesc);
            $("input[name='oppoTypeHid']").val(dopp.oppoType);
            $("input[name='oppoType']").val(dopp.oppoTypeDesc);

            oppProjectFun();
            selectOptOppFun();
            $("#salesProcess").select2({
                minimumResultsForSearch: Infinity,
                data: salesProcess
            }).val(dopp.orderSection).trigger("change");
            $.ajax({
                url: "/system/partner/simpleCustomerList",
                dataType: "json",
                success: function (data) {

                    $("#clientsDp").html(opportunityFun.returnopt(data, 1)).val(dopp.partnerKey);
                    $("#clientsDp").select2({
                        templateResult: opportunityFun.formatState
                    });
                    var funChange = function (id, defat) {
                        $.ajax({
                            url: "/system/partner/listPartnerContacter",
                            dataType: "json",
                            data: {"partnerKey": id},
                            timeout: "8000",
                            success: function (data) {
                                $("#contacterDp").html(opportunityFun.returnopt(data, 2));
                                $("#contacterDp").select2({
                                    minimumResultsForSearch: Infinity
                                }).val(defat).trigger("change");
                            },
                            error: function () {
                            }
                        })
                    }
                    var funChange2 = function (id, defat) {
                        $.ajax({
                            url: "/system/partner/listPartnerContacter",
                            dataType: "json",
                            data: {"partnerKey": id},
                            timeout: "8000",
                            success: function (data) {
                                $("#contacterDp").html(opportunityFun.returnopt(data, 2));
                                $("#contacterDp").select2({
                                    minimumResultsForSearch: Infinity
                                });
                            },
                            error: function () {
                            }
                        })
                    }
                    $("#clientsDp").on("change", function (e) {
                        funChange2($(this).val());
                    });
                    funChange(dopp.partnerKey, dopp.contactId);

                },
                error: function () {
                }
            });

            $('#startTime').datetimepicker({
                format: 'yyyy-mm-dd hh:ii:ss',widthCustom:"290px", language: 'zh-CN', autoclose: true, minView: 'hour', todayBtn: true
            }).on("click", function () {
                $("#startTime").datetimepicker("setEndDate", $("#endTime").val())
            });
            $('#endTime').datetimepicker({
                format: 'yyyy-mm-dd hh:ii:ss',widthCustom:"290px", language: 'zh-CN', autoclose: true, minView: 'hour', todayBtn: true
            }).on("click", function () {
                $("#endTime").datetimepicker("setStartDate", $("#startTime").val())
            });



        }
        if (oppoNo == null || oppoNo == "") {
            noOppoFun();   //新建路由
        } else {
            // 修改路由
            $.ajax({
                url: "/ydz/opportunity/queryOneOpportunityOrder?oppoNo=" + oppoNo,
                dataType: "json",
                success: function (dt) {
                    oppoFun(dt.data);
                },
                error: function () {
                }
            })
        }
        $(".saveOpp").unbind("click").bind("click", function () {
            var opp2=$("input[name='oppoDesc']").val();
            var opp3=$("#salesProcess").val();
            var opp1=$("#clientsDp").val();
            if( opp2==""){
                $.mytoast({text:"请填写商机名称"})
                return;
            }
            if(opp1==null || opp1==""){
                $.mytoast({text:"请选择客户"})
                return;
            }
            if(opp3==null || opp3==""){
                $.mytoast({text:"请选择销售阶段"})
                return;
            }

            opportunityFun.saveOpp(this);
        })
        // 继续添加报价清单
        $(".continueOpp").off("click").on("click", function () {
            var opp2=$("input[name='oppoDesc']").val();
            var opp3=$("#salesProcess").val();
            var opp1=$("#clientsDp").val();
            if( opp2==""){
                $.mytoast({text:"请填写商机名称"})
                return;
            }
            if(opp1==null || opp1==""){
                $.mytoast({text:"请选择客户"})
                return;
            }
            if(opp3==null || opp3==""){
                $.mytoast({text:"请选择销售阶段"})
                return;
            }
            opportunityFun.continueOpp(this);
        })
        $(".cancelOpp").one("click", function () {
            opportunityFun.cancelOpp(this);
        })
    });
    var opportunityFun = {
        cancelOpp: function () {
            window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
        },
        saveOpp: function (fun) {
            $(".saveOpp").attr("disabled", true);
            $(".continueOpp").attr("disabled", true);
            var empId = "";
            if ($("#gxWaySel").val()) {
                empId = $("#gxWaySel").val().join(",");
            }
            var param = {
                "address": $("input[name='address']").val(),
                "contactId": $("#contacterDp").val(),
                "contactName": $("#contacterDp").find("option:selected").text(),
                "endDateValue": $("#endTime").val(),
                "startDateValue": $("#startTime").val(),
//                "orderDate":"2017-11-21",
                "orderSection": $("#salesProcess").val(),
                "oppoDesc": $("input[name='oppoDesc']").val(),
//                "orderStatus":"01",gxWaySel
                "participantEmployeeId": empId,
                "partnerKey": $("#clientsDp").val(),
                "partnerName": $("#clientsDp").find("option:selected").text(),
//                "partnerShortname":"紫燕集团",
//                "remarks":"23324324",
                "salesId": $("#saleManDp").val(),
                "salesName": $("#saleManDp").find("option:selected").text(),
                "oppoType": $("input[name='oppoTypeHid']").val(),
                "oppoTypeDesc": $("input[name='oppoType']").val(),
                "oppoNo": oppoNo

            };
            var urlT = "/ydz/opportunity/updateOpportunity";
            var oppoG = oppoNo;
            if (oppoNo == null || oppoNo == "") {
                urlT = "/ydz/opportunity/addOpportunity";
            }
            $.ajax({
                url: urlT,
                dataType: "json",
                type: "post",
                contentType: "application/json",
                data: JSON.stringify(param),
                success: function (data) {
                    if (data.code == "1") {
                        $.mytoast({text: data.msg, time: 1000});

                        if (oppoG == "" || oppoG == null) {
                            oppoG = data.oppoNo;
                        }
                        setTimeout(function () {
                            if (typeof fun == "function") {
                                window.location.href = "/ydz/opportunity/forward-AddorUpdateOpportunity?oppoNo=" + oppoG;
                            } else {
                                window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
                            }
                        }, 1500);
                    } else {
                        $(".saveOpp").attr("disabled", false);
                        $(".continueOpp").attr("disabled", false);
                        $.mytoast({text: data.msg, time: 1000});
                    }

                },
                error: function () {
                    $(".saveOpp").attr("disabled", false);
                    $(".continueOpp").attr("disabled", false);
                    $.mytoast({text: "操作出错", time: 1000});
                }
            })
        },
        continueOpp: function () {
            var fun = function () {
                window.location.href = "/ydz/opportunity/forward-AddorUpdateOpportunity?oppoNo=";
//                window.location.href="/openPage?pageName=project_quotation-add-update";
            }
            opportunityFun.saveOpp(fun);

        },

        returnopt: function (data, type) {
            var opt = "";
            for (var i = 0; i < data.length; i++) {
                var dt = data[i];
                var dtn = "";
                if (type == 1) {
                    if(dt.partnerShortname=="全部客户"){continue;}
//                    dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                    dtn = dt.myComShortname;
                    opt += '<option data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
                }
                if (type == 2) {
                    opt += '<option value="' + dt.contacterId + '">' + dt.contacterName + '</option>';
                }
                if (type == 3) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                    opt += '<li><a rel="' + dt.employeeId + '" href="javascript:;">' + dt.realName + '</a></li>';
                }
                if (type == 4) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                    opt += '<li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a></li>';
                } else if (type == 5) {

                    opt += ' <li><a rel="' + dt.typeCode + '" href="javascript:;">' + dt.typeDesc + '</a><span nid="' + dt.typeDesc + '" cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" csid="d">删除</span><span cid="' + dt.typeCode + '" nid="' + dt.typeDesc + '" style="right: 36px;">修改</span></li>';
                }

            }
            return opt;
        },
        formatState: function (state) {
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
    };
</script>
</body>
</html>