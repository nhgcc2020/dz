<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>投放计划列表</title>
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

        .ydz_select2, .ydz_input_readOnly {
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
        * {
            -ms-word-wrap: break-word;
            word-wrap: break-word;
        }

        html {
            -webkit-text-size-adjust: none;
            text-size-adjust: none;
        }

        html, body, h1, h2, h3, h4, h5, h6, div, ul, ol, li, dl, dt, dd, iframe, textarea, input, button, p, strong, b, i, a, span, del, pre, table, tr, th, td, form, fieldset, .pr, .pc {
            margin: 0;
            padding: 0;
            word-wrap: break-word;
            font-family: verdana, Microsoft YaHei, Tahoma, sans-serif;
            *font-family: Microsoft YaHei, verdana, Tahoma, sans-serif;
        }

        body, ul, ol, li, dl, dd, p, h1, h2, h3, h4, h5, h6, form, fieldset, .pr, .pc, em, del {
            font-style: normal;
            font-size: 100%;
        }

        ul, ol, dl {
            list-style: none;
        }

        ._citys {
            width: 376px;
            display: inline-block;
            border: 2px solid #eee;
            padding: 5px;
            position: relative;
        }

        ._citys span {
            color: #56b4f8;
            height: 15px;
            width: 15px;
            line-height: 12px;
            text-align: center;
            border-radius: 3px;
            position: absolute;
            right: 10px;
            top: 10px;
            border: 1px solid #56b4f8;
            cursor: pointer;
        }

        ._citys0 {
            width: 100%;
            height: 34px;
            display: inline-block;
            border-bottom: 2px solid #56b4f8;
            padding: 0;
            margin: 0;
        }

        ._citys0 li {
            display: inline-block;
            line-height: 34px;
            font-size: 15px;
            color: #888;
            width: 80px;
            text-align: center;
            cursor: pointer;
        }

        .citySel {
            background-color: #56b4f8;
            color: #fff !important;
        }

        ._citys1 {
            width: 100%;
            display: inline-block;
            padding: 10px 0;
        }

        ._citys1 a {
            width: 83px;
            height: 35px;
            display: inline-block;
            background-color: #f5f5f5;
            color: #666;
            margin-left: 6px;
            margin-top: 3px;
            line-height: 35px;
            text-align: center;
            cursor: pointer;
            font-size: 13px;
            overflow: hidden;
        }

        ._citys1 a:hover {
            color: #fff;
            background-color: #56b4f8;
        }

        .AreaS {
            background-color: #56b4f8 !important;
            color: #fff !important;
        }

        #regularWin {
            border: none;
            z-index: 99;
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
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
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
                <div class="col-xs-2" style="width:200px;padding:0 5px 0 0">
                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                </div>

                <div class="col-xs-2 " style="width:130px;padding:0 5px ">
                    <select class="form-control input-xs" id="planStatus">
                    </select>
                </div>

                <div class="col-xs-2 w1200ipt150" style="padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="w1200input">
                                <input type="text" style="" class="form-control" id="datetimepickers"
                                       data-format="yyyy-MM-dd" placeholder="开始日期">
                                <span onclick="$('#datetimepickers').datetimepicker('show');" class="" style="
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
                                <input type="text" style="" class="form-control" id="datetimepickere"
                                       data-format="yyyy-MM-dd" placeholder="结束日期">
                                <span onclick="$('#datetimepickere').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>


                <button type="button" id="" class="btn  btn-primary searchBtn "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>


                <button type="button" class="btn btn-primary pull-right receivableBtn "
                        style="margin-right:15px;height:30px;line-height:1;"
                        onclick="oppColumnFun.openReceivablesBar()">新建投放计划
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
<div id="regularWin" style="    padding-top: 5px;
    top: 50%;
    left: 50%;
    margin-left: -130px;
    margin-top: -175px;
    position: absolute;
    width: 350px;
    height: 260px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        修改点位状态</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="oppColumnFun.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 2px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group">

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
            <button type="button" class="btn  btn-default" onclick="oppColumnFun.closeTaxPoint()" style="width:92px;">
                取消
            </button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;"
                    onclick="saveTable()">保存
            </button>
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
    <div class="autoEdit autoEditOnce">编辑自定义分类</div>
</div>

<script>
    (function (window, $, undefined) {
        "use strict";
        var objSelMenu;// 临时保存页面共享下拉框的对象
        var kehuselDat = [], kehuselDat2 = [], objSelType, kehuUrl, addUrl, updateUrl, delUrl, queryParamsUpdate = {}, queryParamsSel = {};
        var reloadUrl = "/ydz/mediaresource/listMediaRunPlans";//列表数据

        $(function () {
            $('#datetimepickers').datetimepicker({
                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
                minView: 'month'
            }).on("click", function () {
                $("#datetimepickers").datetimepicker("setEndDate", $("#datetimepickere").val())
            });
            $('#datetimepickere').datetimepicker({
                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
                minView: 'month'
            }).on("click", function () {
                $("#datetimepickere").datetimepicker("setStartDate", $("#datetimepickers").val())
            });
            $.ajax({
                url: "/system/partner/dropdownPartner?partnerType=1",
                dataType: "json",
                timeout: "8000",
                success: function (data) {
                    var returnopt = function (data) {
                        var opt = "";
                        for (var i = 0; i < data.length; i++) {
                            var dt = data[i];
                            var dtn = "";
                            dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                            opt += '<option data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
                        }
                        return opt;
                    }
                    $("#customerDat").html(returnopt(data));
                    var formatState = function (state) {
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
                    $("#customerDat").select2({
//                        maximumInputLength:2,
                        templateResult: formatState
                    });
                },
                error: function () {
                }
            });

            $(".city").click(function (e) {
                SelCity(this, e);
            });
            $(".searchBtn").click(function (e) {
                reload();
            });

            var rto2 = function () {
                var dtn = '<option value="">排期状态</option>'
                    + '<option value="1L">锁定</option>'
                    + '<option value="2S">售出</option>';
                return dtn;
            }
            $("#planStatus").html(rto2()).select2({minimumResultsForSearch: Infinity});
            var rto1 = function () {
                var dtn = '<option value="">所属公司</option>';
                return dtn;
            }
            $("#dateDat").html(rto1()).select2({minimumResultsForSearch: Infinity});
            reload();
        })

        var param = getRequestParam.GetRequest();
        var yucunKuan = 0, yucunKuanSubmit = true;
        window.oppColumnFun = {
            closeTaxPoint: function () {
                $("#regularWin").hide();
            },
            modifyWin: function (id) {

                $("#priceWaySel").select2({
                    minimumResultsForSearch: Infinity,
                    data: [
                        {
                            id: "1",
                            text: "维护"
                        }, {
                            id: "2",
                            text: "正常"
                        }]
                }).val("1").trigger("change");
                $("#regularWin").show();
            },
            openReceivablesBar: function () {
                var turl = "/ydz/mediaresource/forward-mediarunplan-add-update";
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
                field: 'adName', width: 250, title: '广告名称'
            });
            arrclo.push({field: 'partnerShortname', width: 130, align: 'center', title: '客户'});
            arrclo.push({
                field: 'planStatus', width: 90, align: 'center', title: '排期状态', formatter: function (value, row) {
                    if (value == "1L") {
                        return "锁定";
                    } else if (value == "2S") {
                        return "售出";
                    } else {
                        return "空闲";
                    }
                }
            });
            arrclo.push({field: 'pointNum', width: 90, align: 'center', title: '点位数量'});
//            arrclo.push({field: '7', width: 90, align: 'center', title: '点位',   formatter: function (value, row) {
//                return '<a style="cursor: pointer" onclick="">预览</a>';
//            }});
            arrclo.push({field: 'startDate', width: 120, align: 'center', title: '投放开始日期'});
            arrclo.push({field: 'endDate', width: 120, align: 'center', title: '投放结束日期'});
            arrclo.push({
                field: 'btn', width: 130, align: 'center', title: '操作',
                formatter: function (value, row) {
                    var changeItem = row.planNo;
                    return '<a style="cursor: pointer" onclick="lookSchedule(\'' + changeItem + '\')">查看排期</a><a style="cursor: pointer;margin-left:10px;" onclick="modifyPlan(\'' + changeItem + '\')">修改</a><a style="cursor: pointer;margin-left:10px;" onclick="openDt(\'' + changeItem + '\')">详情<a>';
                }
            });

            return arrclo;
        }

        window.openDt = function (p) {
            var url = "/ydz/mediaresource/forward-media-run-plan-detail?planNo=" + p;
            showMessageDialog(url, "", "84%", "100%", true);
        }
        function msg(content) {
            $("#msgwindow").html(content).addClass("activ");
        }

        window.hideMsg = function () {
            $(".window-mask").hide();
            $("#msgwindow").css({left: "100%"}).removeClass("activ");
        }
        function showMessageDialog(url, title, width, height, shadow) {
            var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
            $("#msgwindow").empty();
            $("#msgwindow").css({left: "16%", width: "84%"});
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

        window.modifyPlan = function (p) {
            var turl = "/ydz/mediaresource/forward-mediarunplan-add-update?planNo=" + p;
            window.location.href = turl;
        }
        window.lookSchedule = function (p) {
            window.location.href = "/ydz/mediaresource/forward-media-point-period?planNo=" + p + "&type=plan";
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
                method: "get",
                pageSize: pageSize,
                pageList: pageList,
                columns: [arrclo],
                queryParams: {
                    "planStatus": $("#planStatus").val(),
                    "partnerKey": $('#customerDat').val(),
//                    "searchKey": $('#searchKey').val()
                    "endDate": $('#datetimepickere').val(),
                    "startDate": $('#datetimepickers').val()

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

    })(window, jQuery);
</script>
</body>
</html>