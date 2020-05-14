<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>项目合同明细</title>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>详情</title>
    <link rel="stylesheet" type="text/css" href="/resources/common/common.css?v=3e10f9c6f9">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=1c43353511">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=95d4665fda">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=ca049c7ec2">
    <style>
        .btn-group.open .dropdown-toggle, .btn-group.currentVersion .dropdown-toggle {
            -webkit-box-shadow: none;
            border: 1px solid #4284d9;
            color: #4284d6;
        }

        .btn-group.currentVersion .dropdown-toggle .caret {
            border-top-color: #4284d9;
        }

        .logInfo div {
            height: 30px;
        }

        label {
            font-weight: normal;
        }

        .tbWk td {
            border: 1px solid #eff1f9;
            /*border-width:0 1px 1px 0;*/

            padding: 10px;
        }

        .select2-selection--multiple {
            height: 31px;
        }

        .select2-selection--multiple ul {
            height: 31px;
            line-height: 31px;
        }

        .tbWk {
            /*border: 1px solid #e4e4e4;*/
            color: #000;
        }

        .tbWk th {
            text-align: center;
            border: 1px solid #eff1f9 !important;
            background: #eff1f3;
            font-size: 14px;
            height: 40px;
            background: #eff1f9;
            border-width: 0;
            font-weight: normal;
            color: #666;
            line-height: 40px;
            cursor: default;
        }

        .Customer-address {
            height: auto;
            line-height: normal;
            color: #666;
        }

        .Customer-address span {
            margin-right: 15px;
        }

        .Customer-address {
            height: 30px;
            line-height: 30px;
            color: #999;
            font-weight: normal;
        }

        .bottom-new-box {
            margin-top: 2px;
            border-bottom: 1px solid #e0e3e6;
            padding: 8px 0;
        }

        .bottom-new-box .left-box {
            padding: 0;
            background-color: transparent;
        }

        .bottom-new-box .left-box .remove-btn {
            cursor: pointer;
        }

        .bottom-new-box .left-box .remove-btn:hover {
            color: #ff0000;
        }

        .bottom-new-box .left-box .add-btn {
            cursor: pointer;
        }

        .bottom-new-box .left-box .add-btn:hover {
            color: #ff0000;
        }

        .bottom-new-box .urgent {
            display: inline-block;
        }

        .bottom-new-box .urgent > span {
            margin-right: 10px;
        }

        .bottom-new-box .right-box {
            color: #337AB7;
            line-height: 2em;
        }

        .bottom-new-box .right-box > span {
            margin-right: 10px;
        }

        .bottom-new-box .right-box .price {
            font-weight: bold;
        }

        #bottomBox {
            margin-top: 1em;
        }

        #bottomBox > .h-box:not(.actions) {
            height: 186px;
        }

        #bottomBox .ui.divider {
            margin: 0.5rem 0;
        }

        #bottomBox .create-info {
            height: 20px;
        }

        #bottomBox .create-info .value {
            padding: 0 8px;
        }

        #bottomBox .remark-container {
            padding-right: 2em;
        }

        #bottomBox .right-summary > .h-box {
            height: 2.4em;
            width: 295px;
            line-height: 2em;
        }

        #bottomBox .right-summary > .h-box > .box {
            padding: 2px;
        }

        #bottomBox .right-summary > .h-box > .box.price {
            padding-right: 2em;
        }

        #bottomBox .right-summary > .h-box > .flex-box {
            height: 100%;
            overflow: hidden;
        }

        #bottomBox .right-summary > .h-box > .flex-box .ui.input {
            margin: 2px 0 0 8px;
        }

        #bottomBox .right-summary > .h-box > .flex-box .ui.input i {
            width: 1.4em;
        }

        #bottomBox .right-summary > .h-box > .flex-box .ui.input i.icon.percent:before {
            content: "%";
        }

        #bottomBox .right-summary > .h-box > .flex-box input {
            padding: 4px 12px 4px 4px !important;
        }

        #bottomBox .right-summary > .h-box .font-btn {
            display: inline-block;
            padding: 2px;
            color: #fff;
            height: 20px;

            text-align: center;
            line-height: 14px;
            margin-left: 1em;
            border-radius: 4px;
            cursor: pointer;
            background-color: #8e8e8e;
        }

        #bottomBox .right-summary > .h-box .font-btn.active,
        #bottomBox .right-summary > .h-box .font-btn:hover {
            background-color: red;
        }

        #bottomBox .right-summary > .h-box .font-btn.active:hover {
            background-color: #8e8e8e;
        }

        /*
            2017 6.17
            创建订单移出的cola样式
            */
        .v-box,
        .h-box {
            position: relative;
            -webkit-flex-wrap: nowrap;
            -ms-flex-wrap: nowrap;
            flex-wrap: nowrap;
            -webkit-justify-content: flex-start;
            -ms-flex-pack: start;
            justify-content: flex-start;
            -webkit-align-content: stretch;
            -ms-flex-line-pack: stretch;
            align-content: stretch;
            -webkit-align-items: flex-start;
            -ms-flex-align: start;
            align-items: flex-start;
        }

        .v-box > .box,
        .h-box > .box {
            overflow: visible;
        }

        .v-box > .flex-box,
        .h-box > .flex-box {
            overflow: auto;
        }

        .v-box .box,
        .h-box .box {
            -webkit-flex: 0 1 auto;
            -ms-flex: 0 1 auto;
            flex: 0 1 auto;
            -webkit-align-self: auto;
            -ms-flex-item-align: auto;
            align-self: auto;
        }

        .v-box .flex-box,
        .h-box .flex-box {
            -webkit-box-flex: 1;
            -moz-box-flex: 1;
            -webkit-flex: 1 1 auto;
            -ms-flex: 1 1 auto;
            flex: 1 1 auto;
            -webkit-align-self: auto;
            -ms-flex-item-align: auto;
            align-self: auto;
        }

        .v-box .flex-box > *,
        .h-box .flex-box > * {
            position: absolute !important;
            left: 0;
            right: 0;
            top: 0;
            bottom: 0;
        }

        .v-box {
            height: 100%;
            -webkit-flex-direction: column;
            -ms-flex-direction: column;
            flex-direction: column;
            -webkit-box-orient: vertical;
            -moz-box-orient: vertical;
        }

        .v-box > * {
            position: relative;
            width: 100%;
        }

        .h-box {
            width: 100%;
            -webkit-flex-direction: row;
            -ms-flex-direction: row;
            flex-direction: row;
            -webkit-box-orient: horizontal;
            -moz-box-orient: horizontal;
        }

        .h-box > * {
            position: relative;
            height: 100%;
        }

        .v-box.center,
        .h-box.center {
            -webkit-justify-content: center;
            -ms-flex-pack: center;
            justify-content: center;
        }

        .v-box.end,
        .h-box.end {
            -webkit-justify-content: flex-end;
            -ms-flex-pack: end;
            justify-content: flex-end;
        }

        /* Text Area */
        .ui.input.textarea {
            width: 100%;
        }

        textarea {
            margin: 0em;
            -webkit-appearance: none;
            tap-highlight-color: rgba(255, 255, 255, 0);
            padding: 0.78571429em 1em;
            background: #FFFFFF;
            border: 1px solid rgba(34, 36, 38, 0.15);
            outline: none;
            color: rgba(0, 0, 0, 0.87);
            border-radius: 0.28571429rem;
            box-shadow: 0em 0em 0em 0em transparent inset;
            -webkit-transition: color 0.1s ease, border-color 0.1s ease;
            transition: color 0.1s ease, border-color 0.1s ease;
            font-size: 1em;
            line-height: 1.2857;
            resize: vertical;
            vertical-align: top;
            width: 100%;
        }

        textarea:not([rows]) {
            height: 12em;
            /*min-height: 6em;*/
            /*max-height: 24em;*/
        }

        textarea:focus {
            color: rgba(0, 0, 0, 0.95);
            border-color: #85b7d9;
            border-radius: 0.28571429rem;
            background: #ffffff;
            box-shadow: none;
            -webkit-appearance: none;
        }

        textarea {
            vertical-align: top;
        }

        textarea.error {
            background: #fff6f6;
            border-color: #e0b4b4;
            color: #9f3a38;
            box-shadow: none;
        }

        .ui.input {
            font-size: 1em;
        }

        .ui.input {
            position: relative;
            font-weight: normal;
            font-style: normal;
            display: -webkit-inline-flex;
            display: -ms-inline-flexbox;
            display: inline-flex;
            color: rgba(0, 0, 0, 0.87);
        }

        .ui.icon.input > i.icon:before, .ui.icon.input > i.icon:after {
            left: 0;
            position: absolute;
            text-align: center;
            top: 50%;
            width: 100%;
            margin-top: -0.5em;
        }

        .ui.input input {
            margin: 0em;
            max-width: 100%;
            -webkit-box-flex: 1;
            -webkit-flex: 1 0 auto;
            -ms-flex: 1 0 auto;
            flex: 1 0 auto;
            outline: none;
            -webkit-tap-highlight-color: rgba(255, 255, 255, 0);
            text-align: left;
            padding: 0px 30px 0px 10px;
            height: 30px;
            line-height: 30px;
            background: #FFFFFF;
            color: #999;
            border-radius: 3px;
            box-shadow: none;
        }

        .ui.icon.input > i.icon:not(.link) {
            pointer-events: none;
        }

        .ui.icon.input > i.icon {
            cursor: default;
            position: absolute;
            line-height: 1;
            text-align: center;
            top: 0px;
            right: -3px;
            margin: 0em;
            height: 100%;
            width: 2.67142857em;
            opacity: 0.5;
            border-radius: 0em 0.28571429rem 0.28571429rem 0em;
            -webkit-transition: opacity 0.3s ease;
            transition: opacity 0.3s ease;
        }

        i.icon, i.icons {
            font-size: 1em;
        }

        .ui.divider:not(.vertical):not(.horizontal) {
            border-top: 1px solid rgba(34, 36, 38, 0.15);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .ui.divider {
            font-size: 1rem;
        }

        .ui.divider {
            margin: 1rem 0rem;
            line-height: 1;
            height: 0em;
            font-weight: bold;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: rgba(0, 0, 0, 0.85);
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
            -webkit-tap-highlight-color: rgba(0, 0, 0, 0);
        }

        .dropdown-menu {
            min-width: 40px !important;
        }

        .btn-group.open .dropdown-toggle, .btn-group.current .dropdown-toggle {
            -webkit-box-shadow: none;
            border: 1px solid #4284d9;
            color: #4284d6;
        }

        .btn-group.current .dropdown-toggle .caret {
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
            padding: 10px 0 10px 6px;
            width: 100px;
            color: #2e8ae6;
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
        .datagrid-btable, .datagrid-btable tr{
            height: 39px;

        }
        .header {
            margin: 11px 0 36px 0;
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

        #bottomBox .right-summary > .h-box > .flex-box input {
            padding: 4px 12px 4px 4px !important;
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
            padding: .5em .4em;
            text-align: right
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

        .step_click .iconfont_new, .step_click p {
            color: #4e8ae6;
        }

        .step_circle {
            cursor: pointer;
        }

        .step_circle .icon_select_opp {
            width: 40px;
            height: 40px;
            display: block;
            background: url("/images/page/unselect_opp.png") center center no-repeat;
            background-size: cover;
        }

        .step_circle .icon_select_win {
            width: 40px;
            height: 40px;
            display: block;
            background: url("/images/page/unselect_win.png") center center no-repeat;
            background-size: cover;
        }

        .step_circle .icon_select_lose {
            width: 40px;
            height: 40px;
            display: block;
            background: url("/images/page/unselect_lose.png") center center no-repeat;
            background-size: cover;
        }

        .step_click .icon_select_opp {
            width: 40px;
            height: 40px;
            display: block;
            background: url("/images/page/selected_opp.png") center center no-repeat;
            background-size: cover;
            background-size: cover;
        }

        .step_click .icon_select_win {
            width: 40px;
            height: 40px;
            display: block;
            background: url(/images/page/select_win.png) center center no-repeat;
            background-size: cover;

        }

        .step_click .icon_select_lose {
            width: 40px;
            height: 40px;
            display: block;
            background: url("/images/page/select_lose.png") center center no-repeat;
            background-size: cover;
        }

        .step_line3 {
            width: 80px;
            height: 80px;
        }

        .runStep {
            width: 80px;
            height: 80px;
            display: block;
            /*background: url(/images/page/load3.gif) center center no-repeat;*/
            background-size: cover;
        }
    </style>
    <style>
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

        .nav-tabs li:nth-child(3).smcolor ~ .block {
            transform: translate(194px, 0);
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
            left: 9px;
            width: 70px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }
    </style>

    <style>
        #modifyYdzMenuWin {
            z-index: 3;
        }

        #autoEditOnceWin {
            z-index: 2;
        }

        #deleteYdzWin {
            z-index: 4;
        }

        #versionControlWin {
            z-index: 5;
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

        .form-group > div {
            padding: 6px 0;
            color: #555;
            height:29px;
        }

        .form-group {
            margin-bottom: 16px;
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
    <script src="/resources/easyui/pace.min.js?v=fe5e2eaca6"></script>
    <link rel="stylesheet" type="text/css" href="/resources/easyui/uploadify.css">

</head>

<body class="modal-page" style="padding:0!important;">
<div id="deleteYdzWin"
     style="    padding-top: 5px;
    left: 50%;
    position: fixed;
    margin-left: -150px;
    top: 70px;
    width: 380px;
    height: 206px;">
    <p style="    position: relative;
    font-weight: 100;
    text-align: left;
    font-size: 18px;
    margin: 0px auto;
    padding: 5px 20px;
    border-bottom: 1px solid #ccc;" id="titleDel">
        删除自定义分类</p>
    <span class="closetranform" style="    position: absolute;
    top: 15px;
    right: 1px;
    display: block;
    height: 30px;
    width: 30px;
    cursor: pointer;"><i
            style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
            alt="点击关闭"></i></span>
    <div style="    text-align: center;
    margin: 40px auto;">
        <span class="customerjc" id="contentDel" style="    position: relative;
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
<div style="padding: 1em 15px !important;">
    <div class="main">
        <div class="fixheader">
            <button type="button" class="btn backMain "
                    style="font-size:14px;height:30px;line-height:1;margin:0px 8px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6f6;</i>返回
            </button>


            <button type="button" did="02" class="btn btn-primary statusChange pull-right hide"
                    style="margin:4px 8px 10px 0px">合同完成
            </button>
            <button type="button" class="btn statusChange pull-right hide" did="04"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe723;</i>作废
            </button>


            <button type="button" class="btn statusRenew  pull-right hide" did="05"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe725;</i>恢复
            </button>

            <button type="button" class="btn statusChange pull-right hide" did="03"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe724;</i>终止
            </button>


            <button type="button" class="btn modifyMain pull-right hide"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e6;</i>修改
            </button>

        </div>

        <div class="contentTp">
            <div class="contenTpl" style="    display: -webkit-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;">
                <div style="padding:22px 40px;height:738px;width:49%;margin-right:10px;background: #f5f5f9">
                    <section style="
    margin-bottom: 10px;
    /*background: #f8f8fc;*/
    min-height: 100px;
">
                        <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin-bottom: 40px;">基本信息</h1>
                        <div style="width:80%;margin:0 auto;">

                            <div class="form-group">


                                <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">合同名称</label>
                                <div class="contractDesc" style="
">
                                </div>

                            </div>
                            <div style="width: 40%; display: inline-block;">
                                <div class="form-group">

                                    <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">客户</label>
                                    <div class="clientsDp" style="">

                                    </div>
                                </div>
                                <div class="form-group">

                                    <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">联系方式</label>
                                    <div class="contactTel" style="">

                                    </div>
                                </div>

                                <div class="form-group">

                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">开始日期</label>
                                    <div class="startDate">

                                    </div>
                                </div>

                                <div class="form-group">


                                    <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">合同签约金额(元)</label>
                                    <div class="contractMoney" style="">

                                    </div>
                                </div>


                            </div>

                            <div style="width: 40%;vertical-align:top;display: inline-block;float: right;">
                                <div class="form-group">

                                    <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">联系人</label>
                                    <div class="contactName" style="">

                                    </div>
                                </div>
                                <div class="form-group">


                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">销售代表</label>
                                    <div class="saleManDp" style="">

                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">结束日期</label>
                                    <div class="endDate" style="">

                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">合同实际金额</label>
                                    <div class="actualMoney" style="">

                                    </div>

                                </div>
                            </div>


                        </div>
                    </section>

                    <section style="
    margin-bottom: 10px;
    /*background: #f8f8fc;*/
    min-height: 100px;
">
                        <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    
    margin-bottom: 40px;">合同信息</h1>
                        <div style="width:80%;margin:0 auto;">
                            <div class="form-group">
                                <label class="control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">合同状态</label>
                                <div class="status" style="">

                                </div>
                            </div>
                            <div style="width: 40%; display: inline-block;">
                                <div class="form-group">
                                    <label class="control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">签约日期</label>
                                    <div class="signDate" style="">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">客户签约人</label>
                                    <div class="partenerSigner" style="">

                                    </div>
                                </div>
                                <div class="form-group">


                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">关联商机</label>
                                    <div class="oppoNo" style="">

                                    </div>


                                </div>

                            </div>
                            <div style="width: 40%;vertical-align:top;display: inline-block;float: right;">

                                <div class="form-group">
                                    <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">合同编号</label>
                                    <div class="contractNo" style="">

                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class=" control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">我方签约人</label>
                                    <div class="ourSigner" style="
">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class=" control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 12px;
    color:#c3c3c5;
">合同附件</label>
                                    <div class="" style="">


                                        <div id="attachFile"></div>


                                    </div>
                                </div>

                            </div>


                        </div>
                    </section>
                    <div style="display: none;"><input type="submit" id="subMain">提交</div>


                </div>

                <div class="contentTp12" style="
            -webkit-box-flex: 1;
    -moz-box-flex: 1;
    -webkit-flex: 1 1 auto;
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    -webkit-align-self: auto;
    -ms-flex-item-align: auto;
    align-self: auto;padding:10px 40px;
        height:738px;width:49%;background: #f5f5f9">
                    <ul class="nav nav-tabs" id="navCondition">
                        <li style="position:relative;" data-s="04" onclick="cgx(this,'4');" class="order4 smcolor"><a
                                href="#">联系记录</a>
                        </li>
                        <li style="position:relative;" data-s="CC" onclick="cgx(this,'6');" class=" order6"><a href="#">参与人员</a>
                        </li>
                        <li style="position:relative;" data-s="" onclick="cgx(this,'');" class="order"><a
                                href="#">操作动态</a></li>
                        <li class="block"></li>
                    </ul>
                    <div class="conListView" style="margin-top: 10px;">
                        <textarea id="addChatMsgCon" placeholder="添加联系记录" style="resize:none;height: 80px;"></textarea>
                        <button type="button" class="btn btn-primary addChatMsg pull-right"
                                style="margin:10px 0 20px 0;">发布
                        </button>
                        <div style="    clear: both;
    height: 480px;
    overflow: auto;">
                            <ul class="talkList">


                            </ul>
                        </div>
                    </div>
                    <div class="conListView hide" style="margin: 10px;">
                        <span style="display:block;margin: 20px;">跟进人员：</span>
                        <select type="text" disabled="disabled" multiple="multiple" readonly style="width: 100%;"
                                class="form-control"
                                id="gxWaySel">
                        </select>
                    </div>
                    <style>
                        .conTalkList {
                            line-height: 20px;
                            margin-top: 10px;
                        }

                        .select2-dropdown {
                            z-index: 1;
                        }

                        #select2-gxWaySel-results {
                            max-height: 300px;
                        }

                        .talkList li {
                            margin: 10px auto;
                            background: #ededf3;
                            min-height: 60px;
                        }

                        .talkList li:first-child {
                            margin-top: 0;
                        }

                        .talkList li:last-child {
                            margin-bottom: 0;
                        }
                    </style>
                    <script>
                        //聊天记录 未分页 
                        var initChatList = function () {
                            $.ajax({
                                url: "/ydz/contract/getContractChatList?oppoNo=" + contractNo + "&page=1" + "&rows=50",
                                type: 'GET',
                                dataType: "json",
                                success: function (dt) {
                                    if (dt.code == "1") {
                                        var html = template('tpl-talk', dt);
                                        $(".talkList").html(html);
                                    }

                                }
                            });
                        }
                        $(function () {
                            $(".addChatMsg").on("click", function () {
                                var $t = $(this);

                                var con = $("#addChatMsgCon").val();
                                if ($.trim(con) == "") {
                                    return;
                                }
                                $t.attr("disabled", true);
                                var param = {
                                    "oppoNo": contractNo,
                                    "chatContent": con
                                }
                                $.ajax({
                                    url: "/ydz/contract/addContractChat",
                                    dataType: "json",
                                    type: "post",
                                    data: JSON.stringify(param),
                                    contentType: "application/json",
                                    success: function (data) {
                                        if (data.code == "1") {
                                            $t.attr("disabled", false);
                                            initChatList();
                                            $("#addChatMsgCon").val("");
                                        } else {
                                            $t.attr("disabled", false);
                                            $.mytoast({text: data.msg, time: 1000});
                                        }
                                    },
                                    error: function () {
                                        $t.attr("disabled", false);
                                        $.mytoast({text: "操作出错", time: 1000});
                                    }
                                })
                            })
                            initChatList();


                        })
                    </script>
                    <div class="conListView hide logInfo" style="margin-top: 10px;">
                        <%--<div><span>XXX</span><span class="pull-right">2423423423</span></div>--%>
                        <%--<div><span>XXX</span><span class="pull-right">2423423423</span></div>--%>
                    </div>
                </div>


            </div>


            <div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span>
            </div>


            <div style="margin-top: 11px" id="tableWrap" class="">
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
                        <%--<a style="color: #4e8ae6;cursor: pointer" class="addWin1"><span class="iconfont_new">&#xe6a1;</span>添加计划</a>--%>
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
                        <%--<a style="color: #4e8ae6;cursor: pointer" class="addWin2"><span class="iconfont_new">&#xe6a1;</span>添加记录</a>--%>
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
                        <%--<a style="color: #4e8ae6;cursor: pointer" class="addWin3"><span class="iconfont_new">&#xe6a1;</span>添加记录</a>--%>
                    </div>

                    <table id="createhkOrder" data-options="remoteSort:false,
fitColumns : true,
           nowrap:true,singleSelect:true,checkOnSelect:false,
          scrollbarSize:0,
           columns: [hkColumn()],
          data:globDataGridhk" class="easyui-datagrid" style="width:100%;height:auto;">
                    </table>


                </section>
            </div>
            <div id="bottomD" class="hide">
            </div>


        </div>
    </div>
</div>
<script id="tpl-talk" type="text/html">
    {{each rows as item i}}
    <li style="padding:5px;">
        <div><span>{{item.chatEmployeeName}}</span><span class="pull-right">{{item.createTime}}</span></div>
        <div class="conTalkList">{{item.chatContent}}</div>
    </li>
    {{/each}}

</script>
<script>
    var contractNo = '${contractNo}';
    function cgx(o, num) {
        $(o).addClass("smcolor").siblings().removeClass("smcolor");
        var status = $(o).attr("data-s");
        $(".conListView").addClass("hide");
        $(".conListView:eq(" + $(o).index() + ")").removeClass("hide");
    }
    $(function () {
        $(".backMain").one("click", function () {
            window.location.href = "/openPage?pageName=project_project-contract-list";
        })

        $(".modifyMain").one("click", function () {
            var turl = "/ydz/contract/forward-contract-update?contractNo=" + contractNo;
            window.location.href = turl;
        })
        $("#deleteYdzMenu").off().on("click", function () {
            var queryParams = {};
            $(this).attr("disabled", true);
            $.ajax({
                url: "/ydz/contract/changeContractStatus?contractNo=" + contractNo + "&status=" + delId,
                dataType: "json",
                contentType: "application/json",
                success: function (data) {
                    $(this).attr("disabled", false);
                    $.mytoast({text: data.msg, time: 1000});
                    if (data.code == "1") {
                        setTimeout(function () {
                            window.location.href = "/openPage?pageName=project_project-contract-list";
                        }, 2000)
                    } else {


                    }
                },
                error: function () {
                    $(this).attr("disabled", false);
                    $.mytoast({text: "操作出错", time: 1000});
                }
            })

        })

        var delId = "";
        $(".statusChange").on("click", function () {
            delId = $(this).attr("did");
            if (delId == "02") {
                $("#contentDel").text("项目款项已收齐？确定要完成吗？");
                $("#titleDel").text("完成项目合同");
            } else if (delId == "03") {
                //意外终止
                $("#contentDel").text("项目发生意外情况？确定要终止吗？");
                $("#titleDel").text("终止项目合同");
            } else if (delId == "04") {
                //合同作废
                $("#contentDel").text("项目发生意外情况？确定要作废吗？");
                $("#titleDel").text("作废项目合同");
            }

            $("#deleteYdzWin").css({display: 'block'});
        })
        $(".statusRenew").on("click", function () {
            delId = "01";
            $("#contentDel").text("操作失误，现在立即恢复到初始状态");
            $("#titleDel").text("恢复项目合同");
            $("#deleteYdzWin").css({display: 'block'});
        })
    })
</script>

<script id="tpl-con" type="text/html">

</script>


<script type="text/html" id="tpl-attach">
    {{each attachments}}
    <div>
        <a style="color:#4e8ae6"
           class=" up_filename"
           href="/ydz/contract/download-attachment?fileId={{$value.fileId}}">{{$value.fileName}}</a>
    </div>
    {{/each}}
</script>
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
    globejhDt.returnName =[];
    globejhDt.returnName['R1']='正常';
    globejhDt.returnName['R2']='坏账';
    globejhDt.returnName['R3']='货抵';
    globejhDt.monList = [
        {hkMoney: "", money2: "", hkDate2: ""},
        {hkMoney: "", money2: "", hkDate2: ""},
        {hkMoney: "", money2: "", hkDate2: ""}
    ];// hkmoney 比例   money2 金额     hkDate2 回款日期

    var contractStatus = [
        {
            id: "01",
            text: "执行中"
        }, {
            id: "02",
            text: "已完成"
        }, {
            id: "03",
            text: "意外终止"
        }, {
            id: "04",
            text: "合同作废"
        }];
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
    var GlobeparticipantEmployeeId = "";
    $(function () {

        if (contractNo == null || contractNo == "") {
//            noOppoFun();   //新建路由
        } else {
            // 修改路由
            $.ajax({
                url: "/ydz/contract/getOneContractProjectAllInfo?contractNo=" + contractNo,
                dataType: "json",
                success: function (dt) {
                    if (dt.code == 1) {
                        oppoFun(dt);
                        var emId = dt.contract.participantEmployeeId;
                        if (emId != "") {
                            GlobeparticipantEmployeeId = emId.split(",");
                        }
                        // 参与人员
                        var initParticipFun = function () {
                            var delFun = function (empId) {
                                $.ajax({
                                    url: "/ydz/contract/updateContractByPara?contractNo=" + contractNo + "&participantEmployeeId=" + empId,
                                    success: function (dt) {

                                    }
                                })
                            }
                            var optionFun = function () {
                                $.ajax({
                                    url: "/ydz/salesorder/listSalesMan",
                                    dataType: "json",
                                    success: function (d) {
                                        var dtall = $.map(d, function (obj) {
                                            obj.text = obj.realName; // replace name with the property used for the text
                                            obj.id = obj.employeeId; // replace name with the property used for the text
                                            return obj;
                                        });
                                        $("#gxWaySel").select2({
                                            placeholder: "请添加参与人员",
//                    minimumResultsForSearch: Infinity,
                                            closeOnSelect: false,
                                            data: dtall
                                        }).val(GlobeparticipantEmployeeId).trigger("change").on("select2:select", function (evt) {
                                            if (evt) {
                                                var arr = [];
                                                var dtsel = $("#gxWaySel").select2("data");
                                                for (var k = 0; k < dtsel.length; k++) {
                                                    arr.push(dtsel[k].id);
                                                }
                                                delFun(arr.join(","));
                                            } else {
                                            }
                                        }).on("select2:unselect", function (evt) {
                                            if (evt) {
                                                var arr = [];
                                                var dtsel = $("#gxWaySel").select2("data");
                                                for (var k = 0; k < dtsel.length; k++) {
                                                    arr.push(dtsel[k].id);
                                                }
                                                delFun(arr.join(","));
                                            } else {
                                            }
                                        });
                                    }
                                })

                            }
                            optionFun();
                        }
                        initParticipFun();
                        var status = dt.contract.status;
                        if (status == "03" || status == "04") {
                            $(".statusRenew").removeClass("hide");
                            $("#addChatMsgCon").attr("disabled", true);
                            $(".addChatMsg ").attr("disabled", true);
                        } else if (status == "01") {
                            $(".statusChange").removeClass("hide");
                            $(".modifyMain").removeClass("hide");
                            $("#gxWaySel").removeAttr("disabled");
//                            $(".statusRenew").removeClass("hide");
                        } else if (status == "02") {
                            $("#addChatMsgCon").attr("disabled", true);
                            $(".addChatMsg ").attr("disabled", true);
                        }


                    } else {
                        $(".copyMain").attr("disabled", true);
                    }

                },
                error: function () {
                }
            })
        }
//        function noOppoFun() {
//            $.ajax({
//                url: "/ydz/contract/getContractNo",
//                dataType: "json",
//                success: function (data) {
//                    $("input[name='contractNo']").val(data);
//                }
//            });
//            $.ajax({
//                url: "/ydz/salesorder/listSalesMan",
//                dataType: "json",
//                success: function (dt) {
//                    // dt=[];
//                    // $("#saleManDp").html( returnopt(data,2));
//                    var dtall = $.map(dt, function (obj) {
//                        obj.text = obj.realName; // replace name with the property used for the text
//                        obj.id = obj.employeeId; // replace name with the property used for the text
//                        return obj;
//                    });
//                    // 参与人员
//                    $("#ourSigner").select2({
//                        placeholder: "请添加签约人",
//                        minimumResultsForSearch: Infinity,
//                        data: dtall
//                    }).val("").trigger("change");
//                    var returnopt = function (data) {
//                        var opt = "";
//                        for (var i = 0; i < data.length; i++) {
//                            var dt = data[i];
//                            opt += '<li did="' + dt.employeeId + '"><a href="javascript:;">' + dt.realName + '</a></li>';
//                        }
//                        return opt;
//                    }
//                    tixinPerson = dt;
//                    shoukuanPerson = returnopt(dt);
//                    var dtall = $.map(dt, function (obj) {
//                        obj.text = obj.realName; // replace name with the property used for the text
//                        obj.id = obj.employeeId; // replace name with the property used for the text
//                        return obj;
//                    });
//                    $("#saleManDp").select2({data: dtall, minimumResultsForSearch: Infinity});
//                },
//                error: function () {
//                }
//            })
//            oppProjectFun();
//            selectOptOppFun();
//            //项目类型
//            //人员
//            $.ajax({
//                url: "/system/partner/simpleCustomerList",
//                dataType: "json",
//                success: function (data) {
//
//                    $("#clientsDp").html(opportunityFun.returnopt(data, 1)).val("");
//
//                    $("#clientsDp").select2({
//                        placeholder: "请选择客户",
//                        templateResult: opportunityFun.formatState
//                    });
//
//
//                    $("#partenerSigner").select2({minimumResultsForSearch: Infinity});
//                    $("#clientsDp").on("change", function (e) {
//                        $.ajax({
//                            url: "/ydz/purchaseorder/listContacter",
//                            dataType: "json",
//                            data: {"partnerKey": $(this).val()},
//                            timeout: "8000",
//                            success: function (data) {
//                                $("#partenerSigner").html(opportunityFun.returnopt(data, 2));
//                                $("#partenerSigner").select2({
//                                    minimumResultsForSearch: Infinity
//                                });
//                            },
//                            error: function () {
//                            }
//                        })
//                    });
//                },
//                error: function () {
//                }
//            });
//            $('#endDate').datetimepicker({
//                format: 'yyyy-mm-dd',
//                widthCustom: '285px',
//                language: 'zh-CN',
//                autoclose: true,
//                minView: 'month',
//                todayBtn: true
//            }).on("click", function () {
//                $("#endDate").datetimepicker("setStartDate", $("#startDate").val())
//            });
//
//            $('#startDate').datetimepicker({
//                format: 'yyyy-mm-dd',
//                widthCustom: '285px',
//                language: 'zh-CN',
//                autoclose: true,
//                minView: 'month',
//                todayBtn: true
//            }).on("click", function () {
//                $("#startDate").datetimepicker("setEndDate", $("#endDate").val())
//            });
//            $('#signDate').datetimepicker({
//                format: 'yyyy-mm-dd',
//                widthCustom: '285px',
//                language: 'zh-CN',
//                autoclose: true,
//                minView: 'month',
//                todayBtn: true
//            })
//
//
//        }

        function oppoFun(dtRt) {
            var dopp = dtRt.contract;
            $("#createhkOrder").datagrid("loadData", dtRt.returnMoneys);
            $("#createjhOrder").datagrid("loadData", dtRt.plans);
            $("#createkpOrder").datagrid("loadData", dtRt.invioces);

            var html = template('tpl-attach', dtRt);
            $("#attachFile").after(html);
//            $.ajax({
//                url: "/ydz/salesorder/listSalesMan",
//                dataType: "json",
//                success: function (dt) {
//                    // dt=[];
//                    var dtall = $.map(dt, function (obj) {
//                        obj.text = obj.realName; // replace name with the property used for the text
//                        obj.id = obj.employeeId; // replace name with the property used for the text
//                        return obj;
//                    });
//                    // 参与人员
//
//                    $("#ourSigner").select2({
//                        placeholder: "请添加参与人员",
//                        minimumResultsForSearch: Infinity,
//                        data: dtall
//                    }).val(dopp.ourSignerId).trigger("change");
//
//                    var returnopt = function (data) {
//                        var opt = "";
//                        for (var i = 0; i < data.length; i++) {
//                            var dt = data[i];
//                            opt += '<li did="' + dt.employeeId + '"><a href="javascript:;">' + dt.realName + '</a></li>';
//                        }
//                        return opt;
//                    }
//                    tixinPerson = dt;
//                    shoukuanPerson = returnopt(dt);
//
//                    var dtall = $.map(dt, function (obj) {
//                        obj.text = obj.realName; // replace name with the property used for the text
//                        obj.id = obj.employeeId; // replace name with the property used for the text
//                        return obj;
//                    });
//                    $("#saleManDp").select2({
//                        data: dtall,
//                        minimumResultsForSearch: Infinity
//                    }).val(dopp.salesId).trigger("change");
//                },
//                error: function () {
//                }
//            })
            for (var i = 0; i < contractStatus.length; i++) {
                if (contractStatus[i].id == dopp.status) {
                    $(".status").text(contractStatus[i].text);
                }
            }
            ;
            $(".saleManDp").text(dopp.salesName);
            $(".clientsDp").text(dopp.partnerName);
            $(".contactTel").text(dopp.contactTel);
            $(".endDate").text(dopp.endDate);
            $(".startDate").text(dopp.startDate);
            $(".contractDesc").text(dopp.contractDesc);
            $(".projectTypeDesc").text(dopp.projectTypeDesc);
            $(".contractNo").text(dopp.contractNo);

            var oppoNotp = "";

            if (dopp.oppoNo == "" || dopp.oppoNo == null) {
                oppoNotp = "";
            }
            else {
                var oppoArr = dopp.oppoNo.split(",");
                oppoArr.forEach((function (item, index) {
                    oppoNotp += "<p>" + item + "</p>";
                }))
            }
            $(".oppoNo").html(oppoNotp);
            $(".signDate").text(dopp.signDate);
            $(".contractMoney").text(dopp.contractMoney);
            $(".partenerSigner").text(dopp.partnerSignerName);
            $(".ourSigner").text(dopp.ourSignerName);
            $(".actualMoney").text(dopp.actualContractMoney);
            $(".contactName").text(dopp.contactName);
            $(".contactId").text(dopp.contactId);
//            oppProjectFun();
//            selectOptOppFun();

//            $.ajax({
//                url: "/system/partner/dropdownPartner?partnerType=1",
//                dataType: "json",
//                success: function (data) {
//                    $("#clientsDp").html(opportunityFun.returnopt(data, 1)).val(dopp.partnerKey);
//                    $("#clientsDp").select2({
//                        templateResult: opportunityFun.formatState
//                    });
//                    var funChange = function (id, defat) {
//                        $.ajax({
//                            url: "/ydz/purchaseorder/listContacter",
//                            dataType: "json",
//                            data: {"partnerKey": id},
//                            timeout: "8000",
//                            success: function (data) {
//                                $("#partenerSigner").html(opportunityFun.returnopt(data, 2));
//                                $("#partenerSigner").select2({
//                                    minimumResultsForSearch: Infinity
//                                }).val(defat).trigger("change");
//                            },
//                            error: function () {
//                            }
//                        })
//                    }
//                    $("#clientsDp").on("change", function (e) {
//                        funChange($(this).val(), "");
//                    });
//                    funChange(dopp.partnerKey, dopp.contactId);
//
//                },
//                error: function () {
//                }
//            });
//
//            $('#startDate').datetimepicker({
//                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true, minView: 'month', todayBtn: true
//            }).on("click", function () {
//                $("#startDate").datetimepicker("setEndDate", $("#endDate").val())
//            });
//            $('#endDate').datetimepicker({
//                format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true, minView: 'month', todayBtn: true
//            }).on("click", function () {
//                $("#endDate").datetimepicker("setStartDate", $("#startDate").val())
//            });


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
//

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
            formatEditLastkp(2, []);
        })

    });

    function readyData() {
        var readyData = {};
        var contractProject =
            {
                "contactId": "",
                "contactName": "",
                "contractDesc": $("input[name='contractDesc']").val(),
                "contractNo": $("input[name='contractNo']").val(),
                "oppoNo": "",//关联报价
                "ourSignerId": $("#ourSigner").val(),
                "ourSignerName": $("#ourSigner").find("option:selected").text(),
                "partnerSignerId": $("#partnerSigner").val(),
                "partnerKey": $("#clientsDp").val(),
                "partnerName": $("#clientsDp").find("option:selected").text(),
                "partnerShortname": "",
                "partnerSignerName": $("#partenerSigner").find("option:selected").text(),
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


    //            invoiceNo 开票单号
    function kpColumn() {
        var arr = [];
        arr.push({
            field: 'ind', align: 'center', title: '序号', formatter: function (value, row, index) {
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
            field: 'invoiceName', title: '票据类型', width: 80, formatter: function (value, row, index) {
                var t = globejhDt.invoiceName[row.invoiceType];
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
//        arr.push({
//            field: 'btn', title: '操作', align: 'center', width: 100, formatter: function (value, row, index) {
//                return formatCaozuokp(row);
//            }
//        });
        return arr;
    }
    function hkColumn() {

        var arr = [];
        arr.push({
            field: 'ind', align: 'center', title: '序号', formatter: function (value, row, index) {
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
                return '<span title="' + t + '">' + t + '</span>';


            }
        });
        arr.push({
            field: 'payName', title: '付款方式', width: 100, formatter: function (value, row, index) {
                var t = globejhDt.payName[row.payType];
                return '<span title="' + t + '">' + t + '</span>';
            }
        });
        arr.push({
            field: 'payeeName', title: '收款人', width: 80, formatter: function (value, row, index) {
                return value;
            }
        });
//        arr.push({
//            field: 'btn', title: '操作', align: 'center', width: 100, formatter: function (value, row, index) {
//                return formatCaozuohk(row);
//            }
//        });
        return arr;
    }
    function jhColumn() {
        var arrclm = [];
        arrclm.push({
            field: 'stage',align: 'center', title: '期次', formatter: function (value, row, index) {
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
        console.log($("#createjhOrder").datagrid("getRows"));
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
//                var html = template('tpl-addWin', dt);
//                $("#contractWin3").html(html);
        } else {
//                 dt={title:'增加回款计划',
//                    num:initNumHk,
//                    sjMoney:54544.34,
//                    qyMoney:55.34,
//                    tixin:'1633316810,3924589634'
//                };
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
            globejhDt.kpbz = -1;
            var dt = {title: '增加开票记录'};
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
        $(".dropdown_click").off().on("click", "li", function () {
            $(this).parent().prev("input").val($(this).text());
            $(this).parent().prev("input").attr("did", $(this).attr("did"));
        })
        $(".dropdown_clickMore").off().on("click", "li", function () {
            $(this).parent().prev("input").val($(this).text());
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
            url: "/ydz/opportunity/listOpportTypeDesc",
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
                    "typeDesc": menu2
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