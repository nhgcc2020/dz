<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <%--对账单--%>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css" href="/resources/easyui/themes/bootstrap/easyui.css?v=21f908a530">
    <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/easyui/jquery.easyui.min.js?v=0e0e0cc31b"></script>
        <script src="/resources/business/base_new.js?v=191ae2bcdf"></script>
    <script type="text/javascript" src="/resources/bootstrap/js/bootstrap.min.js?v=9e25e8e29e"></script>
    <script type="text/javascript" src="/resources/bootstrap/bootstrap-datetimepicker.js?v=ca317bd7f1"
            charset="UTF-8"></script>
    <script type="text/javascript" src="/resources/bootstrap/locales/bootstrap-datetimepicker.zh-CN.js?v=1c1e7187f0" charset="UTF-8"></script>
    <script type="text/javascript" src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4" charset="UTF-8"></script>
    <style>
        .ui.input.drop > .value-content {
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

        #order .table-wrapper > table thead th:nth-child(11),
        #order .table-wrapper > table thead th:nth-child(1),
        #order .table-wrapper > table thead th:nth-child(12),
        #order .table-wrapper > table thead th:nth-child(2) {
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

        .datagrid-header,
        .datagrid-td-rownumber {
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

        .btn.smcolor {
            background-color: #2e8ae6;
            border-color: #2e8ae6;
            color: #fff;
        }

        .datagrid-header .datagrid-cell {
            text-align: center !important;
        }

        .tips_contants {
            position: fixed;
            top: 50%;
            left: 47%;
            z-index: 99999;
            display: none;
            margin-top: -150px;
            margin-left: -150px;
            width: 400px;
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
            padding: 10px 5px 10px 5px;
        }

        .form-control {
            display: block;
            width: 100%;
            height: 30px;
            padding: 6px 10px 6px 12px;
            font-size: 14px;
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

        .payment,
        .scan {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            height: 624px;
            width: 660px;
            background: #fbfbfb;
            z-index: 9999;
            margin-left: -330px;
            margin-top: -320px;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        .online,
        .downline {
            background: #fff;
            height: 140px;
            width: 360px;
            margin: 100px auto 90px;
            text-align: center;
            cursor: pointer;
        }

        .downline {
            margin: 0 auto;
        }

        .online:hover .online_one,
        .downline:hover .online_one {
            display: none;
        }

        .online:hover .onhover,
        .downline:hover .onhover {
            display: block;
        }

        .online_one > p {
            margin-top: 20px;
            height: 80px;
            line-height: 80px;
            text-align: center;
            font-size: 20px;
            color: #000;
        }

        .onhover,
        .online_one {
            height: 100%;
            width: 100%;
        }

        .onhover {
            display: none;
            box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
            border-radius: 5px;
        }

        .onhover > p {
            height: 100px;
            line-height: 100px;
            text-align: center;
            font-size: 20px;
            color: #00ae41;
        }

        .particulars li {
            font-size: 14px;
            line-height: 50px;
            color: #000;
        }

        .particulars li span:last-child {
            float: right;
            color: #999;
        }

        .scan_one {
            text-align: center;
            margin-top: 150px;
        }

        .scan_one button {
            border: none;
            background: #00ae41;
            line-height: 30px;
            width: 120px;
            text-align: center;
            border-radius: 5px;
            color: #fff;
        }

        .paymentscan {
            display: none;
        }
    </style>
    <script>
        var pageUrl = "/ydz/purchasechecking/listPageTotalPurchaseCheckingOrder";// 本页面请求url
        var pageVendorUrl = "/system/partner/dropdownPartner?partnerType=2";// 本页面供应商请求url
        var pageBillReqUrl = "/ydz/purchasechecking/payPurchaseOrder";// 本页面付款请求地址
        var pagePayReqUrl = "/ydz/purchaseorder/listPurchaseMen";// 本页面付款人请求地址
        var pageDetailReqUrl = "/ydz/purchasechecking/detail?purchasecheckingNo=";// 本页面打开详情
        function GetRequest() {
            var url = location.search; //获取url中"?"符后的字串
            var theRequest = new Object();
            if (url.indexOf("?") != -1) {
                var str = url.substr(1);
                strs = str.split("&");
                for (var i = 0; i < strs.length; i++) {
                    theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1]);
                }
            }
            return theRequest;
        }
        function cgx(o, num) {
            $(o).addClass("smcolor").siblings().removeClass("smcolor");
            var status = $(o).attr("data-s");
            reload(status);
        }
        function reload(status) {
            //        var url='test.json';
            var url = pageUrl;
            var arrclo = [];

            arrclo.push({field: 'ck', checkbox: true});
            arrclo.push({
                field: 'purchasecheckingNo',
                title: '对账单号',
                width: 190,
                align: 'center',
                formatter: function (value, row) {
                    return '<a data-id=' + row.purchasecheckingNo + ' data-did=' + row.industryId + ' href=\'##\' onclick=openDt(this)>' + row.purchasecheckingNo + '<span style="margin-left:26px;">详情</span></a>';
                }
            });
            arrclo.push({field: 'createTime', title: '制单时间', width: 130});
            arrclo.push({field: 'orderCycle', title: '订单周期', width: 170, align: "center"});
            arrclo.push({field: 'partnerShortname', width: 200, align: 'left', title: '供应商'});
            arrclo.push({field: 'contactName', width: 100, title: '联系人'});
            arrclo.push({field: 'caseDesc', width: 200, title: '项目名称'});
            arrclo.push({field: 'orderCountValue', width: 100, title: '订单(明细)'});
            arrclo.push({
                field: 'price', width: 100, align: 'right', formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '订单总金额'
            });
            arrclo.push({
                field: 'taxPrice', width: 100, align: 'right', formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '税款'
            });
            arrclo.push({
                field: 'totalPrice', width: 100, align: 'right', formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '对账总金额'
            });
            arrclo.push({
                field: 'depositRequested', width: 100, align: 'right', formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '预付总金额'
            });
            arrclo.push({
                field: 'receivablesMoney', width: 100, align: 'right', formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '应付总金额'
            });
            arrclo.push({
                field: 'paidUp', width: 100, align: 'right', formatter: function (value, row) {
                    return accounting.formatNumber(value, 2);
                }, title: '实付总金额'
            });
            arrclo.push({field: 'recpayDate', width: 100, align: 'center', title: '付款日期'});
            arrclo.push({field: 'recpayName', width: 80, align: 'center', title: '付款人'});
            arrclo.push({field: 'invoiceAmount', width: 100, align: 'center', title: '开票金额'});
            arrclo.push({field: 'invoiceDate', width: 100, align: 'center', title: '开票日期'});
            arrclo.push({field: 'orderStatusDesc', width: 80, align: 'center', title: '状态'});

            if (status == "") {
                $(".modifyOrder,.generatorBill").addClass("hide");
                $('#order').datagrid({
                    url: pageUrl,
                    pagination: true,
                    columns: [arrclo],
                    queryParams: {
                        "partnerKey": $('#customerDat').val(),
                        "endTime": $('#datetimepickere').val(),
                        "searchKey": $('#searchK').val(),
                        "startTime": $('#datetimepickers').val()
                    }
                });
            } else {
                if (status == "09") {
                    $(".modifyOrder,.generatorBill").removeClass("hide");
                } else {
                    $(".modifyOrder,.generatorBill").addClass("hide");
                }
                $('#order').datagrid({
                    url: pageUrl,
                    pagination: true,
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
        function openDt(obj) {
            var url = pageDetailReqUrl + $(obj).attr("data-id") + "&industryId=" + $(obj).attr("data-did");
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
        function onLoadSuccess(data) {
            var heji = '<span class="total_all">合计:</span>';
            var sum = '对账总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice">0.00</span>';
            var sumRecev = '应付总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice2">0.00</span>';
            var sumPaidUp = '实付总金额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice3">0.00</span>';
            var chaMon = '差额(元)：<span style="color: red;margin-right: 15px;" id="orderPrice4">0.00</span>';
            var odcount = '对账单数(笔)：<span style="color: red;margin-right: 15px;" id="order2PagerNum">0</span>';
            var status = $("#btnGrpOp").find(".btn.smcolor").attr("data-s");
            if (status == "09") {
                $("#pageToolbar").html(heji + sum + sumRecev + odcount);
            } else {
                $("#pageToolbar").html(heji + sum + sumRecev + sumPaidUp + chaMon + odcount);
            }


            if (data.rows.length > 0) {
                $("#order2PagerNum").text(data.bottomInfo.orderCount);
                var sumr = data.bottomInfo.sumReceivablesMoney;
                var sumPair = data.bottomInfo.sumPaidUp;
                var char = Number(sumPair) - Number(sumr);

                $("#orderPrice").text(accounting.formatNumber(data.bottomInfo.sumTotalPrice, 2));
                $("#orderPrice2").text(accounting.formatNumber(data.bottomInfo.sumReceivablesMoney, 2));
                $("#orderPrice3").text(accounting.formatNumber(data.bottomInfo.sumPaidUp, 2));
                $("#orderPrice4").text(accounting.formatNumber(char, 2));


            } else {
                $("#order2PagerNum").text(0);
                $("#orderPrice").text("0.00");
                $("#orderPrice2").text("0.00");
                $("#orderPrice3").text("0.00");
                $("#orderPrice4").text("0.00");
                $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
            }
        }

        function payPerson() {
            $.ajax({
                type: "get",
                url: pagePayReqUrl,
                dataType: "json",
                success: function (callback) {
                    var op = "";
                    for (var i = 0; i < callback.length; i++) {
                        op += "<option value='" + callback[i].employeeId + "'>" + callback[i].realName + "</option>"
                    }
                    $("#payOrderPerson").html(op);
                }
            })
        }


        function openpayment() {

            var order4ItemsArr = $('#order').datagrid('getChecked');
            if (order4ItemsArr.length > 1) {
                $("<div class='tips_contants'>").fadeIn(250).html("不可同时付款多笔对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            var purchaseNos = new Array();
            $.each(order4ItemsArr, function (index, element) {
                purchaseNos.push(element.purchaseNo);
            });
            if (purchaseNos.length == 0) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择一笔需要付款的对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            $(".window-mask").show();
            $(".payment").show();
        }
        function closepage(type) {
            if (type == 1) {
                $(".payment").hide();
                $(".window-mask").hide();
            }
            if (type == 2) {
                $(".scan").hide();
                $(".payment").show();
                $(".particulars").show();
                $(".paymentscan").hide();
            }
        }
        function openscan() {
            var order4ItemsArr = $('#order').datagrid('getChecked');
            if (order4ItemsArr[0].salescheckingNo == "") {
                $("<div class='tips_contants'>").fadeIn(250).html("该生意伙伴非系统用户，无法在线支付").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            $(".scan").show();
            $(".message").eq(0).text(order4ItemsArr[0].partnerShortname);
            $(".message").eq(1).text("￥" + accounting.formatNumber(order4ItemsArr[0].totalPrice, 2));
            $(".message").eq(2).text("￥" + accounting.formatNumber(order4ItemsArr[0].depositRequested, 2));
            $(".message").eq(3).text("￥" + accounting.formatNumber(order4ItemsArr[0].receivablesMoney, 2));
        }
        function immediately() {
            var order4ItemsArr = $('#order').datagrid('getChecked');
            $(".particulars").hide();
            $(".paymentscan").show();
            $.ajax({
                type: "POST",
                url: "/wechat/pay/paykey",
                data: {"salescheckingNo": order4ItemsArr[0].salescheckingNo},
                dataType: "json",
                success: function (dat) {
                    if (dat.code == 1) {
                        $.ajax({
                            type: "GET",
                            url: "/wechat/pay/doPay?key=" + dat.paykey,
                            dataType: "json",
                            success: function (dt) {
                                if (dt.status == "1") {
                                    $('.qrCodeDataMid').empty();
                                    $('.qrCodeDataMid').qrcode({width: 140, height: 140, text: dt.url});
                                    var polling = setInterval(function () {
                                        $.ajax({
                                            type: "GET",
                                            url: "/wechat/pay/polling?tradeNo=" + dat.tradeNo,
                                            dataType: "json",
                                            success: function (dt) {
                                                if (dt.code == 1) {
                                                    clearInterval(polling)
                                                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(3000).fadeOut(250).appendTo('body');
                                                    setTimeout(function () {
                                                        location.reload();
                                                    }, 3000);
                                                }
                                            }
                                        })
                                    }, 5000)

                                } else {
                                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(3000).fadeOut(250).appendTo('body');
                                }
                            }
                        })
                    } else {
                        $("<div class='tips_contants'>").fadeIn(250).html(dat.msg).delay(3000).fadeOut(250).appendTo('body');
                    }

                }
            })
        }
        function openTaxPoint() {
            payPerson();

            var partnetKey, partnerShortname;
            var order4ItemsArr = $('#order').datagrid('getChecked');
            var order4Items = [];
            var checkRow = "";
            for (var i = 0; i < order4ItemsArr.length; i++) {
                if (i == 0) {
                    checkRow = order4ItemsArr[i].purchaseNo;
                    partnerShortname = order4ItemsArr[i].partnerShortname;
                    order4Items.push(order4ItemsArr[i]);
                } else {
                    if (order4ItemsArr[i].purchaseNo == checkRow) {
                        continue;
                    } else {
                        checkRow = order4ItemsArr[i].purchaseNo;
                        order4Items.push(order4ItemsArr[i]);
                    }
                }
            }

            var flag = false;
            var numIndex = 0, partnerIndex = 0;
            if (order4ItemsArr.length > 1) {
                $("<div class='tips_contants'>").fadeIn(250).html("不可同时付款多笔对账单").delay(3000).fadeOut(250).appendTo('body');
                return false;
            }
            $.each(order4Items, function (index, element) {
                if (element.salescheckingNo != "") {
                    $("<div class='tips_contants'  style='line-height: 40px'>").fadeIn(250).html("此单为协同对账单，</br>你可以使用微信在线支付 或者线下转账给销售方，由对方进行收款操作").delay(3000).fadeOut(250).appendTo('body');
                    flag = true;
                    return false;
                }
            });
            if (flag) {
                return false;
            }

            var totalPrice = 0, depositRequested = 0, receivablesMoney = 0, paidUp = 0, purchaseOrderNum = 0, receivePrice = 0;
            var purchaseNos = new Array();
            $.each(order4Items, function (index, element) {
                purchaseNos.push(element.purchaseNo);
                totalPrice = totalPrice + element.totalPrice;
                receivablesMoney = receivablesMoney + element.receivablesMoney;
                depositRequested = depositRequested + element.depositRequested;
                purchaseOrderNum = purchaseOrderNum + element.purchaseOrderNum;
            });
            if (purchaseNos.length == 0) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择一笔需要付款的对账单").delay(3000).fadeOut(250).appendTo('body');
            } else {
                $("#depositRequestedHid").val(depositRequested);
                $("#totalPriceHid").val(totalPrice);
                totalPrice = accounting.formatNumber(totalPrice, 2);
                depositRequested = accounting.formatNumber(depositRequested, 2);
                receivePrice = accounting.formatNumber(receivablesMoney, 2);
                $("#receivePriceHid").val(receivePrice);
                $("#totalPrice").text(totalPrice);//销售价格
                $("#numIndex").text(purchaseOrderNum);//订单笔数
                $("#partnerShortname").text(partnerShortname);//供应商简称
                $("#depositRequested").text(depositRequested);//预付金额

                //需要变换的值
                $("#taxRateView").val(0);//税率赋值0
                $("#totalPriceWithTax").text(totalPrice);//默认价格
                $("#taxPrice").text(0.00);//默认税额
                $("#receivePrice").text(receivePrice);//应付金额
                $("#paidUp").val(accounting.formatNumber(receivablesMoney, 2,""));//应付金额
                $(".payment").hide();
                $("#taxPointWin").css({display: 'block'});
            }
        }
        function inputCalMoney(o) {
            if (isNaN($(o).val())) {
                $("#taxRateView").val(0);//税率赋值0
                $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
                $("#taxPrice").text(0.00);//默认税额
                $("#receivePrice").text($("#receivePriceHid").val());//应付金额

                $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
                $("#taxPriceHid").val(0);

                return;
            }
            //        $("#totalPriceWithTaxHid").val(Number($("#totalPriceHid").val())*(1+Number($("#taxRateView").val())/100));
            //        $("#taxPriceHid").val((Number($("#taxRateView").val())*Number($("#totalPriceHid").val())).toFixed(2));

            $("#taxPrice").text(accounting.formatNumber((Number($("#taxRateView").val()) * Number($("#totalPriceHid").val())).toFixed(0) / 100, 2));
            $("#totalPriceWithTax").text(accounting.formatNumber(Number($("#totalPriceHid").val()) * (1 + Number($("#taxRateView").val()) / 100), 2));
            $("#receivePrice").text(accounting.formatNumber((Number($("#totalPriceHid").val()) * (1 + Number($("#taxRateView").val()) / 100)) - Number($("#depositRequestedHid").val()), 2));
        }
        function closeTaxPoint(type) {
            if (type == 1) {
                $("#taxPointWin").css({display: 'none'});
                $(".window-mask").hide();
            } else {
                $(".payment").show();
                $("#taxPointWin").css({display: 'none'});
            }
            $("#taxRateView").val(0);//税率赋值0
            $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
            $("#taxPrice").text(0.00);//默认税额

            //         $("#totalPriceWithTaxHid").val($("#receivePriceHid").val());
            //         $("#taxPriceHid").val(0);
            $(".generatorBill").attr("disabled", false);
            $("#receivePrice").text($("#receivePriceHid").val());//应付金额
            $("#shuiDianCtrl").slideUp();
            $("#shuidainBtn").text("添加税点")
        }
        function batchGenerateBill(btn) {
            $(btn).attr("disabled", true);
            var order4ItemsArr = $('#order').datagrid('getChecked');
            var order4Items = [];
            var checkRow = "";

            var purchaseNos = new Array();
            var partnetKey;
            var flag = false;
            var parse = {};
            parse.checkingNo = order4ItemsArr[0].purchasecheckingNo;
            parse.recpayMoney = $("#paidUp").val();
            parse.recpayDate = new Date($("#payDate").val());
            parse.recpayName = $("#payOrderPerson option:selected").text();
            $.ajax({
                type: "POST",
                url: pageBillReqUrl,
                data: jQuery.param(parse),
                async: "false",
                dataType: "json",
                success: function (callback) {
                    closeTaxPoint(1);
                    $(btn).attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("付款成功").delay(3000).fadeOut(250).appendTo('body');
                    setTimeout(function () {
                        $("#order").datagrid('reload');
                    }, 2500);
                },
                error: function () {
                    $(btn).attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("付款失败").delay(3000).fadeOut(250).appendTo('body');
                }
            })
        }
    </script>
</head>

<body class="easyui-layout" style="border:none !important;">
<div id="msgwindow" style="border:none;"></div>
<%--遮罩--%>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>
<div id="CashSale"
     style="width: 660px;height: 340px;box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2); background: #fff; position: absolute;z-index: 9999;top:50%;left:50%;margin-left:-330px;margin-top:-170px;display: none;">
    <div style="font-size: 18px;color: #333;line-height: 50px; border-bottom: 1px solid #ccc; padding-left: 15px;">
        对账单金额注释
    </div>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeFormua()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeFormua()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="margin: 20px auto 40px;"><img src="../../images/formula_2.png" alt="采购方对账单注释"></div>
    <div style="text-align: center;border:1px solid #ccc; border-radius: 3px;font-size: 12px;color: #ccc; height: 30px; width: 120px;line-height: 30px;margin: 0 auto;cursor: pointer; "
         onclick="closeFormua()">我知道了
    </div>
</div>
<div data-options="region:'north'" style="border:none !important;padding:10px;margin-right: 10px;overflow: hidden;">
    <div id="CashFormula" style="    cursor: pointer;
    color: rgb(66, 132, 217);
    font-size: 12px;
    top: 23px;
    left: 300px;
    position: absolute;
    display: block;" onclick="showFormua()">查看金额公式>>
    </div>
    <div>

        <div class="btn-group" id="btnGrpOp">
            <button type="button" data-s="09" onclick="cgx(this,'4');" class="order2 btn btn-default smcolor">待付款对账单
            </button>
            <button type="button" data-s="10" onclick="cgx(this,'5');" class="order3 btn btn-default ">已付款对账单</button>
            <button type="button" data-s="" onclick="cgx(this,'');" class="order btn btn-default ">全部对账单</button>

        </div>
        <div class="h10"></div>
        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:150px;padding:0 5px 0 0">
                    <select class="form-control input-xs" id="customerDat">
                    </select>
                </div>
                <div class="col-xs-2" style="width:150px;padding:0 5px">
                    <select class="form-control input-xs" id="dateDat">
                        <option value=""></option>
                    </select>
                </div>
                <div class="col-xs-2 " style="width:160px;padding:0 5px">

                    <div class="input-group">
                        <div class="input-icon-group">
                            <div class="input-group" style="width:100%">
                                <input type="text" class="form-control" id="datetimepickers" data-format="yyyy-MM-dd"
                                       placeholder="">
                                <%--<span class="glyphicon glyphicon-calendar "></span>--%>
                                <span onclick="$('#datetimepickers').datetimepicker('show');" class="input-group-addon"><i
                                        class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2 " style="width:160px;padding:0 5px">

                    <div class="input-group">
                        <div class="input-icon-group">
                            <div class="input-group" style="width:100%">
                                <input type="text" class="form-control" id="datetimepickere" data-format="yyyy-MM-dd"
                                       placeholder="">
                                <span onclick="$('#datetimepickere').datetimepicker('show');" class="input-group-addon"><i
                                        class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>
                                </input>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-2">
                    <div class="input-group">
                        <input type="text" class="form-control" id="searchK" placeholder="搜订单号/项目名称/业务内容..."
                               style="width:212px;">
                        <span class="input-group-btn">
						<button class="btn btn-primary" id="searchBtn" type="button"
                                style="height:30px; line-height:1;">
							搜索
						</button>
					</span>
                    </div>
                </div>
                <button type="button" id="" class="btn btn-primary pull-right generatorBill hide"
                        style="height:30px;line-height:1;" onclick="openpayment()">付款
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    $(function () {
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
        $('#payDate').datetimepicker({
            format: 'yyyy-mm-dd', language: 'zh-CN', pickerPosition: 'top-right', autoclose: true,
            minView: 'month'
        })
        $("#payDate").val(new Date().Format("yyyy-MM-dd"));
        $.ajax({
            url: pageVendorUrl,
            dataType: "json",
            type: "post",
            success: function (data) {
                $("#customerDat").html(returnopt(data, 1));
                $("#customerDat").select2({
                    //                        maximumInputLength:2,
                    templateResult: formatState
                });
                var showNum = "order2";
                var type = GetRequest().type;
                if (type != "" && type != undefined) {
                    showNum = type;
                }
                $("#btnGrpOp").find("." + showNum).addClass("smcolor").siblings().removeClass("smcolor");

                var status = $("#btnGrpOp").find("." + showNum).attr("data-s");
                reload(status);
            },
            error: function () {
            }
        });


        //全部订单搜索
        $("#searchBtn").click(function () {
            var status = $("#btnGrpOp").find(".btn.smcolor").attr("data-s");
            reload(status);

        })


    });
    function returnopt(data, type) {
        var opt = "";
        for (var i = 0; i < data.length; i++) {
            var dt = data[i];
            var dtn = "";
            if (type == 1) {
                //                    if(dt.partnerShortname==undefined){continue;}
                dtn = dt.myComShortname == undefined ? "全部供应商" : dt.myComShortname;
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
            //                '<span style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;width:90px;display: block;">'+state.text + '</span><i style="position:absolute;right:0;top:5px;">sfsd</i>'
            //                '<span><img src="/' + state.element.value.toLowerCase() + '.png" class="img-flag" /> ' + state.text + '</span>'
        );
        return $state;
    }

</script>

<div data-options="region:'center'" style="border:none !important;padding:10px;width: 100%;">
    <table id="order" style="width: 100%;" class="easyui-datagrid order" data-options="remoteSort:false,
           nowrap:true,singleSelect:false,checkOnSelect:false,onLoadSuccess:onLoadSuccess,fit:true">
    </table>
</div>

<div id="pageToolbar"
     style="font-weight: bolder;position: fixed;bottom:10px;left:30px; line-height: 50px; overflow: hidden;">

</div>

<!--税点弹出框-->
<div id="taxPointWin" class="segment show-on-ready"
     style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-269px;position:absolute; width: 660px;height:588px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        付款记录</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;">
            填写付款信息，将对账单变更为已收款</p>
        <span class="customerjc"
              style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
              data-title="供应商简称" id="partnerShortname"></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单总数(笔)：<em
                    style="font-family:Arial;font-weight: 100;    font-style: normal; font-size: 22px;"
                    id="numIndex"></em></span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;">对账单金额：<em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;"
                    id="totalPrice"></em></span>
        </div>
        <input type="hidden" name="depositRequestedHid" id="depositRequestedHid">
        <input type="hidden" name="totalPriceHid" id="totalPriceHid">
        <input type="hidden" name="receivePriceHid" id="receivePriceHid">
        <%--<input type="hidden" name="taxPriceHid" id="taxPriceHid">--%>
        <%--<input type="hidden" name="totalPriceWithTaxHid" id="totalPriceWithTaxHid">--%>
        <div style="margin:-1px auto;width:400px;border-top:1px solid rgba(195, 191, 191, 0.2)"></div>
        <div style="      width: 400px; margin: 0 auto; padding: 30px 20px 0; position: relative;">
            <p style="text-align: right;  height: 30px;  color: #666;font-size: 14px;font-weight: 700;"><span
                    style="float:left;">预付金额：</span><em
                    style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100">-</em>
                <em style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100"
                    id="depositRequested"></em></p>
            <p style="text-align: right; height: 30px;   margin-top:15px; color: #666;font-size: 14px;font-weight: 700;">
                <span style="float:left;">应付金额：</span><em
                    style="font-weight:100;font-family: Arial; font-style:normal;font-size: 22px;"
                    id="receivePrice"></em></p>


            <div style="    margin: 20px 0 20px -20px;
    width: 400px;
    border-top:1px solid rgba(195, 191, 191, 0.2)"></div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
    padding: 0;
    text-align: left;
    font-size: 14px;
">付款日期：</label>
                <div class="col-sm-6 pull-right" style="
    padding-right: 0;
    text-align: right;
">
                    <input type="text" name="payDate" data-format="yyyy-MM-dd" class="form-control" id="payDate">
                    <i onclick="$('#payDate').datetimepicker('show')" class="iconfont_new" style="    font-size: 18px;
    top: 1px;
    position: absolute;
    right: 10px;">&#xe6a6;</i>
                </div>

            </div>
            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
    padding: 0;
    text-align: left;
    font-size: 14px;
">实付金额：</label>
                <div class="col-sm-6 pull-right" style="
    padding-right: 0;
    text-align: right;
">
                    <input type="text" style="text-align: right" class="form-control" id="paidUp" placeholder=""/>
                </div>
            </div>

            <div class="form-group" style="height: 30px;line-height: 30px;">
                <label class="col-sm-4 control-label" style="
    padding: 0;
    text-align: left;
    font-size: 14px;
">付款人：</label>
                <div class="col-sm-6 pull-right" style="
    padding-right: 0;

    text-align: right;
">
                    <select type="text" style="padding-top:3px; " class="form-control" id="payOrderPerson" placeholder="">
                    </select>
                </div>
            </div>


        </div>

        <div style="clear: both;margin: 20px 0 20px 280px; position:absolute;bottom:10px;right:80px;">
            <button type="button" class="btn  btn-default" onclick="closeTaxPoint()" style="width:100px;">以后再说</button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;width:100px;font-size:12px;"
                    onclick="batchGenerateBill(this)">我已付款
            </button>
        </div>
    </div>
</div>
<div class="payment" style="background:#f5f5f7;">
    <p style="height:50px;background:#4284d9;border-radius: 5px 5px 0 0 ;line-height:50px;"><span
            style="font-size:16px;margin-left:22px;color:#fff;">支付选择</span><i onclick="closepage(1)"
                                                                              class="iconfont_new"
                                                                              style="color:#fff;float:right;font-size:30px;margin-right:10px;">
        &#xe6a0;</i></p>
    <div class="online">
        <div class="online_one">
            <p>微信在线支付</p>
            <span style="color:#666;font-size:14px;">直接对该笔【待付款对账单】进行在线支付</span>
        </div>
        <div onclick="openscan()" class="onhover">
            <p>微信在线支付</p>
            <button style="line-height:40px;background:#00ae41;color:#fff;border:none;width:100%;border-radius:0 0 5px 5px;text-align:center;">
                选择
            </button>
        </div>
    </div>
    <div class="downline">
        <div class="online_one">
            <p>线下付款记录</p>
            <span style="color:#666;font-size:14px;">将该笔【待付款对账单】的线下付款做记录</span>
        </div>
        <div onclick="openTaxPoint()" class="onhover">
            <p style="color:#4284d9;">线下付款记录</p>
            <button style="line-height:40px;background:#4284d9;color:#fff;border:none;width:100%;border-radius:0 0 5px 5px;text-align:center;">
                选择
            </button>
        </div>
    </div>
</div>
<div class="scan">
    <P style="height:168px;background:#00ae41;border-radius:5px 5px 0 0;overflow:hidden;position:relative;">
        <i onclick="closepage(2)" class="iconfont_new" style="color:#fff;position:absolute;font-size:30px;right:10px;">
            &#xe6a0;</i>
        <img style="height:105px;width:105px;border-radius:50%;display:block;margin:20px auto 10px;"
             src="../../images/phonescan.png"
             alt="">
        <span style="display:block;text-align:center;font-size:18px;color:#fff;">扫码付款</span>

    </P>
    <div class="particulars">
        <ul style="width:60%;margin:50px auto;">
            <li><span>供应商</span><span class="message">上海仁石科技</span></li>
            <li><span>账单金额</span><span class="message">100.00</span></li>
            <li><span>预付金额</span><span class="message">200.00</span></li>
            <li><span>应付金额</span><span class="message" style="color:#eb6877;font-size:18px;">300.00</span></li>
        </ul>
        <div class="scan_one">
            <button onclick="immediately()">立即扫码付款</button>
        </div>
    </div>
    <div class="paymentscan">
        <div class="qrCodeDataMid" style="height:140px;width:140px;margin:50px auto;"></div>
        <p style="margin-left:170px;"><span
                style="background:#ee8e52;display:inline-block;height:42px;width:42px;border-radius:50%;"><i
                class="iconfont_new"
                style="font-size:50px;color:#fff;position:relative;top:-14px;left:-4px;">&#xe6b5;</i></span>
            <span
                    style="position:relative;top:-28px;left:20px;color:#000;">付款完成前，请不要关闭此支付验证窗口</span>
        </p>
    </div>
</div>
<script>
    $("#CashFormula").css({display: 'block'});
    $('.table_contant, .table_contant>table').height($(document.body).height() - 149);
    $(window).bind("resize", function (e) {
        $('.table_contant, .table_contant>table').height($(document.body).height() - 149)
    });
    $(".table_contant").on("click", ".table-link-temp", function () {
        $(this).parentsUntil(".table_contant").find(".table-link-temp").removeClass("clikcBTn");
        $(this).addClass("clikcBTn");
    });
    function showFormua() {
        $("#CashSale").css({display: 'block'})
        $(".window-mask").show();
    }
    function closeFormua() {
        $("#CashSale").css({display: 'none'})
        $(".window-mask").hide()
    }

</script>

</body>

</html>