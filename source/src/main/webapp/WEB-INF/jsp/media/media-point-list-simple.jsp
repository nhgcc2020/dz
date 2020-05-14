<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>媒体点位资源列表</title>
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

        .ydz_select2, .ydz_input_readOnly{
            cursor: default !important;
            background-color: #fff !important;
        }

        .ydz_select2 ~ .ydz_select_a, .ydz_input_readOnly ~ .ydz_select_a {
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
    </style>
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>
    <script src="/resources/cola-ui/china_city.js"></script>
    <script src="/resources/easyui/Popt.js"></script>
    <script src="/resources/easyui/citySet.js"></script>

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

                <div class="col-xs-2" style="width:200px;">
                    <input type="hidden">
                    <input type="text" style="" did="" class="form-control ydz_select2" readonly name="mediaNo"
                           placeholder="媒体类型"/><span class="ydz_select_a"></span>
                </div>
                <div class="col-xs-2" style="width:250px;">
                    <input type="text" style="" did="1" class="form-control ydz_input_readOnly city" readonly name="" id="citySelDt"
                           placeholder="全部城市"/><span class="ydz_select_a"></span>
                </div>
                <div class="col-xs-2 " style="width:130px;padding:0 5px ">
                    <select class="form-control input-xs" id="contacterDp" >
                    </select>
                </div>

                <div class="col-xs-2 " style="width:130px;padding:0 5px">
                    <select class="form-control input-xs" id="dateDat">
                        <option value=""></option>
                    </select>
                </div>




                <button type="button" id="" class="btn  btn-primary searchBtn "
                        style="font-size:12px;height:30px;line-height:1;">搜索
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
     style="    font-weight: bolder;
    position: fixed;
    bottom: 10px;
    left: 45%;
    line-height: 50px;
    overflow: hidden;">
    <button type="button" class="btn btn-primary pull-right  "
            style="margin-right:15px;height:30px;line-height:1;"
            onclick="oppColumnFun.openReceivablesBar()">选择点位
    </button>
    <button type="button" class="btn btn-warning pull-right  "
            style="margin-right:15px;height:30px;color: #b3b3b3;border-color: #b3b3b3;"
            onclick="window.parent.hideMsg()">取消
    </button>

</div>
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
<div id="regularWin"  style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -130px;
    margin-top: -175px;
    position: absolute;
    width: 350px;
    height: 260px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;" id="">修改点位状态</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="oppColumnFun.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 2px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group" >

                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">点位状态：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;
margin-bottom: 10px;
">
                    <select type="text" style="width:200px;" class="form-control" id="priceWaySel" placeholder="">
                    </select>
                </div>

            </div>
        </div>

        <div style="clear: both; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default"  onclick="oppColumnFun.closeTaxPoint()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;" onclick="oppColumnFun.saveTable()">保存</button>
        </div>
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
        var objSelMenu;// 临时保存页面共享下拉框的对象
        var kehuselDat=[],kehuselDat2=[],objSelType,kehuUrl,addUrl,updateUrl,delUrl,queryParamsUpdate={},queryParamsSel={};
        var kehuselUrl="/ydz/mediaresource/listMediaResources?showType=&mediaType=&page=1&rows=30";//媒体
        var kehuselUrl2="/ydz/common/listComSettingClass?settingClass=MEDIA_SHOW";//表现形式
        var kehuAddUrl="/ydz/common/insertComSettingClass";//媒体
        var kehuAddUrl2="/ydz/common/insertComSettingClass";//表现形式
        var kehuDelUrl="/ydz/common/deleteComSettingClass?settingClass=MEDIA_TYPE&typeCode=";//媒体
        var kehuDelUrl2="/ydz/common/deleteComSettingClass?settingClass=MEDIA_SHOW&typeCode=";//表现形式
        var kehuUpateUrl="/ydz/common/updateComSettingClass";//媒体
        var kehuUpateUrl2="/ydz/common/updateComSettingClass";//表现形式
        var  reloadUrl= "/ydz/mediaresource/listMediaPointLocations";//列表数据
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
                    oppProjectFun(kehuselDat2);
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
                        kehuselDat=projectTp.rows;
                    }else if(type=="2"){
                        kehuselDat2=projectTp.rows;
                    }
                    oppProjectFun(projectTp.rows);
                },
                error: function () {
                    kehuselDat=[],kehuselDat2=[];
                    oppProjectFun([]);
                }
            });

        }


        function oppProjectFun(data) {
            var returnopt = function (data, type) {
                var opt = "";
                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    if(i==0){
                        $("input[name='mediaNo']").val(dt.mediaDesc);
                        $("input[name='mediaNo']").prev().val(dt.mediaNo);
                    }
                    var dtn = "";
                    if (type == 4) {
                        opt += '<li><a rel="' + dt.mediaNo + '" href="javascript:;">' + dt.mediaDesc + '</a></li>';
                    }
                }
                return opt;
            }
            $(".recpayAccountList").empty().html(returnopt(data, 4));
//            $(".ydz_select_menu_ul2").empty().html(returnopt(data, 5));
            reload();
        }
        $(function () {
            $(".city").click(function (e) {
                SelCity(this,e);
            });     $(".searchBtn").click(function (e) {
                reload();
            });

            var rto2=function () {
                var dtn=  '<option value="">状态</option>'+
                    '<option value="1N">正常</option>'+
                    '<option value="2R">维护</option>';
                return dtn;
            }
            $("#contacterDp").html(rto2()).select2({ minimumResultsForSearch: Infinity });
            var rto1=function () {
                var dtn=  '<option value="">所属公司</option>'
                    +  '<option value="1">自有媒体资源</option>'
                    +  '<option value="2">第三方媒体资源</option>';
                return dtn;
            }
            $("#dateDat").html(rto1()).select2({ minimumResultsForSearch: Infinity });


            selectOptOppFun();
            initselOption(kehuselUrl,1);
//            initselOption(kehuselUrl2,2);
//            $(".ydz_select_menu_ul").on("click", "li", function () {
//                if (objSelMenu) {
//                    objSelMenu.val($(this).find("a").text());
//                }
//            })
            $(".autoEditOnce").on("click", function () {
                $("#autoEditOnceWin").show();
                $(".window-mask").show();
//            $("#autoEditOnceWin").draggable({ cursor: "move", containment: "parent"});
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
                    reload();
                }
            })
        })

        var param = getRequestParam.GetRequest();
        var yucunKuan = 0, yucunKuanSubmit = true;
        window.oppColumnFun = {
            closeTaxPoint:function () {
                $("#regularWin").hide();
            },
            saveTable:function () {
                var order4ItemsArr = $('#order').datagrid('getChecked');
                var param={"mediaNo":order4ItemsArr[0].mediaNo,"pointNo":order4ItemsArr[0].pointNo,"status":$("#priceWaySel").val()};
                param=$.param(param);
                var url="/ydz/mediaresource/updateStatusForMediaPointLocaiton?"+param;
                $.ajax({
                    url: url,
                    dataType: "json",
                    type:"put",
                    success: function (data) {
                        $.mytoast({text:data.msg});
                        reload();
                        $("#regularWin").hide();
                    },
                    error: function () {
                    }
                });

            },
            modifyWin: function (id) {
                var order4ItemsArr = $('#order').datagrid('getChecked');
                var len=order4ItemsArr.length;
                if(len==1){
                    $("#priceWaySel").select2({
                        minimumResultsForSearch: Infinity,
                        data: [
                            {
                                id: "1N",
                                text: "正常"
                            },
                            {
                                id: "2R",
                                text: "维护"
                            }]
                    }).val(order4ItemsArr[0].status).trigger("change");
                    $("#regularWin").show();
                }else if(len==0){
                    $.mytoast({text:"请选择点位"});
                }else {
                    $.mytoast({text:"只能选择一个点位修改"});
                }

            },
            openReceivablesBar: function () {

                var selectItems = $('#order').datagrid('getChecked');
                var arr=[];
//                pointNo pointCode pointName
                var bl=false;
                selectItems.forEach(function(item,value){
                    if(item.status=="2R"){
                        bl=true;
                    }
                    arr.push(item.oppoNo);
                })
                if(bl){
                    $.mytoast({text:"该点位正在维护,请联系管理员"})
                    return ;
                }
                window.parent.relateOpp(selectItems);

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

        function oppColumn() {
            var arrclo = [];
            arrclo.push({field: 'ck', checkbox: true});
            arrclo.push({
                field: 'index', title: '序号', width: 50, align: 'center', formatter: function (val, row, index) {
                    return index + 1;
                }
            });
            arrclo.push({
                field: 'pointName', width: 250, title: '点位名称'
            });
            arrclo.push({field: 'pointCode', width: 90, align: 'center', title: '编码'});

            arrclo.push({field: 'pointLocation', width: 90, align: 'center', title: '位置'});
//            arrclo.push({field: '7', width: 90, align: 'center', title: '实景'});
            arrclo.push({field: 'statusDesc', width: 90, align: 'center', title: '状态'});
            arrclo.push({field: 'belongsType', width: 90, align: 'center', title: '所属公司',  formatter: function (value, row) {
                if(value=="1"){
                    return "自有媒体资源";
                }else if(value=="2"){
                    return "第三方媒体资源";
                }else {
                    return "";
                }

            }});
            arrclo.push({field: 'pointProvince', width: 90, align: 'center', title: '省',  formatter: function (value, row) {
                return findCity(value,1) ;
            }});
            arrclo.push({field: 'pointCity', width: 90, align: 'center', title: '市',  formatter: function (value, row) {
                return findCity(value,2) ;
            }});
            arrclo.push({field: 'pointCountry', width: 90, align: 'center', title: '区县',  formatter: function (value, row) {
                return findCity(value,3) ;
            }});
            arrclo.push({field: 'place', width: 90, align: 'center', title: '所在场所'});
            arrclo.push({field: 'pointLocation', width: 90, align: 'center', title: '详细位置'});
            arrclo.push({field: 'specification', width: 90, align: 'center', title: '规格'});
            arrclo.push({field: 'priceScheme', width: 90, align: 'center', title: '价格方案',  formatter: function (value, row) {
                var arrdata=[
                    "日"
                    ,"周"
                    ,"月"
                    ,"季度"
                    ,"半年"
                    ,"年"
                ];
                var num=Number(row.priceWay)-1;
                var str=num>=0?arrdata[num]:"";
                return row.unitPrice+"/"+str ;
            }});


            return arrclo;
        }
        window.openProReq=function(p) {
            window.location.href="/ydz/mediaresource/forward-media-point-picture-view?pointNo="+p.pointNo+"&mediaNo="+p.mediaNo;

        }
        window.modifyPoint=function(p) {
            console.log(p.mediaNo);
            console.log(p.pointNo);
            window.location.href="/ydz/mediaresource/forward-mediapointlocation-update?pointNo="+p.pointNo+"&mediaNo="+p.mediaNo;


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
                method:'get',
                onLoadSuccess: onLoadSuccess,
                pagination: true,
                pageSize: pageSize,
                pageList: pageList,
                columns: [arrclo],
                queryParams: {
                    "mediaNo": $("input[name='mediaNo']").prev().val(),
                    "belongsType": $('#dateDat').val(),
                    "status": $('#contacterDp').val(),
                    "pointProvince": $('#citySelDt').attr("data-pid"),
                    "pointCity": $('#citySelDt').attr("data-cid"),
                    "pointCountry": $('#citySelDt').attr("data-aid")
                }
            });
            var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
            pager.pagination({
                layout: ['first', 'links', 'last'],
                showRefresh: false,
                displayMsg: ''
            });
            $(".pagination").show();
//            $(".pagination").hide();
        }
        function onLoadSuccess(data) {
            if (data.rows.length > 0) {
            } else {
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        }

    })(window,jQuery);
</script>




<%--一个复杂的页面化成一个顶部下拉筛选的额外的工作代码--%>
<%--把列表显示需要字段做隐藏--%>
<%--操作按钮居中显示 加上放入dom里   pageToolbar的id--%>
<%--把加上按钮的事件替换--%>
<%--把原页面无关的按钮去掉--%>
<style>
    .datagrid .datagrid-pager {
        border-color: none;
        border-top-width: 0;
        background: #fff;
    }
</style>
<script>
//    $(".receivableBtn ").hide();
</script>
</body>
</html>