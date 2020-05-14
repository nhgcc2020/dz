<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8" />
            <title>营业毛利润统计</title>
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
                html,
                body {
                    height: 100%;
                }

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
                    line-height: 80px;
                    display: none;
                }

                .pagination {
                    display: none;
                }
                /*    .datagrid-header td,.datagrid-body td{
                padding:5px;you duo shao
            }*/

                .datagrid-body .datagrid-cell {
                    padding: 25px 4px;
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
                    margin: 5px 0 26px;
                    font-size: 16px;
                    color: #000;
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
                    border-color: #f2f2f2;
                }

                .datagrid-header td {
                    border-width: 0;
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

                .addcount {
                    width: 100%;
                    height: 170px;
                    background: #f8f9fd;
                    overflow: hidden;
                }

                .addcount>div {
                    text-align: center;
                    margin-top: 20px;
                    font-size: 16px;
                    color: #333;
                }

                @media only screen and (min-height: 870px) {
                    .count li span:nth-child(2) {
                        float: right;
                        line-height: 80px;
                        color: #ccc;
                        font-size: 30px;
                        font-family: "arial";
                    }

                    .count li span:nth-child(1) {
                        display: inline-block;
                        line-height: 80px;
                        width: 80px;
                        border-radius: 50%;
                        text-align: center;
                        margin-bottom: 27px;
                        font-size: 16px;
                    }
                }

                @media only screen and (max-height: 869px) {
                    .count li span:nth-child(2) {
                        float: right;
                        line-height: 60px;
                        color: #ccc;
                        font-size: 30px;
                        font-family: "arial";
                    }

                    .count li span:nth-child(1) {
                        display: inline-block;
                        line-height: 60px;
                        width: 60px;
                        border-radius: 50%;
                        text-align: center;
                        margin-bottom: 20px;
                        font-size: 16px;
                    }
                }

                .count {
                    width: 370px;
                    margin: 0 auto;
                    color: #fff;
                    margin-top: 3%;
                }

                .count li .colorSize {
                    color: #666!important;
                }

                .animated {
                    display: none;
                }
            </style>
        </head>

        <body class="easyui-layout" style="border:none !important;">
            <div class="adapt" style="border:none !important;padding:10px 20px;box-sizing: border-box;height:100%;">
                <header>
                    营业毛利
                </header>

                <div>
                    <form role="form">
                        <div class="row" style="margin:0;">
                            <span style="float:left;margin-top:5px;color:#000;margin-right:17px;">日期筛选：</span>
                            <div class="col-xs-2" style="width:150px;padding:0 5px">
                                <select class="form-control input-xs" id="year">
                                    <option value="2016">2016年</option>
                                    <option value="2017">2017年</option>
                                    <option value="2018">2018年</option>
                                    <option value="2019">2019年</option>
                                    <option value="2020" selected>2020年</option>
                                </select>
                            </div>
                            <div class="col-xs-2" style="width:150px;padding:0 5px">
                                <select class="form-control input-xs" id="month">
                                    <option value="12">12月</option>
                                    <option value="11">11月</option>
                                    <option value="10">10月</option>
                                    <option value="09">09月</option>
                                    <option value="08">08月</option>
                                    <option value="07">07月</option>
                                    <option value="06">06月</option>
                                    <option value="05">05月</option>
                                    <option value="04">04月</option>
                                    <option value="03">03月</option>
                                    <option value="02">02月</option>
                                    <option value="01">01月</option>
                                </select>
                            </div>
                            <button type="button" id="searchBtn" class="btn btn-primary " style="font-size:12px;height:30px;line-height:1;margin-left:5px;">搜索
                            </button>
                        </div>
                    </form>
                </div>
                <div class="line"></div>
                <div class="addcount">
                    <div><span class="moneys">11</span><span>月盈利金额：</span><span class="profit" style="font-size:80px;color:#f15822;margin-left:12px;font-family: 'arial';position:relative;top:2px;">0.00</span></div>
                </div>
                <ul class="count">
                    <li class="animated"><span style="background:#eb6877;">销售</span><span class="message">+ 0.00</span></li>
                    <li class="animated"><span style="background:#009fe8;">外协</span><span class="message">- 0.00</span></li>
                    <li class="animated"><span style="background:#009fe8;">采购</span><span class="message">- 0.00</span></li>
                    <li class="animated"><span style="background:#15bc83;">日常</span><span class="message">- 0.00</span></li>
                    <li class="animated"><span style="background:#15bc83;">工资</span><span class="message">- 0.00</span></li>
                </ul>
            </div>
            <div class="tips_contants"></div>
        </body>

        </html>
        <script>
            setTimeout(function(){
                $(".adapt").css("overflow","auto");
            },3000)
            $(".animated").eq(0).show().addClass("bounceInUp");
            var i = 1;
            var anmite = setInterval(function () {
                $(".animated").eq(i).show().addClass("bounceInUp");
                i++;
                if (i == 5) {
                    clearInterval(anmite);
                }
            }, 500)
            var date = new Date();
            debugger;
            var md=Number(new Date().getMonth())+1;
            if(md<10){md="0"+md};
            $("#monthDat").val(md);
            if(date.getMonth()==0){
                $("#year").val(date.getFullYear()-1);
                $("#month").val(12);
            }else{
                $("#month").val(md);
                $("#year").val(date.getFullYear());
            }
            $("#year").select2({
                minimumResultsForSearch: Infinity
            });
            $("#month").select2({
                minimumResultsForSearch: Infinity
            });
            $(".moneys").text($("#month").val());
            function request() {
                $.ajax({
                    url: '/report/company/gross-profit',
                    type: 'GET',
                    dataType: "json",
                    data: { orderDate: $("#year").val() + '-' + $("#month").val() },
                    success: function (data) {
                        if (data == null) {
                            $(".tips_contants").html("没有数据").fadeIn(250).delay(1000).fadeOut(250);
                            $(".message").text("- 0.00").removeClass("colorSize");
                            $(".message").eq(0).text("+ 0.00");
                            $(".profit").text("0.00");
                        }else{
                            if(data.salesTotalPrice==0){
                                $(".message").eq(0).text("+ "+accounting.formatNumber(data.salesTotalPrice,2)).removeClass("colorSize");
                            }else{
                                $(".message").eq(0).text("+ "+accounting.formatNumber(data.salesTotalPrice,2)).addClass("colorSize");
                            }
                            if(data.purchaseTotalPrice==0){
                                $(".message").eq(2).text("- "+accounting.formatNumber(data.purchaseTotalPrice,2)).removeClass("colorSize");
                            }else{
                                $(".message").eq(2).text("- "+accounting.formatNumber(data.purchaseTotalPrice,2)).addClass("colorSize");
                            }
                            if(data.expenseDailyTotalPrice==0){
                                $(".message").eq(3).text("- "+accounting.formatNumber(data.expenseDailyTotalPrice,2)).removeClass("colorSize");
                            }else{
                                $(".message").eq(3).text("- "+accounting.formatNumber(data.expenseDailyTotalPrice,2)).addClass("colorSize");
                            }
                            if(data.expenseSalaryTotalPrice==0){
                                $(".message").eq(4).text("- "+accounting.formatNumber(data.expenseSalaryTotalPrice,2)).removeClass("colorSize");
                            }else{
                                $(".message").eq(4).text("- "+accounting.formatNumber(data.expenseSalaryTotalPrice,2)).addClass("colorSize");
                            }
                            $(".message").eq(1).text("- 0.00").removeClass("colorSize");
                            var profit = data.salesTotalPrice - (data.purchaseTotalPrice+data.expenseDailyTotalPrice+data.expenseSalaryTotalPrice);
                            if(profit<0){
                                $(".profit").css("color","#15bc83");
                            }else{
                                $(".profit").css("color","#f15822");
                            }
                            $(".profit").text(accounting.formatNumber(profit,2));
                        }
                    }
                });
            }
            request();
            $("#searchBtn").click(function () {
                $(".moneys").text($("#month").val());
                request();
            })
        </script>