<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>安装分派</title>
    <meta name="renderer" content="webkit">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">


    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
    <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>

    <style>
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
            transform: translate(117px, 0);
        }

        .nav-tabs li:nth-child(3).smcolor ~ .block {
            transform: translate(168px, 0);
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
            left: 8px;
            width: 100px;
            height: 2px;
            background-color: #2e8ae6;
            transition: all .3s;
        }

        .telColor {
            color: #ff9200
        }
    </style>
    <script>


        var pageUrl = "/order/installation/listSalesOrderAndDetail";// 本页面请求url1
        var pageCustomerUrl =  "/system/partner/dropdownPartner?partnerType=1";// 本页面客户数据url1
        var pageNeedUrl =  "/order/installation/insertInstallStandingBy";// 本页面需要安装url1
        var pageInstallUrl =  "/order/installation/listInstallStandingBy";// 查询待安装记录
        var installPageFun = {
            returnopt: function (data, type) {
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
            },
            arrFunDetail: function () {
                var status = $("#navCondition").find(".smcolor").attr("data-s");
                var arrclo = [];
                arrclo.push({field: 'ck', checkbox: true});
                arrclo.push({
                    field: 'orderDate',
                    title: '散单概要',
                    width: 140,
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row) {
                        var r = row.caseDesc == "" ? "无概要" : row.caseDesc;
                        return '<span data-id=' + row.salesNo + ' data-did=' + row.industryId + ' href=\'##\'>' + row.orderDate + '</span>' + '<div class="namebd"><span class="namebdsml">' + r + '</span></div>';
                    }
                });

                if(status==""){
                    arrclo.push({field: 'statusDesc',    align: 'center', width: 100, title: '安装状态', formatter: function (value, row) {
                        if(row.status=="0"){
                            return '<span style="color:#ff9900" class="namebdsml">'+value+'</span>';
                        }else{
                            return '<span style="color:#33cc00" class="namebdsml">'+value+'</span>';
                        }

                    }});
                }

                arrclo.push({
                    field: 'partnerShortname', title: '客户', width: 100, formatter: function (value, row) {

                        return '<div>' + row.partnerShortname + '</div>' + '<div class="namebd"><span class="namebdsml">' + row.contactName + '</span></div>';
                    }
                });
                arrclo.push({field: 'businessDesc', width: 200, title: '业务内容'});

                arrclo.push({field: 'requirements', width: 200, title: '物料/制作/说明'});
                arrclo.push({field: 'specification', width: 100, align: 'center', title: '规格(m)'});
                arrclo.push({field: 'quantity', width: 60, align: 'center', title: '数量'});
                arrclo.push({field: 'totalArea', width: 60, align: 'right', title: '面积(㎡)'});
                arrclo.push({field: 'unit', width: 60, align: 'center', title: '单位'});

                arrclo.push({
                    field: 'unitPrice', width: 90, align: 'right', formatter: function (value, row) {
                        return accounting.formatNumber(value, 2);
                    }, title: '单价(元)'
                });
                arrclo.push({
                    field: 'totalPrice', width: 90, align: 'right', formatter: function (value, row) {
                        return accounting.formatNumber(value, 2);
                    }, title: '行小计(元)'
                });
                arrclo.push({
                    field: 'totalPriceOrder', width: 100, align: 'right', formatter: function (value, row) {
                        return accounting.formatNumber(value, 2);
                    }, title: '订单金额'
                });
                arrclo.push({
                    field: 'salesNo', width: 160, align: 'center', title: '销售单号', formatter: function (value, row) {
                        if (row.purchaseNo != '') {
                            return value + '<p class="plistmarkSale">协</p>';
                        }
                        return value;
                    }
                });
                arrclo.push({field: 'createTime', sortable: true, width: 140, align: 'center', title: '制单时间'});
                return arrclo;
            },
            onLoadSuccess: function (data) {
                if (data.rows.length > 0) {
                } else {
                    $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
                }
            },
            msg: function (content) {
                $("#msgwindow").html(content).addClass("activ");
            },
            createOrder: function () {

                var modifyRow = new Array();
                var flag = false;
                var order4ItemsArr = $('#order').datagrid('getChecked');
                console.log(order4ItemsArr);
                var cols = [];
                var checkRow = "";
                $.each(order4ItemsArr, function (index, item) {

                    if(index==order4ItemsArr.length-1){
                        checkRow +=order4ItemsArr[index].uid;
                    }else{
                        checkRow +=order4ItemsArr[index].uid+",";
                    }

                });

                /*      if (flag) {
                 $("<div class='tips_contants'>").fadeIn(250).html("好友协同单已经被收货，不可修改。").delay(4000).fadeOut(250).appendTo('body');
                 return false;
                 }*/


                if (order4ItemsArr.length>0) {
                    //查询订单状态
//                    $.post("/ydz/salesorder/saleOrderOne", {salesNo: saleOrderNo}, function (data) {
//                        var callback = eval("(" + data + ")");
//                        var orderStatus = callback.orderStatus;
//                        if (orderStatus != modifyRow[0].orderStatus) {
//                            $("<div class='tips_contants'>").fadeIn(250).html("订单状态已过期，请刷新").delay(4000).fadeOut(250).appendTo('body');
//                            return false;
//                        } else {
                            var App = window.parent.App;
                            var config = {
                                path: "/order/installation/forward-addInstallationOrder?detailUid="+checkRow,
                            };
                            App.open(config.path, config);
//                        }
//
//                    });
                    //调转修改页面

                } else {
                        $("<div class='tips_contants'>").fadeIn(250).html("请选择安装单").delay(3000).fadeOut(250).appendTo('body');
                }


            },
            needInstaller: function () {
                var modifyRow = new Array();
                var flag = false;
                var order4ItemsArr = $('#order').datagrid('getChecked');
                console.log(order4ItemsArr);
                var cols = [];
                var checkRow = "";
                for (var i = 0; i < order4ItemsArr.length; i++) {

                        if(i==order4ItemsArr.length-1){
                            checkRow +=order4ItemsArr[i].uid;
                        }else{
                            checkRow +=order4ItemsArr[i].uid+",";
                        }

                }

                    $.post(pageNeedUrl, {detailUid: checkRow}, function (data) {

                        $("#navCondition").find("li:eq(1)").click();
                    });
                    //调转修改页面



            },
            showMessageDialog: function (url, title, width, height, shadow) {
                var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
                $("#msgwindow").empty();
                $("#msgwindow").css({left: "16%"});
                $(".window-mask").hide();
                var last = Date.now();
                setTimeout(function () {
                    // 监听动画完成时间
                    if ($("#msgwindow").hasClass("activ")) {
                        installPageFun.msg(content);
                    } else {
                        $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function () {
                            if (Date.now() - last < 3000) {
                                installPageFun.msg(content);
                            }
                        }, false);
                    }

                }, 0);
            },
            openDt: function (obj) {
                var url = "/ydz/salesorder/salesOrderDetail?salesNo=" + $(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
                installPageFun.showMessageDialog(url, "", "84%", "100%", true);
            }
        }   //本页面的交互方法
        $(function () {
            $('[data-toggle="popover"]').popover();
            $("#navCondition").on("click", "li", function () {
                hideMsg();
                $(this).addClass("smcolor").siblings().removeClass("smcolor");
                reload();
            })
            $(".createInstaller").click(function () {
                installPageFun.createOrder();
            })
            $(".needInstaller").click(function () {
                installPageFun.needInstaller();
            })
            var dateObj = orderUtil.dpDateCompute("ld", 30);
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
            $("#datetimepickers").val(dateObj.beforeDate);
            $("#datetimepickere").val(dateObj.nowDate);
            $("#dateDat").html(installPageFun.returnopt(orderUtil.dateConfig, 2)).change(function () {
                var code = $(this).val().substring(0, 2);
                var num = $(this).val().substring(2, $(this).val().length);
                var dt = orderUtil.dpDateCompute(code, num);
                $("#datetimepickers").val(dt.beforeDate);
                $("#datetimepickere").val(dt.nowDate);
            });
            $("#dateDat").select2({
                minimumResultsForSearch: Infinity
            });

            $.ajax({
                url:pageCustomerUrl,
                dataType: "json",
                success: function (data) {
                    $("#customerDat").html(installPageFun.returnopt(data, 1));
                    $("#customerDat").select2({
//                        maximumInputLength:2,
                        templateResult: installPageFun.formatState
                    });
                    reload();
                },
                error: function () {
                }
            });
            //全部订单搜索
            $("#searchBtn").click(function () {
                var status = $("#navCondition").find(".smcolor").attr("data-s");
                reload(status);
            })
            $("#switch_order").on("click", "span", function () {
                $(this).addClass("switch_handle_on").siblings().removeClass("switch_handle_on");
                var status = $("#navCondition").find(".smcolor").attr("data-s");
                reload(status);
            });

        });//本页面加载完成初始化数据
        // 公共方法
        function reload() {
            var status = $("#navCondition").find(".smcolor").attr("data-s");
            var arrclo = [], url = "", pageSize = 30, pageList = [30, 40];
            var arrclo = installPageFun.arrFunDetail();
            if(status==""){

                url=pageInstallUrl;
            }else{
                url = pageUrl;
            }




            pageSize = 30;
            pageList = [30, 40];


            if (status == "") {
                $(".createInstaller").removeClass("hide");
                $(".needInstaller").addClass("hide");
                $('#order').datagrid({
                    url: url,
                    fit: true,
                    onLoadSuccess: installPageFun.onLoadSuccess,
                    pagination: true,
                    pageSize: pageSize,
                    pageList: pageList,
                    columns: [arrclo],
                    queryParams: {
                        "partnerKey": $('#customerDat').val(),
                        "endTime": $('#datetimepickere').val(),
                        "searchKey": $('#searchK').val(),
                        "startTime": $('#datetimepickers').val()
                    }
                });
            } else {
                $(".createInstaller").addClass("hide");
                $(".needInstaller").removeClass("hide");

                $('#order').datagrid({
                    url: url,
                    fit: true,
                    onLoadSuccess: installPageFun.onLoadSuccess,
                    pagination: true,
                    pageSize: pageSize,
                    pageList: pageList,
                    columns: [arrclo],
                    queryParams: {
                        "orderStatus": status,
                        "partnerKey": $('#customerDat').val(),
                        "endTime": $('#datetimepickere').val(),
                        "searchKey": $('#searchK').val(),
                        "startTime": $('#datetimepickers').val()
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
        function hideMsg() {
            $(".window-mask").hide();
            $("#msgwindow").css({left: "100%"}).removeClass("activ");
        }


    </script>
</head>
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<%--遮罩--%>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" data-s="01" class="smcolor order2"><a href="#">全部业务明细</a></li>
        <li style="position:relative;" data-s="" class="order"><a href="#">待安装明细</a></li>
        <li class="block"></li>
    </ul>


    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:200px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                </div>
                <div class="col-xs-2" style="width:120px;padding:0 5px">
                    <select class="form-control input-xs" id="dateDat">
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-xs-2 " style="width:150px;padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:120px">
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
                <div class="col-xs-2 " style="width:120px;padding:0 5px">

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
                <div class="col-xs-2" style="width: 222px;">

                    <div class="input-group">
                        <input type="text" class="form-control"

                               onkeypress="if(event.keyCode == 13) {reload('');return false;}"
                               id="searchK" placeholder="输入单号、项目名称、业务内容" style="      width: 192px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;">

                    </div>
                </div>
                <button type="button" id="searchBtn" class="btn btn-primary "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>

                <button type="button" class="btn btn-primary hide pull-right createInstaller "
                        style="font-size:12px;height:30px">创建工单
                </button>
                <button type="button" class="btn btn-primary hide pull-right needInstaller "
                        style="font-size:12px;height:30px">需要安装
                </button>
                <div  style="     color: #ff9900;
    float: right;
    margin-right: 20px;" id="caozuoTip" data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom"
                      data-html="true" data-content="将需要一起安装的业务明细批量勾选，创建为一笔安装工单" data-original-title="" title="">
                    注意事项<span class="iconfont_new"
                              style="position: relative;top:-1px;vertical-align: middle;font-size: 20px"></span></div>
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


</body>
</html>