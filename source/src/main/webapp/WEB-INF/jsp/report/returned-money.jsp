<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8" />
            <title>回款统计</title>
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
                    /*border-color:  #2e8ae6;*/
                    /**/
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
                    width: 70%;
                    height: 110px;
                    display: flex;
                    justify-content: center;
                    margin: 0 auto;
                }
                .addcount>ul>li{
                    display: inline-block;
                    width: 50%;
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
                    回款分布&#x3000;&nbsp;<span style="font-size:12px;color:#999;">说明：销售对账单收款成功后即计入统计（时间按照收款日期归入）</span>
                </header>
               
                <div>
                   <form role="form">
                        <div class="row" style="margin:0;">
                            <span style="float:left;margin-top:5px;color:#000;">收款日期筛选：</span>
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
                            <button type="button" id="searchBtn" class="btn btn-primary " style="font-size:12px;height:30px;line-height:1;margin-left:10px;">搜索
                </button>
                        </div>
                    </form>
                </div>
                <div class="line"></div>
                <div class="addcount">
                    <ul>
                        <li>
                            <p>合计对账单金额</p>
                            <p class="sumRangeTotalPrice" style="color:#eb6877;">0.00</p>
                        </li>
                        <li>
                            <p>合计实收金额</p>
                            <p class="sumRangeRecpayMoney" style="color:#eb6877;">0.00</p>
                        </li>
                    </ul>
                </div>
            </div>

            <div data-options="region:'center'" style="border:none !important;padding:10px 20px;padding-top: 0;">
                <table id="order" style="height: 100%;" class="easyui-datagrid " data-options="remoteSort:false,fit:true,
           nowrap:true,singleSelect:false,checkOnSelect:false,fitColumns:true">
                </table>
            </div>
        </body>

        </html>
        <script>
           
            function returnopt(data, type) {
                var opt = "";
                for (var i = 1; i < data.length; i++) {
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
            // $("#dateDat").prepend("<option value='pm00' selected ></option>").change();
            $("#dateDat").children().eq(3).attr("selected", "selected")
                .change();
            reload();
            })
             
        
            function arrFunDz() {
               var titl = "收款账户（"+$('#datetimepickers').val()+" 至 "+$('#datetimepickere').val()+"）"
                var arrclo = [];
                arrclo.push({ field: "cke", width: 76, align: 'center',formatter: function (value,row,index) {
                        return 
                    } });
                arrclo.push({
                    field: 'accountPayee', width: 280, align: 'left', title: titl, formatter: function (value, row) {
                        return value;
                    }
                });
                arrclo.push({ field: 'sumTotalPrice', width: 260, align: 'right', sortable: true, title: '对账单金额',formatter: function (value, row) {
                        return value.toFixed(2);
                    }  });

                arrclo.push({ field: 'sumRecpayMoney', width: 260, align: 'right', sortable: true, title: '实收金额',formatter: function (value, row) {
                        return value.toFixed(2);
                    } });
                arrclo.push({ field: 'sumAllRecpayMoney', width: 260, align: 'right', sortable: true, title: '累计实收金额（全部时间段）',formatter: function (value, row) {
                        return value.toFixed(2);
                    } });
                arrclo.push({ field: 'fill', width: "200" });
                return arrclo;
            }

            function reload(){
                $('#order').datagrid({
                    url: "/report/saleorder/companyRecPayAmount",
                    fit: true,
                    onLoadSuccess: onLoadSuccess,
                    columns: [arrFunDz()],
                    queryParams: {
                        "endTime": $('#datetimepickere').val(),
                        "startTime": $('#datetimepickers').val(),
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
        	 
                $(".sumRangeTotalPrice").text("￥ "+accounting.formatNumber(data.rangeAmount.sumRangeTotalPrice,2));
                $(".sumRangeRecpayMoney").text("￥ "+accounting.formatNumber(data.rangeAmount.sumRangeRecpayMoney,2));
                if(data.rows.length<=0){
                    $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
                }
               
            }
            
            $("#dateDat").select2({
                minimumResultsForSearch: Infinity
            });
            
        </script>