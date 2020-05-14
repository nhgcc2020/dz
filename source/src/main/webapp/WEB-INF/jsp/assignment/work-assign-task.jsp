
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>
    <head>
        <meta charset="UTF-8"/>
        <title>制作-任务派工</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="renderer" content="webkit">
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
        <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
        <style>
            .topbarPrCss{
            display: none;        position: absolute;
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

            .select2-selection--multiple{
                line-height: 30px;
            }
            .labelCon{
                display: inline-block;
                background: #800080;
                color: #fff;
                padding: 1px 10px;
                margin: 0 5px;
                border-radius: 2px;
            }
            .topbarPrCss{
                display: none;        position: absolute;
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
            .namebdsml{
                font-size:12px;
                color:#b3b3b3;
                line-height: 23px;
                /*margin-left:15px;*/
            }
            .namebd{
                /*height: 40px;*/
                /*line-height: 30px;*/

                font-size:12px;
                color:#000;
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
                font-size: 14px;
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
                padding: 2%;
                background: #fff;
                transition: all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
            }

            #taxPointWin {
                border: none;
                z-index: 999;
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
                transform: translate(112px, 0);
            }


            .nav-tabs li:nth-child(1) ~ .block {
                position: absolute;
                bottom: 3px;
                left: 2px;
                width: 95px;
                height: 2px;
                background-color: #2e8ae6;
                transition: all .3s;
            }
           .conTbText .datagrid-header td,.conTbText .datagrid-body td,.conTbText .datagrid-footer td{
                border-width:0;
            }
            .conTbText .datagrid-header td, .conTbText.datagrid-body td, .conTbText .datagrid-footer td{
                border-style:solid;
                border-color: #e4e4e4;
            }
            .conTbText .datagrid-body td{
                border-bottom:1px solid #eae8e8;
            }
            .pagination-btn-separator{
                display: none;
            }
            .select2-container--default .select2-selection--multiple .select2-selection__rendered{
                display: block;
            }
            #sale{
                width: 38px;
                height: 18px;
                text-align: center;
                line-height: 16px;
                right:10px;
            }
        </style>
        <script src="/resources/jquery/jquery-2.1.3.js?v=b11891de95"></script>
        <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
        <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
        <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
        <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
        <script src="/resources/business/base_new.js?v=9ac481258d"></script>
        <script src="/resources/pageConfig.js?v=d1935279f7"></script>
        <script src="/resources/business/work-assign-task.js?v=28f6fdd781"></script>

    </head>
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">
    <%--<ul class="nav nav-tabs" id="navCondition">--%>
        <%--<li style="position:relative;" data-s="01"  class="order4 smcolor"><a href="#">已分派工序</a>--%>
        <%--</li>--%>
        <%--<li style="position:relative;" data-s="00" class="order"><a href="#">未分派工序</a></li>--%>
        <%--<li class="block"></li>--%>
    <%--</ul>--%>


    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                </div>
                <%--<div class="col-xs-2" style="width:150px;padding:0 5px">--%>
                    <%--<select class="form-control input-xs" id="dateDat">--%>
                        <%--<option value=""></option>--%>
                    <%--</select>--%>
                <%--</div>--%>
                <div class="col-xs-2 " style="width:180px;padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:150px">
                                <input type="text" style="" class="form-control" id="datetimepickers"
                                       data-format="yyyy-MM-dd" placeholder="订单日期">
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
                <div class="col-xs-2 " style="width:150px;padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:100%">
                                <input type="text" style="" class="form-control" id="datetimepickere"
                                       data-format="yyyy-MM-dd" placeholder="订单日期">
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
                <div class="col-xs-2" style="width: 242px;">

                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchK" placeholder="输入单号、项目名称、业务内容" style="      width: 212px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">

                    </div>
                </div>
                <button type="button" id="searchBtn"  class="btn btn-primary "
                        style="font-size:12px;height:30px;line-height:1;" >搜索
                </button>


            </div>
        </form>
    </div>

</div>
<div data-options="region:'center'" style="border:none !important;padding:10px;padding-top: 0;">
    <table id="order" style="height: 100%"  class="easyui-datagrid"
           data-options="remoteSort:false,
           nowrap:true,singleSelect:false,checkOnSelect:false">
    </table>

</div>
<%--订单流程详情--%>
<div id="orderProcedure"
     style="box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2); background: #fff; position: absolute;z-index: 9999;top:50%;left:50%;margin-left:-435px;margin-top:-286px; display: none;">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #e4e4e4; padding-left: 15px;">
        快速了解订单流程
    </div>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeOverFlow()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="font-size: 12px;color:#666;background-color: #f5f5f5; text-align: center; width: 500px; margin: 20px auto; line-height: 30px;">
        颜色区块表示系统对应操作 ! 灰色区块为辅助操作
    </div>
    <div style="margin: 70px auto 60px; padding: 0 20px;"><img src="../../images/orderflow.png" alt="订单流程图"></div>
    <div style="text-align: center;border:1px solid #ccc; border-radius: 3px;font-size: 12px;color: #ccc; height: 30px; width: 120px;line-height: 30px;margin: 0 auto 30px;cursor: pointer; "
         onclick="closeOverFlow()">我知道了
    </div>
</div>

<div id="topBarPR" class="topbarPrCss" style="height: 700px;width:100%;" >
    <%--这个是加载框，切勿修改--%>
    <article style="    text-align: left;
    font-size: 1.6rem;
    padding: 1.2rem;
    margin: 1.2rem;">
           <div class="col-xs-6" style="top:-15px;">
        <button type="button" class="btn "  onclick="closeProReq()" style="background: #DEE1E2;">返回</button>
    </div>
    </article>

    <div class="" style="width: 100%;
    height: 600px;clear: both;
    padding: 0 13px;">
        <table id="orderPg"  style="width:100%;margin-top:50px;    height: 600px;" class="easyui-datagrid "
               data-options="remoteSort:false,
           nowrap:true,singleSelect:true,checkOnSelect:false">
        </table>
    </div>
</div>
</body>
</html>