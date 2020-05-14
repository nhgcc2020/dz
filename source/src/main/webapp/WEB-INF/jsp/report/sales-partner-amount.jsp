<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8" />
            <title>客户应收账款报表</title>
            <meta name="renderer" content="webkit">
            <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
            <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
            <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
            <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
            <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
            <script src="/resources/easyui/locale/easyui-lang-zh_CN.js?v=af8a82977a"></script>
            <script src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
            <script src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"></script>
            <script src="/resources/business/base_new.js?v=9ac481258d"></script>

            <style>
                .conTbText .datagrid-header td,
                .conTbText .datagrid-body td,
                .conTbText .datagrid-footer td {
                    border-width: 0;
                }

                .conTbText .datagrid-header td,
                .conTbText.datagrid-body td,
                .conTbText .datagrid-footer td {
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
                    height: 50px;
                    line-height: 50px;
                    color: #333;
                }

                .datagrid-header,
                .datagrid-td-rownumber {
                    background: #eff1f9;
                }

                .datagrid-header {
                    border-width: 0;
                    /*border-color:  #2e8ae6;;*/
                }

                .datagrid-header .datagrid-cell span {
                    font-size: 14px;
                }

                .btn-primary {
                    background-color: #2e8ae6;
                    border-color: #2e8ae6;
                }

                .btn-primary:hover,
                .btn-primary:focus,
                .btn-primary:active,
                .btn-primary.active,
                .open .dropdown-toggle.btn-primary {
                    background-color: #2e8ae6;
                    border-color: #2e8ae6;
                }

                .datagrid-header td,
                .datagrid-body td,
                .datagrid-footer td {
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

                .datagrid-header-row,
                .datagrid-row {
                    height: 30px;
                    line-height: 30px;
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
              /**/
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
                    padding: 25px  4px;
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

                .datagrid-cell a:hover,
                .datagrid-cell a:visited,
                .datagrid-cell a:link {
                    color: #4284d9;
                    text-decoration: none;
                }

                .nav-tabs>li>a {
                    color: #3f3e3e;
                    border: none;
                }

                .nav-tabs,
                .nav-tabs>li.smcolor>a,
                .nav-tabs>li.smcolor>a:hover,
                .nav-tabs>li.smcolor>a:focus {
                    border: none;
                    font-size: 14px;
                }

                .nav-tabs>li.smcolor>a,
                .nav-tabs>li.smcolor>a:hover,
                .nav-tabs>li.smcolor>a:focus {
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

                .nav-tabs {
                    position: relative;
                }

                .nav-tabs li:nth-child(2).smcolor~.block {
                    transform: translate(82px, 0);
                    width: 70px;
                }
                .nav-tabs li:nth-child(1)~.block {
                    position: absolute;
                    bottom: 3px;
                    left: 2px;
                    width: 70px;
                    height: 2px;
                    background-color: #2e8ae6;
                    transition: all .3s;
                }


                header {
                    height: 50px;
                    line-height: 50px;
                    font-size: 16px;
                    color: #333;
                    margin-left: 19px;
                    background: #fff !important;
                    border: none !important;
                    padding: 0 !important;
                }

                .line {
                    margin: 12px 0 9px;
                    border-top: 1px solid #f2f2f2;
                }

                .datagrid-body td {
                    border-width: 0 0 1px 0;
                    border-color:#f2f2f2;
                }
                .datagrid-header td{
                    border-width:0;
                }
                .datagrid-cell-c2-number {
                    color: #999 !important;
                    font-size: 12px !important;
                }

                .datagrid-cell {
                    color: #333;
                }

                .datagrid-htable {
                    height: 50px !important;
                    line-height: 50px !important;
                }

                .datagrid-cell-c2-clientele {
                    font-size: 14px;
                }
                .addcount{
                    width: 100%;
                    height: 110px;
                    background: #f8f9fd;
                }
                .addcount>ul{
                    width: 80%;
                    height: 110px;
                    display: flex;
                    justify-content: center;
                    margin: 0 auto;
                }
                .addcount>ul>li{
                    display: inline-block;
                    width: 20%;
                    text-align: center;
                    font-size: 14px;
                    color: #999;
                    height: 46px;
                    margin-top:28px;
                }
                .addcount>ul>li>p:nth-child(2){
                    font-size: 24px;
                    color: #666;
                }
            </style>
        </head>

        <body class="easyui-layout" style="border:none !important;">
            <div data-options="region:'north'" style="border:none !important;padding:10px 20px;overflow: hidden;box-sizing: border-box;">
                <header>
                    客户应收报表
                </header>
                <ul class="nav nav-tabs" id="navCondition">
                    <li style="position:relative;" data-s="04" onclick="cgx(this,'1');" class="smcolor"><a href="#">待对账</a></li>
                    <li style="position:relative;" data-s="07" onclick="cgx(this,'2');"><a href="#">待收款</a></li>
                    <li class="block"></li>
                </ul>
                <div class="h10"></div>
                <div>
                   <form role="form">
                        <div class="row" style="margin:0;">
                            <div class="col-xs-2" style="width:140px;padding:0 5px">
                                <select class="form-control input-xs" id="dateDat">
                        <option value=""></option>
                    </select>
                            </div>
                            <div class="col-xs-2 " style="width:170px;padding:0 5px">

                                <div class="">
                                    <div class="input-icon-group">
                                        <div class="" style="width:140px">
                                            <input type="text" style="" class="form-control" id="datetimepickers" data-format="yyyy-MM-dd" placeholder="订单日期">
                                            <span onclick="$('#datetimepickers').datetimepicker('show');" class="" style="
    position: absolute;
    right: 30px;
    top: 3px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                            <span style="
    position: absolute;
    right: 5px;
    top: 7px;
">至</span>
                                            </input>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-2 " style="width:140px;padding:0 5px">

                                <div class="">
                                    <div class="input-icon-group">
                                        <div class="" style="width:100%">
                                            <input type="text" style="" class="form-control" id="datetimepickere" data-format="yyyy-MM-dd" placeholder="订单日期">
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
                            <div class="col-xs-2" style="width:145px;padding:0 5px;">
                                <div class="col-xs-2" style="width:140px;padding:0 5px 0 0">
                                    <select class="form-control input-xs" id="customerDat" placeholder="选择客户">
                    </select>
                                </div>
                            </div>
                            <div class="col-xs-2" style="width:140px; padding:0 5px">
                                <select class="form-control input-xs" id="clientele">
                                <option value="">二者都查</option>
                                <option value="1">好友客户</option>
                                <option value="0">非好友客户</option>
                    </select>
                            </div>
                            <button type="button" id="searchBtn" class="btn btn-primary " style="font-size:12px;height:30px;line-height:1;margin-left:10px;">搜索
                </button>
                        </div>
                    </form>
                </div>
                <div class="line"></div>
                <div class="addcount">
                    <ul>
                        <li>
                            <p>待对账销售单总额</p>
                            <p class="totalPrice04"></p>
                        </li>
                        <li style="font-size:35px;color:#ccc;line-height:46px;">+</li>
                        <li>
                            <p>待收款对账单总额</p>
                            <p class="totalPrice07"></p>
                        </li>
                        <li style="font-size:35px;color:#ccc;line-height:46px;">=</li>
                        <li>
                            <p>合计欠款金额</p>
                            <p class="SumReceivablesMoney" style="color:#eb6877;"></p>
                        </li>
                    </ul>
                </div>
            </div>

            <div data-options="region:'center'" style="border:none !important;padding:10px 20px;padding-top: 0;">
                <table id="order" style="height: 100%;" class="easyui-datagrid " data-options="remoteSort:true,fit:true,
           nowrap:true,singleSelect:false,checkOnSelect:false,fitColumns:true">
                </table>
            </div>
        </body>

        </html>
        <script>
            var   num_s = "136155514456.546 ";
            console.log(parseFloat(num_s).toLocaleString());
            // $("#dateDat").select2({
            //     minimumResultsForSearch: Infinity 
            // });
            $.ajax({
                url: "/system/partner/dropdownPartner?partnerType=1",
                dataType: "json",
                timeout: "8000",
                success: function (data) {
                    $("#customerDat").html(returnopt(data, 1));
                    var status = 1;
                    reload(status); 
                },
                error: function () {
                }
            })
            function returnopt(data, type) {
                var opt = "";
                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    var dtn = "";
                    if (type == 1) {
                        //                    if(dt.partnerShortname==undefined){continue;} 
                        dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                        opt += '<option value="' + dt.partnerKey + '">' + dtn + '</option>';
                    }
                    if (type == 2) {
                        dtn = dt.show;
                        opt += '<option value="' + dt.key + '">' + dtn + '</option>';
                    }
                }
                return opt;
            }
            function formatState(state) {
                var $state = $(
                    '<span >' + state.text + '</span>'
                );
                return $state;
            }
            $(function(){
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
            // $("#dateDat").prepend("<option value='pm00' selected >上月</option>").change();
            $("#dateDat").children().eq(3).attr("selected", "selected")
                .change();
            })
           

            function arrFunDz() {
                var arrclo = [];
                arrclo.push({ field: "cke", width: 100, align: 'center',formatter: function (value,row,index) {
                        return index+1;
                    } });
                arrclo.push({
                    field: 'partnerName', width: 280, align: 'left', title: '客户', formatter: function (value, row) {

                        return value;
                    }
                });
                arrclo.push({ field: 'orderCount', width: 260, align: 'right', sortable: true, title: '待对账销售单笔数' });

                arrclo.push({ field: 'totalPrice04', width: 260, align: 'right', sortable: true, title: '待对账销售单金额',formatter: function (value, row) {
                        return value.toFixed(2);
                    } });
                arrclo.push({
                    field: 'pur', width: "200", align: 'center', title: '操作', formatter: function (value, row) {
                        return '<span onclick="similar(' + row.checkMoney + ')" style="color:#2e8ae6;cursor: pointer;font-size:12px;">去对账</span>';
                    }
                });
                arrclo.push({ field: 'fill', width: "200" });
                return arrclo;
            }


            function arrFunSk() {
                var arrclo = [];
                arrclo.push({ field: "cke", width: 100, align: 'center',formatter: function (value,row,index) {
                        return index+1;
                    } });
                arrclo.push({
                    field: 'partnerName', width: 280, align: 'left', title: '客户', formatter: function (value, row) {

                        return value;
                    }
                });
                arrclo.push({ field: 'orderCount', width: 260, align: 'right', sortable: true, title: '待收款对账单笔数' });

                arrclo.push({ field: 'totalPrice07', width: 260, align: 'right', sortable: true, title: '待收款对账单金额',formatter: function (value, row) {
                        return value.toFixed(2);
                    } });
                arrclo.push({
                    field: 'pur', width: "200", align: 'center', title: '操作', formatter: function (value, row) {
                        return '<span onclick="similar(' + row.checkMoney + ')" style="color:#2e8ae6;cursor: pointer;font-size:12px;">去收款</span>';
                    }
                });
                arrclo.push({ field: 'fill', width: "200" });
                return arrclo;
            }

            var pageSize = 30;
            var pageList=[30,40];
            var message = arrFunSk();
            var status = $("#navCondition").find(".smcolor").attr("data-s");
            function cgx(o, num) {
                $(o).addClass("smcolor").siblings().removeClass("smcolor");
                reload()
            }
            function reload(){
                status = $("#navCondition").find(".smcolor").attr("data-s");
                if(status==04){
                    message = arrFunDz();
                }else{
                    message = arrFunSk();
                }
                $('#order').datagrid({
                    url: "report/saleorder/partnerAmount",
                    fit: true,
                    onLoadSuccess: onLoadSuccess,
                    pagination: true,
                    pageSize: pageSize,
                    pageList: pageList,
                    columns: [message],
                    queryParams: {
                        "partnerKey": $('#customerDat').val(),
                        "endTime": $('#datetimepickere').val(),
                        "startTime": $('#datetimepickers').val(),
                        "friend" : $("#clientele").val(),
                        "orderStatus" : status
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
          $("#searchBtn").click(function(){
                reload()
          })

            function onLoadSuccess(data) {
                $(".totalPrice04").text("￥ "+accounting.formatNumber(data.totalPrice04,2));
                $(".totalPrice07").text("￥ "+accounting.formatNumber(data.totalPrice07,2));
                $(".SumReceivablesMoney").text("￥ "+accounting.formatNumber(data.SumReceivablesMoney,2));
            }
            function similar(data) {
                // similar var 
                console.log(data);
            };

            $("#dateDat").select2({
                minimumResultsForSearch: Infinity
            });
             $("#clientele").select2({
                minimumResultsForSearch: Infinity
            });

            $("#customerDat").select2({
                //                        maximumInputLength:2,
                templateResult: formatState
            });
        </script>