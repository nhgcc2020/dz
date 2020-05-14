<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>销售提成列表</title>
        <meta name="renderer" content="webkit">
        <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
        <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">


        <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
        <script src="/resources/pageConfig.js?v=d1935279f72c87"></script>
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
            #taxPointWin{
                border: none;
                z-index: 99;
                width:700px;
                box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
                background: #fff;
                transition:all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
                display: none;
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

            #taxPointWin ,#orderWin{
                border: none;
                z-index: 9999;
                width: 700px;
                box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
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
                transform: translate(80px, 0);
            }



            .nav-tabs li:nth-child(1) ~ .block {
                position: absolute;
                bottom: 3px;
                left: 8px;
                width: 60px;
                height: 2px;
                background-color: #2e8ae6;
                transition: all .3s;
            }

            .telColor {
                color: #ff9200
            }
        </style>
        <script>

            var pageDefaultSaleConUrl="/ydz/salesorder/getDefaultSalesMan"; //销售代表默认值
            var pageUrl = "/ydz/commission/listPageSalesCheckingOrderForCommissions";// 本页面请求url1
            var pageAllocationUrl = "/ydz/commission/allocationCommission";// 分配请求
            var pageUpdateUrl = "/ydz/commission/updatecommission";//   修改分配请求
            var pageInfoUrl = "/ydz/commission/ordercommission-info";//   请求提成比例数据
            var pageCreateInfoUrl = "/ydz/commission/createCommissionChecking";//  生成结算单 orderNoIns
            var pageCustomerUrl =  "/system/partner/dropdownPartner?partnerType=1";// 本页面客户数据url1
            var pageListSaleConUrl="/ydz/salesorder/listSalesMan"; //销售代表下拉框



            var salesCommList = {
                recpayKeyUp:function (b) {
                    var $this=$(b),$va=   parseFloat($("#orderMon").val());
                    if(isNaN($this.val())){
                        $(".recpayDiscount").addClass("smallCls");
                        $(".recpayDiscount").removeClass("hide").html("非法数字");
//                    Number(totalPrice).toFixed(2);
//                    parseFloat($("input.unitPriceChange")[rindex].value);
                        $("#blMoneyCls").val(accounting.formatNumber($("#orderMon").val(),2));
                        $("#blMoney").text(accounting.formatNumber($("#orderMon").val(),2));
                        return;
                    }
                    if(isNaN($va)){
                        $.mytoast({text:"应收金额含有非法数字"});
                        return;
                    }
                    var pr=Number($va*Number($("#allowcationBl").val())*0.01);
                    $("#blMoneyCls").val(accounting.formatNumber(pr,2,""));
                    $("#blMoney").text(accounting.formatNumber(pr,2));
                },
                closeTaxPoint: function () {
                $(".window-mask").hide();
                    $("#partnetKeyCls").val("");
                    $("#salesNameCls").val("");
                    $("#salesIdCls").val("");
                    $("#blMoneyCls").val("");
                    $("#blMoney").text("");
                    $("#allowcationBl").val("");
                    $("#checkingNoCls").val("");
                    $("#ordernoCls").val("");
                $("#taxPointWin,#orderWin").css({display: 'none'});
            },
                saveTable2: function () {
                    var self=$(this);
                    self.attr("disabled",true);
                    var parse={};
                    parse.orderNoIns=$("#checkingNoCls").val();
                    $.ajax({
                        url: pageCreateInfoUrl,
                        type: "post",
                        data: jQuery.param(parse),
                        dataType: "json",
                        success: function (callBack) {
                            $.mytoast({text: callBack.msg});
                            self.attr("disabled",false);
                            salesCommList.closeTaxPoint();
                            reload();
                        }, error: function () {
                            $.mytoast({text: "操作出错"});
                            self.attr("disabled",false);
                        }
                    });
                },
                saveTable: function () {
                    var br=Number($("#allowcationBl").val());
                    if(isNaN(br) || br==""){     $.mytoast({text: "请填写提成比例"});return;}
                    var self=$(this);
                    self.attr("disabled",true);
                    var parse={};
                       parse.partnerKey= $("#partnetKeyCls").val();
                       parse.salesId= $("#salesIdCls").val();
                       parse.salesName=$("#salesNameCls").val();
                       parse.allocationType=$("#allowcationWaySel").val();
                       parse.commissionsRate=br/100;
                       parse.commissionsMoney=$("#blMoneyCls").val();
                       parse.orderNo=$("#ordernoCls").val();
                    var status = $("#navCondition").find(".smcolor").attr("data-s");
                       var url=status=="1" ? pageUpdateUrl:pageAllocationUrl;
                    $.ajax({
                        url: url,
                        type: "post",
                        data: jQuery.param(parse),
                        dataType: "json",
                        success: function (callBack) {
                            $.mytoast({text: callBack.msg});
                            self.attr("disabled",false);
                            salesCommList.closeTaxPoint();
                            reload();
                        }, error: function () {
                            $.mytoast({text: "分配出错"});
                            self.attr("disabled",false);
                        }
                    });
            },
                saleManDp:  function (){
                $.ajax({
                    url:pageListSaleConUrl,
                    dataType:"json",
                    timeout:"8000",
                    success:function(dt){
                        // dt=[];
                        // $("#saleManDp").html( returnopt(data,2));
                        var dtall = $.map(dt, function (obj) {
                            obj.text = obj.realName; // replace name with the property used for the text
                            obj.id = obj.employeeId; // replace name with the property used for the text
                            return obj;
                        });
                       var returnopt2=function () {
                            var opt =  '<option  value="">选择销售代表</option>';
                            for (var i = 0; i < dtall.length; i++) {
                                var dt = dtall[i];
                                var dtn = "";
                                opt += '<option  value="' + dt.id + '">' +  dt.text + '</option>';
                            }
                                return opt;

                        }
                        $("#saleManDp").html(returnopt2).select2({ minimumResultsForSearch: Infinity});
                    },
                    error:function(){
                    }
                })
            },

                returnopt: function (data, type) {
                    var opt = "";
                    for (var i = 0; i < data.length; i++) {
                        var dt = data[i];
                        var dtn = "";
                        if (type == 1) {
                            dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                            opt += '<option data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
                        }else
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
                    arrclo.push({field: 'recpayDate', sortable: true, width: 140, align: 'center', title: '收款日期'});
                    arrclo.push({field: 'checkingNo',  width: 140, align: 'center', title: '对账单号'});
                    arrclo.push({field: 'orderCycle', width: 200, align: 'center', title: '订单周期'});
                    arrclo.push({
                        field: 'partnerShortname', title: '客户', align: 'center',width: 140, formatter: function (value, row) {

                            return '<div>' + row.partnerShortname + '</div>' + '<div class="namebd"><span class="namebdsml">' + row.contactName + '</span></div>';
                        }
                    });
                    arrclo.push({field: 'caseDesc', width: 200, title: '项目名称'});
                    arrclo.push({field: 'salesName',align: 'center', width: 100, title: '销售代表'});


                    arrclo.push({
                        field: 'depositRequested', width: 90, align: 'right', formatter: function (value, row) {
                            return accounting.formatNumber(value, 2);
                        }, title: '预收金额(元)'
                    });
                    arrclo.push({
                        field: 'paidUp', width: 90, align: 'right', formatter: function (value, row) {
                            return accounting.formatNumber(value, 2);
                        }, title: '实收总金额(元)'
                    });
                    arrclo.push({
                        field: 'commissionsMoney', width: 100, align: 'right', formatter: function (value, row) {
                            return accounting.formatNumber(value, 2);
                        }, title: '提成金额(元)'
                    });
                    arrclo.push({field: 'createTime', sortable: true, width: 140, align: 'center', title: '制单时间'});
                    return arrclo;
                },
                onLoadSuccess: function (data) {
                    if (data.rows.length > 0) {
                        $("#order2PagerNum").text(data.bottomInfo.orderCount);
                        $("#order2PagerPrice").text(accounting.formatNumber(data.bottomInfo.sumPaidUp, 2));
                        $("#orderPrice").text(accounting.formatNumber(data.bottomInfo.sumCommissionsMoney, 2));
                    } else {
                        $("#order2PagerNum").text("0");
                        $("#order2PagerPrice").text("0.00");
                        $("#orderPrice").text("0.00");
                        $.mytoast({text:"没有查询到数据"});
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
                        $.mytoast({text: "请选择安装单"});
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

//                    $.post(pageNeedUrl, {detailUid: checkRow}, function (data) {
//
//                        $("#navCondition").find("li:eq(1)").click();
//                    });
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
                            salesCommList.msg(content);
                        } else {
                            $("#msgwindow")[0].addEventListener('webkitTransitionEnd', function () {
                                if (Date.now() - last < 3000) {
                                    salesCommList.msg(content);
                                }
                            }, false);
                        }

                    }, 0);
                },
                openDt: function (obj) {
                    var url = "/ydz/salesorder/salesOrderDetail?salesNo=" + $(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
                    salesCommList.showMessageDialog(url, "", "84%", "100%", true);
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
//                    salesCommList.createOrder();
                    var order4Items = $('#order').datagrid('getChecked');
                    var salesNos = new Array();
                    var flag = false;   var partnetKey,paidUp=0;  var numIndex = 0;
                    if(order4Items.length>1 || order4Items.length==0){
                        $.mytoast({text: "分配只能针对单个订单"});
                        return ;}
                    $.each(order4Items, function (index, element) {
                        //判断是否同一用户
                        if (numIndex == 0) {
                            partnetKey = element.partnerKey;

                            $("#partnetKeyCls").val(partnetKey);
                            $("#salesIdCls").val(element.salesId);
                            $("#ordernoCls").val(element.checkingNo);
                            $("#salesNameCls").val(element.salesName);
                        }
                        paidUp +=element.depositRequested+element.paidUp;
                        numIndex++;
                    });
                    if (flag) {
                        return false;
                    }
                    $("#orderMon").val(accounting.formatNumber(paidUp,2,""));
                    $("#taxPointWin").css({display:'block'});
                })
                $("#modifyOrder").click(function () {
                    var order4Items = $('#order').datagrid('getChecked');
                    if(order4Items.length>1 || order4Items.length==0){
                        $.mytoast({text: "修改只能针对单个订单"});
                        return ;}
                    var salesNos = new Array();
                    var flag = false;   var partnetKey,paidUp=0;   var numIndex = 0;
                    $.each(order4Items, function (index, element) {
                        if (numIndex == 0) {
                            partnetKey = element.partnerKey;
                            $("#blMoneyCls").val(element.commissionsMoney);
                            $("#blMoney").text(element.commissionsMoney);
                            $("#partnetKeyCls").val(partnetKey);
                            $("#salesIdCls").val(element.salesId);
                            $("#ordernoCls").val(element.checkingNo);
                            $("#salesNameCls").val(element.salesName);
                            var parse={};
                            parse.orderNo=element.checkingNo;

                            $.ajax({
                                url:pageInfoUrl,
                                data:jQuery.param(parse),
                                dataType: "json",
                                success: function (data) {
                                    $("#allowcationBl").val(data.commissionsRate);
                                }
                            });
                        }
                        paidUp +=element.depositRequested+element.paidUp;
                        numIndex++;
                    });

                    $("#orderMon").val(accounting.formatNumber(paidUp,2,""));
                    $("#taxPointWin").css({display:'block'});
                })

                $("#createCheckOrder").click(function () {
                    var order4Items = $('#order').datagrid('getChecked');
                    var salesNos = new Array();
                    var flag = false;   var salesId,salesName;  var numIndex = 0;
                    $.each(order4Items, function (index, element) {
                        salesNos.push(element.salesNo);
                        //判断是否同一用户
                        if (numIndex == 0) {
                            salesId = element.salesId;
                            salesName = element.salesName;
                        } else if (salesId != element.salesId) {
                            $.mytoast({text:"请选择相同销售代表"});
                            flag = true;
                            return false;
                        }
                        numIndex++;
                    });
                    if (flag) {
                        return false;
                    }
                    var totalPrice = 0, depositRequested = 0,checkingNo=[], receivePrice = 0;
                    $.each(order4Items, function (index, element) {
                        checkingNo.push(element.checkingNo);
                        totalPrice = totalPrice + element.commissionsMoney;
                    });
                    $("#depositRequested").text(accounting.formatNumber(totalPrice,2));//销售价格
                    $("#numIndex").text(numIndex);//订单笔数
                    $("#partnerShortname").text(salesName);//客户简称
                    $("#checkingNoCls").val(checkingNo.join(","));//

                    $("#orderWin").css({display:'block'});
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
                $("#dateDat").html(salesCommList.returnopt(orderUtil.dateConfig, 2)).change(function () {
                    var code = $(this).val().substring(0, 2);
                    var num = $(this).val().substring(2, $(this).val().length);
                    var dt = orderUtil.dpDateCompute(code, num);
                    $("#datetimepickers").val(dt.beforeDate);
                    $("#datetimepickere").val(dt.nowDate);
                });
                $("#dateDat").select2({
                    minimumResultsForSearch: Infinity
                });
                salesCommList.saleManDp();
                $.ajax({
                    url:pageCustomerUrl,
                    dataType: "json",
                    success: function (data) {
                        $("#customerDat").html(salesCommList.returnopt(data, 1));
                        $("#customerDat").select2({
//                        maximumInputLength:2,
                            templateResult: salesCommList.formatState
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

            });//本页面加载完成初始化数据
            // 公共方法
            function reload() {
                var status = $("#navCondition").find(".smcolor").attr("data-s");
                var arrclo = [], url = "", pageSize = 30, pageList = [30, 40];
                var arrclo = salesCommList.arrFunDetail();
//                if(status==""){
//                    url=pageInstallUrl;
//                }else{
                    url = pageUrl;
//                }
                pageSize = 30;
                pageList = [30, 40];

                if(status=="0"){
                    $(".createInstaller").removeClass("hide");
                    $(".needInstaller").addClass("hide");
                }else{
                    $(".createInstaller").addClass("hide");
                    $(".needInstaller").removeClass("hide");
                }

                    $('#order').datagrid({
                        url: url,
                        fit: true,
                        onLoadSuccess: salesCommList.onLoadSuccess,
                        pagination: true,
                        pageSize: pageSize,
                        pageList: pageList,
                        columns: [arrclo],
                        queryParams: {
                            "isSettlement": status,
                            "partnerKey": $('#customerDat').val(),
                            "endTime": $('#datetimepickere').val(),
                            "searchKey": $('#searchK').val(),
                            "salesId": $("#saleManDp").val(),
                            "startTime": $('#datetimepickers').val()
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
            function hideMsg() {
                $(".window-mask").hide();
                $("#msgwindow").css({left: "100%"}).removeClass("activ");
            }



        </script>
    </head>
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>

<div id="taxPointWin" class="segment show-on-ready" style="padding-top:5px;top:50%;left:50%;margin-left:-250px; margin-top:-230px;position:absolute; width: 500px;height:280px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 18px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;" id="fuwuTitle">
        绩效核算    </p>

    <input type="hidden" name="partnetKeyCls" id="partnetKeyCls" />
    <input type="hidden" name="salesIdCls" id="salesIdCls" />
    <input type="hidden" name="salesNameCls" id="salesNameCls" />
    <input type="hidden" name="blMoneyCls" id="blMoneyCls" />
    <input type="hidden" name="ordernoCls" id="ordernoCls" />


    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="salesCommList.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <div style=" margin: 20px 0 25px 2px;line-height: 30px;position: relative;text-align: right;">
            <div class="form-group" >
                <label class="col-sm-4 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">订单金额：</label>
                <div class="col-sm-5 " style="
    margin-bottom: 10px;
padding:0;
">
                    <input type="text" style="text-align:right;width:214px;" class="form-control" readonly id="orderMon" />

                </div>


                <div class="col-sm-3 hide requireMenu"></div>

                <label class="col-sm-4 control-label" style="
padding-right: 15px;
    text-align: right;
    font-size: 14px;
">分配方式：</label>
                <div class="col-sm-8 " style="
    padding: 0;text-align: left;
margin-bottom: 10px;
">
                    <select type="text" style="width:214px;" class="form-control" id="allowcationWaySel" placeholder="">
                        <option value="1">按比例</option>
                    </select>
                </div>

                <label class="col-sm-4 control-label" style="
    padding-right: 15px;
    text-align: right;
    font-size: 14px;
">提成比例：</label>
                <div class="col-sm-1 " style="
    margin-bottom: 10px;position:relative;
padding:0;
">
                    <input type="number" style="width:70px;" onkeyup="salesCommList.recpayKeyUp(this)" class="form-control" id="allowcationBl"  />
                    <i style="    position: absolute;right: -45px;top: 0;">%</i>

                </div>
                <div class="col-sm-3 " id="blMoney" style="
    margin-bottom: 10px;width:165px;
padding:0;
">
                </div>


            </div>
        </div>

        <%--<div style="    clear: both;--%>
    <%--margin: auto;--%>
    <%--padding-top: 20px;--%>
    <%--width: 400px;--%>
    <%--border-bottom: 1px solid #ccc;"></div>--%>


        <div style="clear: both; padding-bottom: 20px; position:absolute;bottom:10px;right:30px;">
            <button type="button" class="btn  btn-default"  onclick="salesCommList.closeTaxPoint()" style="width:92px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:12px;width:92px;font-size:12px;" onclick="salesCommList.saveTable(this)">确定</button>
        </div>
    </div>
</div>

<div id="orderWin"
     style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-239px;position:absolute; width: 660px;height:478px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;" id="orderTitWin">生成结算单
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="salesCommList.closeTaxPoint()"><img src="/images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;" id="orderdescWin">通过提成结算单向销售代表发放提成奖金
        </p>
        <span class="customerjc"
              style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
              data-title="客户简称" id="partnerShortname"></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: center;">
            <span style="color: #666;font-size: 14px;font-weight: 700;"> 核算单数(笔)：<em
                    style="vertical-align:middle;font-family:Arial;font-weight: 100;    font-style: normal; font-size: 22px;"
                    id="numIndex"></em></span>

        </div>
<input type="hidden" name="checkingNoCls" id="checkingNoCls">
        <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>
        <div style="      width: 400px; margin: 0 auto; padding: 30px 20px 0; position: relative;">
            <p style="text-align: right;  height: 30px;  color: #666;font-size: 14px;font-weight: 700;"><span
                    style="float:left;">提成总金额：</span>
                <em style="font-weight:100;font-family: Arial; font-style:normal;font-size: 22px;color:#ff0000;"
                    id="depositRequested"></em></p>

        </div>
        <%--<div style="    position: absolute;--%>
    <%--bottom: 70px;--%>
    <%--right: 80px;" class="telSelMesWin  prettyck"><input id="telSelMes" checked type="checkbox" name="ck" value=""><label for="telSelMes" style="vertical-align:middle;font-weight: normal;">给安装供应商发送账单链接短信【手机号：<i class="telNumberShow telColor"></i>】</label></div>--%>

        <div style="clear: both; position:absolute;bottom:25px;right:80px;">
            <button type="button" class="btn " onclick="salesCommList.closeTaxPoint()" style="width:100px;">取消</button>
            <button type="button" class="btn btn-primary" style="width:100px;margin-left:15px;font-size:12px;" onclick="salesCommList.saveTable2(this)"
                    id="orderMake">生成结算单
            </button>
        </div>
    </div>
</div>



<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" data-s="0" class="smcolor order2"><a href="#">待分配</a></li>
        <li style="position:relative;" data-s="1" class="order"><a href="#">已分配</a></li>
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
                <div class="col-xs-2 " style="width:120px;padding:0 5px">
                    <select placeholder="销售代表" class="form-control input-xs" id="saleManDp" >
                    </select>
                </div>
                <%--<div class="col-xs-2" style="width:120px;padding:0 5px">--%>
                    <%--<select class="form-control input-xs" id="dateDat">--%>
                        <%--<option value=""></option>--%>
                    <%--</select>--%>
                <%--</div>--%>
                <div class="col-xs-2 " style="width:150px;padding:0 5px">

                    <div class="">
                        <div class="input-icon-group">
                            <div class="" style="width:120px">
                                <input type="text" style="" class="form-control" id="datetimepickers"
                                       data-format="yyyy-MM-dd" placeholder="收款日期">
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
                                       data-format="yyyy-MM-dd" placeholder="收款日期">
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
                <%--<div class="col-xs-2" style="width: 222px;">--%>

                    <%--<div class="input-group">--%>
                        <%--<input type="text" class="form-control"--%>

                               <%--onkeypress="if(event.keyCode == 13) {reload('');return false;}"--%>
                               <%--id="searchK" placeholder="输入单号、项目名称、业务内容" style="      width: 192px;--%>
    <%--border-radius: 30px;--%>
    <%--color: #b3b3b3;--%>
    <%--font-size: 12px;">--%>

                    <%--</div>--%>
                <%--</div>--%>
                <button type="button" id="searchBtn" class="btn btn-primary "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>

                <button type="button" class="btn btn-primary hide pull-right createInstaller "
                        style="font-size:12px;height:30px">分配
                </button>

                <button type="button" id="createCheckOrder" class="btn btn-primary hide pull-right needInstaller "
                        style="font-size:12px;height:30px">生成结算单
                </button>
                <button type="button" id="modifyOrder" class="btn btn-primary hide pull-right needInstaller "
                        style="font-size:12px;height:30px;margin-right:15px;">修改
                </button>
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
<div style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">
    订单数(笔)：
    <span style="color: red;margin-right: 15px;" id="order2PagerNum">0</span>
    <span id="totalTextSpan">实收总金额(元)：</span>
    <span style="color: red;margin-right: 15px;" id="order2PagerPrice">0.00</span>
    提成总金额(元)：
    <span style="color: red;margin-right: 15px;" id="orderPrice">0.00</span>

</div>

</body>
</html>