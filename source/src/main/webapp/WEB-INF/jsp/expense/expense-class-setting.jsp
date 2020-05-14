<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>费用分类设置</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
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
            font-size: 14px;
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
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <style>
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
            transform: translate(98px, 0);
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
            left: 8px;
            width: 70px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .telColor {
            color: #ff9200
        }
    </style>
    <%--简单实现的下拉框方式--%>
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
            width: 120px;
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
            width: 120px;
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

        .datagrid-header,
        .datagrid-td-rownumber {
            background: #eff1f9;
        }

        .datagrid-header td, .datagrid-body td, .datagrid-footer td {
            border: none;

        }

        .datagrid-body td {
            border-bottom: 1px solid #f2f2f2;
        }

        .datagrid-header-row, .datagrid-row, .datagrid-header {
            height: 50px;
            line-height: 50px;
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
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<%--<div class="window-mask" style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>--%>


<div id="taxPointWin"
     style="padding-top: 5px; top: 50%; left: 50%; margin-left: -250px; margin-top: -130px; position: absolute; width: 500px; height: 260px; display: none;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">创建费用分类</p>
    <input type="hidden" name="fwdjId" id="fwdjId">
    <input type="hidden" name="fwdjcid" id="fwdjcid">
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="salescheckFun.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style="    margin-left: 50px; margin-top:60px;line-height: 30px;position: relative;">
            <div class="form-group" style="height: 30px;">

                <label class="col-sm-2 control-label" style="
    padding: 0;
    text-align: right;
    font-size: 14px;
">当前费用：</label>
                <div class="col-sm-6 " style="
    padding-right: 0;
    font-size: 14px;
    text-align: left;
" id="categoryDesc">
                </div>

            </div>
        </div>
    </div>

    <div style="  clear: both;     margin-left:50px; position: relative;">

        <div class="form-group" style="height: 30px;line-height: 30px;">
            <label class="col-sm-2 control-label" style="
    padding: 0;
    text-align: right;
    font-size: 14px;
">分类名称：</label>
            <div class="col-sm-6 " style="
    padding-right: 0;
    text-align: right;
">
                <input data-s="select" type="text" style="/* text-align: right */" class="form-control" id="pricezg"
                       placeholder="请输入分类名称">
                <input type="hidden" id="categoryId">
            </div>
            <div class="col-sm-3 hide requireshow" style="
    /*padding: 0;*/
    text-align: left;color:#ff704f;
    font-size: 12px;
">分类不能为空
            </div>
        </div>
        <div class="col-sm-9  hide requireshow2" style="
    /*padding: 0;*/
    text-align: right;
    color:#8e8e8e;
    width: 320px;
    font-size: 12px;
">修改后已创建的费用单分类也会被更新！
        </div>

    </div>

    <div style="clear: both;margin-left:255px;margin-top:60px;">
        <button type="button" class="btn  btn-default" onclick="salescheckFun.closeTaxPoint()" style="width:100px;">取消
        </button>
        <button type="button" class="btn btn-primary" style="margin-left:12px;width:100px;font-size:12px;"
                onclick="salescheckFun.saveTable()">保存
        </button>
    </div>
</div>


<div id="deleteWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -125px;
    margin-top: -143px;
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
    cursor: pointer;" onclick="salescheckFun.closeTaxPoint()"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
    margin: 30px auto 20px;">
        <span class="customerjc" style="    position: relative;
    text-align: center;
    margin: 0 auto;
    font-size: 22px;
    font-weight: normal;
    color: #44ae80;
    height: 30px;
    line-height: 30px;">确定要删除吗？</span>
        <div style="clear: both;margin-top:35px;">
            <button type="button" class="btn  btn-default" onclick="salescheckFun.closeTaxPoint()" style="width:92px;">
                取消
            </button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="salescheckFun.deleteServLast(this)">确认
            </button>
        </div>
    </div>
</div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition" style="width:200px;">

        <li style="position:relative;" data-s="01" onclick="cgx(this);" class="order2 smcolor"><a href="#">日常支出</a>
        </li>
        <li style="position:relative;" data-s="02" onclick="cgx(this);" class=" order3"><a href="#">工资支出</a></li>
        <li class="block"></li>
    </ul>

    <%--<div id="CashFormula" style="color: #ff9900;--%>
    <%--position: absolute;--%>
    <%--left: 420px;--%>
    <%--top: 25px;--%>
    <%--cursor: pointer;" onclick="showFormua()">查看金额公式>>--%>
    <%--</div>--%>
    <button type="button" class="btn  btn-primary pull-right drawBillBtn "
            style="margin-top:-35px;font-size:12px;height:30px;line-height:1;"
            onclick="salescheckFun.drawBillWithNoReceive()">创建费用分类
    </button>

    <div class="h10" style="border-bottom: 1px solid #f2f2f2;"></div>
</div>
<div data-options="region:'center'" style="border:none !important;padding:10px;padding-top: 0;">

    <table id="order" style="height: 100%" class="easyui-datagrid"
           data-options="remoteSort:false,fit:true,
           nowrap:true,singleSelect:false,checkOnSelect:false">
    </table>
</div>
<script>


    // isDel typeCode settingClass

    var tab = "order2";
    var pageInsertMenuUrl = "";
    var pageSaveMenuUrl = "/ydz/expensebook/saveExpenseTypeSetting";
    var param = getRequestParam.GetRequest();
    var type = param.type || "";

    var pageAllUrl = "/ydz/expensebook/listExpenseTypeSetting";//getExpenseTypeForDropdown expenseTypeSetting settingClass  01日常支出 02工资支出
    //    var pageAllUrl="/ydz/expensebook/getExpenseTypeForDropdown";//getExpenseTypeForDropdown expenseTypeSetting settingClass  01日常支出 02工资支出
    function formatCaozuo(row) {
        var changeItem = JSON.stringify(row);
        return "<span onclick='salescheckFun.formatEditLast(" + changeItem + ")' style='    vertical-align: middle;font-size: 24px;color: #999;margin-right: 10px' class='iconfont_new'>&#xe6e6;</span><span onclick='salescheckFun.formatDelLast(" + changeItem + ")'  style='    vertical-align: middle;font-size: 24px;color: #999;' class='iconfont_new'>&#xe6f1;</span>"

    }
    function hideMsgWin() {
        $("#receivablesBar").hide();
    }
    function cgx(o) {
        hideMsgWin();
        $(o).addClass("smcolor").siblings().removeClass("smcolor");
        reload();
    }
    function returnopt(data, type) {
        var opt = "";
        for (var i = 0; i < data.length; i++) {
            var dt = data[i];
            var dtn = "";
            if (type == 1) {
//                    if(dt.partnerShortname==undefined){continue;}
                dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                opt += '<option data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
            }
            if (type == 2) {
                dtn = dt.show;
                opt += '<option value="' + dt.key + '">' + dtn + '</option>';
            }
            if (type == 3) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                opt += '<li><a rel="' + dt.employeeId + '" href="javascript:;">' + dt.realName + '</a></li>';
            }
            if (type == 4) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                opt += '<li><a rel="' + dt.id + '" href="javascript:;">' + dt.text + '</a></li>';
            }

        }
        return opt;
    }
    function formatState(state) {
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
    function arrShoukuan() {
        var arrclo = [];
        arrclo.push({field: 'zz', width: 80, fixed: true, align: 'center', title: ''});
        arrclo.push({field: 'typeDesc', fixed: true, width: 420, halign: 'left', align: 'left', title: '分类名称'});
        arrclo.push({
            field: 'cc', width: 116, fixed: true, align: 'center', title: '操作', formatter: function (value, row) {
                return formatCaozuo(row);
            }
        });
        arrclo.push({field: 'vv', width: 80, align: 'center', title: ''});
        return arrclo;
    }
    function reload() {
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        var arrclo = [], url = "", pageSize = 30, pageList = [30, 40];
        arrclo = arrShoukuan();


        url = pageAllUrl + "?settingClass=" + status;
        pageSize = 30;
        pageList = [30, 40];


        $('#order').datagrid({
            url: url,
//                data:globDataGrid,
            fit: true,
            fitColumns: true,
            onLoadSuccess: onLoadSuccess,
            pagination: false,
            pageSize: pageSize,
            pageList: pageList,
            columns: [arrclo],
        });

    }
    function hideMsg() {
        $(".window-mask").hide();
        $("#msgwindow").css({left: "100%"}).removeClass("activ");
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
    function onLoadSuccess(data) {
        if (data.rows.length > 0) {
        } else {
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }
    function showFormua() {
        $("#CashSale").css({display: 'block'})
        $(".window-mask").show();
    }
    function closeFormua() {
        $("#CashSale").css({display: 'none'})
        $(".window-mask").hide()
    }

    $(function () {

        $("#timeDp").select2({
            minimumResultsForSearch: Infinity
        });

        $.ajax({
            url: "/system/partner/dropdownPartner?partnerType=1",
            dataType: "json",
            success: function (data) {
                $("#clientsDp").html(returnopt(data, 1));
                $("#clientsDp").select2({
//                        maximumInputLength:2,
                    templateResult: formatState
                });
                var showNum = "order4";
                var type = getRequestParam.GetRequest().type;
                if (type != "" && type != undefined) {
                    showNum = type;
                }
                $("#navCondition").find("." + showNum).addClass("smcolor").siblings().removeClass("smcolor");

                var status = $("#navCondition").find("." + showNum).attr("data-s");
                reload(status);
            },
            error: function () {
            }
        });
        //全部订单搜索
        $(".searchBtn").click(function () {
            reload();
        })
        $.ajax({
            url: "/ydz/salesorder/listSalesMan",
            dataType: "json",
            success: function (data) {
                $(".recpayNameList").html(returnopt(data, 3));
            },
            error: function () {
            }
        });
        $(".recpayAccountList").html(returnopt(globeConfigData.recpayAccountList, 4));
        $(".billList").html(returnopt(globeConfigData.billList, 4));
    });
    var salesCheckObj = {
        typeCode: "",
        settingClass: ""
    };
    var salescheckFun = {
        saveTable: function () {
            if ($.trim($("#pricezg").val()) == "") {
                $(".requireshow").removeClass("hide");
                return;
            }


//            pricezg

            if ($("#navCondition").find(".smcolor").index() == 0) {
            } else {
            }
            var queryParams = {
                "settingClass": salesCheckObj.settingClass,
                "typeDesc": $("#pricezg").val(),
                "typeCode": salesCheckObj.typeCode,
            };
            $.ajax({
                url: pageSaveMenuUrl,
                type: 'post',
                data: jQuery.param(queryParams),
                dataType: "json",
                success: function (dt) {
                    $.mytoast({text: dt.msg});
                    salescheckFun.closeTaxPoint();
                    reload();
                },
                error: function () {
                    $.mytoast({text: "保存失败"});
                }
            })
        },
        //打开收款窗口
        openReceivablesBar: function () {

            //当前时间 nowDate
//                model.set("receiptpayment.recpayDate",new Date());
//                $("#recpayDate").val();
            var selectItems = $('#order').datagrid('getChecked');
            var totalPrice = 0;
            var flag = false;
            if (selectItems.length == 0) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择一笔需要收款的对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            if (selectItems.length > 1) {
                $("<div class='tips_contants'>").fadeIn(250).html("不可同时收款多笔对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            if (selectItems.length == 1) {
                var selectObj = selectItems[0];
                if (selectObj.invoiceStatus == "1") {
                    $("#invoiceAlready").removeClass("hide");
                } else {
                    $("#invoiceAlready").addClass("hide");
                }
                $(".partnerShortnameCls").text(selectObj.partnerShortname);
                $(".contactNameCls").text(selectObj.contactName);
                $(".detailNumCls").text(selectObj.salesOrderNum);

                $(".receivablesMoneyCls").val(selectObj.receivablesMoney);
                $(".checkingNoCls").val(selectObj.salescheckingNo);
                $(".orderCycleCls").text(selectObj.orderCycle);

                $(".totalPriceCls").text(accounting.formatNumber(selectObj.totalPrice, 2));
                $(".receivablesMoneyShow").text(accounting.formatNumber(selectObj.receivablesMoney, 2));
                $(".depositRequestedCls").text("- " + accounting.formatNumber(selectObj.depositRequested, 2));
                $("#receivablesBar").show();
            }

        },
        //关闭收款窗口
        formatDelLast: function (rowData) {
            salesCheckObj.typeCode = rowData.typeCode;//初始化
            salesCheckObj.row = rowData;//初始化
            $(".window-mask").show();
            $('#deleteWin').show();

        },
        deleteServLast: function (o) {
            var queryParams = salesCheckObj.row;
            queryParams.isDel="1";
            $.ajax({
                url: pageSaveMenuUrl,
                type: 'post',
                data: jQuery.param(queryParams),
                dataType: "json",
                success: function (dt) {
                    $.mytoast({text: dt.msg});
                    salescheckFun.closeTaxPoint();
                    reload();
                },
                error: function () {
                    $.mytoast({text: "保存失败"});
                }
            })

        },
        formatEditLast: function (rowData) {
            salesCheckObj.typeCode = rowData.typeCode;//初始化
            salesCheckObj.settingClass = rowData.settingClass;//初始化
            $("#fuwuTitle").text("修改费用分类");
            $("#pricezg").val(rowData.typeDesc);
            $(".requireshow").addClass("hide");
            $(".requireshow2").removeClass("hide");
            $("#categoryDesc").text($("#navCondition").find(".smcolor").text());
            $("#taxPointWin").show();
            $(".window-mask").show();
        },

        closeTaxPoint: function () {
            $("#invoiceAlready").addClass("hide");
            $(".requireshow,.requireshow2").addClass("hide");
            $("#taxPointWin,#receivablesBar2,.window-mask,#deleteWin").hide();
        },
        //收款操作
        sureReceivables: function (bt) {
            var btn = $(bt);
            btn.attr("disabled", true);
            $.ajax({
                type: "POST",
                url: "/ydz/salescheck/receivables",
                data: {
                    "checkingNo": $(".checkingNoCls").val(),
                    "recpayType": "1",
                    "recpayMoney": $("input[name='recpayMoney']").val(),
                    "recpayDate": new Date($("input[name='recpayDate']").val()),
                    "recpayName": $(".recpayNameShow").text(),
                    "accountPayee": $("input[name='recpayAccount']").val(),
                    "remarks": $("#remarks").val()
                },
                dataType: "json",
                success: function (callback) {
                    if (callback == "1") {
                        reload();
                        $("<div class='tips_contants'>").fadeIn(250).html("保存成功").delay(500).fadeOut(250).appendTo('body');
                        //cola.alert("保存成功",{title: "提示", level: "info"});
                        salescheckFun.closeReceivablesBar();
                        btn.attr("disabled", false);
                    } else {
                        btn.attr("disabled", false);
                        $("<div class='tips_contants'>").fadeIn(250).html("收款失败").delay(500).fadeOut(250).appendTo('body');
                        salescheckFun.closeReceivablesBar();
                    }
                },
                error: function () {
                    btn.attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("收款失败").delay(500).fadeOut(250).appendTo('body');
                }
            })
        },
        drawBillWithNoReceive: function () {
            salesCheckObj.typeCode = "";//初始化
            salesCheckObj.settingClass = $("#navCondition").find(".smcolor").attr("data-s");//初始化
            $("#fuwuTitle").text("创建费用分类");
            $("#pricezg").val("");
            $(".requireshow,.requireshow2").addClass("hide");
            $("#categoryDesc").text($("#navCondition").find(".smcolor").text());
            $("#taxPointWin").show();

        },

        //详情部分
        showOrderDetail: function (obj) {
            var url = "/ydz/salescheck/salesCheckDetail?orderNo=" + $(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
            showMessageDialog(url, "", "84%", "100%", true);
        },
        //关闭详情窗口
        closeRightWin: function () {
//                $("#rightWin").hide();
            $(".window-mask").hide();
            $("#msgwindow").css({left: "100%"}).removeClass("activ");
        }
    };
</script>

</body>
</html>
