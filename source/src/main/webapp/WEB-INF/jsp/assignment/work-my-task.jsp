<%@ page language="java" contentType="text/html; charset=UTF-8"
             pageEncoding="UTF-8"%>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>

    <head>
        <meta charset="UTF-8">
        <title>制作-我的任务</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="renderer" content="webkit">
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
        <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
        <style type="text/css">
            .tbWk td {
                border: 1px solid #000;
                padding: 10px;
            }

            .tbWk {
                border: 1px solid #000;
                color: #000;
            }

            .tbWk caption {
                border: 1px solid #000;
                padding: 10px;
                font-size: 28px;
                border-bottom: none;
            }

            .datagrid-body td {
                position: relative;
            }

            .tbList li {
                text-align: center;
                color: #4284d9;
                height: 220px;
                position: relative;
                padding: 0 30px;
                cursor: pointer;
                overflow: hidden;
                border: 1px solid #e8e8e8;
                float: left;
                width: 250px;
                font-size: 22px;
                line-height: 220px;
                margin-right: 20px;
                margin-top:26px;
            }

            .wk {
                color: #4284d9;
                font-size: 28px;
                line-height: 60px;
            }

            .wkNum {
                font-size: 18px;
                font-weight: 700;
                margin-top: -5px;
                vertical-align: bottom;
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

            .ui.input.drop>.value-content {
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

            #order .table-wrapper>table thead th:nth-child(11),
            #order .table-wrapper>table thead th:nth-child(1),
            #order .table-wrapper>table thead th:nth-child(12),
            #order .table-wrapper>table thead th:nth-child(2) {
                font-weight: 700;
            }

            .pagination table {
                height: 50px;
                line-height: 50px;
                float: right;
                opacity: 0;
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

            .datagrid-header,
            .datagrid-td-rownumber {
                background: #eff1f3;
            }

            .datagrid-header .datagrid-cell span {
                font-size: 14px;
            }

            .btn-primary {
                background-color: #2e8ae6;
                border-color: #2e8ae6;
                font-size: 14px;
            }

            .btn-primary:hover,
            .btn-primary:focus,
            .btn-primary:active,
            .btn-primary.active,
            .open .dropdown-toggle.btn-primary {
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

            .datagrid-header-row,
            .datagrid-row,
            .datagrid-header {
                height: 50px;
            }

            .datagrid-header .datagrid-cell {
                /*height:40px;*/
                /*line-height: 40px;*/
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
                padding: 2%;
                background: #fff;
                transition: all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
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

            .btn.smcolor {
                background-color: #2e8ae6;
                border-color: #2e8ae6;
                color: #fff;
            }

            .datagrid-header .datagrid-cell {
                /*text-align: center !important;*/
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

            .select2-results__options li {
                position: relative;
            }

            .datagrid-body .datagrid-cell {
                padding: 10px;
            }

            .datagrid-htable .datagrid-cell {
                padding-left: 10px;
            }

            .datagrid-header .datagrid-cell span {
                color: #666;
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

            .panel {
                box-shadow: 0 0 0;
            }


            .datagrid-body td {
                border-bottom: 1px solid #eae8e8;
            }

            .pagination-btn-separator {
                display: none;
            }


            #order .table-wrapper>table thead th:nth-child(1) {
                text-align: left;
            }

            .qqhover:hover,
            .telhover:hover {
                color: #2e8ae6 !important;
            }

            .datagrid-cell,
            .datagrid-cell-group,
            .datagrid-header-rownumber,
            .datagrid-cell-rownumber {
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
                height: 40px;
                line-height: 30px;
                cursor: pointer;
                font-size: 14px;
                color: #000;
            }

            .contactbd {
                cursor: pointer;
                color: #b3b3b3;
                font-size: 12px;
                /*line-height: 45px;*/
            }

            .namebdsml {
                font-size: 12px;
                color: #b3b3b3;
                margin-left: 15px;
            }

            .namebd {
                font-size: 12px;
                color: #4284d9;
                margin-left: 15px;
            }

            .telhover,
            .qqhover {
                margin-left: 8px;
                vertical-align: middle;
            }

            .contacthover {
                margin-right: 20px;
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

            .datagrid-body {
                overflow-x: hidden;
            }

            .nicescroll-rails-vr,
            .nicescroll-rails-hr {
                /*display: block !important;*/
            }

            .nav-tabs>li>a {
                color: #3f3e3e;
                border: none;
            }

            .nav-tabs,
            .nav-tabs>li.active>a,
            .nav-tabs>li.active>a:hover,
            .nav-tabs>li.active>a:focus {
                border: none;
                font-size: 14px;
            }

            .nav-tabs>li.active>a,
            .nav-tabs>li.active>a:hover,
            .nav-tabs>li.active>a:focus {
                /*border-bottom: 2px solid #2e8ae6;*/
                color: #2e8ae6;
                padding-bottom: 5px;
            }

            .nav-tabs>li>a:hover {
                border: none;
            }

            .nav>li>a:hover,
            .nav>li>a:focus {
                text-decoration: none;
                background: none !important;
            }

            #navCondition li {
                margin-right: 10px;
            }
           #navCondition li{
               padding: 36px 0 9px 0;
               border-bottom: 1px solid #e4e4e4;
               width: 1060px;
            }

            .nav-tabs {
                position: relative;
            }

            .nav-tabs li:nth-child(1)~.block {
                position: absolute;
                bottom: 3px;
                left: 8px;
                width: 55px;
                height: 2px;
                background-color: #2e8ae6;
                transition: all .3s;
            }

            .nav-tabs li:nth-child(2).active~.block {
                transform: translate(84px, 0);
            }

            #taxPointWin {
                border: none;
                z-index: 99;
                width: 556px;
                box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
                min-height: 484px;
                background: #fff;
                transition: all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
                display: none;
                margin-left: -288px;
                margin-top: -242px;
            }

            .labelCon {
                display: inline-block;
                background: #800080;
                color: #fff;
                padding: 1px 10px;
                margin: 0 5px;
                border-radius: 2px;
            }
            /*制作车间列表样式*/

            .tbList li:nth-child(4n) {
                margin-right: 0;
            }
           .datagrid-htable .datagrid-cell{
                text-align: center !important;
            }
            .plistmarkSale{
                width: 38px;
                height: 18px;
                text-align: center;
                line-height: 16px;
                right:10px;
            }
        </style>
        <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
        <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
        <script src="/resources/pageConfig.js?v=d1935279f7"></script>
        <script>
            var pageUrl="/order/workingassigntask/forward-assignworkingtask?workingProcedure=";
            function clickforward(id) {
                window.location.href=pageUrl+id;
            }
            $(
                function () {
                    var tarr="";
                    for(var l=0;l<wkListType.length;l++){
                        var obj=wkListType[l];
                        tarr +='<li  href="javascript:void(0)" onclick="clickforward(\''+obj.id+'\')"> '+obj.text+'</li>';
                    }
                    $(".tbList").html(tarr);
                }
            )



        </script>
    </head>
        <body>

        <div class="header_text" style="border:1px solid #ccc;font-size:1.6rem;color:#000;padding:1.2rem;margin:12px;">制作工序</div>

       <div id="regionCon"   style="border:none !important;width: 1060px;margin:0 auto;" >
    <ul class="tbList">
        
       
    </ul>
</div>

    </body>

    </html>