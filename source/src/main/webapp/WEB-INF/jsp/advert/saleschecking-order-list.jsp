<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>销售对账单列表</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">

    <style>
        .ydz_select_menu2 {
            max-height: 210px;
        }

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

        @media only screen and (max-width: 1280px) {
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

        input,
        textarea {
            outline: none;
        }

        .conTbText .datagrid-header td,
        .conTbText .datagrid-body td,
        .conTbText .datagrid-footer td {
            border-width: 0;
        }

        .conTbText .datagrid-header td,
        .conTbText.datagrid-body td,
        .conTbText .datagrid-footer td {
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

        .datagrid-header .datagrid-cell {
            height: 40px;
            line-height: 40px;
        }

        .datagrid-header,
        .datagrid-td-rownumber {
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

        .btn-primary:hover,
        .btn-primary:focus,
        .btn-primary:active,
        .btn-primary.active,
        .open .dropdown-toggle.btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
        }

        .datagrid-header td,
        .datagrid-body td,
        .datagrid-footer td {
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

        .datagrid-header-row,
        .datagrid-row {
            height: 30px;
            line-height: 30px;
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

        .datagrid-cell a:hover,
        .datagrid-cell a:visited,
        .datagrid-cell a:link {
            color: #4284d9;
            text-decoration: none;
        }

        .nav-tabs > li > a {
            color: #3f3e3e;
            border: none;
        }

        .nav-tabs,
        .nav-tabs > li.smcolor > a,
        .nav-tabs > li.smcolor > a:hover,
        .nav-tabs > li.smcolor > a:focus {
            border: none;
            font-size: 14px;
        }

        .nav-tabs > li.smcolor > a,
        .nav-tabs > li.smcolor > a:hover,
        .nav-tabs > li.smcolor > a:focus {
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
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/cola-ui/clipboard.min.js?v=bd70fd596a"></script>
    <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    <style>
        .conTbText .datagrid-header td,
        .conTbText .datagrid-body td,
        .conTbText .datagrid-footer td {
            border-width: 0;
        }

        .conTbText .datagrid-header td,
        .conTbText.datagrid-body td,
        .conTbText .datagrid-footer td {
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

        .datagrid-header .datagrid-cell {
            height: 40px;
            line-height: 40px;
        }

        .datagrid-header,
        .datagrid-td-rownumber {
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

        .btn-primary:hover,
        .btn-primary:focus,
        .btn-primary:active,
        .btn-primary.active,
        .open .dropdown-toggle.btn-primary {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
        }

        .datagrid-header td,
        .datagrid-body td,
        .datagrid-footer td {
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

        .datagrid-header-row,
        .datagrid-row {
            height: 30px;
            line-height: 30px;
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

        .datagrid-cell a:hover,
        .datagrid-cell a:visited,
        .datagrid-cell a:link {
            color: #4284d9;
            text-decoration: none;
        }

        .nav-tabs > li > a {
            color: #3f3e3e;
            border: none;
        }

        .nav-tabs,
        .nav-tabs > li.smcolor > a,
        .nav-tabs > li.smcolor > a:hover,
        .nav-tabs > li.smcolor > a:focus {
            border: none;
            font-size: 14px;
        }

        .nav-tabs > li.smcolor > a,
        .nav-tabs > li.smcolor > a:hover,
        .nav-tabs > li.smcolor > a:focus {
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

        .ydz_select_menu,
        .ydz_select_menu2 {
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

        .ydz_select_menu li,
        .ydz_select_menu2 li {
            line-height: 21px;
            padding-bottom: 0 !important
        }

        .open .ydz_select_menu,
        .open .ydz_select_menu2 {
            display: block
        }

        .open .ydz_select_a {
            border-bottom: 5px solid #786f6f;
            border-top: transparent;
        }

        .ydz_select_menu li a,
        .ydz_select_menu2 li a {
            clear: both;
            text-align: left;
            color: #323232;
            display: block;
            font-size: 12px;
            line-height: 21px;
            padding: 3px 5px;
            white-space: nowrap
        }

        .ydz_select_menu2 li a:hover,
        .ydz_select_menu li a:hover {
            background: none repeat scroll 0 0 #5897fb;
            color: #FFF;
            text-decoration: none
        }

        .payment,
        .scan {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            height: 624px;
            width: 660px;
            background: #fbfbfb;
            z-index: 9999;
            margin-left: -330px;
            margin-top: -320px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        .online,
        .downline {
            background: #fff;
            height: 140px;
            width: 360px;
            margin: 100px auto 90px;
            text-align: center;
            cursor: pointer;
        }

        .downline {
            margin: 0 auto;
        }

        .online:hover .online_one,
        .downline:hover .online_one {
            display: none;
        }

        .online:hover .onhover,
        .downline:hover .onhover {
            display: block;
        }

        .online_one > p {
            margin-top: 20px;
            height: 80px;
            line-height: 80px;
            text-align: center;
            font-size: 20px;
            color: #000;
        }

        .onhover,
        .online_one {
            height: 100%;
            width: 100%;
        }

        .onhover {
            display: none;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        .onhover > p {
            height: 100px;
            line-height: 100px;
            text-align: center;
            font-size: 20px;
            color: #00ae41;
        }

        .particulars li {
            font-size: 14px;
            line-height: 50px;
            color: #000;
        }

        .particulars li span:last-child {
            float: right;
            color: #999;
        }

        .scan_one {
            text-align: center;
            margin-top: 150px;
        }

        .scan_one button:nth-child(1) {
            border: none;
            background: #4284d9;
            line-height: 30px;
            margin-right: 10px;
            width: 120px;
            text-align: center;
            border-radius: 5px;
            color: #fff;
        }

        .scan_one button:nth-child(2) {
            border: none;
            background: #00ae41;
            line-height: 30px;
            width: 120px;
            text-align: center;
            border-radius: 5px;
            color: #fff;
        }

        .paymentscan {
            display: none;
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
            $(".ydz_select_menu2").on("click", "li", function () {
                $(this).closest(".ydz_select").find("input[type='hidden']").val($(this).find("a").attr("rel"));
                $(this).closest(".ydz_select").find("span").text($(this).find("a").text());
                if ($(this).find("a").text() === "预存款账户") {
                    var pr1 = Number($("input[name='recpayMoney']").val()) - Number(accounting.unformat($(".yucunKuanShow").val()));
                    if (pr1 >= 0) {
                        $(" .yucunkuan2").html("余额不足").show();
                        yucunKuanSubmit = false;
                    } else {
                        $(".yucunkuan2").html("");
                        yucunKuanSubmit = true;
                    }
                    $(".yucunkuanCls").text("余额：" + $(".yucunKuanShow").val()).show();

                } else {
                    yucunKuanSubmit = true;
                    $(".yucunkuanCls,.yucunkuan2").text("").hide();
                }

            })

            //            ydz/salescheck/getComPartnerBalanceMoney
            //            partnerKey


        })
    </script>
</head>

<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="CashSale"
     style="width: 660px;height: 340px;box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2); background: #fff; position: absolute;z-index: 9999;top:50%;left:50%;margin-left:-330px;margin-top:-170px;display: none;">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #ccc; padding-left: 15px;">
        对账单金额注释
    </div>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeFormua()"><img src="../../images/close_user.png" alt="订单流程图"></span>
    <div style="margin: 20px auto 40px"><img src="../../images/formula_1.png" alt="销售方对账单注释"></div>
    <div style="text-align: center;border:1px solid #ccc; border-radius: 3px;font-size: 12px;color: #ccc; height: 30px; width: 120px;line-height: 30px;margin: 0 auto;cursor: pointer; "
         onclick="closeFormua()">我知道了
    </div>
</div>
<div id="receivablesBar2"
     style="/* padding-top: 5px; */top: 50%;left: 50%;margin-left: -420px;margin-top: -230px;position: absolute;width: 780px;height: 460px;display: none;">
    <span style="position: absolute;top: 12px;left:10px;display: block;font-size: 18px;height:30px;/* width: 30px; */">开发票</span>
    <p style="position:relative;font-weight: 100;text-align: center;height: 50px;font-size: 14px;color: #999;margin: 0px auto;padding: 10px 20px;border-bottom: 1px solid #e4e4e4;line-height: 30px;"
       id="">
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="salescheckFun.closeReceivablesBar()"><img src="../../images/close_user.png" alt="点击关闭"></span>

    <div style="width: 550px;margin: 0 auto;position: relative">
        <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

        <div style="width:552px;margin:35px auto;">
            <div style="width:235px;display: inline-block;position:relative;margin-right: 62px;text-align: right;margin-bottom: 30px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">账单金额：</label>
                <input class="form-ydz" type="text" readonly name="totalPrice" data-s='select' style="width:120px;    text-align: right;line-height: 18px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">

                <input type="hidden" name="cecheckingNo">
            </div>

            <div style="width: 235px;display: inline-block;text-align: right;height: 34px;line-height: 34px;margin-bottom: 30px;margin-left:15px;">

                <label style="float: left;float: left;font-size: 14px;color: #333;width: 70px;font-weight: normal;">发票类型：</label>
                <%--<input type="text" style="padding: 5px;width: 120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">--%>

                <div class="ydz_select ">
                    <div class="">
                        <span class="ydz_select_txt "></span>
                        <input type="hidden" value="" name="invoiceType">
                        <a class="ydz_select_a" href="javascript:;"></a>
                    </div>
                    <ul class="ydz_select_menu billList">
                    </ul>
                </div>


            </div>
            <div style="width:235px;display: inline-block;position:relative;margin-right: 62px;text-align: right;margin-bottom: 30px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">发票金额：</label>
                <input type="number" name="invoiceAmount" data-s='select' style="width:120px;    text-align: right;
    padding: 5px;height: 34px;line-height:18px;border: 1px solid #f2f2f2;border-radius: 3px;">

            </div>
            <div style="width:235px;display: inline-block;position:relative;text-align: right;margin-bottom: 30px;height: 34px;line-height: 34px;margin-left:15px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">发票号码：</label>
                <input type="text" name="invoiceNo" data-s='select' style="width:120px;    text-align: right;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">

            </div>
            <div style="width:235px;display: inline-block;position:relative;margin-right: 62px;text-align: right;margin-bottom: 30px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">发票签收：</label>
                <input type="text" placeholder="发票接收人" name="recipient" data-s='select' style="width:120px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
            </div>

            <div style="width: 235px;display: inline-block;height: 34px;position:relative;line-height: 34px;margin-bottom: 30px;text-align: right;margin-left:15px;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">开票日期：</label>
                <input id="invoiceDate" type="text"
                       style="padding: 5px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                <span onclick="$('#invoiceDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
            </div>
            <div style="width:550px;display: inline-block;position:relative;text-align: right;margin-bottom: 30px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">差额说明：</label>
                <input type="text" name="ceremarks" data-s='select' style="width:435px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
            </div>
            <div style="width:550px;display: inline-block;position:relative;text-align: right;margin-bottom: 30px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">发票内容：</label>
                <input type="text" placeholder="" name="invoiceContent" data-s='select' style="width:435px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
            </div>
        </div>


    </div>
    <div style="clear: both;position:absolute;bottom:25px;right: 115px;">
        <span style="font-size: 14px;color:red;display: inline-block;vertical-align: middle">开票后不可修改，请谨慎填写</span>
        <button type="button" class="btn " onclick="salescheckFun.closeReceivablesBar(this)"
                style="margin-left:15px;width:100px;">取消
        </button>
        <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;"
                onclick="salescheckFun.sureBill(this)">确认
        </button>
    </div>
</div>
<div id="receivablesBar"
     style="/* padding-top: 5px; */top: 50%;left: 50%;margin-left: -420px;margin-top: -320px;position: absolute;width: 760px;height: 640px;display: none;">
    <span style="position: absolute;top: 12px;left:20px;display: block;font-size: 16px;height:30px;color:#333;">收款</span>
    <p style="position:relative;font-weight: 100;text-align: center;height: 50px;font-size: 14px;color: #999;margin: 0px auto;padding: 10px 20px;border-bottom: 1px solid #e4e4e4;line-height: 30px;"
       id="orderTitWin"><label style="
    font-weight: normal;
">账单周期：</label>&nbsp;
        <span class="orderCycleCls"></span>
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="salescheckFun.closeReceivablesBar(1)"><img src="../../images/close_user.png" alt="点击关闭"></span>


    <div style="width: 560px;margin: 0 auto;position: relative">
        <div style="position: absolute;right: 0px;top:55px;font-size: 12px;color:#ff5505;" class="hide"
             id="invoiceAlready" did="已开票">已开票
        </div>
        <div style="display: inline-block;vertical-align: middle;width: 184px;">
            <img class="comImgTran"
                 style="margin: 38px auto 38px;float:left;width: 50px;height: 50px;border-radius: 40px;border:1px solid #ccc;padding:3px;"
                 src="/images/share.png"><em class="partnerShortnameCls"
                                             style="margin-top: 45px;margin-left: 10px;display: inline-block;width: 110px;overflow: hidden;font-weight: 700;text-overflow: ellipsis;height: 20px;word-wrap: break-word;font-size: 14px;"></em><br>
            <span
                    class="contactNameCls" style="
    margin-left: 10px;
    color: #999;
"></span>
        </div>

        <div style="display: inline-block;width: 164px;text-align: center;">
            <label style="
    font-weight: normal;
    color: #999;
    font-size: 14px;
">订单笔数：</label>&nbsp;<span class="detailNumCls" style="
    font-size: 20px;
    width: 80px;
    display: inline-block;
    vertical-align: middle;
    overflow: hidden;
    text-align: left;
    margin-top:-5px;
"></span>
        </div>

        <div style="display: inline-block;width: 204px;">
            <label style="
    font-weight: normal;
    color: #999;
    font-size: 14px;
">账单金额：</label>&nbsp;<span class="totalPriceCls" style="
    font-size: 20px;
    width: 120px;
    display: inline-block;
    text-align: left;
    vertical-align: middle;
    overflow: hidden;
    margin-top:-5px;
"></span>
        </div>
        <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

        <div style="margin:24px auto;width: 270px;">
            <p style="text-align: right;height: 40px;line-height: 40px;">
                <label style="float: left;font-weight: normal;color: #999;font-size: 14px;">预收金额：</label>
                <span class="depositRequestedCls" style="
    font-size: 20px;
    color: #666;
"></span>
            </p>
            <p style="text-align: right;clear: both;height: 40px;line-height: 40px;">
                <label style="float: left;font-weight: normal;color: #999;font-size: 14px;">应收金额：</label>
                <span class="receivablesMoneyShow" style="
    color: #ff5505;
    font-size: 20px;
"></span>
                <input type="hidden" class="receivablesMoneyCls">
                <input type="hidden" class="checkingNoCls">
                <input type="hidden" class="yucunKuanShow">
            </p>
        </div>

        <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

        <div style="width:552px;margin:35px auto;">
            <div style="width:215px;display: inline-block;position:relative;margin-right: 117px;text-align: right;margin-bottom: 20px;height: 34px;line-height: 34px;">
                <label style="float: left;font-size: 14px;color: #333;font-weight: normal;">实收金额：</label>
                <input placeholder="0.00" type="number" name="recpayMoney" data-s='select'
                       onkeyup="salescheckFun.recpayKeyUp(this)" style="width:120px;    text-align: right;line-height: 18px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;" placeholder="0.00">
                <span class="recpayDiscount bigCls hide"
                      style="position: absolute;top:30px;right:0;font-size: 12px;"></span>
            </div>

            <div style="width: 215px;display: inline-block;text-align: right;height: 34px;line-height: 34px;margin-bottom: 22px;">

                <label style="float: left;float: left;font-size: 14px;color: #333;width: 70px;font-weight: normal;">收款人：</label>
                <%--<input type="text" style="padding: 5px;width: 120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">--%>

                <div class="ydz_select ">
                    <div class="">
                        <span class="ydz_select_txt recpayNameShow"></span>
                        <input type="hidden" value="" name="recpayName">
                        <a class="ydz_select_a" href="javascript:;"></a>
                    </div>
                    <ul class="ydz_select_menu recpayNameList">
                    </ul>
                </div>


            </div>
            <div style="width:215px;display: inline-block;position:relative;text-align: right;height: 34px;margin-right: 117px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">收款账户：</label>
                <%--<input type="text" style="padding: 5px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">--%>
                <div class="ydz_select ">
                    <div class="">
                        <span class="ydz_select_txt recpayAccountCls">选择收款账户</span>
                        <input type="hidden" value="" name="recpayAccount">
                        <a class="ydz_select_a" href="javascript:;"></a>
                    </div>
                    <ul class="ydz_select_menu2 recpayAccountList">

                    </ul>
                </div>
                <span class="yucunkuanCls  " style="position: absolute;top:30px;left:105px;font-size: 12px;">
                </span>
            </div>
            <div style="width: 215px;display: inline-block;height: 34px;position:relative;line-height: 34px;margin-bottom: 22px;text-align: right;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">收款日期：</label>
                <input id="recpayDate" name="recpayDate" type="text"
                       style="padding: 5px 5px 5px 10px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                <span onclick="$('#recpayDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
            </div>
            <div style="text-align: right;height: 34px;line-height: 34px;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">附加说明：</label>
                <textarea rows="2" id="remarks" name="remarks"
                          style="resize: none;padding: 5px;border: 1px solid #f2f2f2;border-radius: 3px;width: 455px;height:68px;"></textarea>
            </div>
        </div>


    </div>
    <div style="    position: absolute;
    bottom: 70px;
    right: 105px;" class="telSelMesWin  prettyck"><input id="telSelMes"  type="checkbox" name="ck"
                                                         value=""><label for="telSelMes"
                                                                         style="vertical-align:middle;font-weight: normal;">发送消费扣款短信通知到客户联系人<i
            class="telNameShow telColor"></i>手机<i class="telNumberShow telColor"></i></label></div>
    <div style="clear: both;position:absolute;bottom:30px;right: 105px;">
        <button type="button" class="btn " onclick="salescheckFun.closeReceivablesBar(1)" style="width:100px;">取消
        </button>
        <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;"
                onclick="salescheckFun.sureReceivables(this)"
                id="orderMake">添加收款记录
        </button>
        <span class="yucunkuan2" style=" position: absolute;
                    top: 35px;
                    right: 5px;
                    color: red;"></span>
    </div>
</div>
<div class="payment" style="background:#f5f5f7;">
    <p style="height:50px;background:#4284d9;border-radius: 5px 5px 0 0 ;line-height:50px;"><span
            style="font-size:16px;margin-left:22px;color:#fff;">支付选择</span><i onclick="salescheckFun.close(1)"
                                                                              class="iconfont_new"
                                                                              style="color:#fff;float:right;font-size:30px;margin-right:10px;">
        &#xe6a0;</i></p>
    <div class="online">
        <div class="online_one">
            <p>微信在线收款</p>
            <span style="color:#666;font-size:14px;">客户对该笔【待收款对账单】进行在线支付</span>
        </div>
        <div onclick="salescheckFun.openscan()" class="onhover">
            <p>微信在线收款</p>
            <button style="line-height:40px;background:#00ae41;color:#fff;border:none;width:100%;border-radius:0 0 5px 5px;text-align:center;">
                选择
            </button>
        </div>
    </div>
    <div class="downline">
        <div class="online_one">
            <p>线下收款记录</p>
            <span style="color:#666;font-size:14px;">将该笔【待收款对账单】的线下收款做记录</span>
        </div>
        <div onclick="salescheckFun.openReceivablesBar()" class="onhover">
            <p style="color:#4284d9;">线下收款记录</p>
            <button style="line-height:40px;background:#4284d9;color:#fff;border:none;width:100%;border-radius:0 0 5px 5px;text-align:center;">
                选择
            </button>
        </div>
    </div>
</div>
<div class="scan">
    <P style="height:168px;background:#00ae41;border-radius:5px 5px 0 0;overflow:hidden;position:relative;">
        <i onclick="salescheckFun.close(2)" class="iconfont_new"
           style="color:#fff;position:absolute;font-size:30px;right:10px;">&#xe6a0;</i>
        <img style="height:105px;width:105px;border-radius:50%;display:block;margin:20px auto 10px;"
             src="../../images/phonescan.png"
             alt="">
        <span style="display:block;text-align:center;font-size:18px;color:#fff;">扫码付款</span>

    </P>
    <div class="particulars">
        <ul style="width:60%;margin:50px auto;">
            <li><span>客户</span><span class="message">上海仁石科技</span></li>
            <li><span>账单金额</span><span class="message">100.00</span></li>
            <li><span>预收金额</span><span class="message">200.00</span></li>
            <li><span>应收金额</span><span class="message" style="color:#eb6877;font-size:18px;">300.00</span></li>
        </ul>
        <div class="scan_one">
            <button id="copy_right" data-clipboard-text="" onclick="salescheckFun.copy()">复制收款链接</button>
            <button
                    onclick="salescheckFun.immediately()">立即扫码收款
            </button>
        </div>
    </div>
    <div class="paymentscan">
        <div class="qrCodeDataMid" style="height:140px;width:140px;margin:50px auto;"></div>
        <p style="margin-left:170px;"><span
                style="background:#ee8e52;display:inline-block;height:42px;width:42px;border-radius:50%;"><i
                class="iconfont_new"
                style="font-size:50px;color:#fff;position:relative;top:-14px;left:-4px;">&#xe6b5;</i></span>
            <span
                    style="position:relative;top:-28px;left:20px;color:#000;">付款完成前，请不要关闭此支付验证窗口</span>
        </p>
    </div>
</div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition">

        <li style="position:relative;" data-s="07" onclick="cgx(this);" class="order2 smcolor"><a href="#">待收款对账单</a>
        </li>
        <li style="position:relative;" data-s="08" onclick="cgx(this);" class=" order3"><a href="#">已收款对账单</a></li>
        <li style="position:relative;" data-s="" onclick="cgx(this);" class="order"><a href="#">全部对账单</a></li>
        <li class="block"></li>
    </ul>

    <div id="CashFormula" style="color: #ff9900;
             position: absolute;
               left: 420px;
    top: 25px;
            cursor: pointer;" onclick="showFormua()">查看金额公式>>
    </div>


    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:200px;padding:0 5px 0 0">
                    <select class="form-control input-xs" id="clientsDp" placeholder="选择客户">
                    </select>
                </div>
                <div class="col-xs-2 w1200alt" style="padding:0 5px ">
                    <select class="form-control input-xs" id="contacterDp">
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
                                <input type="text" style="" class="form-control" id="startTime" data-format="yyyy-MM-dd"
                                       placeholder="制单时间">
                                <span onclick="$('#startTime').datetimepicker('show');" class="" style="
    position: absolute;
    right: 30px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                <span
                                        style="
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
                                <input type="text" style="" class="form-control" id="endTime" data-format="yyyy-MM-dd"
                                       placeholder="制单时间">
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

                <div class="col-xs-2" style="width: 242px;">

                    <div class="input-group">
                        <input type="text" class="form-control"
                               onkeypress="if(event.keyCode == 13) {reload('');return false;}" id="searchKey"
                               placeholder="输入对账单号、项目名称、业务内容"
                               style="      width: 212px;
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
    <%--color: #b3b3b3;">&#xe6df;--%>
					<%--</span>--%>
                    </div>
                </div>
                <button type="button" class="btn btn-primary  searchBtn "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>
                <button type="button" class="btn  btn-warning pull-right drawBillBtn hide"
                        style="font-size:12px;height:30px;line-height:1;"
                        onclick="salescheckFun.drawBillWithNoReceive()">开票
                </button>
                <button type="button" class="btn btn-primary pull-right receivableBtn hide"
                        style="margin-right:10px;height:30px;line-height:1;"
                        onclick="salescheckFun.buttondown()">收款
                </button>


            </div>
        </form>
    </div>

</div>

<div data-options="region:'center'" style="border:none !important;padding:10px;padding-top: 0;">

    <table id="order" style="height: 100%" class="easyui-datagrid" data-options="remoteSort:false,fit:true,
           nowrap:true,singleSelect:false,checkOnSelect:false">
    </table>
</div>

<div id="pageToolbar"
     style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">


</div>

<script>
    //    var pageAllUrl = "ydz/salesorder/listPageSalesOrder";// 本页面请求url2
    var contactListUrl = "/system/partner/listPartnerContacter";// 获取联系人下拉框
    var pageAllUrl = "/ydz/salescheck/listPageSalesCheckingOrder";// 本页面请求url2
    $(function () {
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
                var rto2=function () {
                    var dtn=  '<option value="">全部联系人</option>';
                    return dtn;
                }
                $("#contacterDp").html(rto2()).select2({minimumResultsForSearch: Infinity});
                $("#clientsDp").on("change", function () {
                    changeClients(this)
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
        var recpayNewList = [
            {
                id: "00",
                text: "现金"
            }, {
                id: "01",
                text: "微信钱包"
            }, {
                id: "02",
                text: "支付宝"
            }, {
                id: "03",
                text: "工商银行"
            }, {
                id: "04",
                text: "建设银行"
            }, {
                id: "05",
                text: "中国银行"
            }, {
                id: "06",
                text: "农业银行"
            }, {
                id: "07",
                text: "其他系统转移"
            }, {
                id: "08",
                text: "预存款账户"
            }, {
                id: "09",
                text: "其他"
            }, {
                id: "10",
                text: "微信在线"
            }];
        $(".recpayAccountList").html(returnopt(recpayNewList, 4));
        $(".billList").html(returnopt(globeConfigData.billList, 4));
    });
    function changeClients(o) {
        $.ajax({
            url: contactListUrl,
            dataType: "json",
            data: {"partnerKey": $(o).val()},
            timeout: "8000",
            success: function (data) {
                var rto = function () {
                    var dtn = "";
                    if (data.length > 1) {
                        dtn = '<option value="">全部联系人</option>';
                    }
                    for (var i = 0; i < data.length; i++) {
                        var dt = data[i];

                        dtn += '<option value="' + dt.contacterId + '">' + dt.contacterName + '</option>';
                    }
                    return dtn;
                }
                $("#contacterDp").html(rto());
                $("#contacterDp").select2({

                    minimumResultsForSearch: Infinity
                });
            },
            error: function () {
            }
        })
    }
    function hideMsgWin() {
        $("#receivablesBar").hide();
    }
    // 为了兼容老页面一些跳转 处理自动跳转到草稿箱
    function cgx(o) {
        hideMsgWin();
        $(o).addClass("smcolor").siblings().removeClass("smcolor");
        reload();
    }
    function hideMsg() {
        $(".window-mask").hide();
        $("#msgwindow").css({left: "100%"}).removeClass("activ");
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
    // 收款
    function arrFunAll() {

        var arrclo = [];
        arrclo.push({field: 'ck', checkbox: true});
        arrclo.push({
            field: 'recpayDate', formatter: function (value, row) {
                return '<a data-id=' + row.salescheckingNo + ' data-did=' + row.industryId + ' href=\'##\' onclick="salescheckFun.showOrderDetail(this)">' + value + '</a>';
            }, width: 90, align: 'center', title: '收款日期'
        });
        arrclo.push({field: 'salescheckingNo', width: 100, align: 'center', title: '对账单号'});
        arrclo.push({field: 'createTime', width: 150, align: 'center', title: '制单时间'});
        arrclo.push({field: 'orderCycle', width: 190, align: 'center', title: '订单周期'});
        arrclo.push({field: 'partnerShortname', width: 90, align: 'center', title: '客户简称'});
        arrclo.push({field: 'contactName', width: 90, align: 'center', title: '联系人'});
        arrclo.push({field: 'caseDesc', width: 150, align: 'center', title: '项目名称'});
        arrclo.push({field: 'orderCountValue', width: 70, align: 'center', title: '订单(明细)'});
        arrclo.push({
            field: 'price', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '订单总金额'
        });
        arrclo.push({
            field: 'taxPrice', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '税款'
        });
        arrclo.push({
            field: 'totalPrice', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '对账总金额'
        });
        arrclo.push({
            field: 'depositRequested', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '预收总金额'
        });
        arrclo.push({
            field: 'receivablesMoney', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '应收总金额'
        });


        arrclo.push({
            field: 'paidUp', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '实收总金额'
        });
        arrclo.push({
            field: 'balanceMoney', width: 80, align: 'center', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '差额'
        });
        arrclo.push({field: 'accountPayee', width: 80, align: 'center', title: '收款账号'});
        arrclo.push({field: 'recpayName', width: 70, align: 'center', title: '收款人'});
        arrclo.push({field: 'balanceRemarks', width: 70, align: 'center', title: '附加说明'});


        arrclo.push({
            field: 'invoiceAmount', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '开票金额'
        });
        arrclo.push({field: 'invoiceDate', width: 80, align: 'center', title: '开票日期'});
        return arrclo;
    }
    // 全部账单
    function arrALLBill() {

        var arrclo = [];
        arrclo.push({field: 'ck', checkbox: true});

        arrclo.push({
            field: 'salescheckingNo', formatter: function (value, row) {
                return '<a data-id=' + row.salescheckingNo + ' data-did=' + row.industryId + ' href=\'##\' onclick="salescheckFun.showOrderDetail(this)">' + value + '<span style="margin-left:26px;">详情</span></a>';
            }, width: 190, align: 'center', title: '对账单号'
        });
        arrclo.push({field: 'createTime', width: 150, align: 'center', title: '制单时间'});
        arrclo.push({field: 'orderCycle', width: 190, align: 'center', title: '订单周期'});
        arrclo.push({field: 'partnerShortname', width: 90, align: 'center', title: '客户简称'});
        arrclo.push({field: 'contactName', width: 90, align: 'center', title: '联系人'});
        arrclo.push({field: 'caseDesc', width: 150, align: 'center', title: '项目名称'});
        arrclo.push({field: 'orderCountValue', width: 70, align: 'center', title: '订单(明细)'});
        arrclo.push({
            field: 'price', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '订单总金额'
        });
        arrclo.push({
            field: 'taxPrice', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '税款'
        });
        arrclo.push({
            field: 'totalPrice', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '对账总金额'
        });
        arrclo.push({
            field: 'depositRequested', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '预收总金额'
        });
        arrclo.push({
            field: 'receivablesMoney', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '应收总金额'
        });


        arrclo.push({
            field: 'paidUp', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '实收总金额'
        });
        arrclo.push({field: 'recpayDate', width: 90, align: 'center', title: '收款日期'});
        arrclo.push({
            field: 'balanceMoney', width: 80, align: 'center', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '差额'
        });
        arrclo.push({field: 'accountPayee', width: 80, align: 'center', title: '收款账号'});
        arrclo.push({field: 'recpayName', width: 70, align: 'center', title: '收款人'});
        arrclo.push({field: 'balanceRemarks', width: 70, align: 'center', title: '附加说明'});


        arrclo.push({
            field: 'invoiceAmount', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '开票金额'
        });
        arrclo.push({field: 'invoiceDate', width: 80, align: 'center', title: '开票日期'});
        arrclo.push({field: 'orderStatusDesc', width: 80, align: 'center', title: '状态'});
        return arrclo;
    }
    // 待收款
    function arrShoukuan() {
        var arrclo = [];
        arrclo.push({field: 'ck', checkbox: true});
        arrclo.push({
            field: 'salescheckingNo', width: 190, align: 'center', formatter: function (value, row) {
                return '<a data-id=' + row.salescheckingNo + ' data-did=' + row.industryId + ' href=\'##\' onclick="salescheckFun.showOrderDetail(this)">' + value + '<span style="margin-left:26px;">详情</span></a>';
            }, title: '对账单号'
        });
        arrclo.push({field: 'createTime', width: 150, align: 'center', title: '制单时间'});
        arrclo.push({field: 'orderCycle', width: 190, align: 'center', title: '订单周期'});
        arrclo.push({field: 'partnerShortname', width: 90, align: 'center', title: '客户简称'});
        arrclo.push({field: 'contactName', width: 90, align: 'center', title: '联系人'});
        arrclo.push({field: 'caseDesc', width: 150, align: 'center', title: '项目名称'});
        arrclo.push({field: 'orderCountValue', width: 70, align: 'center', title: '订单(明细)'});
        arrclo.push({
            field: 'price', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '订单总金额'
        });
        arrclo.push({
            field: 'taxPrice', width: 80, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '税款'
        });
        arrclo.push({
            field: 'totalPrice', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '对账总金额'
        });
        arrclo.push({
            field: 'depositRequested', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '预收总金额'
        });
        arrclo.push({
            field: 'receivablesMoney', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '应收总金额'
        });
        arrclo.push({
            field: 'invoiceAmount', width: 85, align: 'right', formatter: function (value, row) {
                return accounting.formatNumber(value, 2);
            }, title: '开票金额'
        });
        arrclo.push({field: 'invoiceDate', width: 80, align: 'center', title: '开票日期'});
        return arrclo;
    }

    function reload() {
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        var arrclo = [], url = "", pageSize = 30, pageList = [30, 40];
        if (status == "07") {
            arrclo = arrShoukuan();
        } else if (status == "08") {
            arrclo = arrFunAll();
        } else {
            arrclo = arrALLBill();
        }

        url = pageAllUrl;
        pageSize = 30;
        pageList = [30, 40];

        if (status == "") {
            $(".drawBillBtn").addClass("hide");
            $(".receivableBtn").addClass("hide");
            $('#order').datagrid({
                url: url,
                fit: true,
                onLoadSuccess: onLoadSuccess,
                pagination: true,
                pageSize: pageSize,
                pageList: pageList,
                columns: [arrclo],
                queryParams: {
                    "partnerKey": $('#clientsDp').val(),
                    "searchKey": $('#searchKey').val(),
                    "contacterId": $('#contacterDp').val(),
                    "endTime": $('#endTime').val(),
                    "startTime": $('#startTime').val()
                }
            });
        } else {
            if (status == "07") {
                $(".drawBillBtn").removeClass("hide");
                $(".receivableBtn").removeClass("hide");
            } else if (status == "08") {
                $(".drawBillBtn").removeClass("hide");
                $(".receivableBtn").addClass("hide");
            } else {
                $(".drawBillBtn").addClass("hide");
                $(".receivableBtn").addClass("hide");
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
                    "parameter": status,
                    "contacterId": $('#contacterDp').val(),
                    "partnerKey": $('#clientsDp').val(),
                    "searchKey": $('#searchKey').val(),
                    "endTime": $('#endTime').val(),
                    "startTime": $('#startTime').val()

                }
            });
        }

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
        var sum = '对账总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice">0.00</span>';
        var sumRecev = '应收总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice2">0.00</span>';
        var sumPaidUp = '实收总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice3">0.00</span>';
        var chaMon = '差额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice4">0.00</span>';
        var odcount = '对账单数(笔)：<span style="color: red;margin-right: 15px;" id="order2PagerNum">0</span>';
        var status = $("#navCondition").find(".smcolor").attr("data-s");
        if (status == "07") {
            $("#pageToolbar").html(heji + sum + sumRecev + odcount);
        } else {
            $("#pageToolbar").html(heji + sum + sumRecev + sumPaidUp + chaMon + odcount);
        }


        if (data.rows.length > 0) {
            $("#order2PagerNum").text(data.bottomInfo.orderCount);
            var sumr = data.bottomInfo.sumReceivablesMoney;
            var sumPair = data.bottomInfo.sumPaidUp;
            var char = Number(sumPair) - Number(sumr);

            $("#orderPrice").text(accounting.formatNumber(data.bottomInfo.sumTotalPrice, 2));
            $("#orderPrice2").text(accounting.formatNumber(data.bottomInfo.sumReceivablesMoney, 2));
            $("#orderPrice3").text(accounting.formatNumber(data.bottomInfo.sumPaidUp, 2));
            $("#orderPrice4").text(accounting.formatNumber(char, 2));


        } else {
            $("#order2PagerNum").text(0);
            $("#orderPrice").text("0.00");
            $("#orderPrice2").text("0.00");
            $("#orderPrice3").text("0.00");
            $("#orderPrice4").text("0.00");
            $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
        }
    }

</script>
<script>
    function showFormua() {
        $("#CashSale").css({display: 'block'})
        $(".window-mask").show();
    }
    function closeFormua() {
        $("#CashSale").css({display: 'none'})
        $(".window-mask").hide()
    }
    var param = getRequestParam.GetRequest();
    var type = param.type || "";
    var yucunKuan = 0, yucunKuanSubmit = true;
    var salescheckFun = {
        recpayKeyUp: function (b) {
            var $this = $(b), $va = parseFloat($(".receivablesMoneyCls").val());
            if (isNaN($this.val())) {
                $(".recpayDiscount").addClass("smallCls");
                $(".recpayDiscount").removeClass("hide").html("非法数字");
                //                    Number(totalPrice).toFixed(2);
                //                    parseFloat($("input.unitPriceChange")[rindex].value);
                $("#preferentialText").text(accounting.formatNumber($("#preferentialVal").val(), 2));
                return;
            }
            if (isNaN($va)) {
                $("<div class='tips_contants'>").fadeIn(250).html("应收金额含有非法数字").delay(3000).fadeOut(250).appendTo('body');
                return;
            }
            var pr = Number($this.val()) - Number($(".receivablesMoneyCls").val());

            if (pr > 0) {
                $(".recpayDiscount").removeClass("smallCls");
                $(".recpayDiscount").addClass("bigCls");
                $(".recpayDiscount").removeClass("hide").html("+" + accounting.formatNumber(pr, 2));
            } else if (pr == 0) {
                $(".recpayDiscount").addClass("hide");
            } else {
                $(".recpayDiscount").addClass("smallCls");
                $(".recpayDiscount").removeClass("bigCls");
                $(".recpayDiscount").removeClass("hide").html(accounting.formatNumber(pr, 2));
            }


            if ($("input[name='recpayAccount']").val() == "08") {
                var pr1 = Number($this.val()) - Number(accounting.unformat($(".yucunKuanShow").val()));
                if (pr1 > 0) {
                    $(" .yucunkuan2").html("余额不足").show();
                    yucunKuanSubmit = false;
                } else {
                    $(".yucunkuan2").html("");
                    yucunKuanSubmit = true;
                }

            }
        },
        // 打开支付选择
        buttondown: function () {
            var selectItems = $('#order').datagrid('getChecked');
            if (selectItems.length == 0) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择一笔需要收款的对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            if (selectItems.length > 1) {
                $("<div class='tips_contants'>").fadeIn(250).html("不可同时收款多笔对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            $(".payment").show();
        },
        // 在线付款
        openscan: function () {
            var selectItems = $('#order').datagrid('getChecked');
            $(".scan").show();
            $(".message").eq(0).text(selectItems[0].partnerShortname);
            $(".message").eq(1).text("￥" + accounting.formatNumber(selectItems[0].totalPrice, 2));
            $(".message").eq(2).text("￥" + accounting.formatNumber(selectItems[0].depositRequested, 2));
            $(".message").eq(3).text("￥" + accounting.formatNumber(selectItems[0].receivablesMoney, 2));
            $.ajax({
                type: "GET",
                url: "/ydz/salescheck/payUrltoShare?checkingNo=" + selectItems[0].salescheckingNo + "&transmit=6",
                dataType: "json",
                success: function (dt) {
                    if (dt.code == 1) {
                        $("#copy_right").attr("data-clipboard-text", dt.payUrltoShare)
                    }
                }
            })

        },
        // 复制链接
        copy: function () {
            var clipboard = new Clipboard('#copy_right');
            clipboard.on('success', function (e) {
                $("<div class='tips_contants'>").fadeIn(250).html("复制成功，让对方通过电脑打开这个链接去付款").delay(3000).fadeOut(250).appendTo('body');
            });

        },
        // 扫码付款
        immediately: function () {
            var selectItems = $('#order').datagrid('getChecked');
            $(".particulars").hide();
            $(".paymentscan").show();
            $.ajax({
                type: "POST",
                url: "/wechat/pay/paykey",
                data: {"salescheckingNo": selectItems[0].salescheckingNo},
                dataType: "json",
                success: function (dat) {
                    if (dat.code == 1) {
                        $.ajax({
                            type: "GET",
                            url: "/wechat/pay/doPay?key=" + dat.paykey,
                            dataType: "json",
                            success: function (dt) {
                                if (dt.status == "1") {
                                    $('.qrCodeDataMid').empty();
                                    $('.qrCodeDataMid').qrcode({width: 140, height: 140, text: dt.url});
                                    var polling = setInterval(function () {
                                        $.ajax({
                                            type: "GET",
                                            url: "/wechat/pay/polling?tradeNo=" + dat.tradeNo,
                                            dataType: "json",
                                            success: function (dt) {
                                                if (dt.code == 1) {
                                                    clearInterval(polling)
                                                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(3000).fadeOut(250).appendTo('body');
                                                    setTimeout(function () {
                                                        location.reload();
                                                    }, 3000);
                                                }
                                            }
                                        })
                                    }, 5000)

                                } else {
                                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(3000).fadeOut(250).appendTo('body');
                                }
                            }
                        })
                    } else {
                        $("<div class='tips_contants'>").fadeIn(250).html(dat.msg).delay(3000).fadeOut(250).appendTo('body');
                    }

                }
            })

        },
        //打开收款窗口
        openReceivablesBar: function () {
            //当前时间 nowDate
            //                model.set("receiptpayment.recpayDate",new Date());
            //                $("#recpayDate").val();
            $(".payment").hide();
            var selectItems = $('#order').datagrid('getChecked');
            var totalPrice = 0;
            var flag = false;
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
                $("input[name='recpayMoney']").val(selectObj.receivablesMoney).trigger("change");
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
        //关闭收款窗口
        close: function (type) {
            if (type == 1) {
                $(".payment").hide();
            }
            if (type == 2) {
                $(".scan").hide();
                $(".payment").show();
                $(".particulars").show();
                $(".paymentscan").hide();
            }

        },
        closeReceivablesBar: function (type) {
            if (type == 1) {
                $(".payment").show();
            }
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
        //收款操作
        sureReceivables: function (bt) {
            if (!yucunKuanSubmit) {
                $.mytoast({text: "余额不足，请联系供应商充值"});
                return;
            }

            if ($("input[name='recpayMoney']").val() == "") {
                $.mytoast({text: "请填写实收金额"});
                return;
            }
            if ($("input[name='recpayAccount']").val() == "") {
                $.mytoast({text: " 请选择收款账户"});
                return;
            }

            var btn = $(bt);
            btn.attr("disabled", true);
            $.ajax({
                type: "POST",
                url: "/ydz/salescheck/receivables",
                data: {
                    "checkingNo": $(".checkingNoCls").val(),
                    "recpayType": "1",
                    "isSms": $("#telSelMes").prop("checked") ? "1" : "0",
                    "recpayMoney": $("input[name='recpayMoney']").val(),
                    "recpayDate": new Date($("input[name='recpayDate']").val()),
                    "recpayName": $(".recpayNameShow").text(),
                    "accountType": $("input[name='recpayAccount']").val(),
                    "accountPayee": $(".recpayAccountCls").text(),
                    "remarks": $("#remarks").val()
                },
                dataType: "json",
                success: function (callback) {
                    if (callback == "1") {
                        reload();
                        $("<div class='tips_contants'>").fadeIn(250).html("保存成功").delay(500).fadeOut(250).appendTo('body');
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
        //打开开票窗口
        drawBillWithNoReceive: function () {
            var items = $('#order').datagrid('getChecked');
            if(items.length>1){
                $("<div class='tips_contants'>").fadeIn(250).html("不可同时针对多笔对账单开票").delay(3000).fadeOut(250).appendTo('body');
                return;
            }
            var checkingNos;
            var totalPrice = 0;
            var flag = false;
            var times = 0;
            var partnerKey = "";
            var invoiced = false;

            $(items).each(function (i, element) {
                if (times == 0) {
                    partnerKey = element.partnerKey;
                } else {
                    //判断是否同一用户
                    if (!(partnerKey == element.partnerKey)) {
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户的对账单").delay(3000).fadeOut(250).appendTo('body');
                        flag = true;
                        return false;
                    }
                }
                if (element.invoiceStatus == "1") {
                    flag = true;
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择你未开票的对账单").delay(3000).fadeOut(250).appendTo('body');
                    //cola.alert("请选择你未开票的对账单",{title: "提示", level: "warning"});
                    return false;
                }
                //
                if (element.invoiceDate != undefined && element.invoiceDate != "") {
                    invoiced = true;
                }
                if (checkingNos == null) {
                    checkingNos = element.salescheckingNo;
                } else {
                    checkingNos = checkingNos + "," + element.salescheckingNo;

                }
                totalPrice = totalPrice + element.totalPrice;
                times++;
            });
            if (flag) {
                return false;
            }
            if (invoiced) {
                $("<div class='tips_contants'>").fadeIn(250).html("本单已开票，不能重开！").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            if (checkingNos == null) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择你需要开票的对账单").delay(3000).fadeOut(250).appendTo('body');
            } else {
                $("input[name='totalPrice']").val(totalPrice);
                $("input[name='cecheckingNo']").val(checkingNos);
                $("#receivablesBar2").show();
            }
        },
        //确认开票
        sureBill: function (bt) {
            var btn = $(bt);
            btn.attr("disabled", true);
            $.ajax({
                type: "POST",
                url: "/ydz/salescheck/drawBill",
                data: {
                    "invoiceNo": $("input[name='invoiceNo']").val(),
                    "invoiceContent": $("input[name='invoiceContent']").val(),
                    "recipient": $("input[name='recipient']").val(),
                    "remarks": $("input[name='ceremarks']").val(),
                    "checkingNo": $("input[name='cecheckingNo']").val(),
                    "invoiceDate": new Date($("#invoiceDate").val()),
                    "invoiceType": $("input[name='invoiceType']").val(),
                    "invoiceAmount": $("input[name='invoiceAmount']").val()
                },
                dataType: "json",
                success: function (callback) {
                    if (callback == "1") {
                        reload();
                        salescheckFun.closeReceivablesBar();
                        $("<div class='tips_contants'>").fadeIn(250).html("开票成功").delay(3000).fadeOut(250).appendTo('body');
                        btn.attr("disabled", false);
                    } else {
                        $("<div class='tips_contants'>").fadeIn(250).html("您已经开过票啦！").delay(500).fadeOut(250).appendTo('body');
                        btn.attr("disabled", false);
                    }
                },
                error: function () {
                    btn.attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("开票失败").delay(500).fadeOut(250).appendTo('body');
                }
            })
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
</script>

</body>

</html>