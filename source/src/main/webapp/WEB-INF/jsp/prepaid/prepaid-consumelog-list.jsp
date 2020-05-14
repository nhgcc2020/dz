<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>预充值消费记录</title>
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
            <script>
                var partnerKey = '${partnerKey}';
                var pageAllUrl = "/system/partner/recharge/listconsumelog";// 本页面请求url2
                $(function () {
                    $(".jump").click(function(){
                        var App = window.parent.App;
                        var config = {
                            path: "/ydz/salesorder/forward-synchroSingleSalesOrder"
                        };
                        App.open(config.path, config);
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
                    $("#dateDat").html(returnopt(orderUtil.dateConfig, 2)).change(function () {
                        var code = $(this).val().substring(0, 2);
                        var num = $(this).val().substring(2, $(this).val().length);
                        var dt = orderUtil.dpDateCompute(code, num);
                        $("#datetimepickers").val(dt.beforeDate);
                        $("#datetimepickere").val(dt.nowDate);
                    });
                    $("#dateDat").select2({
                        minimumResultsForSearch: Infinity
                    });


                    //全部订单搜索
                    $(".searchBtn").click(function () {
                        var status = $("#navCondition").find(".smcolor").attr("data-s");
                        reload(status);
                    })
                    $("#switch_order").on("click", "span", function () {
                        $(this).addClass("switch_handle_on").siblings().removeClass("switch_handle_on");
                        var status = $("#navCondition").find(".smcolor").attr("data-s");
                        reload(status);
                    });

                });

                function arrFunAll() {
                    var arrclo=[];
                    arrclo.push({field: 'xh',width: 50,title: '', align: 'center',  formatter: function(val,row,index){
                        return index+1;
                    }});
                    arrclo.push({field: 'checkingNo',width: 200,title: '对账单号'});
                    arrclo.push({field: 'consumeDate',  width: 150, align: 'center', title: '消费日期'});
                    arrclo.push({field: 'consumeMoney',  width: 150, align: 'right', title: '消费金额', formatter: function (value, row) {
                        return accounting.formatNumber(value, 2);
                    }});
                    return arrclo;
                }
                function reload() {
                    var status = $("#navCondition").find(".smcolor").attr("data-s");
                    var arrclo=[],url="",pageSize=30,pageList=[30,40];
                    var arrclo =arrFunAll();
                    url = pageAllUrl;
                    pageSize=30;pageList=[30,40];
                    $('#order').datagrid({
                        url: url,
                        fit:true,
                        onLoadSuccess:onLoadSuccess,
                        pagination: true,
                        pageSize:pageSize,
                        pageList: pageList,
                        columns: [arrclo],
                        queryParams: {
                            "rechargeType": $('#customerDat').val(),
                            "endTime": $('#datetimepickere').val(),
                            "partnerKey": partnerKey,
                            "searchKey": $('#searchK').val(),
                            "startTime": $('#datetimepickers').val()
                        }
                    })

                    var pager = $('#order').datagrid('getPager');	// get the pager of datagrid
                    pager.pagination({
                        layout: ['first', 'links', 'last'],
                        showRefresh: false,
                        displayMsg: ''
                    });
                    $(".pagination").show();
                }
                function onLoadSuccess(data) {
                    $(".datagrid-mask-msg").hide();
                    if (data.rows.length > 0) {
                        $("#order2PagerPrice").text(accounting.formatNumber(data.bottomInfo.sumConsumeMoney, 2));
                    } else {
                        $("#order2PagerPrice").text("0.00");
                        $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
                    }
                }

                function msg(content) {
                    $("#msgwindow").html(content).addClass("activ");
                }
            </script>
            <style>
                /*max-width 请根据页面一级导航实时调整*/
                .w1200alt{
                    width:120px;
                }
                .w1200input{
                    width:150px;
                }

                .w1200ipt150{
                    width:180px;
                }
                .w1200hide{
                    display: inline-block;
                }
                .w1200show{
                    display: none;
                }
                @media only screen and (max-width:1280px){.w1200input{
                    width:120px;
                }
                    .w1200ipt150{
                        width:150px;
                    }
                    .w1200hide{
                        display: none;
                    }
                    .w1200show{
                        display: inline-block;
                    }
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
                    transform: translate(82px, 0);
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
                    left: 2px;
                    width: 70px;
                    height: 2px;
                    background-color: #2e8ae6;
                    transition: all .3s;
                }
                .telColor{
                    color:#ff9200
                }
            </style>
            <script>

                function arrFunPg(){
                    var arrclo=[];

                    arrclo.push({field: 'businessDesc', width: 200, title: '业务内容', formatter: function (value, row) {

                        return value;
                    }});
                    arrclo.push({field: 'requirements', width: 200, title: '物料/制作/说明'});

                    arrclo.push({field: 'specification', width: 100, align: 'center', title: '规格(m)'});
                    arrclo.push({field: 'quantity', width: 60, align: 'center', title: '数量'});
                    arrclo.push({field: 'totalArea', width: 60, align: 'center', title: '面积(㎡)'});
                    arrclo.push({field: 'cz', width: 60, align: 'center', title: '<div style="" id="caozuoTip"  data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom" data-html="true"        data-content="用于标记加急的制作物料,便于员工优先制作" >加急<span  class="iconfont_new" style="color: #ff9900;position: relative;top:-1px;vertical-align: middle;font-size: 20px">&#xe6b8;</span></div>', formatter: function (value, row) {
                        if(row.isUrgent=="1"){
                            return ' <div style="width: 40px;    display: inline-block;" class="checkbox checkbox-slider--b-flat "><label><input onclick="checkChange(this)" value="1" checked type="checkbox"><span></span></label></div>'
                        }else{
                            return ' <div style="width: 40px;    display: inline-block;" class="checkbox checkbox-slider--b-flat "><label><input onclick="checkChange(this)" value="1"  type="checkbox"><span></span></label></div>'
                        }

                    }});

                    return arrclo;
                }
                function checkChange(o) {
                    // var rindex=  $(o).parents("tr").index();
                    // var pageCheckbox=  $('#order').datagrid('getRows')[rindex];
                    // if(pageCheckbox.isChecked=="1"){
                    //     f=0
                    // }else{f=1}
                    // $('#order').datagrid('getRows')[rindex].isChecked=f;
                    var rindex=  $(o).parents("tr").index();
                    var pageCheckbox=  $('#orderPg').datagrid('getRows')[rindex];
                    var f;
                    if(pageCheckbox.isUrgent=="1"){
                        f=0
                    }else{f=1}

                    $('#orderPg').datagrid('updateRow',{index:rindex,row:{
                        "isUrgent": f
                    }});
                }

            </script>
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

                .ydz_select_a {
                    width: 0;
                    height: 0;
                    border-left: 5px solid transparent;
                    border-right: 5px solid transparent;
                    border-top: 5px solid #786f6f;
                    position: absolute;
                    right: 5px;
                    top: 15px;
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
                    float: left;
                    left: 0;
                    overflow-x: hidden;
                    overflow-y: auto;
                    position: absolute;
                    top: 100%;
                    width: 170px;
                    z-index: 1000;
                }

                .ydz_select_menu li {
                    line-height: 21px;
                    padding-bottom: 0 !important
                }

                .open .ydz_select_menu {
                    display: block
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

                .ydz_select_menu li a:hover {
                    background: none repeat scroll 0 0 #5897fb;
                    color: #FFF;
                    text-decoration: none
                }

            </style>
            <script>
                $(function () {
                    $("body").bind('click', function () {
                        $(".ydz_select").removeClass("open");
                    });
                    $(".ydz_select").on("click", function (e) {
                        e.stopPropagation();
                        if ($(this).hasClass("open")) {
                            $(this).removeClass("open");
                        } else {
                            $(".ydz_select").removeClass("open");
                            $(this).addClass("open");
                        }
                    });
                    $(".ydz_select_menu").on("click", "li", function () {
                        $(this).closest(".ydz_select").find("input[type='hidden']").val($(this).find("a").attr("rel"));
                        $(this).closest(".ydz_select").find("span").text($(this).find("a").text());

                    })
                    reload();
                })
                function returnopt(data, type) {
                    var opt = "";
                    for (var i = 0; i < data.length; i++) {
                        var dt = data[i];
                        var dtn = "";
                        if (type == 1) {
                            dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                            opt += '<option data-p="'+dt.partnerStatus+'" value="' + dt.partnerKey + '">' + dtn + '</option>';
                        }
                        if (type == 2) {
                            dtn = dt.show;
                            opt += '<option value="' + dt.key + '">' + dtn + '</option>';
                        }
                    }
                    return opt;
                }
                function  returnopt3(data, type) {
                    var  opt = '<option value="">充值方式</option>';
                    for (var i = 0; i < data.length; i++) {
                        var dt = data[i];
                        var dtn = "";
                        if (type == 1) {
                            opt += '<option value="' + dt.id + '">' + dt.text + '</option>';
                        }
                        else if (type == 2) {
                            dtn = dt.show;
                            opt += '<option value="' + dt.key + '">' + dtn + '</option>';
                        } else if (type == 3) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                            opt += '<li><a rel="' + dt.employeeId + '" href="javascript:;">' + dt.realName + '</a></li>';
                        }
                        else if (type == 4) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                            opt += '<li><a rel="' + dt.id + '" href="javascript:;">' + dt.text + '</a></li>';
                        }

                    }
                    return opt;
                }
            </script>
        </head>
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">





    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">

                <div class="col-xs-2 w1200alt" style="padding:0 5px">
                    <select class="form-control input-xs" id="dateDat">
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-xs-2 w1200ipt150" style="padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="w1200input" >
                                <input type="text" style="" class="form-control" id="datetimepickers"
                                       data-format="yyyy-MM-dd" placeholder="消费日期">
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
                                       data-format="yyyy-MM-dd" placeholder="消费日期">
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

                <button type="button" id=""  class="btn w1200hide btn-primary searchBtn "
                        style="font-size:12px;height:30px;line-height:1;" >搜索
                </button>

                <button type="button"  class="btn btn-warning pull-right  "
                        style="font-size:12px;height:30px;line-height:1;" onclick="funOpenUrl('1')">返回
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
<div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">
<span id="totalTextSpan">消费总金额(元)：</span>
<span style="color: red;margin-right: 15px;" id="order2PagerPrice">0.00</span>
</div>
<script>
    function closeProReq() {
        $(".window-mask").hide();
        $("#topBarPR").hide();
        reload();
    }
    function funOpenUrl(v) {
        window.location.href ="/openPage?pageName=prepaid_prepaid-deposit-list";
    }
    function openDt(obj) {
        var url = "/ydz/salesorder/salesOrderDetail?salesNo=" + $(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
        showMessageDialog(url, "", "84%", "100%", true);
    }

    function msg(content) {
        $("#msgwindow").html(content).addClass("activ");
    }
    function hideMsg() {
        $(".window-mask").hide();
        $("#msgwindow").css({left: "100%"}).removeClass("activ");
    }
    function showMessageDialog(url, title, width, height, shadow) {
        var content = '<iframe id="msgF" src="' + url + '" width="100%" height="99%" frameborder="0" scrolling="yes"></iframe>';
        $("#msgwindow").empty();
        $("#msgwindow").css({left: "16%"});
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
</script>
</body>
</html>

</body>

</html>