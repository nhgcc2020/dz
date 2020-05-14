<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>新建点位</title>
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

        .ydz_select_Css {
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

        .ydz_select_Css li {
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

        .open .ydz_select_Css {
            display: block
        }

        .ydz_select_Css_ul {
            max-height: 180px;
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

        .ydz_select_Css li a {
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

        .ydz_select_Css li a:hover {
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
        .control-label-mark:before{
            content: '*';
            color:red;
            margin-right:5px;
            font-size:12px;
        }
    </style>

    <style type="text/css">
        * { -ms-word-wrap: break-word; word-wrap: break-word; }
        html { -webkit-text-size-adjust: none; text-size-adjust: none; }
        html, body, h1, h2, h3, h4, h5, h6, div, ul, ol, li, dl, dt, dd, iframe, textarea, input, button, p, strong, b, i, a, span, del, pre, table, tr, th, td, form, fieldset, .pr, .pc { margin: 0; padding: 0; word-wrap: break-word; font-family: verdana,Microsoft YaHei,Tahoma,sans-serif; *font-family: Microsoft YaHei,verdana,Tahoma,sans-serif; }
        body, ul, ol, li, dl, dd, p, h1, h2, h3, h4, h5, h6, form, fieldset, .pr, .pc, em, del { font-style: normal; font-size: 100%; }
        ul, ol, dl { list-style: none; }
        ._citys { width: 376px; display: inline-block; border: 2px solid #eee; padding: 5px; position: relative; }
        ._citys span {color: #56b4f8;
            height: 15px;
            width: 15px;
            line-height: 12px;
            text-align: center;
            border-radius: 3px;
            position: absolute;
            right: 10px;
            top: 10px;
            border: 1px solid #56b4f8;
            cursor: pointer; }
        ._citys0 { width: 100%; height: 34px; display: inline-block; border-bottom: 2px solid #56b4f8; padding: 0; margin: 0; }
        ._citys0 li { display: inline-block; line-height: 34px; font-size: 15px; color: #888; width: 80px; text-align: center; cursor: pointer; }
        .citySel { background-color: #56b4f8; color: #fff !important; }
        ._citys1 { width: 100%; display: inline-block; padding: 10px 0; }
        ._citys1 a { width: 83px; height: 35px; display: inline-block; background-color: #f5f5f5; color: #666; margin-left: 6px; margin-top: 3px; line-height: 35px; text-align: center; cursor: pointer; font-size: 13px; overflow: hidden; }
        ._citys1 a:hover { color: #fff; background-color: #56b4f8; }
        .AreaS { background-color: #56b4f8 !important; color: #fff !important; }
        #regularWin{
            border: none;
            z-index: 99;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            background: #fff;
            transition:all 0.2s 0s linear;
            -webkit-transition: all 0.2s 0s linear;
            position: absolute;
            display: none;
        }
        .datagrid-cell{
            position: relative;
        }
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/easyui/pace.min.js?v=fe5e2eaca6"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=df96034f1e"></script>
    <script src="/resources/business/base_new.js?v=1191ae2bcdf"></script>
    <script src="/resources/cola-ui/china_city.js"></script>
    <script src="/resources/easyui/Popt.js"></script>
    <script src="/resources/easyui/citySet.js"></script>
    <script src="/resources/easyui/jquery.autocomplete.js?v=88de880408"></script>
</head>

<body class="modal-page" style="padding:0!important;">
<div
        style="    padding: 70px 50px 0 50px;" class="main"
>

    <div class="fixheader">
        <button type="button" onclick="saveAll(this)" class="btn btn-primary copyMain " style="width:90px;margin:4px 8px 10px 0px">保存
        </button>
        <button type="button"  onclick="backPage()" class="btn  cancelOpp"
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
    font-weight: 700;">新建点位</h1>

        <label style="padding-right:0;width:90px;" class="col-xs-1 control-label control-label-mark">所属媒体 :</label>
        <div class="col-xs-2" style="width:200px;">
            <%--<input type="text" style="" did="1" class="form-control ydz_select2" readonly name="oppoType"--%>
            <%--placeholder="媒体类型"/><span class="ydz_select_a"></span>--%>
            <select class="form-control input-xs" id="mediaNoSel" placeholder="媒体类型">
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
<div class="ydz_select_menu ydz_select_Css">
    <ul class="ydz_select_menu_ul ydz_select_Css_ul recpayAccountList">
        <li><a rel="现金" href="javascript:;">现金</a></li>
    </ul>
    <div class="autoEdit autoEditOnce">编辑自定义分类</div>
</div>
<div class="ydz_select_com ydz_select_Css">
    <ul class="ydz_select_com_ul ydz_select_Css_ul">
        <li><a rel="1" href="javascript:;">自有媒体资源</a></li>
        <li><a rel="2" href="javascript:;">第三方媒体资源</a></li>
    </ul>
</div>
<div class="ydz_select_way ydz_select_Css">
    <ul class=" ydz_select_Css_ul">
        <li><a rel="01" href="javascript:;">日</a></li>
        <li><a rel="02" href="javascript:;">周</a></li>
        <li><a rel="03" href="javascript:;">月</a></li>
        <li><a rel="04" href="javascript:;">季度</a></li>
        <li><a rel="05" href="javascript:;">半年</a></li>
        <li><a rel="06" href="javascript:;">年</a></li>
    </ul>
</div>





<script>
    (function(window,$,undefined){
        var globVar={};
        var pointNo = '${pointNo}';// 商机号
        var mediaNo = '${mediaNo}';// 商机号
        var globDataGrid =
            [
                {
                    "belongsType": "", //所属公司类别
                    "environment": "", //环境属性
                    "mediaNo": "", //媒体资源编码
                    "place": "", //所在场所
                    "pointCity": "", //点位城市编码
                    "pointCode": "", //点位编码
                    "pointCountry": "",//点位县区编码
                    "pointLocation": "", //详细位置
                    "pointName": "", //点位名称
                    "pointProvince": "", //点位省
                    "priceScheme": "", //价格方案
                    "priceWay": "", //计价方式
                    "remarks": "", //备注
                    "cityName": "", //
                    "specification": "", //媒体规格
                    "status": "", //点位状态 1N正常 2R维护
                    "statusDesc": "", //状态描述
                    "unitPrice": 0 //单价
                },{
                "belongsType": "", //所属公司类别
                "environment": "", //环境属性
                "mediaNo": "", //媒体资源编码
                "place": "", //所在场所
                "pointCity": "", //点位城市编码
                "cityName": "", //
                "pointCode": "", //点位编码
                "pointCountry": "",//点位县区编码
                "pointLocation": "", //详细位置
                "pointName": "", //点位名称
                "pointProvince": "", //点位省
                "priceScheme": "", //价格方案
                "priceWay": "", //计价方式
                "remarks": "", //备注
                "specification": "", //媒体规格
                "status": "", //点位状态 1N正常 2R维护
                "statusDesc": "", //状态描述
                "unitPrice": 0 //单价
            },{
                "belongsType": "", //所属公司类别
                "environment": "", //环境属性
                "mediaNo": "", //媒体资源编码
                "place": "", //所在场所
                "pointCity": "", //点位城市编码
                "pointCode": "", //点位编码
                "pointCountry": "",//点位县区编码
                "pointLocation": "", //详细位置
                "pointName": "", //点位名称
                "pointProvince": "", //点位省
                "priceScheme": "", //价格方案
                "priceWay": "", //计价方式
                "remarks": "", //备注
                "specification": "", //媒体规格
                "cityName": "", //
                "status": "", //点位状态 1N正常 2R维护
                "statusDesc": "", //状态描述
                "unitPrice": 0 //单价
            }
            ];
        window.arrclo_addList = columnInit();
        function columnInit(){
            var arrclo_addListNew=[];
        arrclo_addListNew.push({
            field: 'pointName',
            title: '点位名称',
            width: 150,
            formatter: function (value, row, index) {
                return inputTemplatepointName(value, index, row)
            }
        });
        arrclo_addListNew.push({field: 'pointCode', title: '点位编码', width: 100, formatter: function (value, row, index) {return inputTemplatepointCode(value, index)}});

        arrclo_addListNew.push({field: 'belongsType', title: '所属公司', width: 100, formatter: function (value, row, index) {return  inputTemplateCom(value, index) }});

        arrclo_addListNew.push({field: 'cityName', title: '所在城市', width: 100, formatter: function (value, row, index) {return inputTemplatepointCity(value, index,row)}});

        arrclo_addListNew.push({field: 'pointLocation', title: '详细位置', width: 100, formatter: function (value, row, index) {return inputTemplatepointLocation(value, index)}});

        arrclo_addListNew.push({field: 'place', title: '所在场所', width: 100, formatter: function (value, row, index) {return inputTemplateplace(value, index)}});

        arrclo_addListNew.push({field: 'specification', title: '媒体规格', width: 100, formatter: function (value, row, index) {return inputTemplatespecification(value, index)}});

        arrclo_addListNew.push({field: 'unitPrice', title: '单价', width: 100, formatter: function (value, row, index) {return inputTemplateunitPrice(value, index)}});

        arrclo_addListNew.push({field: 'priceWay', title: '计价方式', width: 100, formatter: function (value, row, index) {return inputTemplatepriceWay(value, index)}});

        arrclo_addListNew.push({field: 'environment', title: '环境属性', width: 100, formatter: function (value, row, index) {return inputTemplateenvironment(value, index)}});

        arrclo_addListNew.push({field: 'remarks', title: '备注', width: 100, formatter: function (value, row, index) {return inputTemplateremarks(value, index)}});

            if (pointNo == null || pointNo == "") {  //新建
                arrclo_addListNew.push({
                    field: 'btn',
                    title: '操作',
                    width: 100,
                    formatter: function (value, row, index) {
                        return '<i class="iconfont_new contentTemplate" title="增加" onclick="addRow(this)">&#xe6a1;</i>&nbsp;<i title="复制" class="iconfont_new contentTemplate" onclick="copyRow(this)" >&#xe69d;</i>&nbsp;<i title="删除" class="iconfont_new contentTemplate" onclick="delRow(this)" >&#xe6f2;</i>';
                    }
                });
            }
        return arrclo_addListNew;
        }
        $(function () {

        });
        function initPageTwoData(d) {
            var ar=[];
            ar.push(d);
            console.log(ar);
            d.mediaNo
                $("#createOrder").datagrid("loadData", ar);

//            var fun = function () {
//                $("#caseDesc").val(d.versionDesc);
//                $("#versionDate").val(d.versionDate);
//
//                $("#remarkInput").val(d.remarks);
//                $("#depositRequested").val(Number(d.taxRate) * 100);
//                $("#preferentialVal").val(d.preferential);
//                $("#salesCount").val(Number(d.discountRate) * 100);
//                onLoadS();
//            }
//            fun();

        }
        var initmediaSel=function (d) {

            $.ajax({
                url: "/ydz/mediaresource/listMediaResources?showType=&mediaType=&page=1&rows=30",
                dataType: "json",
                timeout: "8000",
                success: function (data) {
                    var returnopt= function (data) {
                        var opt = "";
                        opt += '<option data-p="" value="">请选择</option>';
                        for (var i = 0; i < data.length; i++) {
                            var dt = data[i];
                            var dtn = "";
//                    if(dt.partnerShortname==undefined){continue;}
                            dtn = dt.mediaDesc;
                            opt += '<option data-p="'+dt.mediaNo+'" value="' + dt.mediaNo + '">' + dtn + '</option>';
                        }
                        return opt;
                    }
                    $("#mediaNoSel").html(returnopt(data.rows));
                    if(d){
                        $("#mediaNoSel").select2({    minimumResultsForSearch: Infinity
                        }).val(d.mediaNo).trigger("change");
                    }else{
                        $("#mediaNoSel").select2({    minimumResultsForSearch: Infinity
                        });
                    }

                },
                error: function () {
                }
            })
        }
        var initFunPage = function () {
            if (pointNo == null || pointNo == "") {  //新建
                $("#createOrder").datagrid("loadData", globDataGrid);
                selectOptOppFun();
                initPageData();
                initmediaSel();
            }
            else {
                $.ajax({
                    url: "/ydz/mediaresource/getMediaPointLocationDetail?pointNo=" + pointNo + "&mediaNo=" + mediaNo,
                    type: 'GET',
                    dataType: "json",
                    success: function (dt) {
                            initPageTwoData(dt);
                        initmediaSel(dt);
                    }
                });

            }
        }
        // 页面入口处
        $(function () {
            initFunPage();
        })
        var objSelMenu;// 临时保存页面共享下拉框的对象
        var oppProjectType = [];
        function oppProjectFun() {
            $.ajax({
                url: "/ydz/common/listComSettingClass?settingClass=MEDIA_TYPE",
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
            var priceWayAll=[
                {
                    priceWay: "01",
                    priceWayDesc: "按面积"
                }];
            var teams1 = $.map(priceWayAll, function (obj) {
                obj.value = obj.priceWayDesc; // replace name with the property used for the text
                obj.data = obj.priceWay; // replace name with the property used for the text
                return obj;
            });
//            $('.autocompleteAttr').devbridgeAutocomplete({
//                lookup: teams1,
//                minChars: 0,
//                readyOn: true,
//                onSelect: function (suggestion) {
//                }
//
//            });
            var belongCom=[
                {
                    value: "1",
                    text: "自有媒体资源"
                },{
                    value: "2",
                    text: "第三方媒体资源"
                }];
            var teamCom = $.map(belongCom, function (obj) {
                obj.value = obj.text; // replace name with the property used for the text
                obj.data = obj.value; // replace name with the property used for the text
                obj.text = obj.value; // replace name with the property used for the text
                return obj;
            });
            $('.autocompleteCom').devbridgeAutocomplete({
                lookup: teamCom,
                minChars: 0,
                readyOn: true,
                onSelect: function (suggestion) {
                    console.log(suggestion);
                }
            });
            $('.autocompletePrice').devbridgeAutocomplete({
                lookup: teams1,
                minChars: 0,
                readyOn: true,
                onSelect: function (suggestion) {
                }
            });
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
            $(".ydz_selectCom").off("click").on("click", function (e) {
                e.stopPropagation();
                var o = $(this).offset();
                var t = o.top + $(this).outerHeight();
                var l = o.left;
                $(".ydz_select_com").css({
                    "display": "block",
                    "top": t,
                    "left": l,
                    "width": $(this).outerWidth(),
                    "z-index": 1000
                });
                $(".ydz_select_com").show();
                objSelMenu = $(this);
                $(this).addClass("open");
            });
            $(".ydz_selectWay").off("click").on("click", function (e) {
                e.stopPropagation();
                var o = $(this).offset();
                var t = o.top + $(this).outerHeight();
                var l = o.left;
                $(".ydz_select_way").css({
                    "display": "block",
                    "top": t,
                    "left": l,
                    "width": $(this).outerWidth(),
                    "z-index": 1000
                });
                $(".ydz_select_way").show();
                objSelMenu = $(this);
                $(this).addClass("open");
            });
            $(".city").off().on("click",(function (e) {
                SelCity(this,e);
            }));
        }
        $(function () {
            selectOptOppFun();

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
                        "settingClass": "MEDIA_TYPE"
                    };
                    $(this).attr("disabled", true);
                    $.ajax({
//                            url:"/ydz/common/updateComSettingClass",
                        url: "/ydz/common/insertComSettingClass",
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
                            url: "/ydz/common/deleteComSettingClass?settingClass=MEDIA_TYPE&typeCode=" + $th.attr("cid"),
                            dataType: "json",
                            type:"delete",
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
                            "settingClass": "MEDIA_TYPE",
                            "typeCode": $th.attr("cid")
                        };
                        $(this).attr("disabled", true);
                        $.ajax({
                            url: "/ydz/common/updateComSettingClass",
//                                url:"/ydz/common/insertComSettingClass",
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
                $(".ydz_select_menu,.ydz_select_com,.ydz_select_way").hide();
            });
            $(".ydz_select_menu").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").text());
                    objSelMenu.prev().val($(this).find("a").attr("rel"));
                }
            })
            $(".ydz_select_com").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").text());
                    objSelMenu.prev().val($(this).find("a").attr("rel"));
                }
            })
            $(".ydz_select_way").on("click", "li", function () {
                if (objSelMenu) {
                    objSelMenu.val($(this).find("a").text());
                    objSelMenu.prev().val($(this).find("a").attr("rel"));
                }
            })

        })

        function initPageData() {
            $("#versionDate").val(new Date().Format("yyyy-MM-dd"));
        }
        window.backPage=function () {
            var turl = "/openPage?pageName=media_media-point-list";
            window.location.href = turl;
        }
        function forwardMainOpp() {
            window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
        }

        function readyData() {
            var rows = $('#createOrder').datagrid("getRows");
            console.log(rows);
            for (var i = 0; i < rows.length; i++) {
//            rows[i].pointCode = $("input[name='pointCode']")[i].value;
                rows[i].pointName = $("input[name='pointName']")[i].value;
                rows[i].pointCode = $("input.inputTemplatepointCode")[i].value;
                rows[i].belongsType = $("input.belongsType")[i].value;
                rows[i].pointCity = $($("input.inputTemplateQuantity")[i]).attr("data-cid");
                rows[i].pointProvince =$($("input.inputTemplateQuantity")[i]).attr("data-pid");
                rows[i].pointCountry =$($("input.inputTemplateQuantity")[i]).attr("data-aid");
                rows[i].pointLocation = $("input.inputTemplatepointLocation")[i].value;
                rows[i].place = $("input.inputTemplateplace")[i].value;
                rows[i].specification = $("input.inputTemplatespecification")[i].value;
                rows[i].unitPrice = $("input.inputTemplateunitPrice")[i].value;
            rows[i].priceWay = $("input.autocompletePrice")[i].value;
                rows[i].environment = $("input.autocompleteAttr")[i].value;
                rows[i].remarks = $("input.inputTemplateremarks")[i].value;
            rows[i].mediaNo =   $("#mediaNoSel").val();

                rows[i].status = "1N";
                rows[i].statusDesc = "1N";
                rows[i].createTime = "";
            }
            console.log(rows);


            return rows;
        }
        function readyData2() {
            var rows = $('#createOrder').datagrid("getRows");
            for (var i = 0; i < rows.length; i++) {
//            rows[i].pointCode = $("input[name='pointCode']")[i].value;
                rows[i].pointName = $("input[name='pointName']")[i].value;
                rows[i].pointCode = $("input.inputTemplatepointCode")[i].value;
                rows[i].belongsType = $("input.belongsType")[i].value;
                rows[i].pointCity = $($("input.inputTemplateQuantity")[i]).attr("data-cid");
                rows[i].pointProvince =$($("input.inputTemplateQuantity")[i]).attr("data-pid");
                rows[i].pointCountry =$($("input.inputTemplateQuantity")[i]).attr("data-aid");
                rows[i].pointLocation = $("input.inputTemplatepointLocation")[i].value;
                rows[i].place = $("input.inputTemplateplace")[i].value;
                rows[i].specification = $("input.inputTemplatespecification")[i].value;
                rows[i].unitPrice = $("input.inputTemplateunitPrice")[i].value;
                rows[i].priceWay = $("input.autocompletePrice")[i].value;
                rows[i].environment = $("input.autocompleteAttr")[i].value;
                rows[i].remarks = $("input.inputTemplateremarks")[i].value;
                rows[i].mediaNo =   $("#mediaNoSel").val();
                rows[i].status = "1N";
                rows[i].statusDesc = "1N";
                rows[i].createTime = "";
            }
            return rows[0];
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
        window.saveAll=function(self, fun) {
            if($("#mediaNoSel").val()==""){$.mytoast({text:"请选择所属媒体"});return;};
            saveOrder(self, "", "dd", fun);
        }
        function saveDraft(self) {
//        window.location.href = "/openPage?pageName=project_opportunity-quotation-list";
        }
        function saveOrder(o, url, tp, fun) {

            var rows = $('#createOrder').datagrid("getRows");
            for (var i = 0; i < rows.length; i++) {
              if($("input[name='pointName']")[i].value==""){
                  $.mytoast({text:"请填写点位名称"});return false;
              };
            }
            var self = $(o);
            self.attr("disabled", true);
            var type="",data="";
            if (pointNo == null || pointNo == "") {
                urlt = "/ydz/mediaresource/insertNewMediaPointLocation";

                data=JSON.stringify(readyData());
                type="post";
            } else {
                urlt = "/ydz/mediaresource/updateMediaPointLocaiton";
                type="put";
                data=JSON.stringify(readyData2());
            }
            $.ajax({
                url: urlt,
                type:type,
                data: data,
                dataType: "json",
                contentType: "application/json",
                success: function (callBack) {
                    if (callBack.code == '1') {
                        $.mytoast({text: callBack.msg});
                        self.attr("disabled", false);
                        setTimeout(function () {
                            window.location.href = "/openPage?pageName=media_media-point-list";
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
        window.onLoadS=function () {
            autocompleteFun();
        }
        function autocompleteFun() {
            selectOptOppFun();

        }
        function inputTemplateremarks(v, i, f) {
            return '<input  class="inputTemplateremarks" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplatepointName(v, i, row) {
            return '<input  name="pointName"  class=""   style="width: 100%;" value="' + v + '" type="text">'
//            return '<input type="hidden" name="pointCode" value="' + row.pointCode + '" class="ydz_select2_prev" /><input readonly name="pointName"  class="ydz_select2"   style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplatepriceWay(v, i, f) {
            var arrdata=[
                "日"
                ,"周"
                ,"月"
                ,"季度"
                ,"半年"
                ,"年"
            ];
            var num=Number(v)-1;
            var str=num>=0?arrdata[num]:"";
            return '<input type="hidden" value="' + v + '" class="autocompletePrice" /><input class="ydz_selectWay " readonly style="width: 100%;" value="' + str+ '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'
//            return '<input class="autocompletePrice " onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'
        }
        function inputTemplateCom(v, i, f) {
//            1自有媒体资源 2第三方媒体资源
            var vname="";
            if(v=="1"){
                vname="自有媒体资源";
            }else if(v=="2"){
                vname="第三方媒体资源";
            }
            return '<input type="hidden" value="' + v + '" class="belongsType" /><input class="ydz_selectCom " readonly style="width: 100%;" value="' + vname + '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'
//            return '<input class="autocompleteCom belongsType" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'


        }
        function inputTemplateLength(v, i, f) {
            return '<input class="inputTemplateLength" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplateWidth(v, i, f) {
            return '<input class="inputTemplateWidth" onkeyup="modifyVal(this,' + i + ',\'' + f + '\')" style="width: 100%;" value="' + v + '" type="text">'
        }
        function  findCity(id,type) {
            switch(type)
            {
                case 1:
                    for(var i=0;i<ProvinceJson.length;i++){
                        var ext=ProvinceJson[i];
                        if(ext.provinceId===id){
                            return ext.provinceName;
                        }
                    }
                    return "";
                    break;
                case 2:
                    for(var i=0;i<CityJson.length;i++){
                        var ext=CityJson[i];
                        if(ext.cityId===id){
                            return ext.cityName;
                        }
                    }
                    return "";
                    break;
                default:
                    for(var i=0;i<CountryJson.length;i++){
                        var ext=CountryJson[i];
                        if(ext.countryId===id){
                            return ext.countryName;
                        }
                    }
                    return "";
            }


        }
        function inputTemplatepointCity(v, i, r) {
            var cname=findCity(r.pointCity,2),pname=findCity(r.pointProvince,1),xname=findCity(r.pointCountry,3);
            return '<input data-cid="'+r.pointCity+'" data-pid="'+r.pointProvince+'" data-aid="'+r.pointCountry+'"  data-ncid="'+cname+'" data-npid="'+pname+'" data-naid="'+xname+'" class="inputTemplateQuantity city"  style="width: 100%;" value="' + cname+'-'+pname+'-'+xname + '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;">&#xe68d;</i>'
        }


        function inputTemplateenvironment(v, i, f) {
//
            return '<input class="autocompleteAttr"  style="width: 100%;" value="' + v + '" type="text"><i class="iconfont_new" style=" cursor: default;  font-size: 14px;line-height:40px;right: 1px;-webkit-transform: scale(.5);position: absolute;color: #ccc;"></i>'
        }
        function inputTemplatepointLocation(v, i, f) {

            return '<input class="inputTemplatepointLocation"  style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplateplace(v, i, f) {

            return '<input class="inputTemplateplace"  style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplatespecification(v, i, f) {

            return '<input class="inputTemplatespecification"  style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplateunitPrice(v, i, f) {

            return '<input class="inputTemplateunitPrice"  style="width: 100%;" value="' + v + '" type="text">'
        }
        function inputTemplatepointCode(v, i, f) {

            return '<input class="inputTemplatepointCode"  style="width: 100%;" value="' + v + '" type="text">'
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
       window.addRow= function (o) {
            var rindex = $(o).parents("tr").index() + 1;
            $('#createOrder').datagrid('insertRow', {
                index: rindex,	// index start with 0
                row: {
                    "belongsType": "", //所属公司类别
                    "environment": "", //环境属性
//            "itemNo": 2, //序号
                    "mediaNo": "", //媒体资源编码
                    "place": "", //所在场所
                    "pointCity": "", //点位城市编码
                    "pointCode": "", //点位编码
                    "pointCountry": "",//点位县区编码
                    "pointLocation": "", //详细位置
                    "pointName": "", //点位名称
                    "pointProvince": "", //点位省
                    "priceScheme": "", //价格方案
                    "priceWay": "", //计价方式
                    "remarks": "", //备注
                    "cityName": "", //备注
                    "specification": "", //媒体规格
                    "status": "", //点位状态 1N正常 2R维护
                    "statusDesc": "", //状态描述
                    "unitPrice": 0 //单价
                }
            });
            onLoadS();
        }
        window.delRow=function (o) {
            var rindex = $(o).parents("tr").index();
            if ($('#createOrder').datagrid("getRows").length > 1) {
                $('#createOrder').datagrid('deleteRow', rindex);
            }


//        priceCount();
            // $("#createOrder").datagrid("reload");
        }
        window.copyRow=function (o) {
            var i = $(o).parents("tr").index();
            var row = {};

            row.pointName = $("input[name='pointName']")[i].value;
            row.pointCode = $("input.inputTemplatepointCode")[i].value;
            row.belongsType = $("input.belongsType")[i].value;
            row.pointCity = $($("input.inputTemplateQuantity")[i]).attr("data-cid");
            row.pointProvince =$($("input.inputTemplateQuantity")[i]).attr("data-pid");
            row.pointCountry =$($("input.inputTemplateQuantity")[i]).attr("data-aid");

            row.cityName = $($("input.inputTemplateQuantity")[i]).attr("data-ncid")+"-"+$($("input.inputTemplateQuantity")[i]).attr("data-npid")+"-"+
                $($("input.inputTemplateQuantity")[i]).attr("data-naid");

            row.pointLocation = $("input.inputTemplatepointLocation")[i].value;
            row.place = $("input.inputTemplateplace")[i].value;
            row.specification = $("input.inputTemplatespecification")[i].value;
            row.unitPrice = $("input.inputTemplateunitPrice")[i].value;
            row.priceWay = $("input.autocompletePrice")[i].value;
            row.environment = $("input.autocompleteAttr")[i].value;
            row.remarks = $("input.inputTemplateremarks")[i].value;



            $('#createOrder').datagrid('insertRow', {
                index: i + 1,	// index start with 0
                row: row
            });
            onLoadS();
        }
    })(window,jQuery);
</script>

</body>

</html>