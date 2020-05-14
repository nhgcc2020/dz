<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>项目合同新建/修改</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=95d4665fda">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">

    <style>
        h1, h2, h3, h4{
            font-weight:normal;
        }
        .w1200alt {
            width: 120px;
        }
        .datagrid-btable, .datagrid-btable tr{
            height: 39px;

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
            padding: 10px 4px;
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
        .input-icon-group {
            position: relative;
        }

        .select2-container--default .select2-selection--multiple .select2-selection__rendered {
            padding: 0 10px;
        }

        .select2-search__field {
            height: 29px;
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
        .control-label{
            margin-bottom: 6px;
        }
    </style>
    <%--下拉框样式--%>
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

        .ydz_select_a {
            width: 0;
            height: 0;
            border-left: 4px solid transparent;
            border-right: 4px solid transparent;
            border-top: 5px solid #786f6f;
            position: absolute;
            right: 8px;
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
    <%--固定头部用的样式--%>
    <style>
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
            z-index: 99;
            overflow: hidden;
        }

        .main {
            height: 100%;
        }

        .main {
            margin-top: 70px;
        }
    </style>
    <%--让表格支持无边框样式--%>
    <style>
        .datagrid-header td, .datagrid-body td, .datagrid-footer td {
            border-width: 0;
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

        .datagrid-cell-c2-cke {
            color: #ccc;
        }

        .datagrid-header-inner {
            background: #eff1f9;
        }
    </style>


    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=df96034f1e"></script>
    <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>
    <script src="/resources/easyui/jquery.Huploadify.js" charset="utf-8"></script>
    <script src="/resources/easyui/validate.min.js"></script>
    <link rel="stylesheet" type="text/css" href="/resources/easyui/uploadify.css">
    <style>
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

        /*上传附件的width设置*/
        /*.uploadify-progress{*/
        /*width:500px;*/
        /*}*/
        .uploadify-button {
            color: #fff !important;
        }

        .icon.percent:before {
            content: "%";
        }

        i.icon {
            right: -3px;
            position: absolute;
            text-align: center;
            top: 0;
        }

        .bigCls {
            color: #009900;
        }

        .smallCls {
            color: #ff9200;
        }

        .table-condensed {
            width: 100%;
        }

        #contractWin, #contractWin2, #contractWin3 {
            border: none;
            z-index: 99;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: fixed;
            display: none;
        }

        #deleteWin {
            border: none;
            z-index: 9999;
            width: 700px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition: all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: fixed;
            display: none;
        }

        .form-control[disabled], .form-control[readonly], fieldset[disabled] .form-control {
            cursor: default;
            background-color: #fff;
        }
    </style>

</head>
<body style="height:100%;position:relative;">
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:9;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.3;font-size: 1px;overflow: hidden;"></div>
<div id="autoEditOnceWin"
     style="    padding-top: 5px;
    left: 50%;
    position: fixed;
    /*margin-top:-175px;*/
    margin-left:-150px;
    width: 300px;
    height: 350px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
    >
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
    left: 50%;
 position: fixed;
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
    left: 50%;
position: fixed;
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
        id="deleteWin" style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -125px;
    margin-top: -108px;
    width: 330px;
    height: 217px;"
>
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
    cursor: pointer;" onclick="closeWin()"><i
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
            <button type="button" class="btn  btn-default" onclick="closeWin()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="deleteServLast(this)">确认
            </button>
        </div>
    </div>
</div>
<div id="contractWin"
     style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -240px;
    margin-top: -195px;
    width: 480px;
    height: 390px;">
</div>
<div id="contractWin2" style="padding-top:5px;top:50%;left:50%;margin-left:-300px; margin-top:-260px;
 width: 600px;height:520px;">
</div>
<div id="contractWin3" style="padding-top:5px;left:50%;margin-left:-300px;
 width: 600px;height:460px;">
</div>
<script type="text/html" id="tpl-addWin2">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        {{title}}</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeWin()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 2px;line-height: 30px;position: relative;text-align: right;">

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开票日期：</label>
                <div class="col-sm-8 " style="
    padding: 0;
    position: relative;
    width: 214px;
">
                    <input data-s="select" name="invoiceDate" style="width:214px;" value="{{invoiceDate}}" type="text"
                           data-provide="datetimepicker-inline" class="form-control" id="invoiceDate" placeholder="">
                    <span onclick="$('#invoiceDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 5px;
    top: 0;
"><i class="iconfont_new" style="font-size: 18px;"></i></span>
                </div>
            </div>

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开票金额：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input data-s='select' name="invoiceMoney" value="{{invoiceMoney}}"
                           style="width:214px;text-align: right" type="number" class="form-control" placeholder=""/>
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开票公司：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input data-s='select' name="invoiceCompany" value="{{invoiceCompany}}" style="width:214px;"
                           type="text" class="form-control" placeholder="请填写开票公司"/>
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开票内容：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input data-s='select' name="invoiceContent" value="{{invoiceContent}}" style="width:214px;"
                           type="text" class="form-control" placeholder="请填写开票内容"/>
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">

                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">票据类型：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;
margin-bottom: 10px;position: relative;width:214px;
"><span class="ydz_select_a"></span>
                    <input type="text" did="{{invoicetype}}" name="invoiceName" value="{{invoiceName}}"
                           id="invoiceNameSel"
                           class="form-control dropdown_input" data-toggle="dropdown" style="width:214px;"
                           readonly="readonly" placeholder="请选择">
                    <ul class="dropdown-menu dropdown_invoiceName dropdown_click" style="width:214px;">
                        <li did="1"><a href="##">增值税普通发票</a></li>
                        <li did="2"><a href="##">增值税专用发票</a></li>
                    </ul>
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">发票号码：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input style="width:214px;" name="invoiceNumber" value="{{invoiceNumber}}" type="text"
                           class="form-control" placeholder="发票号码"/>
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">客户签收人：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input style="width:214px;" name="signerName" type="text" value="{{signerName}}"
                           class="form-control" placeholder="请填写客户签收人"/>
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开票人：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input style="width:214px;" name="drawerName" value="{{drawerName}}" type="text"
                           class="form-control" placeholder="请填写开票人"/>
                </div>
            </div>

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">送票人：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input style="width:214px;" name="sendName" value="{{sendName}}" type="text" class="form-control"
                           placeholder="请填写送票人"/>
                </div>
            </div>

        </div>


        <div style="clear: both; padding-bottom: 10px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default" onclick="closeWin()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary " style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="saveTable1()">保存
            </button>
        </div>
    </div>
</script>
<script type="text/html" id="tpl-addWin3">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">{{title}}</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeWin()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 2px;line-height: 30px;position: relative;text-align: right;">

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">回款日期：</label>
                <div class="col-sm-8 " style="
    padding: 0;
    position: relative;
    width: 214px;
">
                    <input value="{{returnDate}}" name="returnDate" style="width:214px;" type="text"
                           data-provide="datetimepicker-inline" class="form-control" id="returnDate" placeholder="">
                    <span onclick="$('#returnDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 5px;
    top: 0;
"><i class="iconfont_new" style="font-size: 18px;"></i></span>
                </div>
            </div>

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">回款金额：</label>
                <div class="col-sm-8 pull-right" style="
    padding: 0;

">
                    <input data-s='select' name="returnMoney" value="{{returnMoney}}"
                           style="width:214px;text-align: right" type="number" class="form-control" placeholder=""/>
                </div>
            </div>
            <%--<label class="col-sm-4 control-label" style="--%>
            <%--padding-right: 15px;--%>
            <%--text-align: right;--%>
            <%--font-size: 14px;--%>
            <%--">服务内容：</label>--%>
            <%--<div class="col-sm-5 " style="--%>
            <%--margin-bottom: 10px;--%>
            <%--padding:0;--%>
            <%--">--%>
            <%--<input type="text" style="width:214px;" class="form-control" id="categoryDesc" placeholder="请填写服务内容" />--%>

            <%--</div>--%>

            <%--<div class="col-sm-3 hide requireMenu">服务不能为空</div>--%>


            <div class="form-group">

                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">回款类型：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;
margin-bottom: 10px;position: relative;width:214px;
"><span class="ydz_select_a"></span>
                    <input type="text" class="form-control dropdown_input" name="returnName" value="{{returnName}}"
                           did="{{returnType}}" data-toggle="dropdown" id="returnNameSel" style="width:214px;"
                           readonly="readonly" placeholder="请选择">
                    <ul class="dropdown-menu dropdown_click dropdown_payName" style="width:214px;">
                        <li did="R1"><a href="##">正常</a></li>
                        <li did="R2"><a href="##">坏账</a></li>
                        <li did="R3"><a href="##">货抵</a></li>
                    </ul>
                </div>
            </div>
            <div class="form-group">

                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">付款方式：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;position: relative;width:214px;
margin-bottom: 10px;
">
                    <span class="ydz_select_a"></span>
                    <input type="text" class="form-control dropdown_input" did="{{payType}}" name="payType"
                           value="{{payName}}"
                           data-toggle="dropdown" style="width:214px;" id="payNameSel" readonly="readonly"
                           placeholder="请选择">
                    <ul class="dropdown-menu dropdown_payType dropdown_click" style="width:214px;">

                    </ul>
                </div>
            </div>
            <div class="form-group">

                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">收款人：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;position: relative;width:214px;
margin-bottom: 10px;
">
                    <span class="ydz_select_a"></span>
                    <input type="text" class="form-control dropdown_input" value="{{payeeName}}" did="{{payeeId}}"
                           name="payeeName"
                           id="payeeNameSel" data-toggle="dropdown" style="width:214px;" readonly="readonly"
                           placeholder="请选择">
                    <ul class="dropdown-menu dropdown_click dropdown_shoukuan" style="width:214px;">

                    </ul>
                </div>
            </div>

        </div>


        <div style="clear: both; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default" onclick="closeWin()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="saveTable2()">保存
            </button>
        </div>
    </div>
</script>
<script type="text/html" id="tpl-listMon">
    {{each monList}}
    <div>
        <label class="col-sm-3 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">第{{$index+1}}期回款金额：</label>
        <div class="col-sm-1 " style="
    padding: 0;text-align: left;position: relative;width:70px;padding-right:10px;
margin-bottom: 10px;
"><input type="text" value="{{$value.hkMoney}}" onkeyup="recpayKeyUpHk(this)" class="form-control hkMoney"
         placeholder=""><i class="percent icon"></i>
        </div>
        <div class="col-sm-1 " style="
      padding: 0;
    text-align: center;
    position: relative;
    width: 110px;
    margin-bottom: 10px;
"><span class="money2">{{$value.money2}}</span>元
        </div>
        <label class="col-sm-3 control-label" style="
    padding-right: 15px;
    text-align: right;
    padding-left: 0;
    font-size: 14px;
    width: 100px;
">回款日期：</label>
        <div class="col-sm-3 " style="
    padding: 0;text-align: left;position: relative;
margin-bottom: 10px;
"><input data-s="select" value="{{$value.hkDate2}}" type="text" data-provide="datetimepicker-inline"
         class="form-control hkDate2" id="hkDate{{$index}}" placeholder="">
            <span onclick="$('#hkDate{{$index}}').datetimepicker('show');" class="" style="
    position: absolute;
    right: 5px;
    top: 0;
"><i class="iconfont_new" style="font-size: 18px;"></i></span>
        </div>
    </div>
    {{/each}}
</script>
<script type="text/html" id="tpl-addWin">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="fuwuTitle">{{title}}</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeWin()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 0;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-3 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">合同签约总额：</label>
                <div class="col-sm-8 " style="
    padding: 0;
    text-align: left;
    position: relative;
    width: 214px;
"><span class="receivablesMoneyCls">{{qyMoney}}</span>元
                </div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;position: relative">
                <label class="col-sm-3 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">合同实际总额：</label>
                <div class="col-sm-3 " style="
    padding: 0;
    position: relative;
    width: 214px;
"><input data-s='select' value="{{sjMoney}}" style="width:214px;text-align: right" type="number"
         onkeyup="recpayKeyUp(this)" class="form-control" id="sjMoney" placeholder="请填写回款金额"/></div>
                <div class="col-sm-2  recpayDiscount bigCls hide" style="text-align:left;font-size: 12px;"></div>
            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;position: relative">
                <label class="col-sm-3 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">计划回款期数：</label>
                <div class="col-sm-4 " style="
    padding: 0;text-align: left;position: relative;width:214px;
margin-bottom: 10px;
">
                    <span class="ydz_select_a"></span>
                    <input type="text" value="{{num}}" class="form-control dropdown_input" data-toggle="dropdown"
                           style="width:214px;"
                           id="hkSelectStage" readonly placeholder="请选择">
                    <ul class="dropdown-menu dropdown_clickMore" style="width:214px;">
                        <li did="1"><a href="##">1</a></li>
                        <li did="2"><a href="##">2</a></li>
                        <li did="3"><a href="##">3</a></li>
                        <li did="4"><a href="##">4</a></li>
                        <li did="5"><a href="##">5</a></li>
                        <li did="6"><a href="##">6</a></li>
                        <li did="7"><a href="##">7</a></li>
                        <li did="8"><a href="##">8</a></li>
                        <li did="9"><a href="##">9</a></li>
                        <li did="10"><a href="##">10</a></li>
                    </ul>
                </div>
            </div>

            <div class="form-group dropdown-money-list" style="     background: #fafafa;
    display: inline-block;
    padding: 10px 0 0;
    width: 100%;
    position: relative;
    overflow: auto;
    height: 130px;
    margin: 0 auto 20px;">


                {{ include 'tpl-listMon' $value}}


            </div>


            <div class="form-group" style="height: 30px;line-height: 30px;position: relative">
                <label class="col-sm-3 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">计划提醒人员：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;position: relative;
margin-bottom: 10px;width:430px;
">
                    <select type="text" multiple="multiple" readonly class="form-control" id="tixinPerson"
                            placeholder="请选择">
                    </select>
                </div>
            </div>


        </div>


        <div style="clear: both; padding-bottom: 10px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default" onclick="closeWin()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="saveTable()">保存
            </button>
        </div>
    </div>
</script>
<script type="text/html" id="tpl-attach">
    {{each attachments}}
    <div class="uploadify-queue-item">
        <div class="cancel"><a class="delfilebtn" onclick="delfilebtn(this,'{{$value.fileId}}')" href="javascript:;">删除</a><a
                class="downfilebtn" href="/ydz/contract/download-attachment?fileId={{$value.fileId}}">下载</a></div>
        <span class="up_filename">{{$value.fileName}}</span>
    </div>
    {{/each}}
</script>
<div
        style="    padding: 0 50px 0 50px;" class="main"
>
    <div class="fixheader">
        <button type="button" class="btn btn-primary copyMain " style="width:90px;margin:4px 8px 10px 0px">保存
        </button>
        <button type="button" class="btn  cancelOpp"
                style="font-size:14px;height:30px;margin:5px 8px 10px 20px;background:#fff;color:#7e92ab;padding:0;">
            <i class="iconfont_new " style="font-size:26px;position:relative;top:4px;"></i>取消
        </button>


    </div>

    <form class="" name="projectForm" id="projectForm" role="form" style="" action="#">
        <section style="
    padding: 20px;width:1180px;
    padding-bottom: 0;
    /*background: #f8f8fc;*/
    min-height: 100px;
">
            <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-bottom: 40px;">基本信息</h1>
            <div style="width:80%;margin:0 auto;">


                <div style="width: 40%; display: inline-block;">
                    <div class="form-group">

                        <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">客户</label>
                        <div class="" style="">
                            <select class="form-control input-xs" id="clientsDp" data-rule="required" placeholder="请选择">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">

                        <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">联系人</label>
                        <div class="" >
                            <select type="text" class="form-control" id="contactSel"
                                    placeholder="请选择">
                            </select>
                        </div>
                    </div>


                    <div class="form-group">

                        <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">开始日期</label>
                        <div class=" ">

                            <div class="">
                                <div class="input-icon-group">
                                    <div class="" style="width:100%">
                                        <input type="text" style="" autocomplete="off" class="form-control"
                                               id="startDate"
                                               data-format="yyyy-MM-dd" placeholder="请选择">
                                        <span onclick="$('#startDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 5px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                        </input>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">结束日期</label>
                        <div class=" " style="">

                            <div class="">
                                <div class="input-icon-group">
                                    <div class="" style="width:100%">
                                        <input type="text" style="" data-rule="required" autocomplete="off"
                                               class="form-control" id="endDate"
                                               data-format="yyyy-MM-dd" placeholder="请选择">
                                        <span onclick="$('#endDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 5px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                        </input>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <%----%>
                        <%--<label class="col-sm-2 control-label" style="--%>
                        <%--padding-right: 15px;--%>
                        <%--text-align: right;--%>
                        <%--font-size: 14px;--%>
                        <%--">项目地址：</label>--%>
                        <%--<div class="col-sm-10 " style="--%>
                        <%--">--%>
                        <%--<input type="text" style="" class="form-control" name="address" placeholder="请填写项目活动具体地址"/>--%>
                        <%--</div>--%>
                    </div>
                    <div class="form-group">


                        <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">关联报价</label>
                        <div class="" style="position: relative" onclick="glContractFun();">
                            <%--&#xe6a5;--%>
                            <input class="form-control input-xs" name="oppoNo" id="oppoNo" readonly placeholder="请选择">
                            <span class="iconfont_new" style="    font-size: 20px;
    position: absolute;
    top: 2px;
    color: #4284d9;
    right: 4px;">&#xe6eb;</span>
                        </div>


                    </div>

                </div>

                <div style="width: 40%;vertical-align:top;display: inline-block;float: right;">
                    <div class="form-group">


                        <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">合同名称</label>
                        <div class=" " style="
">
                            <input type="text" style="" class="form-control  " id="contractDesc" name="contractDesc"
                                   placeholder="请填写合同名称"/>

                        </div>

                    </div>
                    <div class="form-group">


                        <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">合同金额(元)</label>
                        <div class=" " style="
">
                            <input type="text" style="" class="form-control " name="contractMoney"
                                   placeholder="请填写合同金额"/>

                        </div>
                    </div>

                    <div class="form-group">


                        <label class=" control-label" style="
            padding-right: 15px;
            text-align: right;
            font-size: 14px;
            ">项目类型</label>
                        <div class="" style="position: relative">
                            <%--<select class="form-control input-xs " id="projectType" placeholder="请选择">--%>
                            <%--</select>--%>
                            <input type="hidden" name="oppoTypeHid">
                            <input type="text" style="" class="form-control ydz_select2" readonly name="projectTypeDesc"
                                   placeholder="请选择"/><span class="ydz_select_a"></span>
                        </div>


                    </div>
                    <div class="form-group">


                        <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">销售代表</label>
                        <div class="" style="">
                            <select class="form-control input-xs" id="saleManDp" placeholder="请选择">
                            </select>
                        </div>

                        <%----%>
                        <%--<label class="col-sm-2 control-label" style="--%>
                        <%--padding-right: 15px;--%>
                        <%--text-align: right;--%>
                        <%--font-size: 14px;--%>
                        <%--">项目地址：</label>--%>
                        <%--<div class="col-sm-10 " style="--%>
                        <%--">--%>
                        <%--<input type="text" style="" class="form-control" name="address" placeholder="请填写项目活动具体地址"/>--%>
                        <%--</div>--%>
                    </div>
                </div>


            </div>
        </section>

        <section style="
    padding: 20px;width:1180px;
    margin-bottom: 10px;
    padding-bottom: 50px;
    padding-top:0;
    min-height: 100px;
">
            <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-top:30px;
    margin-bottom: 40px;">合同信息</h1>
            <div style="width:80%;margin:0 auto;">

                <div style="width: 40%; display: inline-block;">
                    <div class="form-group">
                        <label class="control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">签约日期</label>
                        <div class=" " style="">

                            <div class="">
                                <div class="input-icon-group">
                                    <div class="" style="width:100%">
                                        <input type="text" style="" autocomplete="off" class="form-control"
                                               id="signDate"
                                               data-format="yyyy-MM-dd" placeholder="请选择">
                                        <span onclick="$('#signDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 5px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                        </input>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">客户签约人</label>

                        <input class="form-control input-xs" name="partenerSigner" placeholder="请填写客户签约人">
                    </div>


                </div>
                <div style="width: 40%;vertical-align:top;display: inline-block;float: right;">

                    <div class="form-group">
                        <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">合同编号</label>
                        <div class="" style="">
                            <input class="form-control input-xs" name="contractNo" readonly>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">我方签约人</label>
                        <div class=" " style="
">
                            <select type="text" readonly style="" class="form-control" id="ourSigner"
                                    placeholder="请选择">
                            </select>

                        </div>
                    </div>


                </div>

                <div class="form-group">
                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">合同附件</label>
                    <div class="" style="">


                        <%--<div id="queue"></div>--%>
                        <%--<input id="attachFile" name="attachFile" type="file" multiple="true">--%>


                        <div id="attachFile"></div>


                    </div>
                </div>

            </div>
        </section>
        <div style="display: none;"><input type="submit" id="subMain">提交</div>
    </form>

    <section style="
    padding: 10px 20px;
    margin-bottom: 20px;
    background: #f8f8fc;
    min-height: 100px;
">
        <div class="hd" style="    margin-bottom: 15px;
    position: relative;
    display: flex;">
            <h1 style="
    flex: 1;
    font-size: 16px;
">回款计划</h1>
            <a style="color: #4e8ae6;cursor: pointer" class="addWin1"><span class="iconfont_new">&#xe6a1;</span>添加计划</a>
        </div>

        <table id="createjhOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [jhColumn()],
          data:globDataGridjh" class="easyui-datagrid" style="width:100%;height:auto;">
        </table>


    </section>

    <%--开票记录--%>
    <section style="
    padding: 10px 20px; margin-bottom: 20px;
    background: #f8f8fc;
    min-height: 100px;
">
        <div class="hd" style="    margin-bottom: 15px;
    position: relative;
    display: flex;">
            <h1 style="
    flex: 1;
    font-size: 16px;
">开票记录</h1>
            <a style="color: #4e8ae6;cursor: pointer" class="addWin2"><span class="iconfont_new">&#xe6a1;</span>添加记录</a>
        </div>

        <table id="createkpOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [kpColumn()],
          data:globDataGridkp" class="easyui-datagrid" style="width:100%;height:auto;">
        </table>


    </section>
    <%--回款记录--%>
    <section style="
  padding: 10px 20px;
 margin-bottom: 20px;
    background: #f8f8fc;
    min-height: 100px;
">
        <div class="hd" style="    margin-bottom: 15px;
    position: relative;
    display: flex;">
            <h1 style="
    flex: 1;
    font-size: 16px;
">回款记录</h1>
            <a style="color: #4e8ae6;cursor: pointer" class="addWin3"><span class="iconfont_new">&#xe6a1;</span>添加记录</a>
        </div>

        <table id="createhkOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [hkColumn()]" class="easyui-datagrid" style="width:100%;height:auto;">
        </table>


    </section>


</div>
<script>
    var globDataGridjh =
        [];
    var globDataGridhk =
        [];

    var globDataGridkp =
        [];

    var shoukuanPerson = "";// 收款人只查询一次
    var tixinPerson = "";// 提醒人只查询一次
    var dropData = {hkMoney: "", money2: "", hkDate2: ""};
    var globejhDt = {};
    globejhDt.num = 3;  // 初始化比例3期
    globejhDt.salesMan = {};  // 初始化
    globejhDt.kpbz = -1;  // 开票修改标志
    globejhDt.hkbz = -1;  // 回款修改标志
    globejhDt.payType = [
        {id: "1", text: "现金"},
        {id: "2", text: "银行转账"},
        {id: "3", text: "信用卡"},
        {id: "4", text: "支付宝"},
        {id: "5", text: "微信钱包"},
        {id: "6", text: "其他"}
    ];
    globejhDt.payName = ["",
        "现金",
        "银行转账",
        "信用卡",
        "支付宝",
        "微信钱包",
        "其他"
    ];
    globejhDt.invoiceName = ["",
        "增值税普通发票",
        "增值税专用发票"
    ];
    globejhDt.returnName = [];
    globejhDt.returnName['R1'] = '正常';
    globejhDt.returnName['R2'] = '坏账';
    globejhDt.returnName['R3'] = '货抵';

    globejhDt.monList = [
        {hkMoney: "", money2: "", hkDate2: ""},
        {hkMoney: "", money2: "", hkDate2: ""},
        {hkMoney: "", money2: "", hkDate2: ""}
    ];// hkmoney 比例   money2 金额     hkDate2 回款日期
    var contractNo = '${contractNo}';
    //    页面入口处
    function delfilebtn(o, id) {
        console.log("del");
        console.log($(o).closest(".uploadify-queue-item").html());
        $.ajax({
            url: "/ydz/contract/deletefile?fileId=" + id,
            dataType: "json",
            success: function (data) {
                $(o).closest(".uploadify-queue-item").fadeOut();
            }
        });
    }
    $(function () {
        var HuploadifyObj = $('#attachFile').Huploadify({
            auto: true,
            fileTypeExts: '*.*',
            multi: true,
            fileSizeLimit: 50000,
            removeTimeout: 2000,
            showUploadedSize: true,
            uploader: '/ydz/contract/fileUpload',
            onUploadStart: function (file) {
                console.log(file.name + '开始上传');
            },
            onUploadComplete: function (file, jsondt) {
            },
            onUploadSuccess: function (file, num, jsondt) {
                var $fi = $('#fileupload_' + num + '_' + file.index).find('.downfilebtn');
                try {
                    var did2 = eval($fi.attr("did"))[0];
                    var url = "/ydz/contract/download-attachment?fileId=" + did2;
                    $fi.attr({"href": url});
                } catch (e) {

                }
                $('#fileupload_' + num + '_' + file.index).find('.delfilebtn').off().on("click", function () {
                    var did = eval($(this).attr("did"))[0];
                    delfilebtn(this, did);
                })
            },
            onUploadError: function (file, num, jsondt) {
                console.log(file.name + '上传完成');
                console.log(jsondt);
                $('#fileupload_' + num + '_' + file.index).addClass("uploadify-error");
                $('#fileupload_' + num + '_' + file.index).find('.uploadify-progress-bar').css('width', '1px');
                $('#fileupload_' + num + '_' + file.index).find('.data').html('-上传出错');
                $('#fileupload_' + num + '_' + file.index).find('.downfilebtn').hide();
            },
            onQueueComplete: function (queueData) {
            }
        });

        if (contractNo == null || contractNo == "") {
            noOppoFun();   //新建路由
        } else {
            // 修改路由
            $.ajax({
                url: "/ydz/contract/getOneContractProjectAllInfo?contractNo=" + contractNo,
                dataType: "json",
                success: function (dt) {
                    if (dt.code == 1) {
                        oppoFun(dt);
                    } else {
                        $(".copyMain").attr("disabled", true);
                    }
                },
                error: function () {
                }
            })
        }
        function noOppoFun() {
            $("#createhkOrder").datagrid("loadData",[]);
            $("#createjhOrder").datagrid("loadData",[]);
            $("#createkpOrder").datagrid("loadData",[]);
            $.ajax({
                url: "/ydz/contract/getContractNo",
                dataType: "json",
                success: function (data) {
                    $("input[name='contractNo']").val(data);
                    HuploadifyObj.settings("formData", {contractNo: data});
                }
            });
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
                    $("#ourSigner").select2({
                        placeholder: "请添加签约人",
                        minimumResultsForSearch: Infinity,
                        data: dtall
                    }).val("").trigger("change");
                    var returnopt = function (data) {
                        var opt = "";
                        for (var i = 0; i < data.length; i++) {
                            var dt = data[i];
                            opt += '<li did="' + dt.employeeId + '"><a href="javascript:;">' + dt.realName + '</a></li>';
                        }
                        return opt;
                    }
                    tixinPerson = dt;
                    shoukuanPerson = returnopt(dt);
                    var dtall = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    $("#saleManDp").select2({data: dtall, minimumResultsForSearch: Infinity});
                },
                error: function () {
                }
            })
            oppProjectFun();
            selectOptOppFun();
            //项目类型
            //人员
            $.ajax({
                url: "/system/partner/simpleCustomerList",
                dataType: "json",
                success: function (data) {


                    $("#clientsDp").html(opportunityFun.returnopt(data, 1)).val("");

                    $("#clientsDp").select2({
                        placeholder: "请选择客户",
                        templateResult: opportunityFun.formatState
                    });


                    $("#contactSel").select2({minimumResultsForSearch: Infinity});
                    $("#clientsDp").on("change", function (e) {
                        $.ajax({
                            url: "/system/partner/listPartnerContacter",
                            dataType: "json",
                            data: {"partnerKey": $(this).val()},
                            timeout: "8000",
                            success: function (data) {
                                $("#contactSel").html(opportunityFun.returnopt(data, 2));
                                $("#contactSel").select2({
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
            $('#endDate').datetimepicker({
                format: 'yyyy-mm-dd',
                widthCustom: '335px',
                language: 'zh-CN',
                autoclose: true,
                minView: 'month',
                todayBtn: true
            }).on("click", function () {
                $("#endDate").datetimepicker("setStartDate", $("#startDate").val())
            });

            $('#startDate').datetimepicker({
                format: 'yyyy-mm-dd',
                widthCustom: '335px',
                language: 'zh-CN',
                autoclose: true,
                minView: 'month',
                todayBtn: true
            }).on("click", function () {
                $("#startDate").datetimepicker("setEndDate", $("#endDate").val())
            });
            $('#signDate').datetimepicker({
                format: 'yyyy-mm-dd',
                widthCustom: '335px',
                language: 'zh-CN',
                autoclose: true,
                minView: 'month',
                todayBtn: true
            })


        }

        function oppoFun(dtRt) {
            var dopp = dtRt.contract;
            $("#createhkOrder").datagrid("loadData", dtRt.returnMoneys);
            $("#createjhOrder").datagrid("loadData", dtRt.plans);
            $("#createkpOrder").datagrid("loadData", dtRt.invioces);

            var html = template('tpl-attach', dtRt);
            $("#attachFile").after(html);
            $.ajax({
                url: "/ydz/salesorder/listSalesMan",
                dataType: "json",
                success: function (dt) {
                    // dt=[];
                    var dtall = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    // 参与人员

                    $("#ourSigner").select2({
                        placeholder: "请添加参与人员",
                        minimumResultsForSearch: Infinity,
                        data: dtall
                    }).val(dopp.ourSignerId).trigger("change");

                    var returnopt = function (data) {
                        var opt = "";
                        for (var i = 0; i < data.length; i++) {
                            var dt = data[i];
                            opt += '<li did="' + dt.employeeId + '"><a href="javascript:;">' + dt.realName + '</a></li>';
                        }
                        return opt;
                    }
                    tixinPerson = dt;
                    shoukuanPerson = returnopt(dt);

                    var dtall = $.map(dt, function (obj) {
                        obj.text = obj.realName; // replace name with the property used for the text
                        obj.id = obj.employeeId; // replace name with the property used for the text
                        return obj;
                    });
                    $("#saleManDp").select2({
                        data: dtall,
                        minimumResultsForSearch: Infinity
                    }).val(dopp.salesId).trigger("change");
                },
                error: function () {
                }
            })
            HuploadifyObj.settings("formData", {contractNo: dopp.contractNo});
            $("#endDate").val(dopp.endDate);
            $("#startDate").val(dopp.startDate);
            $("input[name='contractDesc']").val(dopp.contractDesc);
            $("input[name='oppoTypeHid']").val(dopp.projectType);
            $("input[name='projectTypeDesc']").val(dopp.projectTypeDesc);
            $("input[name='contractNo']").val(dopp.contractNo);
            $("input[name='partenerSigner']").val(dopp.partnerSignerName);
            $("input[name='oppoNo']").val(dopp.oppoNo);
            $("#signDate").val(dopp.signDate);
            $("input[name='contractMoney']").val(dopp.contractMoney);
            oppProjectFun();
            selectOptOppFun();

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
                                $("#contactSel").html(opportunityFun.returnopt(data, 2)).val(defat).trigger("change");
                                $("#contactSel").select2({
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
                                $("#contactSel").html(opportunityFun.returnopt(data, 2));
                                $("#contactSel").select2({
                                    minimumResultsForSearch: Infinity
                                })
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

            $('#startDate').datetimepicker({
                format: 'yyyy-mm-dd',
                language: 'zh-CN',
                widthCustom: '335px',
                autoclose: true,
                minView: 'month',
                todayBtn: true
            }).on("click", function () {
                $("#startDate").datetimepicker("setEndDate", $("#endDate").val())
            });
            $('#endDate').datetimepicker({
                format: 'yyyy-mm-dd',
                language: 'zh-CN',
                widthCustom: '335px',
                autoclose: true,
                minView: 'month',
                todayBtn: true
            }).on("click", function () {
                $("#endDate").datetimepicker("setStartDate", $("#startDate").val())
            });
            $('#signDate').datetimepicker({
                format: 'yyyy-mm-dd',
                widthCustom: '335px',
                language: 'zh-CN',
                autoclose: true,
                minView: 'month',
                todayBtn: true
            })

        }
    });

    $(function () {

        new FormValidator('projectForm', [{
            name: 'contractDesc',
            display: '请填写合同名称',
            rules: 'required'
        }, {
            name: 'contractMoney',
            display: '请填写合同金额',
            rules: 'required'
        }, {
            name: 'clientsDp',
            display: '请选择客户',
            rules: 'required'
        }], function (errors, evt) {
            if (errors.length > 0) {
                $.mytoast({text: errors[0].display});
                $(".copyMain").attr("disabled", false);
            } else {
                if (evt && evt.preventDefault) {
                    evt.preventDefault();
                } else if (event) {
                    event.returnValue = false;
                }
                console.log(readyData());

                var urlCz = "";
                if (contractNo == null || contractNo == "") {
                    urlCz = "/ydz/contract/addContract";
                } else {
                    urlCz = "/ydz/contract/updateContract";
                }
                $.ajax({
                    url: urlCz,
                    dataType: "json",
                    type: "post",
                    contentType: "application/json",
                    data: JSON.stringify(readyData()),
                    success: function (d) {
                        if (d.code == "1") {
                            $.mytoast({text: d.msg});
                            setTimeout(function () {
                                window.location.href = "/openPage?pageName=project_project-contract-list";
                            }, 2000);
                        }
                        $(".copyMain").attr("disabled", false);
                    }, error: function () {
                        $(".copyMain").attr("disabled", false);
                    }
                });
            }
        });
//            $('#projectForm').validator({
//                timely:2,theme:'yellow_right',
////                stopOnError: true,
//                display: function(input) {
//                    return $(input).attr('placeholder');
//                }
//            });
//            var $my_form =  $("#projectForm");
//            $my_form.validate(function($form, e){alert("callback function invoked me !")})
        $(".copyMain").click(function () {
            $(".copyMain").attr("disabled", true);
            $("#subMain").click();
        })
        $(".cancelOpp").one("click", function () {
            opportunityFun.cancelOpp(this);
        })

        $(".addWin1").on("click", function () {
            if ($("input[name='contractMoney']").val() == "") {
                $.mytoast({text: '请先填写合同金额'});
                return;
            }
            formatEditLast(2, []);
        })
        $(".addWin3").on("click", function () {
            formatEditLasthk(2, []);
        })
        $(".addWin2").on("click", function () {
            if ($("#clientsDp").val() == null || $("#clientsDp").val() == "") {
                $.mytoast({text: '请先选择客户'});
                return;
            }
            if ($("input[name='contractMoney']").val() == "") {
                $.mytoast({text: '请先填写合同金额'});
                return;
            }
            formatEditLastkp(2, []);
        })

    });

    function readyData() {
        var readyData = {};
        var contractProject =
            {

                "contactId": $("#contactSel").val(),
                "contactName": $("#contactSel").find("option:selected").text(),
                "contractDesc": $("input[name='contractDesc']").val(),
                "contractNo": $("input[name='contractNo']").val(),
                "oppoNo": $("input[name='oppoNo']").val(),//关联报价
                "ourSignerId": $("#ourSigner").val(),
                "ourSignerName": $("#ourSigner").find("option:selected").text(),
                "partnerKey": $("#clientsDp").val(),
                "partnerName": $("#clientsDp").find("option:selected").text(),
                "partnerShortname": "",
                "partnerSignerName": $("input[name='partenerSigner']").val(),
                "projectType": $("input[name='oppoTypeHid']").val(),
                "projectTypeDesc": $("input[name='projectTypeDesc']").val(),
                "remarks": "",
                "salesId": $("#saleManDp").val(),
                "salesName": $("#saleManDp").find("option:selected").text(),
                "signDate": $("#signDate").val(),
                "startDate": $("#startDate").val(),
                "endDate": $("#endDate").val(),
                "contractMoney": $("input[name='contractMoney']").val()
            };
        readyData.contractProject = contractProject;
        // 回款计划
        var plans = $("#createjhOrder").datagrid("getRows");
        readyData.plans = plans;
        var invoices = $("#createkpOrder").datagrid("getRows");
        readyData.invoices = invoices;
        var returnRecords = $("#createhkOrder").datagrid("getRows");
        readyData.returnRecords = returnRecords;
        return readyData;
    }
</script>
<%--回款计划--%>
<script>
    function glContractFun() {
        var url = "/openPage?pageName=project_opportunity-quotation-list-simple";
        showMessageDialog(url, "", "84%", "100%", true);

    }
    function showMessageDialog(url, title, width, height, shadow) {
        var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
        $("#msgwindow").empty();
        $("#msgwindow").css({height: "550px"});
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
    function msg(content) {
        $("#msgwindow").html(content).addClass("activ");
    }
    function hideMsg() {
        $(".window-mask").hide();
        $("#msgwindow").css({height: "0"}).removeClass("activ");
    }
    function relateOpp(ids) {

        $("#oppoNo").val(ids);
        hideMsg();
    }

    //            invoiceNo 开票单号
    function kpColumn() {
        var arr = [];
        arr.push({
            field: 'ind',
            align: 'center',
            title: '序号',
            formatter: function (value, row, index) {
                return index + 1;
            }
        });
        arr.push({
            field: 'invoiceDate', title: '开票日期', width: 100, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'invoiceCompany', title: '开票公司', width: 150, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'invoiceMoney', title: '开票金额', width: 100, formatter: function (value, row, index) {
                return "&yen;" + accounting.formatNumber(value, 2);
            }
        });
        arr.push({
            field: 'invoiceContent', title: '开票内容', width: 100, formatter: function (value, row, index) {
                return '<span title="' + value + '">' + value + '</span>';
            }
        });
        arr.push({
            field: 'invoiceName', title: '票据类型', width: 100, formatter: function (value, row, index) {
                var t = globejhDt.invoiceName[row.invoiceType];
                if (!t) {
                    t = ""
                }
                ;
                return '<span title="' + t + '">' + t + '</span>';

            }
        });
        arr.push({
            field: 'invoiceNumber', title: '发票号码', width: 100, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'signerName', title: '客户签收人', width: 80, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'drawerName', title: '开票人', width: 80, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'sendName', title: '送票人', width: 80, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'btn', title: '操作', align: 'center', width: 100, formatter: function (value, row, index) {
                return formatCaozuokp(row);
            }
        });
        return arr;
    }
    function hkColumn() {

        var arr = [];
        arr.push({
            field: 'ind',
            align: 'center',
            title: '序号',
            formatter: function (value, row, index) {
                return index + 1;
            }
        });
        arr.push({
            field: 'returnDate', title: '回款日期', width: 100, formatter: function (value, row, index) {
                return value;
            }
        });

        arr.push({
            field: 'returnMoney', title: '回款金额', width: 100, formatter: function (value, row, index) {
                return "&yen;" + accounting.formatNumber(value, 2);
            }
        });

        arr.push({
            field: 'returnName', title: '回款类型', width: 80, formatter: function (value, row, index) {
                var t = globejhDt.returnName[row.returnType];
                if (!t) {
                    t = ""
                }
                ;
                return '<span title="' + t + '">' + t + '</span>';


            }
        });
        arr.push({
            field: 'payName', title: '付款方式', width: 100, formatter: function (value, row, index) {
                var t = globejhDt.payName[row.payType];
                if (!t) {
                    t = ""
                }
                ;
                return '<span title="' + t + '">' + t + '</span>';
            }
        });
        arr.push({
            field: 'payeeName', title: '收款人', width: 80, formatter: function (value, row, index) {
                return value;
            }
        });
        arr.push({
            field: 'btn', title: '操作', align: 'center', width: 100, formatter: function (value, row, index) {
                return formatCaozuohk(row);
            }
        });
        return arr;
    }
    function jhColumn() {
        var arrclm = [];
        arrclm.push({
            field: 'stage',
            align: 'center',
            title: '期次',
            formatter: function (value, row, index) {
//                return inputTemplate(value, index, 'businessDesc')
                return index + 1;
            }
        });
        arrclm.push({
            field: 'planReturnDate',
            title: '计划回款日期',
            width: 100,
            formatter: function (value, row, index) {
                return value;
//                return inputTemplateReq(value, index, row)
            }
        });
        arrclm.push({
            field: 'planReturnMoney',
            title: '计划回款金额',
            width: 100,
            formatter: function (value, row, index) {
                return "&yen;" + accounting.formatNumber(value, 2);
            }
        });
//            arrclm.push({
//                field: 'planRemindTimeValue',
//                title: '计划提醒时间',
//                width: 100,
//                formatter: function (value, row, index) {
//                    return value;
//                }
//            });
        arrclm.push({
            field: 'planRemindContactName',
            title: '计划提醒人员',
            width: 150,
            align: 'center', formatter: function (value, row, index) {
                return value;

//                return inputTemplateWay(value, index, 'priceWayDesc')
            }
        });
//            arrclm.push({
//                field: 'btn',
//                title: '操作',align: 'center',
//                width: 70,
//                formatter: function (value, row, index) {
//                    return formatCaozuo(row);
//                }
//            });
        return arrclm;
    }

    function formatCaozuo(row) {
        var changeItem = JSON.stringify(row);
        return "<span onclick='formatEditLast(\"1\"," + changeItem + ")' style='    vertical-align: middle;font-size: 24px;color: #999;margin-right: 10px' class='iconfont_new'>&#xe6e6;</span><span onclick='formatDelLast(\"createjhOrder\",this," + changeItem + ")'  style='    vertical-align: middle;font-size: 24px;color: #999;' class='iconfont_new'>&#xe6f1;</span>"

    }
    function formatCaozuokp(row) {
        var changeItem = JSON.stringify(row);
        return "<span onclick='formatEditLastkp(this,\"1\"," + changeItem + ")' style='    vertical-align: middle;font-size: 24px;color: #999;margin-right: 10px' class='iconfont_new'>&#xe6e6;</span><span onclick='formatDelLast(\"createkpOrder\",this," + changeItem + ")'  style='    vertical-align: middle;font-size: 24px;color: #999;' class='iconfont_new'>&#xe6f1;</span>"

    }
    function formatCaozuohk(row) {
        var changeItem = JSON.stringify(row);
        return "<span onclick='formatEditLasthk(this,\"1\"," + changeItem + ")' style='    vertical-align: middle;font-size: 24px;color: #999;margin-right: 10px' class='iconfont_new'>&#xe6e6;</span><span onclick='formatDelLast(\"createhkOrder\",this," + changeItem + ")'  style='    vertical-align: middle;font-size: 24px;color: #999;' class='iconfont_new'>&#xe6f1;</span>"

    }
    function saveTable() {
        $("#createjhOrder").datagrid('loadData', {total: 0, rows: []});
        var arr = [], arrid = [];
        var dtsel = $("#tixinPerson").select2("data");
        for (var k = 0; k < dtsel.length; k++) {
            arr.push(dtsel[k].text);
            arrid.push(dtsel[k].id);
        }

        var boolRt = false;
        var tsNum = 0;
        for (var m = 0; m < globejhDt.num; m++) {

            var ts = Number($(".hkMoney")[m].value);

            if (!isNaN(ts) && ts > 0) {
                tsNum += ts;
            } else {
                boolRt = true;
            }

        }
        if (tsNum > 100) {
            $.mytoast({text: "回款总比例不能超过100%"});
            return;
        }
        if (tsNum < 100) {
            $.mytoast({text: "回款总比例必须等于100%"});
            return;
        }

        if (boolRt) {
            $.mytoast({text: "每期回款比例必须填写"});
            return;
        }
        for (var i = 0; i < globejhDt.num; i++) {
            var num = i + 1;
            $("#createjhOrder").datagrid("insertRow", {
                row: {
                    "planReturnDate": $(".hkDate2")[i].value,
                    "planReturnMoney": accounting.unformat($(".money2")[i].innerText),
                    "planReturnRate": $(".hkMoney")[i].value,
                    "planRemindContactId": arrid.join(","),
                    "stage": num,
                    "planRemindContactName": arr.join(",")
                }
            });
        }
        $('#createjhOrder').datagrid('acceptChanges');
        $("#createjhOrder").datagrid("reload");
        closeWin();
    }
    function saveTable1() {
//            $("#createkpOrder").datagrid('loadData', { total: 0, rows: [] });
        if (globejhDt.kpbz < 0) {
            insert()
        } else {
            update();
        }
        function insert() {
            $("#createkpOrder").datagrid("insertRow", {
                row: {
                    "drawerName": $("input[name='drawerName']").val(), //开票人
                    "invoiceCompany": $("input[name='invoiceCompany']").val(),//开票公司全称
                    "invoiceContent": $("input[name='invoiceContent']").val(),//开票内容
                    "invoiceDate": $("input[name='invoiceDate']").val(),//开票日期
                    "invoiceMoney": $("input[name='invoiceMoney']").val(), //开票金额
                    "invoiceNo": $("input[name='invoiceNo']").val(), //开票单号
                    "invoiceNumber": $("input[name='invoiceNumber']").val(), //发票号
                    "invoiceType": $("input[name='invoiceName']").attr("did"),//发票类型
                    "isDel": "0",
                    "invoiceName": $("input[name='invoiceName']").val(),//发票类型
                    "sendName": $("input[name='sendName']").val(),//送票人
                    "signerName": $("input[name='signerName']").val()//客户签收人
                }
            });
        }

        function update() {
            $("#createkpOrder").datagrid("updateRow", {
                index: globejhDt.kpbz,
                row: {
                    "drawerName": $("input[name='drawerName']").val(), //开票人
                    "invoiceCompany": $("input[name='invoiceCompany']").val(),//开票公司全称
                    "invoiceContent": $("input[name='invoiceContent']").val(),//开票内容
                    "invoiceDate": $("input[name='invoiceDate']").val(),//开票日期
                    "invoiceMoney": $("input[name='invoiceMoney']").val(), //开票金额
                    "invoiceNo": $("input[name='invoiceNo']").val(), //开票单号
                    "invoiceNumber": $("input[name='invoiceNumber']").val(), //发票号
                    "invoiceType": $("input[name='invoiceName']").attr("did"),//发票类型
                    "invoiceName": $("input[name='invoiceName']").val(),//发票类型
                    "sendName": $("input[name='sendName']").val(),//送票人
                    "signerName": $("input[name='signerName']").val()//客户签收人
                }
            })
        }

        $('#createkpOrder').datagrid('acceptChanges');
        $("#createkpOrder").datagrid("reload");
        closeWin();
    }
    function saveTable2() {
//            $("#createkpOrder").datagrid('loadData', { total: 0, rows: [] });
        if (globejhDt.hkbz < 0) {
            insert()
        } else {
            update();
        }


        function insert() {
            $("#createhkOrder").datagrid("insertRow", {
                row: {
                    "payType": $("input[name='payType']").attr("did"),//付款方式
                    "payName": $("input[name='payType']").val(),//付款方式名称
                    "payeeId": $("input[name='payeeName']").attr("did"),//收款人ID
                    "payeeName": $("input[name='payeeName']").val(),//收款人姓名
                    "returnDate": $("input[name='returnDate']").val(),//回款日期
                    "isDel": "0",
                    "returnMoney": $("input[name='returnMoney']").val(),//回款金额
                    "returnType": $("input[name='returnName']").attr("did"),//回款类型
                    "returnName": $("input[name='returnName']").val()//回款类型名称
                }
            });
        }

        function update() {
            $("#createhkOrder").datagrid("updateRow", {
                index: globejhDt.hkbz,
                row: {
                    "payType": $("input[name='payType']").attr("did"),//付款方式
                    "payName": $("input[name='payType']").val(),//付款方式名称
                    "payeeId": $("input[name='payeeName']").attr("did"),//收款人ID
                    "payeeName": $("input[name='payeeName']").val(),//收款人姓名
                    "returnDate": $("input[name='returnDate']").val(),//回款日期
                    "returnMoney": $("input[name='returnMoney']").val(),//回款金额
                    "returnType": $("input[name='returnName']").attr("did"),//回款类型
                    "returnName": $("input[name='returnName']").val()//回款类型名称
                }
            })
        }

        $('#createhkOrder').datagrid('acceptChanges');
        $("#createhkOrder").datagrid("reload");
        closeWin();
    }

    function formatEditLast(type, rowData) {
        $(".window-mask").show();
        $(".requireMenu").addClass("hide");


        $("#contractWin3").css({display: 'block'});

        if (type == 1) {
        } else {
            globejhDt.qyMoney = $("input[name='contractMoney']").val();
            globejhDt.title = "增加回款计划";
            var rows = $("#createjhOrder").datagrid("getRows");
            var monTp = 0, tixinTp = "";
            var arrm = [];
            rows.forEach(function (item, index) {
                monTp += item.planReturnMoney;
                tixinTp = item.planRemindContactId;
                arrm.push({hkMoney: item.planReturnRate, money2: item.planReturnMoney, hkDate2: item.planReturnDate});
            })
            globejhDt.sjMoney = monTp;
            globejhDt.tixin = tixinTp;
            globejhDt.num = rows.length > 0 ? rows.length : 3;
            var html = template('tpl-addWin', globejhDt);
            $("#contractWin3").html(html);
            globejhDt.monList = rows.length > 0 ? arrm : globejhDt.monList;
            initMonD(globejhDt.num);

        }

        var dtall = $.map(tixinPerson, function (obj) {
            obj.text = obj.realName;
            obj.id = obj.employeeId;
            return obj;
        });
        // 参与人员

        var dtdata = globejhDt.tixin == "" || globejhDt.tixin == null ? "" : globejhDt.tixin.split(",");
        $("#tixinPerson").select2({
            placeholder: "请添加提醒人员",
            minimumResultsForSearch: Infinity,
            closeOnSelect: false,
            data: dtall
        }).val(dtdata).trigger("change");
        initWin();
    }
    function formatEditLasthk(o, type, rowData) {
        $(".window-mask").show();
        $(".requireMenu").addClass("hide");

        $("#contractWin").css({display: 'block'});

        if (type == "1") {
            globejhDt.hkbz = $(o).parents("tr").index();
            rowData.title = "修改回款记录";
            rowData.returnName = globejhDt.returnName[rowData.returnType];
            rowData.payName = globejhDt.payName[rowData.payType];
            html = template('tpl-addWin3', rowData);
        } else {
            globejhDt.hkbz = -1;
            var dt = {title: '增加回款记录'};
            html = template('tpl-addWin3', dt);
        }
        $("#contractWin").html(html);
        initWin();
    }
    function formatEditLastkp(o, type, rowData) {
        $(".window-mask").show();
        $(".requireMenu").addClass("hide");

        $("#contractWin2").css({display: 'block'});
        var html = "";
        if (type == "1") {
            globejhDt.kpbz = $(o).parents("tr").index();
            rowData.title = "修改开票记录";
            rowData.invoiceName = globejhDt.invoiceName[rowData.invoiceType];
            html = template('tpl-addWin2', rowData);
        } else {

            var companyTitle = $("#clientsDp").select2("data")[0].title;

            globejhDt.kpbz = -1;
            var dt = {
                title: '增加开票记录',
                invoiceCompany: companyTitle,
                invoiceMoney: $("input[name='contractMoney']").val(),
                invoiceDate: new Date().Format("yyyy-MM-dd")
            };
            html = template('tpl-addWin2', dt);
        }
        $("#contractWin2").html(html);
        initWin();
    }

    function formatDelLast(tb, obj, rowData) {
        var rindex = $(obj).parents("tr").index();
        var rows = $('#' + tb).datagrid("getRows");
//            if ($('#'+tb).datagrid("getRows").length > 1) {
//                $('#'+tb).datagrid('deleteRow', rindex);
//            }
        rows.splice(rindex, 1);
//            rows.forEach(function(item,index){
//
//            })
        $("#" + tb).datagrid('loadData', {total: rows.length, rows: rows});
        $('#' + tb).datagrid('acceptChanges');
        $("#" + tb).datagrid("reload");
//            $(".window-mask").show();
//            $('#deleteWin').show();
//            servPageConfig.delConData=rowData;
    }

    function recpayKeyUp(b) {
        var $this = $(b), $va = parseFloat($(".receivablesMoneyCls").text());
        $(".hkMoney").keyup();
        if (isNaN($this.val())) {
            $(".recpayDiscount").addClass("smallCls");
            $(".recpayDiscount").removeClass("hide").html("非法数字");
//                $("#preferentialText").text(accounting.formatNumber($("#preferentialVal").val(), 2));
            return;
        }
        if (isNaN($va)) {
            $("<div class='tips_contants'>").fadeIn(250).html("合同签约总额含有非法数字").delay(3000).fadeOut(250).appendTo('body');
            return;
        }
        var pr = Number($this.val()) - Number($(".receivablesMoneyCls").text());

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
    }
    function recpayKeyUpHk(b) {
        var $this = $(b), $va = parseFloat($(".receivablesMoneyCls").text()),
            $sj = $("#sjMoney").val();
        if (isNaN($sj)) {
            $.mytoast({text: "请填写合同实际总额", time: 1000});
        }
        if (isNaN($va)) {
            $("<div class='tips_contants'>").fadeIn(250).html("合同签约总额含有非法数字").delay(3000).fadeOut(250).appendTo('body');
            return;
        }
        var pr2 = Number(Number($this.val()) * $sj * 0.01);
        $this.parent().next().find(".money2").text(accounting.formatNumber(pr2, 2));

    }

    function initMonD(nd) {
        var tplMon = {};
        tplMon.monList = globejhDt.monList;
        var html = template('tpl-listMon', tplMon);
        $(".dropdown-money-list").html(html);
    }
    function initMonDChange(nd) {
        globejhDt.num = nd;
        var monListChange = new Array();
        var tplMon = {};
        for (var k = 0; k < globejhDt.num; k++) {
            monListChange.push(dropData);
        }
        tplMon.monList = monListChange;
        var html = template('tpl-listMon', tplMon);
        $(".dropdown-money-list").html(html);
    }
    function initWin() {
        $('[data-provide="datetimepicker-inline"]').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
            minView: 'month'
        });
        $(".dropdown_shoukuan").off().on("click", "li", function () {
            $("#payeeNameSel").val($(this).text());
            $("#payeeNameSel").attr("did", $(this).attr("did"));
        })
        $(".dropdown_payType").off().on("click", "li", function () {
            $("#payNameSel").val($(this).text());
            $("#payNameSel").attr("did", $(this).attr("did"));
        })
        $(".dropdown_payName").off().on("click", "li", function () {
            $("#returnNameSel").val($(this).text());
            $("#returnNameSel").attr("did", $(this).attr("did"));
        })
        $(".dropdown_invoiceName").off().on("click", "li", function () {
            $("#invoiceNameSel").val($(this).text());
            $("#invoiceNameSel").attr("did", $(this).attr("did"));
        })
        $(".dropdown_clickMore").off().on("click", "li", function () {
//            $(this).parent().prev("input").val($(this).text());
            $("#hkSelectStage").val($(this).text());
            globejhDt.num = Number($(this).attr("did"));
            initMonDChange(globejhDt.num);

            $('[data-provide="datetimepicker-inline"]').datetimepicker({
                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
                minView: 'month'
            });
        })
        $(".dropdown_shoukuan").empty().html(shoukuanPerson);

        var returnopt = function (data) {
            var opt = "";
            for (var i = 0; i < data.length; i++) {
                var dt = data[i];
                opt += '<li did="' + dt.id + '"><a href="javascript:;">' + dt.text + '</a></li>';
            }
            return opt;
        }
        $(".dropdown_payType").html(returnopt(globejhDt.payType));
    }

    function closeWin() {
        $(".window-mask").hide();
        $("#contractWin,#contractWin2,#contractWin3,#deleteWin").css({display: 'none'});
    }
</script>
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

    function selectOptOppFun() {
        $(".ydz_select2").off("click").on("click", function (e) {

            e.stopPropagation();

            var o = $(this).offset();
            var t = o.top + $(this).outerHeight() - 70;
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
                var $that = $(this);

                var menu2 = $("#menu1").val();
                var categoryId = "", categoryDesc = "", url = "";
                if ($.trim(menu2) == "") {
                    $(".requireYdzMenu").show().removeClass("hide");
                    return;
                } else {
                    $(".requireYdzMenu").hide().addClass("hide");
                }
                $that.attr("disabled", true);
                var queryParams = {
                    "typeDesc": menu2,
                    "settingClass": "OPPORT_TYPE"
                };
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
                    }, error: function () {
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
                    var queryParams = {};
                    $(this).attr("disabled", true);
                    $.ajax({
                        url: "/ydz/opportunity/deleteOpportTypeDesc?settingClass=OPPORT_TYPE&typeCode=" + $th.attr("cid"),
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
                        "settingClass": "OPPORT_TYPE",
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
    var opportunityFun = {
        cancelOpp: function () {
            window.location.href = "/openPage?pageName=project_project-contract-list";
        },

        returnopt: function (data, type) {
            var opt = "";
            for (var i = 0; i < data.length; i++) {
                var dt = data[i];
                var dtn = "";
                if (type == 1) {
                    if (dt.partnerShortname == "全部客户") {
                        continue;
                    }
                    dtn = dt.myComShortname;
                    opt += '<option title="' + dt.partnerShortname + '" data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
                }else if (type == 2) {
                    opt += '<option value="' + dt.contacterId + '">' + dt.contacterName + '</option>';
                }else if (type == 3) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                    opt += '<li><a rel="' + dt.employeeId + '" href="javascript:;">' + dt.realName + '</a></li>';
                }else if (type == 4) {
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