<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>资源档期列表</title>
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
    <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>
    <style>
        .calendarCust {
            width: 680px;
            margin: 10px 0px 20px 0px;
            color: #555;
        }

        .calendarCust h4 {
            border-bottom: 2px solid #5bd999;
            text-align: center;
            font-size: 22px;
            font-weight: 700;
            margin-top: 10px;
            margin-bottom: 0px;
            padding: 10px 0;
        }

        .calendarCust .sign_tab {
            width: 100%;
            border-collapse: collapse;
            border: 1px solid #e5e5e5;
            table-layout: fixed;
        }

        .calendarCust .sign_tab th {
            text-align: center;
            height: 40px;
            /*font-weight: 700;*/
            background: #eff1f9;
            border: 1px solid #dce0f1;
        }

        #datatb th {
            height: 80px;
            border: 1px solid #dce0f1;
            background: #eff1f9;
        }

        #datatb thead, #box thead {
            /*transform: translateZ(0);*/
        }

        .calendarCust .sign_tab td {
            border: 1px solid #e5e5e5;
            height: 40px;
            text-align: center;
            font-size: 14px;
            font-family: arial;
        }

        .calendarCust .sign_tab td.over {
            background-color: #f3f3f3;
            border-left: 0;
            border-right: 0;
        }

        .calendarCust .sign_tab td.red_tbg {
            background-color: #da4654;
            color: #FFF;
        }

        .calendarCust .sign_tab td.blue_tbg {
            background-color: #66cc00;
            color: #FFF;
        }

        .calendarCust .sign_tab td.cur_day {
            background-color: #FFD2D2;
            color: #FFF;
        }

        /*下面这段代码固定头部只能解决一个页面一个table并且宽度是固定的*/
        /*table tbody {*/
        /*display:block;*/
        /*height:350px;*/
        /*overflow-y: auto;*/
        /*}*/
        /*table thead, tbody tr {*/
        /*display:table;*/
        /*width:100%;*/
        /*table-layout:fixed;*/
        /*}*/

        /*table thead {*/
        /*width: calc( 100% - 1em )*/
        /*}*/
    </style>
    <script>
        var Calendar = {
            _today: new Date(),
            _date: new Date().getDate(),
            _day: new Date().getDay(),
            _month: new Date().getMonth() + 1,
            _year: new Date().getFullYear(),
            setDate: function () {
                this._date = new Date(this._today).getDate();
            },
            setDay: function () {
                this._day = new Date(this._today).getDay();
            },
            setMonth: function () {
                this._month = new Date(this._today).getMonth() + 1;
            },
            setYear: function () {
                this._year = new Date(this._today).getFullYear();
            },
            init: function (curDate) {
                this._today = new Date(curDate);
                this.setDate();
                this.setDay();
                this.setMonth();
                this.setYear();
                this.setYear();
            },
            isLeap: function () {
                var year = this._year;
                if (year % 4 == 0 && year % 100 > 0) {
                    return true;
                }
                if (year % 400 == 0 && year % 3200 > 0) {
                    return true;
                }
                return false;
            },
            getLen: function () {
                if (this._month == 2) {
                    if (this.isLeap()) {
                        return 29;
                    }
                    return 28;
                }
                if (this._month < 8) {
                    if (this._month % 2 > 0) {
                        return 31;
                    }
                    return 30;
                }
                if (this._month % 2 > 0) {
                    return 30;
                }
                return 31;
            },
            getCaleBtw: function (options, filter) {
//                    debugger;
                var len = this.getLen();
                var d = new Date(this._year, this._month - 1, 1);
                var dfw = d.getDay();
                var arr = ["日", "一", "二", "三", "四", "五", "六"];
                var tem = 0;
                var str = "";
                str += '<tbody>';


                var formatDateTo1=function(dt){
                    var dm=new Date(dt).getMonth()+1;
                    dm=dm<10?"0"+dm:dm;
                    var m=dm.toString();
                    var y=(new Date(dt).getFullYear()).toString();
                    return (y+m+" ");
                }

                for (var l = 0; l < options.length; l++) {
                    str += '<tr>';
                    var arrBtw = [];
                    var str21 = options[l]["startDate"];
                    var str42 = options[l]["endDate"];
                    var bgColor = "";
                    if (options[l]["status"] == "1L") {
                        bgColor = "red_tbg";
                    } else if (options[l]["status"] == "2S") {
                        bgColor = "blue_tbg";
                    }


                    //月份和年份一起比较

//                    时间核心代码
                    // 同年同月 ,
//                    同年不同月   ,
//                    同年跨月+1  ,
//                    同年跨月+3  ,
                    var str21YM=Number(formatDateTo1(str21));
                    var str42YM=Number(formatDateTo1(str42)) ;
                    var filterYM=Number(formatDateTo1(filter));
                    console.log(str21YM+".."+str42YM+"..."+filterYM);
                    var tnian = Number(new Date(str42).getFullYear()) == Number(new Date(str21).getFullYear()) ? true : false;
                    if(tnian){
                        var tyue = Number(new Date(str42).getMonth()+1) == Number(new Date(str21).getMonth()+1) ? true : false;
                        if(tyue){//同月 2017-09   2017-09
                            var filterTnTy = (new Date(str42).getFullYear() + "-" + new Date(str42).getMonth()+1) == (new Date(filter).getFullYear() + "-" + new Date(filter).getMonth()+1) ? true : false;
                            if(filterTnTy){
                                arrBtw[0] = new Date(str21).getDate(),arrBtw[1] =new Date(str42).getDate()
                            }else{
                                arrBtw[0] = 0,arrBtw[1] =0
                            }
                        }else{//不同月 2017-07   2017-10  2017-8

                            var filterTnBty =str21YM ==filterYM  ? true : false;
                            var filterTnBtyDayu = str42YM== filterYM ? true : false;
                            var filterTnBtyQJ = (str42YM> filterYM && str21YM<filterYM) ? true : false;
                            if(filterTnBty){
                                arrBtw[0] = new Date(str21).getDate(),arrBtw[1] =len
                            }else if(filterTnBtyDayu){
                                arrBtw[0] = 1,arrBtw[1] =new Date(str42).getDate()
                            }else if(filterTnBtyQJ){
                                arrBtw[0] = 1,arrBtw[1] =len
                            }else {
                                arrBtw[0] = 0,arrBtw[1] =0
                            }
                        }
                    }//同年
                    else{
//                        var tyue = Number(new Date(str42).getMonth()+1) == Number(new Date(str21).getMonth()+1) ? true : false;

//                        if(tyue){//同月 2017-09   2018-09  和 2018-07

                            var filterBtnBtyDayu =str21YM== filterYM ? true : false;
                            var filterBtnBtyEnd =str42YM== filterYM? true : false;
                            var filterBTnBtyQJ = (str42YM> filterYM && str21YM<filterYM) ? true : false;
                            if (filterBtnBtyDayu) {
                                arrBtw[0] = new Date(str21).getDate(),arrBtw[1] = len
                            }else if(filterBtnBtyEnd){
                                arrBtw[0] = 1,arrBtw[1] = new Date(str42).getDate()
                            }else if(filterBTnBtyQJ){
                                arrBtw[0] = 1,arrBtw[1] =len
                            }

                    }//不同年
//                        不同年 跨月+1   ,
                    //    不同年同月 ,
//                        不同年不同月  ,
//                        不同年跨月+3,
//                        不同年 跨月-1   ,
//                        不同年跨月-3


                    for (var m = 1; m <= len; m++) {
                        if (m >= arrBtw[0] && m <= arrBtw[1]) {
                            str += '<td class="' + bgColor + '"></td>';
                        } else {
                            str += '<td></td>';
                        }
                    }
                    str += '</tr>';
                }


                str += '</tbody>';
                return str;
            },
            getCalendar: function (events) {
                var len = this.getLen();
                var d = new Date(this._year, this._month - 1, 1);
                var dfw = d.getDay();
                var arr = ["日", "一", "二", "三", "四", "五", "六"];
                var tem = 0;
                var str = "";

//                str += '<h4>' + this._year + '年' + this._month + '月' + this._date + '日</h4>';//标题
                str += '<table class="sign_tab" >';
                str += '<thead>';
                for (var n = 1; n <= len; n++) {
                    var week = new Date(this._year + '-' + this._month + '-' + n).getDay();
                    str += '<th>' + arr[week] + '</th>';
                }
                str += '</tr>';
//                str += '<tbody>';
                str += '<tr>';
                for (var m = 1; m <= len; m++) {
                    str += '<th>' + m + '</th>';
                }
                str += '</tr>';
                str += '</thead>';
                str += '</table>';
                return str;
            },
            nextMonth: function (callback) {
                if (this._month == 12) {
                    this._year++;
                    this._month = 0;
                }
                this._month++;
                callback && callback(this._year + "-" + this._month + "-1");
            },
            nextYear: function () {
                this._year++;
            },
            previousMonth: function (callback) {
                if (this._month == 1) {
                    this._year--;
                    this._month = 13;
                }
                this._month--;
                callback && callback(this._year + "-" + this._month + "-1");
            },
            curMonth: function (callback) {
                this._year = new Date().getFullYear();
                this._month = new Date().getMonth() + 1;
                callback && callback(this._year + "-" + this._month + "-1");
            },
            curYearMonth: function (year, month, callback) {
                this._year = year;
                this._month = parseInt(month);
                var dt=new Date(this._year + "-" + this._month + "-1").setDate(1);
                callback && callback(dt);
            },
            previousYear: function () {
                this._year--;
            }
        };

        Array.prototype.contains = function (element) {
            for (var i = 0; i < this.length; i++) {
                if (this[i] == element) {
                    return true;
                }
            }
            return false;
        };
    </script>
</head>
<body class="easyui-layout" style="border:none !important;">
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:10;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.6;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">
    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class=" row" style="margin:0;">


                <button type="button" class="btn  btn-warning backBtn "
                        style="font-size:12px;height:30px;line-height:1;">返回
                </button>


                <div class="pull-right " style="    height: 30px;
    line-height: 30px;">
                    <span style="    background: #66cc00;width: 20px;height: 20px;display: inline-block;margin-right: 5px;vertical-align: middle;"></span><span>售出</span>
                    <span style="    background: #da4654;width: 20px;height: 20px;display: inline-block;margin-right: 5px;vertical-align: middle;"></span><span>锁定</span>
                    <span style="    background: #fff;border:1px solid #ccc;width: 18px;height: 18px;display: inline-block;margin-right: 5px;vertical-align: middle;"></span><span>空闲</span>
                </div>
                <div class="col-xs-2 pull-right" style="maring-right:15px;width:70px;padding:0 5px ">
                    <select class="form-control input-xs" id="monthDat">
                        <option value="01">1月</option>
                        <option value="02">2月</option>
                        <option value="03">3月</option>
                        <option value="04">4月</option>
                        <option value="05">5月</option>
                        <option value="06">6月</option>
                        <option value="07">7月</option>
                        <option value="08">8月</option>
                        <option value="09">9月</option>
                        <option value="10">10月</option>
                        <option value="11">11月</option>
                        <option value="12">12月</option>
                    </select>
                </div>
                <div class="col-xs-2 pull-right" style="width:100px;padding:0 5px ">
                    <select class="form-control input-xs" id="yearDat">
                    </select>
                </div>
            </div>
        </form>
    </div>

</div>
<div data-options="region:'center'" style="border:none !important;padding:10px;padding-top: 0;">
    <%--<button onclick="Calendar.previousMonth(initCal)">上一月</button>--%>
    <%--<button onclick="Calendar.nextMonth(initCal)">下一月</button>--%>
    <%--<button onclick="Calendar.curMonth(initCal)">本月</button>--%>

    <div style="display: flex;min-width:1200px;overflow: auto">
        <!--<div style="display: flex;min-width:1200px;height:500px;overflow: auto">-->
        <div id="datatb" style="flex: 1;" class="calendarCust">
            <div>
                <table class="sign_tab">
                    <colgroup>
                        <col width="3"/>
                        <col width="10"/>
                        <col width="10"/>
                        <col width="10"/>
                        <col width="10"/>
                        <col width="10"/>
                    </colgroup>
                    <thead>
                    <tr>
                        <th>序号</th>
                        <th>点位名称</th>
                        <th>所在场所</th>
                        <th>详细位置</th>
                        <th>规格(mm)</th>
                        <th>价格方案</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <div style="flex: 1;min-width:700px;" id="box" class="calendarCust"></div>
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
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;"
       id="">修改点位状态</p>
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
<script>
    (function (window, $, undefined) {
        var reloadUrl = "/ydz/mediaresource/getMediaPointPeriod";//列表数据
        $(function () {
            $(".searchBtn").click(function () {
                reload();
            })
            var myDate = new Date();
            var startYear = 2017;//
            var endYear = myDate.getFullYear() + 3;//结束年份
            var obj = document.getElementById('yearDat')
            $("#yearDat").empty();
            for (var i = startYear; i <= endYear; i++) {
                obj.options.add(new Option(i + "年", i));
            }
            $("#yearDat").val(new Date().getFullYear());
            var md = Number(new Date().getMonth()) + 1;
            if (md < 10) {
                md = "0" + md
            }
            ;
            $("#monthDat").val(md);
            $("#monthDat").select2({
                minimumResultsForSearch: Infinity
            }).on("select2:select", function (evt) {
                if (evt) {
                    var dtsel = $("#monthDat").select2("data");
                    onLoadSuccess(arrData);
                }
            });
            $("#yearDat").select2({
                minimumResultsForSearch: Infinity
            }).on("select2:select", function (evt) {
                if (evt) {
                    var dtsel = $("#yearDat").select2("data");
                    onLoadSuccess(arrData);
                }
            });

//            $(".city").click(function (e) {
//                SelCity(this,e);
//            });

            var rto2 = function () {
                var dtn = '<option value="">环境属性</option>';
                return dtn;
            }
            $("#contacterDp").html(rto2()).select2({minimumResultsForSearch: Infinity});
            var rto1 = function () {
                var dtn = '<option value=""></option>';
                return dtn;
            }
            $("#dateDat").html(rto1()).select2({minimumResultsForSearch: Infinity});
            reload();
        })
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
            }
        };
        var arrData = [];
        function reload() {
            var planNo = '${planNo}';
            var pointNo = '${pointNo}';
            var type = planNo == "" ? "point" : "plan";
            if (type == "point") {
                $(".backBtn").text("返回点位资源管理");
                $(".backBtn").unbind("click").bind("click", function () {
                    window.location.href = "/openPage?pageName=media_media-point-list";
                });

            } else {
                $(".backBtn").text("返回投放计划");
                $(".backBtn").unbind("click").bind("click", function () {
                    window.location.href = "/openPage?pageName=media_media-run-plan-list";
                });
            }
            $("#datagrid-mask-msg").show();
            $.ajax({
                url: reloadUrl,
                data: {
                    "type": type,
                    "planNo": planNo,
                    "pointNo": pointNo,
                },
                dataType: "json",
                success: function (callback) {
                    $("#datagrid-mask-msg").hide();
                    if (callback.code == "1") {
                        var data = callback.runplans;
                        arrData = callback.runplans;
                        onLoadSuccess(data);
                    } else {
                        arrData = [];
                    }
                },
                error: function () {
                    $("#datagrid-mask-msg").hide();
                    arrData = [];
                }
            })
        }
        function initCal(cal) {
            Calendar.init(cal);//
            $("#box").html(Calendar.getCalendar());
            $("#box .sign_tab").append(Calendar.getCaleBtw(arrData, cal));
        }
        function onLoadSuccess(data) {
            if (true) {
                Calendar.curYearMonth($("#yearDat").val(), $("#monthDat").val(), initCal);
                var d = [];
                var arrdata = [
                    "日"
                    , "周"
                    , "月"
                    , "季度"
                    , "半年"
                    , "年"
                ];
                for (var i = 0; i < data.length; i++) {
                    var num = Number(data[i].priceWay) - 1;
                    var str = num >= 0 ? arrdata[num] : "";
                    var priceWay = data[i].unitPrice + "/" + str;
                    d.push("<tr><td>" + (i + 1) + "</td><td>" + data[i].pointName + "</td><td>" + data[i].place + "</td><td>" + data[i].pointLocation + "</td><td>" + data[i].specification + "</td><td>" + priceWay + "</td></tr>");
                }
                $("#datatb tbody").empty().html(d.join(" "));
            } else {
                $(".sign_tab tbody").empty();
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        }
    })(window, jQuery);
</script>
</body>
</html>