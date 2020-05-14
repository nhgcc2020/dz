<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>销售提成结算列表</title>
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
            }        .bigCls{
                         color:#009900;
                     }
            .smallCls{
                color:#ff9200;
            }
        </style>
        <script>

            var pageDefaultSaleConUrl="/ydz/salesorder/getDefaultSalesMan"; //销售代表默认值
            //            var pageUrl = "/ydz/commission/listPageSalesCheckingOrderForCommissions";// 本页面请求url1
            var pageUrl = "/ydz/commission/listCommissionChecking";// 本页面请求url1
            var pageAddUrl = "/ydz/commission/addPayment";// 本页面请求url1
            var pageUpdateUrl = "/ydz/commission/udpatePayment";// 本页面请求url1
//            var pageUrl = "/ydz/commission/allocationCommission";// 本页面请求url1
            var pageCustomerUrl =  "/system/partner/dropdownPartner?partnerType=1";// 本页面客户数据url1
            var pageNeedUrl =  "/order/installation/insertInstallStandingBy";// 本页面需要安装url1
            var pageInstallUrl =  "/order/installation/listInstallStandingBy";// 查询待安装记录
            var pageListSaleConUrl="/ydz/salesorder/listSalesMan"; //销售代表下拉框
            var installPageFun = {
                recpayKeyUp:function (b) {
                    var $this=$(b),$va=   parseFloat($(".receivablesMoneyCls").val());
                    if(isNaN($this.val())){
                        $(".recpayDiscount").addClass("smallCls");
                        $(".recpayDiscount").removeClass("hide").html("非法数字");
//                    Number(totalPrice).toFixed(2);
//                    parseFloat($("input.unitPriceChange")[rindex].value);
                        $("#preferentialText").text(accounting.formatNumber($("#preferentialVal").val(),2));
                        return;
                    }
                    if(isNaN($va)){
                        $.mytoast({text:"应收金额含有非法数字"});
                        return;
                    }
                    var pr=Number($this.val())-Number($(".receivablesMoneyCls").val());

                    if(pr>0){
                        $(".recpayDiscount").removeClass("smallCls");
                        $(".recpayDiscount").addClass("bigCls");
                        $(".recpayDiscount").removeClass("hide").html("+"+accounting.formatNumber(pr,2));
                    }else if(pr==0){
                        $(".recpayDiscount").addClass("hide");
                    }else{
                        $(".recpayDiscount").addClass("smallCls");
                        $(".recpayDiscount").removeClass("bigCls");
                        $(".recpayDiscount").removeClass("hide").html(accounting.formatNumber(pr,2));
                    }
                },

                returnopt:  function (data, type) {
                var opt = "";
                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    var dtn = "";
                    if (type == 1) {
//                    if(dt.partnerShortname==undefined){continue;}
                        dtn = dt.myComShortname == undefined ? "全部客户" : dt.myComShortname;
                        opt += '<option data-p="'+dt.partnerStatus+'" value="' + dt.partnerKey + '">' + dtn + '</option>';
                    }
                    else if (type == 2) {
                        dtn = dt.show;
                        opt += '<option value="' + dt.key + '">' + dtn + '</option>';
                    }else  if (type == 3) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                        opt += '<li><a rel="'+dt.employeeId+'" href="javascript:;">'+dt.realName+'</a></li>';
                    }
                   else if (type == 4) {
//                if(i==0){opt= '<li><a rel="" href="javascript:;">请选择</a></li>'}
                        opt += '<li><a rel="'+dt.id+'" href="javascript:;">'+dt.text+'</a></li>';
                    }

                }
                return opt;
            },
                closeTaxPoint: function () {
                    $(".window-mask").hide();
                    $(".recpayDiscount,.orderCycleCls").text("");
                    $(".checkingNoCls").val("");
                    $("input[name='recpayMoney']").val("");
//            $("input[name='recpayName']").val("");
                    $("#remarks").val("");
                    $("input[name='invoiceNo']").val("");
                    $("input[name='invoiceContent']").val("");
                    $("input[name='recipient']").val("");
                    $("input[name='ceremarks']").val("");
                    $("input[name='cecheckingNo']").val("");
                    $("input[name='invoiceType']").val("");
                    $("input[name='invoiceAmount']").val("")
                    $("#taxPointWin,#orderWin").css({display: 'none'});
                },
                saleManDp:  function (){
                    $.ajax({
                        url:pageListSaleConUrl,
                        dataType:"json",
                        timeout:"8000",
                        success:function(dt){
                            // dt=[];
                            // $("#saleManDp").html( returnopt(data,2));
                            $(".recpayNameList").html(installPageFun.returnopt(dt, 3));
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

                    if(status=="12"){
                        arrclo.push({field: 'recpayDate', width: 100, align: 'center', title: '结算日期'});
                    }

                    arrclo.push({field: '11',  width: 140, align: 'center', title: '结算单号',  formatter: function (value, row) {
//                        var r = row.caseDesc == "" ? "无概要" : row.caseDesc;
                        return '<a data-id=' + row.commissionsCheckingNo + ' data-did=' + row.industryId + ' href=\'##\' onclick=installPageFun.openDt(this)>' + row.commissionsCheckingNo + '</a>';
                    }});
                    arrclo.push({field: 'orderCycle', width: 180, align: 'center', title: '订单周期'});
                    arrclo.push({
                        field: 'partnerShortname', title: '客户', width: 140,align: 'center', formatter: function (value, row) {

                            return '<div>' + row.partnerShortname + '</div>' + '<div class="namebd"><span class="namebdsml">' + row.contactName + '</span></div>';
                        }
                    });
                    arrclo.push({field: 'salesName', width: 100, align: 'center',title: '销售代表'});
                    arrclo.push({field: 'caseDesc', width: 200, title: '结算单概要'});
//                    arrclo.push({field: '77', width: 200, title: '规格'});

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

                    if(status=="12"){
                        arrclo.push({field: 'settlementMoney', width: 100, align: 'right', title: '结算金额(元)', formatter: function (value, row) {
                            return accounting.formatNumber(value, 2);
                        }});
                        arrclo.push({field: 'accountPayee', width: 100, align: 'center', title: '结算账户'});
                        arrclo.push({field: 'balanceMoney', width: 100, align: 'right', title: '差额'});
                        arrclo.push({field: 'balanceRemarks', width: 140, align: 'center', title: '差额说明'});
                    }
                    arrclo.push({field: 'createTime', sortable: true, width: 140, align: 'center', title: '制单时间'});
                    return arrclo;
                },


                onLoadSuccess: function (data) {
                    if (data.rows.length > 0) {
                            $("#order2PagerNum").text(data.bottomInfo.orderCount);
                        $("#order2PagerPrice").text(accounting.formatNumber(data.bottomInfo.sumPaidUp, 2));
                        $("#orderPrice").text(accounting.formatNumber(data.bottomInfo.sumCommissionsMoney, 2));
                        $("#orderPrice2").text(accounting.formatNumber(data.bottomInfo.sumSettlementMoney, 2));
                    } else {
                        $("#order2PagerNum").text("0");
                        $("#order2PagerPrice").text("0.00");
                        $("#orderPrice").text("0.00");
                        $("#orderPrice2").text("0.00");
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
                sureReceivables:function(bt){
                    var url="";
                    var status = $("#navCondition").find(".smcolor").attr("data-s");
                    if(status=="11"){
                        url=pageAddUrl;
                    }else{ url=pageUpdateUrl;}
                    var btn=$(bt);
                    btn.attr("disabled",true);
                    $.ajax({
                        type: "POST",
                        url:url ,
                        data:{
                            "checkingNo":  $(".checkingNoCls").val(),
                            "recpayType":"1",
                            "recpayMoney":$("input[name='recpayMoney']").val(),
                            "recpayDate":new Date($("input[name='recpayDate']").val()),
                            "recpayName":$(".recpayNameShow").text(),
                            "accountPayee":$("input[name='recpayAccount']").val(),
                            "remarks":$("#remarks").val()
                        },
                        dataType: "json",
                        success:function(callback){
                            if(callback.code =="1"){
                                reload();
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(500).fadeOut(250).appendTo('body');
                                installPageFun.closeReceivablesBar();
                                btn.attr("disabled",false);
                            }else{
                                btn.attr("disabled",false);
                                $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(500).fadeOut(250).appendTo('body');
                                installPageFun.closeReceivablesBar();
                            }
                        },
                        error:function(){
                            btn.attr("disabled",false);
                            $("<div class='tips_contants'>").fadeIn(250).html("添加失败").delay(500).fadeOut(250).appendTo('body');
                        }
                    })
                },
                closeReceivablesBar:function () {
                    $(".recpayDiscount,.orderCycleCls").text("");
                    $(".checkingNoCls").val("");
                    $("input[name='recpayMoney']").val("");
                    $("#remarks").val("");
                    $("input[name='invoiceNo']").val("");
                    $("input[name='invoiceContent']").val("");
                    $("input[name='recipient']").val("");
                    $("input[name='ceremarks']").val("");
                    $("input[name='cecheckingNo']").val("");
                    $("input[name='invoiceType']").val("");
                    $("input[name='invoiceAmount']").val("")
                    $("#receivablesBar,#taxPointWin").hide();
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
                    var url = "/ydz/commission/forward-commissionchecking-detail?commissionsCheckingNo=" + $(obj).attr("data-id") ;
                    installPageFun.showMessageDialog(url, "", "84%", "100%", true);
                }
            }   //本页面的交互方法
            $(function () {
                $('#recpayDate').datetimepicker({
                    format: 'yyyy-mm-dd', language: 'zh-CN', autoclose: true,
                    minView: 'month'
                });
                $('#recpayDate').val(new Date().Format("yyyy-MM-dd"));
                $('[data-toggle="popover"]').popover();
                $("#navCondition").on("click", "li", function () {
                    hideMsg();
                    $(this).addClass("smcolor").siblings().removeClass("smcolor");
                    reload();
                })
                $(".createInstaller,#modifyOrder").click(function () {
            var selectItems =     $('#order').datagrid('getChecked');
                    var totalPrice = 0;
                    var flag = false;
                    if(selectItems.length == 0){

                        $.mytoast({text:"请选择一笔需要收款的对账单"});

                        return false;
                    }
                    if(selectItems.length > 1){
                        $.mytoast({text:"不可同时收款多笔对账单"});

                        return false;
                    }

                    var selectObj = selectItems[0];
                    var status = $("#navCondition").find(".smcolor").attr("data-s");
                    if(status=="12"){
                        $(".sureReceivables").text("修改结算记录");
                        $("input[name='recpayMoney']").val(selectObj.settlementMoney);
                        $("input[name='recpayDate']").val(selectObj.recpayDate);
                        $(".recpayNameShow").text(selectObj.recpayName);
                        $(".recpayAccountShow").text(selectObj.accountPayee);
                        $("input[name='recpayAccount']").val(selectObj.accountPayee);
                        $("#remarks").val(selectObj.balanceRemarks);

                        var pr=Number(selectObj.balanceMoney);
                        if(pr>0){
                            $(".recpayDiscount").removeClass("smallCls");
                            $(".recpayDiscount").addClass("bigCls");
                            $(".recpayDiscount").removeClass("hide").html("+"+accounting.formatNumber(pr,2));
                        }else if(pr==0){
                            $(".recpayDiscount").addClass("hide");
                        }else{
                            $(".recpayDiscount").addClass("smallCls");
                            $(".recpayDiscount").removeClass("bigCls");
                            $(".recpayDiscount").removeClass("hide").html(accounting.formatNumber(pr,2));
                        }
                    }else{
                        $(".sureReceivables").text("添加结算记录");
                        $("input[name='recpayMoney']").val("");
                        $("input[name='recpayDate']").val(new Date().Format("yyyy-MM-dd"));
                        $("#remarks").val("");
                        $(".recpayDiscount").addClass("hide");

                    }


                        $(".partnerShortnameCls").text(selectObj.salesName);
//                        $(".contactNameCls").text(selectObj.contactName);
                        $(".detailNumCls").text(selectObj.orderNum);

                        $(".receivablesMoneyCls").val(selectObj.commissionsMoney);
                        $(".checkingNoCls").val(selectObj.commissionsCheckingNo);
                        $(".orderCycleCls").text(selectObj.orderCycle);

                        $(".totalPriceCls").text(accounting.formatNumber(selectObj.paidUp,2));
                        $(".receivablesMoneyShow").text(accounting.formatNumber(selectObj.commissionsMoney,2));
                        $(".depositRequestedCls").text("- "+accounting.formatNumber(selectObj.depositRequested,2));
                    console.log(selectObj);
                    $("#taxPointWin").css({display:'block'});
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
//                $("#dateDat").html(installPageFun.returnopt(orderUtil.dateConfig, 2)).change(function () {
//                    var code = $(this).val().substring(0, 2);
//                    var num = $(this).val().substring(2, $(this).val().length);
//                    var dt = orderUtil.dpDateCompute(code, num);
//                    $("#datetimepickers").val(dt.beforeDate);
//                    $("#datetimepickere").val(dt.nowDate);
//                });
                $("#dateDat").select2({
                    minimumResultsForSearch: Infinity
                });
                installPageFun.saleManDp();
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


                $(".recpayAccountList").html(installPageFun.returnopt(globeConfigData.recpayAccountList, 4));
            });//本页面加载完成初始化数据
            // 公共方法
            function reload() {
                var status = $("#navCondition").find(".smcolor").attr("data-s");
                var arrclo = [], url = "", pageSize = 30, pageList = [30, 40];
                var arrclo = installPageFun.arrFunDetail();
//                if(status==""){
//                    url=pageInstallUrl;
//                }else{
                url = pageUrl;
//                }
                pageSize = 30;
                pageList = [30, 40];
                if (status == "11") {
                    $(".createInstaller").removeClass("hide");
                    $(".needInstaller").addClass("hide");
                }else{
                    $(".createInstaller").addClass("hide");
                    $(".needInstaller").removeClass("hide");
                }
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
    <style>
        .ydz_select{display: inline-block;
            font-size: 0;
            position: relative;
            vertical-align: middle;
            white-space: nowrap;}
        .ydz_select_txt{background: none repeat scroll 0 0 #FFF;
            border: 1px solid #f2f2f2;
            cursor: pointer;
            display: inline-block;
            font-size: 12px;
            line-height: 34px!important;
            height: 34px!important;
            overflow: hidden;
            text-align: left;
            border-radius: 3px;
            padding: 0 5px 0 10px;
            text-overflow: ellipsis;
            vertical-align: top;
            white-space: nowrap;
            width: 120px;}
        .ydz_select_a {    width: 0;
            height: 0;
            border-left: 5px solid transparent;
            border-right: 5px solid transparent;
            border-top: 5px solid #786f6f;
            position: absolute;
            right: 5px;
            top: 15px;}
        .ydz_select_menu{    background: none repeat scroll 0 0 #FFF;
            /*border: 1px solid #f2f2f2;*/
            border-top: none;
            border-radius: 2px;
            padding: 4px 0;
            display:none;
            border: 1px solid #e0dfdf;
            box-shadow: 0 6px 12px rgba(0,0,0,0.175);
            float: left;
            left: 0;
            overflow-x: hidden;
            overflow-y: auto;
            position: absolute;
            top: 100%;
            width: 120px;
            z-index: 1000;}

        .ydz_select_menu li{line-height:21px;padding-bottom:0!important}
        .open .ydz_select_menu{display:block}
        .open .ydz_select_a{
            border-bottom: 5px solid #786f6f;
            border-top: transparent;
        }
        .ydz_select_menu li a{clear:both;text-align:left;color:#323232;display:block;font-size:12px;line-height:21px;padding:3px 5px;white-space:nowrap}
        .ydz_select_menu li a:hover{background:none repeat scroll 0 0 #5897fb;color:#FFF;text-decoration:none}

    </style>
    <script>
        $(function(){
            $("body").bind('click', function () {
                $(".ydz_select").removeClass("open");
            });
            $(".ydz_select").on("click",function(e){
                e.stopPropagation();
                if($(this).hasClass("open")){
                    $(this).removeClass("open");
                } else{
                    $(".ydz_select").removeClass("open");
                    $(this).addClass("open");
                }
            })   ;
            $(".ydz_select_menu").on("click","li",function(){
                $(this).closest(".ydz_select").find("input[type='hidden']").val($(this).find("a").attr("rel"));
                $(this).closest(".ydz_select").find("span").text($(this).find("a").text());

            })
        })
    </script>
    </head>
<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>

<div id="taxPointWin" style="/* padding-top: 5px; */top: 50%;left: 50%;margin-left: -420px;margin-top: -320px;position: absolute;width: 760px;height: 640px;display: none;">
    <span style="position: absolute;top: 12px;left:20px;display: block;font-size: 16px;height:30px;color:#333;">绩效结算</span>
    <p style="position:relative;font-weight: 100;text-align: center;height: 50px;font-size: 14px;color: #999;margin: 0px auto;padding: 10px 20px;border-bottom: 1px solid #e4e4e4;line-height: 30px;" id="orderTitWin"><label style="
    font-weight: normal;
">订单周期：</label>&nbsp;
        <span class="orderCycleCls"></span>
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="installPageFun.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="width: 560px;margin: 0 auto;position: relative">
        <%--<div style="position: absolute;right: 0px;top:55px;font-size: 12px;color:#ff5505;" class="hide" id="invoiceAlready" did="已开票">已开票</div>--%>
        <div style="display: inline-block;vertical-align: middle;width: 184px;">
            <img class="comImgTran" style="margin: 38px auto 38px;float:left;width: 50px;height: 50px;border-radius: 40px;border:1px solid #ccc;padding:3px;" src="/images/share.png"><em class="partnerShortnameCls" style="margin-top: 45px;margin-left: 10px;display: inline-block;width: 110px;overflow: hidden;font-weight: 700;text-overflow: ellipsis;height: 20px;word-wrap: break-word;font-size: 14px;"></em><br><span class="contactNameCls" style="
    margin-left: 10px;
    color: #999;
"></span>
        </div>

        <div style="display: inline-block;width: 184px;text-align: center;">
            <label style="
    font-weight: normal;
    color: #999;
    font-size: 14px;
">订单笔数：</label>&nbsp;<span class="detailNumCls" style="
    font-size: 20px;
    width: 80px;
    display: inline-block;
    vertical-align: middle;
    overflow: hidden;
    text-align: left;
    margin-top:-5px;
"></span>
        </div>

        <div style="display: inline-block;width: 184px;">
            <label style="
    font-weight: normal;
    color: #999;
    font-size: 14px;
">订单金额：</label>&nbsp;<span class="totalPriceCls" style="
    font-size: 20px;
    width: 100px;
    display: inline-block;
    text-align: left;
    vertical-align: middle;
    overflow: hidden;
    margin-top:-5px;
"></span>
        </div>
        <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

        <div style="margin:24px auto;width: 270px;">
            <p style="text-align: right;clear: both;height: 40px;line-height: 40px;">
                <label style="float: left;font-weight: normal;color: #999;font-size: 14px;">应付金额：</label>
                <span class="receivablesMoneyShow" style="
    color: #ff5505;
    font-size: 20px;
"></span>
                <input type="hidden" class="receivablesMoneyCls" >
                <input type="hidden" class="checkingNoCls" >
            </p>
        </div>

        <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

        <div style="width:552px;margin:35px auto;">
            <div style="width:215px;display: inline-block;position:relative;margin-right: 117px;text-align: right;margin-bottom: 20px;height: 34px;line-height: 34px;"><label style="float: left;font-size: 14px;color: #333;font-weight: normal;">实付金额：</label>
                <input placeholder="0.00" type="number" name="recpayMoney" data-s='select' onkeyup="installPageFun.recpayKeyUp(this)" style="width:120px;    text-align: right;line-height: 18px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;" placeholder="0.00">
                <span class="recpayDiscount bigCls hide" style="position: absolute;top:30px;right:0;font-size: 12px;"></span>
            </div>

            <div style="width: 215px;display: inline-block;text-align: right;height: 34px;line-height: 34px;margin-bottom: 22px;">

                <label style="float: left;float: left;font-size: 14px;color: #333;width: 70px;font-weight: normal;">结算人：</label>
                <%--<input type="text" style="padding: 5px;width: 120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">--%>
                <div class="ydz_select ">
                    <div class="">
                        <span class="ydz_select_txt recpayNameShow"></span>
                        <input type="hidden" value="" name="recpayName">
                        <a class="ydz_select_a" href="javascript:;"></a>
                    </div>
                    <ul class="ydz_select_menu recpayNameList">
                    </ul>
                </div>

            </div>
            <div style="width:215px;display: inline-block;text-align: right;height: 34px;margin-right: 117px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */"> <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">结算账户：</label>
                <%--<input type="text" style="padding: 5px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">--%>
                <div class="ydz_select ">
                    <div class="">
                        <span  class="ydz_select_txt recpayAccountShow">选择结算账户</span>
                        <input type="hidden" value="" name="recpayAccount">
                        <a class="ydz_select_a" href="javascript:;"></a>
                    </div>
                    <ul class="ydz_select_menu recpayAccountList">

                    </ul>
                </div>

            </div>
            <div style="width: 215px;display: inline-block;height: 34px;position:relative;line-height: 34px;margin-bottom: 22px;text-align: right;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">结算日期：</label>
                <input id="recpayDate" name="recpayDate" type="text" style="padding: 5px 5px 5px 10px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                <span onclick="$('#recpayDate').datetimepicker('show');" class="" style="
    position: absolute;
    right: 10px;
"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
            </div>
            <div style="text-align: right;height: 34px;line-height: 34px;">
                <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">附加说明：</label>
                <textarea rows="2" id="remarks" name="remarks" style="resize: none;padding: 5px;border: 1px solid #f2f2f2;border-radius: 3px;width: 455px;height:68px;"></textarea>
            </div>
        </div>




    </div>
    <div style="clear: both;position:absolute;bottom:30px;right: 105px;">
        <button type="button" class="btn " onclick="installPageFun.closeTaxPoint(this)" style="width:100px;">取消</button>
        <button type="button" class="btn btn-primary sureReceivables" style="margin-left:15px;width:100px;font-size:12px;" onclick="installPageFun.sureReceivables(this)" id="orderMake">添加结算记录
        </button>
    </div>
</div>

<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" data-s="11" class="smcolor order2"><a href="#">待结算</a></li>
        <li style="position:relative;" data-s="12" class="order"><a href="#">已结算</a></li>
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
                                       data-format="yyyy-MM-dd" placeholder="结算日期">
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
                                       data-format="yyyy-MM-dd" placeholder="结算日期">
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
                        style="font-size:12px;height:30px">添加结算
                </button>

                <button type="button" id="modifyOrder" class="btn btn-primary hide pull-right needInstaller "
                        style="font-size:12px;height:30px;margin-right:15px;">修改
                </button>


                <%--<div  style="     color: #ff9900;--%>
                <%--float: right;--%>
                <%--margin-right: 20px;" id="caozuoTip" data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom"--%>
                <%--data-html="true" data-content="将需要一起安装的业务明细批量勾选，创建为一笔安装工单" data-original-title="" title="">--%>
                <%--注意事项<span class="iconfont_new"--%>
                <%--style="position: relative;top:-1px;vertical-align: middle;font-size: 20px"></span></div>--%>
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
    结算总金额(元)：
    <span style="color: red;margin-right: 15px;" id="orderPrice2">0.00</span>

</div>

</body>
</html>