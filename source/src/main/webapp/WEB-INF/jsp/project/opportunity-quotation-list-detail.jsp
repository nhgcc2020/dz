<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>商机报价单明细</title>
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
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=ea11ea1d51"></script>
    <script src="/resources/bootstrap/jquery.webui-popover.min.js?v=4f80ef33c0"></script>
    <script src="/resources/easyui/pace.min.js?v=fe5e2eaca6"></script>
    <script src="/resources/pageConfig.js?v=c1c50d6d4f"></script>
    <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=3768a187eb"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=6d91d60c6b"></script>
    <script src="/resources/business/base_new.js?v=1191ae2bcdf"></script>

</head>

<body class="modal-page" style="padding:0!important;">
<div style="padding: 1em 15px !important;">
    <div class="hide qrCodeDataCls" style="padding: 0;margin-right: 5px;width: 280px;height: 260px;"><p
            style="margin-top: 20px;text-align: center">扫一扫，转发给客户做确认</p>
        <div style="margin-top: 30px ;text-align: center;" class="qrCodeDataMid"></div>
    </div>
    <div class="main">
        <div class="fixheader">
            <button type="button" class="btn backMain "
                    style="font-size:14px;height:30px;line-height:1;margin:0px 8px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6f6;</i>返回
            </button>


          
            <button type="button" class="btn modifyMain pull-right"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e6;</i>修改商机
            </button>
            <button type="button" class="btn newAddMain pull-right"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e6;</i>修改报价
            </button>
            <button type="button" class="btn  pull-right" data-toggle="popover" data-container="body"
                    data-trigger="hover"
                    data-placement="bottom"
                    data-html="true"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e9;</i>转发报价单
            </button>
            <button type="button" class="btn oppoPrint pull-right"
                    style="font-size:14px;height:30px;line-height:1;margin:0px 10px 10px 0px;background:#fff;color:#7e92ab;padding:0;">
                <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e8;</i>打印报价单
            </button>
        </div>

        <div class="contentTp">
            <div class="contenTpl" style="    display: -webkit-box;
    display: -ms-flexbox;
    display: -webkit-flex;
    display: flex;">


                <div class="contentTp12" style="
            -webkit-box-flex: 1;
    -moz-box-flex: 1;
    -webkit-flex: 1 1 auto;
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    -webkit-align-self: auto;
    -ms-flex-item-align: auto;
    align-self: auto;padding:10px 40px;
        height:508px;width:49%;background: #f5f5f9">
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
                                style="margin:10px 0 20px 0">发布
                        </button>
                        <div style="    clear: both;
    height: 280px;
    overflow: auto;">
                            <ul class="talkList">


                            </ul>
                        </div>
                    </div>
                    <div class="conListView hide" style="margin: 10px;">
                        <span style="display:block;margin: 20px;">跟进人员：</span>
                        <select type="text" multiple="multiple" readonly style="width: 100%;" class="form-control"
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
                                url: "/ydz/opportunity/getOpportChatList?oppoNo=" + oppoNo + "&page=1" + "&rows=50",
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
                                if($.trim(con)==""){return;}
                                $t.attr("disabled", true);
                                var param = {
                                    "oppoNo": oppoNo,
                                    "chatContent": con
                                }
                                $.ajax({
                                    url: "/ydz/opportunity/addOpportChat",
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
                            // 参与人员
                            var initParticipFun=function (wkListType1) {
                                var arr2 = [];
                                $.map(wkListType1, function (obj) {
                                    arr2.push(obj.employeeId);
                                });
                                var delFun = function (empId) {

                                    $.ajax({
                                        url: "/ydz/opportunity/updateOpportunityByParam?oppoNo=" + oppoNo + "&participantEmployeeId=" + empId,
                                        success: function (dt) {

                                        }
                                    })
                                }
                                var optionFun = function (ar) {
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
                                            }).val(ar).trigger("change").on("select2:select", function (evt) {
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
                                optionFun(arr2);
                            }
                            $.ajax({
                                    url: "/ydz/opportunity/listParticipanEmployees?oppoNo=" + oppoNo,
                                    success: function (dt) {

                                        if (dt.code == "1") {
                                            var wkListType1 = dt.data;

                                            initParticipFun(wkListType1);

                                        }

                                    },error:function () {
                                    initParticipFun([]);
                                }
                                }
                            )
                        })
                    </script>
                    <div class="conListView hide logInfo" style="margin-top: 10px;">
                        <%--<div><span>XXX</span><span class="pull-right">2423423423</span></div>--%>
                        <%--<div><span>XXX</span><span class="pull-right">2423423423</span></div>--%>
                    </div>
                </div>



            </div>


            <div class="header" id="header">
            </div>

            <div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span>
            </div>


            <div style="margin-top: 11px" id="tableWrap" class="hide">


            </div>

            <div id="bottomD" class="hide">

            </div>


        </div>
    </div>
</div>
<script type="text/javascript">
    var oppoNo = '${oppoNo}';// 商机号
    var animateFun = function () {
        $(".step_lines").on("click", ".step_circle", function () {
//        $(".step_lines").on("click", ".step_circle:not('.step_click')", function () {

            var $t = $(this);

            $t.addClass("step_click");


            var fun = function () {
                $t.prevAll().addClass("step_click");
                $t.nextAll().removeClass("step_click");
                $(".step_line2").css({"width": $t.attr("did") + "%"});
                var wth = Number($t.attr("did"));
                $(".step_line3").addClass("runStep").css({"left": wth + "%"});


                $(".step_line3")[0].addEventListener('webkitTransitionEnd', function () {
                    var t = parseInt($(".step_line3").css("left"));
                    var t1 = parseInt($(".step_click:last").css("left"));
                    if (t > t1) {
                        $(".step_line3").removeClass("runStep");
                    }
                })
            }
            $.ajax({
                url: "/ydz/opportunity/updateOpportunityByParam?oppoNo=" + oppoNo + "&orderSection=" + $t.attr("cid"),
                dataType: "json",
                success: function (data) {
                    if (data.code == "1") {
                        fun();
                    } else {
                        $t.removeClass("step_click");
                        $.mytoast({text: data.msg, time: 1000});
                    }
                },
                error: function () {
                    $t.removeClass("step_click");
                    $.mytoast({text: "操作出错", time: 1000});
                }
            })

        })
        $(".step_circle").each(function () {
            if ($(this).hasClass("step_click")) {
                $(this).prevAll().addClass("step_click");
                $(".step_line2").css({"width": $(this).attr("did") + "%"});
//                $(".step_line3").css({"width": $(this).attr("did") + "%"});
                var wth = Number($(this).attr("did"));
//                $(".step_line3").addClass("runStep").css({"left": wth + "%"});
                $(".step_line3").css({"left": wth + "%"});

            }
        })

    }

    //入口处
    // 页面入口处
    var initFunPage = function () {
        var noPage = $(".currentVersion").attr("id");
        if (noPage == null || noPage == "") {  //新建
        }
        else {
            $.ajax({
                url: "/ydz/opportunity/queryOneQuotationOrderAndDetail?oppoNo=" + oppoNo + "&quotationNo=" + noPage,
                type: 'post',
//                contentType: 'application/json',
                dataType: "json",
                success: function (dt) {
                    if (dt.code == "1") {
                        initPageTwoData(dt);
                    }

                }
            });

        }


    }
    var initFunPageMain = function () {
        $.ajax({
            url: "/ydz/opportunity/listVersions?oppoNo=" + oppoNo,
            dataType: "json",
            success: function (d) {
                var dt = {};
                dt.orders = d.data;
                if (d.code == "1") {
                    if (d.data.length == 0) {
                        initFunPage();
                        return;
                    }
                    var html = template('tpl-print', dt);
                    document.getElementById("header").innerHTML = html;
                    initFunPage();
                    $(".changeVersionFun").on("click", function () {
                        var $t = $(this);
                        var $t1 = $t.attr("cid");
                        if ($(this).hasClass("currentVersion")) {
                            return;
                        }
                        var fun = function () {
                            $t.addClass("currentVersion").siblings().removeClass("currentVersion");
                            initFunPage();
                        }
                        fun();

                    })
                } else {
                }

            },
            error: function () {
                initFunPage();
            }
        })
    }
    function initTbData() {
        $.ajax({
            url: "/ydz/opportunity/queryOneOpportunityOrder?oppoNo=" + oppoNo,
            dataType: "json",
            success: function (dt) {
                var bothd = dt.data;
                var html2 = template('tpl-con', bothd);
                $(html2).insertBefore($(".contentTp12"));
                var html2 = template('tpl-detail2', dt.bottomComInfo);
                document.getElementById("bottomD").innerHTML = html2;
                animateFun();
                initFunPageMain();
                $("[data-toggle='popover']").webuiPopover({
                    content: $(".qrCodeDataCls")[0].innerHTML,
                    width: '250',
                    height: '260',
                    onShow: function () {
                        if ($('.qrCodeDataMid').html() == "") {
                            $('.qrCodeDataMid').html("正在生成二维码...");
                            $.ajax({
                                url: "/ydz/opportunity/shareUrl?orderNo=" + oppoNo,
                                dataType: "json",
                                success: function (dt) {
                                    if (dt.code == "1") {
                                        $('.qrCodeDataMid').empty();
                                        $('.qrCodeDataMid').qrcode({width: 160, height: 160, text: dt.shareUrl});
                                    }
                                }
                            })
                        }
                    },
                    onHide: function ($element) {
                    },
                    trigger: 'hover'
                });
            },
            error: function () {
            }
        })


//        $.ajax({
//            url: "/ydz/salesorder/salesOrderDetailData?salesNo=" + salesNo + "&industryId=" + industryId,
//            type: 'post',
//            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
//            dataType: "json",
//            success: function (bothData) {
//                template.defaults.imports.formatNumber = function (value) {
//                    return accounting.formatNumber(value, 2);
//                };

////                var bothData2={"detail":[{"name":1,"tf":3}]};
//                var bothData2 = {"name": 1, "tf": 3};
//                var html2 = template('tpl-con', bothData2);
//                document.getElementById("tableContainer").innerHTML += html;
//                $("#tableContainer").removeClass("hide");
//
//            }
//        })

    }
    function initPageTwoData(dc) {
        var d = dc.data;
        var salesOrderDetail = {};
        salesOrderDetail.orders = d.details;
        var remarks = d.remarks;
        if (remarks != undefined && remarks != null) {
            $("#remarkBtn").click();
        }

//        $("#createOrder").datagrid("loadData", globDataGrid);
        template.defaults.imports.convertCurrency = function (value) {
            return convertCurrency(value);
        };
        template.defaults.imports.formatNumber = function (value) {
            return accounting.formatNumber(value, 2);
        };
        var html = template('tpl-detail', dc.data);
        $("#bottomD").removeClass("hide");
        document.getElementById("tableWrap").innerHTML = html;

        $("#tableWrap").removeClass("hide");

        var fun = function () {
            $("#depositRequested").val(accounting.formatNumber((Number(d.taxRate) * 100), 2, ""));
//            $("#preferentialVal").val(d.preferential);
            $("#salesCount").val(accounting.formatNumber((Number(d.discountRate) * 100), 2, ""));
//            $(".tbWk tbody").rowspan(0);


        }
        fun();

    }
    function convertCurrency(currencyDigits) {
// Constants:
        var MAXIMUM_NUMBER = 99999999999.99;
        // Predefine the radix characters and currency symbols for output:
        var CN_ZERO = "零";
        var CN_ONE = "壹";
        var CN_TWO = "贰";
        var CN_THREE = "叁";
        var CN_FOUR = "肆";
        var CN_FIVE = "伍";
        var CN_SIX = "陆";
        var CN_SEVEN = "柒";
        var CN_EIGHT = "捌";
        var CN_NINE = "玖";
        var CN_TEN = "拾";
        var CN_HUNDRED = "佰";
        var CN_THOUSAND = "仟";
        var CN_TEN_THOUSAND = "万";
        var CN_HUNDRED_MILLION = "亿";
        var CN_SYMBOL = "";
        var CN_DOLLAR = "元";
        var CN_TEN_CENT = "角";
        var CN_CENT = "分";
        var CN_INTEGER = "整";

// Variables:
        var integral;    // Represent integral part of digit number.
        var decimal;    // Represent decimal part of digit number.
        var outputCharacters;    // The output result.
        var parts;
        var digits, radices, bigRadices, decimals;
        var zeroCount;
        var i, p, d;
        var quotient, modulus;

// Validate input string:
        currencyDigits = currencyDigits.toString();
        if (currencyDigits == "") {
            return "";
        }
        if (currencyDigits.match(/[^,.\d]/) != null) {
            return "";
        }
        if ((currencyDigits).match(/^((\d{1,3}(,\d{3})*(.((\d{3},)*\d{1,3}))?)|(\d+(.\d+)?))$/) == null) {
            return "";
        }

// Normalize the format of input digits:
        currencyDigits = currencyDigits.replace(/,/g, "");    // Remove comma delimiters.
        currencyDigits = currencyDigits.replace(/^0+/, "");    // Trim zeros at the beginning.
        // Assert the number is not greater than the maximum number.
        if (Number(currencyDigits) > MAXIMUM_NUMBER) {
            return "";
        }

// Process the coversion from currency digits to characters:
        // Separate integral and decimal parts before processing coversion:
        parts = currencyDigits.split(".");
        if (parts.length > 1) {
            integral = parts[0];
            decimal = parts[1];
            // Cut down redundant decimal digits that are after the second.
            decimal = decimal.substr(0, 2);
        }
        else {
            integral = parts[0];
            decimal = "";
        }
        // Prepare the characters corresponding to the digits:
        digits = new Array(CN_ZERO, CN_ONE, CN_TWO, CN_THREE, CN_FOUR, CN_FIVE, CN_SIX, CN_SEVEN, CN_EIGHT, CN_NINE);
        radices = new Array("", CN_TEN, CN_HUNDRED, CN_THOUSAND);
        bigRadices = new Array("", CN_TEN_THOUSAND, CN_HUNDRED_MILLION);
        decimals = new Array(CN_TEN_CENT, CN_CENT);
        // Start processing:
        outputCharacters = "";
        // Process integral part if it is larger than 0:
        if (Number(integral) > 0) {
            zeroCount = 0;
            for (i = 0; i < integral.length; i++) {
                p = integral.length - i - 1;
                d = integral.substr(i, 1);
                quotient = p / 4;
                modulus = p % 4;
                if (d == "0") {
                    zeroCount++;
                }
                else {
                    if (zeroCount > 0) {
                        outputCharacters += digits[0];
                    }
                    zeroCount = 0;
                    outputCharacters += digits[Number(d)] + radices[modulus];
                }
                if (modulus == 0 && zeroCount < 4) {
                    outputCharacters += bigRadices[quotient];
                }
            }
            outputCharacters += CN_DOLLAR;
        }
        // Process decimal part if there is:
        if (decimal != "") {
            for (i = 0; i < decimal.length; i++) {
                d = decimal.substr(i, 1);
                if (d != "0") {
                    outputCharacters += digits[Number(d)] + decimals[i];
                }
            }
        }
        // Confirm and return the final output string:
        if (outputCharacters == "") {
            outputCharacters = CN_ZERO + CN_DOLLAR;
        }
        if (decimal == "") {
            outputCharacters += CN_INTEGER;
        }
        outputCharacters = CN_SYMBOL + outputCharacters;
        return outputCharacters;
    }
    function cgx(o, num) {
        $(o).addClass("smcolor").siblings().removeClass("smcolor");
        var status = $(o).attr("data-s");
        $(".conListView").addClass("hide");
        $(".conListView:eq(" + $(o).index() + ")").removeClass("hide");
    }
    $(function () {
        $(".backMain").one("click", function () {
            var turl = "/openPage?pageName=project_opportunity-quotation-list";
            window.location.href = turl;
        })
        $(".modifyMain").one("click", function () {
            var turl = "/ydz/opportunity/forward-updateOpportunity?oppoNo=" + oppoNo;
            window.location.href = turl;
        })
        $(".newAddMain").one("click", function () {
            window.location.href = "/ydz/opportunity/forward-AddorUpdateOpportunity?oppoNo=" + oppoNo;
        })
        $(".oppoPrint").on("click", function () {
            var noPage = $(".currentVersion").attr("id");
            window.open("/print/opportunity-quotation-print.html?oppoNo=" + oppoNo + "&quotationNo=" + noPage);
        })

        $(".copyMain").one("click", function () {
//          var turl="/ydz/opportunity/forward-updateOpportunity?oppoNo="+oppoNo;
            $(".copyMain").attr("disabled", true);
            $.ajax({
                url: "",
                dataType: "json",
                type: "post",
                contentType: "application/json",
                success: function (data) {
                    if (data.code == "1") {
                        window.location.href = "/ydz/opportunity/forward-AddorUpdateOpportunity?oppoNo=" + oppoNo;
                    } else {
                        $(".copyMain").attr("disabled", false);
                        $.mytoast({text: data.msg, time: 1000});
                    }
                },
                error: function () {
                    $(".copyMain").attr("disabled", false);
                    $.mytoast({text: "操作出错", time: 1000});
                }
            })

        })
        initTbData();
    })
    $(function () {



        var objSelMenu;// 临时保存页面共享下拉框的对象
        var objSelDataGb = [
            {
                id: "现金",
                text: "现金"
            }, {
                id: "微信钱包",
                text: "微信钱包"
            }, {
                id: "支付宝",
                text: "支付宝"
            }]; //分类下拉框共享数据
        var delSelData = function (txt) {
            for (var i = 0; i < objSelDataGb.length; i++) {
                var t = objSelDataGb[i].text;
                if (t == txt) {
                    {
                        objSelDataGb.splice(i);
                    }

                }
            }

        }
        $(document).bind('click', function () {
            $(".ydz_select2").removeClass("open");
            $(".ydz_select_menu").hide();
        });
        $(".ydz_select2").on("click", function (e) {

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
            if ($(this).hasClass("open")) {
                $(this).removeClass("open");
                $(".ydz_select_menu").hide();
                objSelMenu = null;
            } else {
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
            delSelData("微信钱包");
            $("#autoEditOnceWin").show();
        })
        $(".autoEditTwice").on("click", function () {
            delSelData("现金");
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
            $("#deleteYdzWin,#versionControlWin").hide();
        })
        $(".ydz_select_menu_ul2").on("click", "li>span", function (e) {
//            $(".window-mask").show();
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
    });
    ; (function ($) {
        $.fn.extend({
            //表格合并单元格，colIdx要合并的列序号，从0开始
            "rowspan": function (colIdx) {
                return this.each(function () {
                    var that;
                    var thatVal;
                    $('tr', this).each(function (row) {
                        var $tdVal = $("td:eq(0)", this).text();
                        $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
                            if (that != null && $(this).text() == $(that).text()) {

                                rowspan = $(that).attr("rowSpan");
                                if (rowspan == undefined) {
                                    $(that).attr("rowSpan", 1);
                                    rowspan = $(that).attr("rowSpan");
                                }
                                rowspan = Number(rowspan) + 1;
                                $(that).attr("rowSpan", rowspan);
                                $(this).hide();

                            } else {
                                that = this;
                            }
                        });
                    });
                });
            }
        });

    })(jQuery);
</script>
<script id="tpl-print" type="text/html">
    {{each orders as item i}}
    <div id="{{item.quotationNo}}" class="btn-group changeVersionFun  {{item.isDefault=='1'?'currentVersion':''}}">
        <button type="button" class="btn  btn-default dropdown-toggle"><span
                class=" {{item.isDefault=='1'?'':'hide'}} iconfont_new" style="
    font-size: 24px;
    color: #4e8ae6;
    position: absolute;
    right: -4px;
    top: -8px;">&#xe720;</span>
            {{item.versionName}}
        </button>

    </div>
    {{/each}}

</script>
<script id="tpl-talk" type="text/html">
    {{each rows as item i}}
    <li style="padding:5px;">
        <div><span>{{item.chatEmployeeName}}</span><span class="pull-right">{{item.createTime}}</span></div>
        <div class="conTalkList">{{item.chatContent}}</div>
    </li>
    {{/each}}

</script>
<script id="tpl-detail" type="text/html">
    <div class="row" style="margin-bottom: 20px;line-height: 30px;">
        <label style="padding-right:0;width:70px;" class="col-xs-1 control-label">版本名称 :</label>
        <%--<div class="col-xs-3 ">--%>
        <span id="caseDesc" style="border:none;float: left;padding:0 15px;">{{versionDesc}}</span>
        <%--</div>--%>
        <label style="padding-right:0;width:70px;" class="col-xs-1 control-label">报价日期 :</label>
        <span readonly style="border:none;float: left;padding:0 15px;" name=""
              id="">{{versionDate}}</span>

    </div>
    <div id="tableContainer"
         style="">
        <table class="tbWk" style="width:100%;">
            <col width="10%"/>
            <col width="4%"/>
            <col width="15%"/>
            <col width="15%"/>
            <col width="5%"/>
            <col width="5%"/>
            <col width="10%"/>
            <col width="10%"/>
            <col width="10%"/>
            <thead>
            <th>报价分类</th>
            <th>序号</th>
            <th>业务内容</th>
            <th>相关描述(规格)</th>
            <th>数量</th>
            <th>单位</th>
            <th>单价</th>
            <th>备注</th>
            <th>行小计</th>
            </thead>
            <tbody>
            {{each details as item i}}
            <tr>
                <td>{{item.classDesc}}</td>
                <td align="center">{{i+1}}</td>
                <td>{{item.businessDesc}}</td>
                <td>{{item.specification}}</td>
                <td align="center">{{item.quantity}}</td>
                <td>{{item.unit}}</td>
                <td align="right">{{item.unitPrice | formatNumber}}</td>
                <td>{{item.remarks}}</td>
                <td align="right">{{item.totalPrice | formatNumber}}</td>
            </tr>
            {{/each}}
            </tbody>

        </table>
    </div>

    <div id="bottomBox">
        <div class="h-box" style="height:204px;">
            <div class="flex-box">
                <div class="v-box">
                    <div class="flex-box">
                        <div class="remark-container">
                            <div id="remarkBtn" class="add_tips">备注</div>
                            <textarea id="remarkInput" readonly
                                      style="resize:none;max-width:669px;height: 60px;border:none;">{{remarks}}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="box right-summary" style="width:300px;">
                <div class="h-box">
                    <div class="box">合&#x3000;计</div>
                    <div class="flex-box">
                    </div>
                    <div class="box price">
                        <span id="priceText">{{price | formatNumber}}</span>
                    </div>
                </div>
                <div class="h-box sales-box">
                    <div class="box">折&#x3000;扣</div>
                    <div class="flex-box">
                        <div>

                            <div class="moneyInput ui input icon" style="width: 80px;"><input readonly
                                                                                              id="salesCount"
                                                                                              maxlength="4"
                                                                                              value="{{discountRate}}"
                                                                                              type="text">
                                <i class="percent icon"></i>
                            </div>
                        </div>
                    </div>
                    <div class="box price">-<span id="discountText">{{discount | formatNumber}}</span>
                    </div>
                </div>
                <div class="h-box earnest-box">
                    <div class="box">税&#x3000;点</div>
                    <div class="flex-box">


                        <div class="moneyInput ui input icon" style="width: 80px;">
                            <input readonly value="{{taxRate}}" id="depositRequested" type="text"><i
                                class="percent icon"></i></div>
                    </div>
                    <div class="box price"><span id="depositRequestedText">{{taxPrice |formatNumber}}</span></div>
                </div>
                <div style="height:30px;" class="h-box minus-box">
                    <div class="box">减&#x3000;免</div>
                    <div class="flex-box">
                    </div>
                    <div class="box price">
                        -<span id="preferentialText">{{preferential |formatNumber}}</span>

                    </div>
                </div>
                <div class="h-box">
                    <div class="box">总金额</div>
                    <div class="flex-box"></div>
                    <div class="box price">
                        <span id="totalPriceText">{{totalPrice |formatNumber}}</span>
                    </div>
                </div>
                <div class="h-box">
                    <div class="box">总金额(大写)</div>
                    <div class="flex-box"></div>
                    <div class="box price">
                        <span id="totalPriceTextCapital">{{totalPrice |convertCurrency}}</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="ui divider" style="border-color:#e4e4e4;"></div>

</script>
<script id="tpl-detail2" type="text/html">
    <div class="Customer-address">
        <span class="relation">联系人 : <span style="margin:0;">{{realName}} ({{userId}})</span></span>
        QQ : <span>{{comQQ}}</span>
        <span class="addr">
        地址 : <span>
                    <b>{{comAddress}}</b>
                </span></span>
    </div>
</script>

<script id="tpl-con" type="text/html">
    <div style="padding:20px 40px;height:508px;width:49%;margin-right:10px;background: #f5f5f9">
        <h1 class="" style="    color: #4284d6;
    font-size: 16px;
    margin: 0 20px 20px -10px;">商机信息</h1>
        <div style="    position: relative;
    padding-left: 70px;
    line-height: 40px;
    height: 50px;
    vertical-align: bottom;
    align-content: center;">
                        <span class="iconfont_new" style="color: #4284d6;
    font-size: 56px;
    position: absolute;
    left: 0;
    top: -4px;">&#xe687;</span><span style="font-size:18px;">{{oppoDesc}}</span><span
                style="margin-left:15px;">销售代表：</span><span style="color:#333;">{{salesName}}</span>
            <span style="float: right;"><i class="iconfont_new"
                                           style="color:#3dcc74;font-size:26px;position:relative;top:4px;">&#xe6f3;</i>订单开始距今：{{upToNow}} 天</span>
        </div>

        <div style="    padding-left: 20px;
    height: 30px;
    line-height: 30px;">
            <span style="font-size:18px;">当前销售阶段</span><span style="margin-left:15px;">直接点击调整阶段</span>
        </div>

        <div class="step_lines" style="    position: relative;
    margin: 20px 20px 0;
    clear: both;
    height: 50px;">
            <div class="step_line"
                 style="position: absolute;z-index: 1;background:#f5f5f9;width:100%;background: #ccc;height:6px;"></div>
            <div class="step_line2" style="position: absolute;z-index: 2;background:#458dcb;width:0%;      transition: all .5s 0s linear;
                        -webkit-transition: all .5s 0s linear;height:6px;"></div>
            <div class="step_line3" style="    position: absolute;
    z-index: 3;
    top: -70px;
    transition: all 2s linear 0s;
    left: 0"></div>
            <div class="step_circle {{orderSection=='01'?'step_click':''}} " did="12" cid="01"
                 style="position: absolute;left:10%;top:-17px;z-index: 3;text-align: center;">
                <div class="icon_select_opp" style="z-index: 1;"></div>
                <p>商机</p>
            </div>
            <div class="step_circle {{orderSection=='02'?'step_click':''}}" did="32" cid="02"
                 style="position: absolute;left:30%;z-index: 3;top:-17px;text-align: center;">
                <div class="icon_select_opp" style="position:relative;"></div>
                <p>需求报价</p></div>
            <div class="step_circle {{orderSection=='03'?'step_click':''}}" did="52" cid="03"
                 style="position: absolute;left:50%;z-index: 3;top:-17px;text-align: center;">
                <div class="icon_select_opp" style="position:relative;"></div>
                <p>谈判审核</p></div>
            <div class="step_circle {{orderSection=='04'?'step_click':''}}" did="72" cid="04"
                 style="position: absolute;left:70%;z-index: 3;top:-17px;text-align: center;">
                <div class="icon_select_win" style="position:relative;"></div>
                <p>赢单</p></div>
            <div class="step_circle {{orderSection=='05'?'step_click':''}}" did="100" cid="05"
                 style="position: absolute;left:98%;z-index: 3;top:-17px;text-align: center;">
                <div class="icon_select_lose" style="position:relative;"></div>
                <p>输单</p></div>
        </div>

        <div style="    display: flex;
    width: 90%;
    margin: 0 auto;">
            <div class="form-group" style="    width: 60%;
    margin-right: 10px;">
                <label for="name" style="color:#c3c3c5">商机名称</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{oppoDesc}}
                </span>
                <label for="name" style="color:#c3c3c5;margin-top:16px;">客户</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{partnerShortname}}
                </span>
                <label for="name" style="color:#c3c3c5;margin-top:16px;">手机号码</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{contactTel}}
                </span> <label for="name" style="color:#c3c3c5;margin-top:16px;">开始日期</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{startDate}}
                </span>
            </div>
            <div class="form-group" style="width: 40%">
                <label for="name" style="color:#c3c3c5">项目类型</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{oppoTypeDesc}}
                </span>
                <label for="name" style="color:#c3c3c5;margin-top:16px;">联系人</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{contactName}}
                </span>
                <label for="name" style="color:#c3c3c5;margin-top:16px;">报价单号</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{oppoNo}}
                </span>
                <label for="name" style="color:#c3c3c5;margin-top:16px;">结束日期</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{endDate}}
                </span>
            </div>

        </div>
        <div style="    display: flex;
    width: 90%;
    margin: 0 auto;">
            <div class="form-group" style="width: 100%">
                <label for="name" style="color:#c3c3c5;">项目地址</label>
                <span class="form-control" style="border:none;background: transparent;padding-left:0;">{{address}}
                </span>


            </div>
        </div>

    </div>
</script>
</body>

</html>