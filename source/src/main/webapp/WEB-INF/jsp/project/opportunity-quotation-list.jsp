<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>商机报价单查询列表</title>
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
            transform: translate(82px, 0);
        }

        .nav-tabs li:nth-child(3).smcolor ~ .block {
            transform: translate(195px, 0);
        }

        .nav-tabs li:nth-child(1) ~ .block {
            position: absolute;
            bottom: 3px;
            left: 10px;
            width: 70px;
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
            transform: translate(96px, 0);
        }

        .nav-tabs li:nth-child(4).smcolor ~ .block {
            transform: translate(249px, 0);
        }

        .nav-tabs li:nth-child(5).smcolor ~ .block {
            transform: translate(350px, 0);
        }

        .telColor {
            color: #ff9200
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=df96034f1e"></script>
    <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>
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
            right: 12px;
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
            width: 140px;
            z-index: 1000;
        }

        .select2-selection__rendered {
            color: #999 !important;
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
            max-height: 200px;
            padding: 10px 10px 0 10px;
            min-height: 100px;
            overflow: auto;
        }

        .ydz_select_menu_ul2 {
            height: 265px;
            overflow: auto;
        }

        .autoEdit {
            text-align: right;
            height: 30px;
            clear: both;
            margin-right: 10px;
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
    <script>
        var hideMenu = function () {
            $(".ydz_select2").removeClass("open");
            $(".ydz_select_menu").hide();
            $(document).unbind("mousedown", onBodyDown);
        }
        var onBodyDown = function (event) {
            if (!(event.target.id == "ydz_select_menu" || $(event.target).parents("#ydz_select_menu").length > 0)) {
                hideMenu();
            }
        }
        $(function () {


            var objSelMenu;// 临时保存页面共享下拉框的对象
//            $(document).bind('click', function () {
//                $(".ydz_select2").removeClass("open");
//                $(".ydz_select_menu").hide();
//            });
            $(".ydz_select2").on("click", function (e) {

                e.stopPropagation();

                var o = $(this).offset();
                var t = o.top + $(this).outerHeight();
                var l = o.left;
                $(".ydz_select_menu").css({
                    "display": "block",
                    "top": t,
                    "left": l,
                    "z-index": 1000
                });
                if ($(this).hasClass("open")) {
                    $(this).removeClass("open");
                    $(".ydz_select_menu").hide();
                    objSelMenu = null;
                    $(document).unbind("mousedown", onBodyDown);
                } else {
                    $(document).bind("mousedown", onBodyDown);
                    $(".ydz_select_menu").show();
                    objSelMenu = $(this);
                    $(this).addClass("open");
                }
            });
            $(".ydz_select_menu").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").attr("rel"));
                }
            })
            $(".ydz_select_menu_ul").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").attr("rel"));
                }
            })
            $(".autoEditOnce").on("click", function () {
                $("#autoEditOnceWin").show();
            })
            $(".autoEditTwice").on("click", function () {
                $("#menuTitle").text("添加自定义分类");
                $(".requireYdzMenu").hide();
                $("#modifyYdzMenuWin").show();
            })
            $(".autoEditWinClose").on("click", function () {
                $("#autoEditOnceWin,#modifyYdzMenuWin").hide();
            })
            $(".autoEditWinClose2").on("click", function () {
                $("#modifyYdzMenuWin").hide();
            })
            $(".closetranform").on("click", function () {
                $("#deleteYdzWin").hide();
            })
            $(".ydz_select_menu_ul2").on("click", "li>span", function (e) {
                $(".window-mask").show();
                if ($(this).attr("csid") == "d") {
                    $("#deleteYdzWin").css({display: 'block'});
                } else {
                    $("#menuTitle").text("修改自定义分类");
                    $(".requireYdzMenu").hide();
                    $("#modifyYdzMenuWin").css({display: 'block'});
                }
                e.stopPropagation();
            })
            $("#deleteYdzMenu").on("click", function () {
                var queryParams = {};
                $(o).attr("disabled", true);
                $.ajax({
                    url: "",
                    type: 'post',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    data: queryParams,
                    dataType: "json",
                    success: function (dt) {
                        $.mytoast({text: dt.msg});
                    }
                })
            })
            $("#saveYdzMenu").on("click", function () {
                var menu2 = $("#menu2").val();
                var categoryId = "", categoryDesc = "", url = "";
                if ($.trim(categoryDesc) == "") {
                    $(".requireYdzMenu").show().removeClass("hide");
                    return;
                }
                var queryParams = {
                    "categoryDesc": categoryDesc,
                    "categoryId": categoryId,
                };
                $(o).attr("disabled", true);
                $.ajax({
                    url: "",
                    type: 'post',
                    contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                    data: queryParams,
                    dataType: "json",
                    success: function (dt) {
                        $.mytoast({text: dt.msg});
                    }
                })
            })
        })
    </script>
</head>
<body class="easyui-layout" style="border:none !important;">


<div class="ydz_select_menu" id="ydz_select_menu">
    <ul class="ydz_select_menu_ul oppProcessList">

    </ul>
    <div class="autoEdit">
        <button type="button" class="btn ydzSelectCancel" style="width: 50px;padding: 3px 5px;">取消</button>
        <button type="button" class="btn searchBtn btn-primary"
                style="margin-left:15px;width: 50px;padding: 3px 5px;font-size:12px;" id="">确定
        </button>
    </div>
</div>
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition">

        <li style="position:relative;" data-s="0" onclick="cgx(this);" class="order2 smcolor"><a href="#">全部商机</a>
        </li>
        <li style="position:relative;" data-s="1" onclick="cgx(this);" class=" order3"><a href="#">我负责的</a></li>
        <li style="position:relative;" data-s="2" onclick="cgx(this);" class="order"><a href="#">我参与的</a></li>
        <li class="block"></li>
    </ul>

    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class=" row" style="margin:0;">
                <div class="col-xs-2" style="width:200px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="clientsDp" placeholder="选择客户">
                    </select>
                </div>
                <div class="col-xs-2 selectsale1" style="width:120px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="salesProcess" placeholder="全部销售代表">
                    </select>
                </div>
                <div class="col-xs-2 selectsale2" style="width:120px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>


                    <input type="text" style="" class="form-control ydz_select2" readonly name="项目类型"
                           placeholder="全部销售阶段"/><span class="ydz_select_a"></span>

                </div>
                <div class="col-xs-2 selectsale3" style="width:120px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="salesOppDp" placeholder="全部销售机会">
                    </select>
                </div>
                <div class="col-xs-2 w1200alt" style="padding:0 5px">
                    <select class="form-control input-xs" id="timeDp">
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-xs-2 w1200ipt150" style="padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="w1200input">
                                <input type="text" style="" class="form-control" id="startTime"
                                       data-format="yyyy-MM-dd" placeholder="订单日期">
                                <span onclick="$('#startTime').datetimepicker('show');" class="" style="
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
                                <input type="text" style="" class="form-control" id="endTime"
                                       data-format="yyyy-MM-dd" placeholder="订单日期">
                                <span onclick="$('#endTime').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-xs-2" style="width: 202px;padding:0 5px 0 0">

                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchKey" placeholder="商机概要" style="      width: 195px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">
                        <span class="input-group-btn iconfont_new w1200show searchBtn" style="        cursor: pointer;
    position: absolute;
    top: 2px;
    width: 20px;
    right: 8px;
    font-size: 20px;
    transform: rotate(-5deg);
    color: #b3b3b3;">&#xe6df;
					</span>
                    </div>
                </div>
                <button type="button" class="btn btn-primary w1200hide searchBtn "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>
                <button type="button" class="btn btn-primary pull-right receivableBtn "
                        style="margin-right:15px;height:30px;line-height:1;"
                        onclick="oppColumnFun.openReceivablesBar()">创建商机
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
<div id="pageToolbar"
     style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">


</div>

<script>
    var pageListSaleConUrl = "/ydz/salesorder/listSalesMan"; //销售代表下拉框
    var pageAllUrl = "/ydz/opportunity/listOpportunity";// 本页面请求url2
    var param = getRequestParam.GetRequest();
    var type = param.type || "";
    var yucunKuan = 0, yucunKuanSubmit = true;
    var oppColumnFun = {
        openReceivablesWin: function (id) {
            var turl = "/ydz/opportunity/forward-OpportQuotationDetail?oppoNo=" + id;
//            var turl="/ydz/opportunity/forward-updateOpportunity?oppoNo="+id;
            window.location.href = turl;
        },
        openReceivablesBar: function () {
            var turl = "/openPage?pageName=project_opportunity-add-update";
            window.location.href = turl;
            return;
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
                yucunKuan = 0, yucunKuanSubmit = true;
                $("#receivablesBar").show();
                //取出预存款用户信息
                $.ajax({
                    type: "POST",
                    url: "/ydz/salescheck/getComPartnerBalanceMoney",
                    data: {
                        "partnerKey": selectObj.partnerKey
                    },
                    dataType: "json",
                    success: function (callback) {
                        if (callback.code == "1") {
                            $(".yucunKuanShow").val(accounting.formatNumber(callback.balanceMoney, 2));
                            $(".telNameShow").text(callback.contacter.contacterName);
                            $(".telNumberShow").text(callback.contacter.tel1);
                        } else {
                            $(".yucunKuanShow").val("0.00");
                            $(".telNumberShow").text("");
                            $(".telNameShow").text("");
                        }
                    },
                    error: function () {
                    }
                })

            }

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
    var OppFun = {
        init: function () {

            this.saleManDp();
            this.saleOppDp();
        },
        saleManDp: function () {
            $.ajax({
                url: pageListSaleConUrl,
                dataType: "json",
                success: function (dt) {
                    var dtal2 = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    var returnopt3 = function () {
                        var opt = '<option  value="">全部销售代表</option>';
                        for (var i = 0; i < dtal2.length; i++) {
                            var dt = dtal2[i];
                            var dtn = "";
                            opt += '<option  value="' + dt.id + '">' + dt.text + '</option>';
                        }
                        return opt;
                    }
                    $("#salesProcess").html(returnopt3).select2({minimumResultsForSearch: Infinity});
                },
                error: function () {
                }
            })
        },
        saleOppDp: function () {

            var dtall = [
                {"id": "0", "text": "全部销售机会"},
                {"id": "1", "text": "我负责的商机"},
                {"id": "2", "text": "我参与的商机"}
            ]
            var returnopt2 = function () {
                var opt = "";
                for (var i = 0; i < dtall.length; i++) {
                    var dt = dtall[i];
                    var dtn = "";
                    opt += '<option  value="' + dt.id + '">' + dt.text + '</option>';
                }
                return opt;
            }
            $("#salesOppDp").html(returnopt2).select2({minimumResultsForSearch: Infinity});
        },


    }
    OppFun.init();
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
            } else if (type == 5) {
                opt += '<li><span class="prettyck"><input value="' + dt.id + '" type="checkbox"><label>' + dt.text + '</label></span></li>';
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
            field: 'oppoDesc', width: 250,  title: '商机概要',align: 'left',
            formatter: function (value, row) {
//                var r=row.caseDesc==""?"无概要":row.caseDesc;
                return '<a data-id=' + row.oppoNo + ' data-did=' + row.industryId + ' href=\'##\' onclick=openDt(this)>' + value + '</a>' + '<div class="namebd"><span class="namebdsml"></span></div>';
            }
        });
        arrclo.push({field: 'participantEmployeeName', width: 200,  title: '跟进记录', formatter: function (value, row) {

            return '<a>' + row.participantEmployeeName + '</a>' + '<div class="namebd"><span title="'+row.latestChat+'" class="namebdsml">' + row.latestChat + '</span></div>';
        }});
        arrclo.push({
            field: 'partnerShortname', width: 140, align: 'center', title: '客户', formatter: function (value, row) {

                return '<div>' + row.partnerShortname + '</div>' + '<div class="namebd"><span class="namebdsml">' + row.contactName + '</span></div>';
            }
        });
        arrclo.push({field: 'salesName', width: 100, align: 'center', title: '销售代表'});
        arrclo.push({
            field: 'totalPrice', width: 100, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '订单金额'
        });
        arrclo.push({field: 'quotCount', width: 90, align: 'center', title: '报价次数'});
        arrclo.push({
            field: 'upToNow', width: 90, align: 'center', formatter: function (value, row) {
                return value+'&nbsp;天';
            },title: '开始距今'});
        arrclo.push({field: 'createTime', width: 150, align: 'center', title: '制单时间'});
        arrclo.push({field: 'oppoNo', width: 150, align: 'center', title: '商机单号'});
//        ',        formatter: function (value, row) {
//        return '<a data-id=' + row.salescheckingNo + ' data-did=' + row.industryId + ' href=\'##\' onclick="oppColumnFun.showOrderDetail(this)">'+value+'</a>';
//    },
        return arrclo;
    }
    function reload() {
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        var arrclo = [],cked=[]; url = "", pageSize = 30, pageList = [30, 40];
        arrclo = oppColumn();
        url = pageAllUrl;
        $(".oppProcessList input[type=checkbox]:checked").each(function(){ //由于复选框一般选中的是多个,所以可以循环输出选中的值
            cked.push($(this).val());
        });

        var statusClone="",orderSectionIn=cked.join(","),salesId=$("#salesProcess").val();// 销售代表
        if (status == "0") {
            $(".selectsale2").removeClass("hide");
            $(".selectsale1").removeClass("hide");
            $(".selectsale3").removeClass("hide");
            statusClone= $("#salesOppDp").val();
        } else if (status == "1") {
            $(".selectsale2").removeClass("hide");
            $(".selectsale3").addClass("hide");
            $(".selectsale1").addClass("hide");
            statusClone="1";
            salesId="";
        } else {
            $(".selectsale3").addClass("hide");
            $(".selectsale2").removeClass("hide");
            $(".selectsale1").removeClass("hide");
            statusClone="2";
        }
        $('#order').datagrid({
            url: url,
            fit: true,
            onLoadSuccess: onLoadSuccess,
            pagination: true,
            pageSize: pageSize,
            pageList: pageList,
            columns: [arrclo],
            queryParams: {
                "state": statusClone,//销售机会
                "partnerKey": $('#clientsDp').val(),
                "searchKey": $('#searchKey').val(),
                "endTime": $('#endTime').val(),
                "orderSectionIn": orderSectionIn,
                "salesId":salesId,
                "startTime": $('#startTime').val()

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
        var heji = '<span class="total_all">合计:</span>';
        var sum = '报价总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice">'+accounting.formatNumber(data.bottomInfo.sumTotalPrice,2)+'</span>';
        var odcount = '订单数(笔)：<span style="color: red;margin-right: 15px;" id="order2PagerNum">'+data.bottomInfo.orderCount+'</span>';
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        $("#pageToolbar").html(heji + sum + odcount);
        if (data.rows.length > 0) {

//            $("#order2PagerNum").text(data.bottomInfo.orderCount);
//            var sumr = data.bottomInfo.sumReceivablesMoney;
//            var sumPair = data.bottomInfo.sumPaidUp;
//            var char = Number(sumPair) - Number(sumr);
//            $("#orderPrice").text(accounting.formatNumber(data.bottomInfo.sumTotalPrice, 2));
//            $("#orderPrice2").text(accounting.formatNumber(data.bottomInfo.sumReceivablesMoney, 2));
//            $("#orderPrice3").text(accounting.formatNumber(data.bottomInfo.sumPaidUp, 2));
//            $("#orderPrice4").text(accounting.formatNumber(char, 2));
        } else {
            $("#order2PagerNum").text(0);
            $("#orderPrice").text("0.00");
            $("#orderPrice2").text("0.00");
            $("#orderPrice3").text("0.00");
            $("#orderPrice4").text("0.00");
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }
    $(function () {
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
        $(".oppProcessList").html(returnopt(salesProcess, 5));
        var dateObj = orderUtil.dpDateCompute("ld", 30);
        $('#recpayDate').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
            minView: 'month'
        });
        $('#recpayDate').val(new Date().Format("yyyy-MM-dd"));
        $('#invoiceDate').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
            minView: 'month'
        });
        $('#invoiceDate').val(new Date().Format("yyyy-MM-dd"));
        $('#startTime').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
            minView: 'month'
        }).on("click", function () {
            $("#startTime").datetimepicker("setEndDate", $("#endTime").val())
        });
        $('#endTime').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
            minView: 'month'
        }).on("click", function () {
            $("#endTime").datetimepicker("setStartDate", $("#startTime").val())
        });
        $("#startTime").val(dateObj.beforeDate);
        $("#endTime").val(dateObj.nowDate);
        $("#timeDp").html(returnopt(orderUtil.dateConfig, 2)).change(function () {
            var code = $(this).val().substring(0, 2);
            var num = $(this).val().substring(2, $(this).val().length);
            var dt = orderUtil.dpDateCompute(code, num);
            $("#startTime").val(dt.beforeDate);
            $("#endTime").val(dt.nowDate);
        });
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
            hideMenu();
            reload();
        })
        $(".ydzSelectCancel").click(function () {

            hideMenu();
        })

    });
</script>

</body>
</html>