<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"/>
    <title>安装单列表</title>
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
            transform: translate(81px, 0);
        }

        .nav-tabs li:nth-child(3).smcolor ~ .block {
            transform: translate(165px, 0);
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


        var pageUrl = "/order/installation/listInstallationOrder";// 本页面请求url1
        var pageCustomerUrl =  "/system/partner/dropdownPartner?partnerType=2";// 本页面客户数据url1
        var pageInstallUrl =  "/order/installation/create-installationchecking";// 本页面生成安装单url1 installationNoIns
        var installPageFun = {
            returnopt: function (data, type) {
                var opt = "";
                for (var i = 0; i < data.length; i++) {
                    var dt = data[i];
                    var dtn = "";
                    if (type == 1) {
//                    if(dt.partnerShortname==undefined){continue;}
                        dtn = dt.myComShortname == undefined ? "全部供应商" : dt.myComShortname;
                        opt += '<option data-p="' + dt.partnerStatus + '" value="' + dt.partnerKey + '">' + dtn + '</option>';
                    }
                    if (type == 2) {
                        dtn = dt.show;
                        opt += '<option value="' + dt.key + '">' + dtn + '</option>';
                    }
                }
                return opt;
            },
            closeTaxPoint:  function () {
            $(".window-mask").hide();
            $("#taxPointWin").css({display: 'none'});
            $("#totalPriceWithTax").text($("#totalPrice").text());//默认价格
            $(".generatorBill").attr("disabled", false);
            $("#receivePrice").text($("#receivePriceHid").val());//应收金额
        },
            openTaxPoint: function () {
            var order4ItemsArr = $('#order').datagrid('getChecked');
            var order4Items = [];
            var checkRow = "";
            for (var i = 0; i < order4ItemsArr.length; i++) {
                if (i == 0) {
                    checkRow = order4ItemsArr[i].installationNo;
                    order4Items.push(order4ItemsArr[i]);
                } else {
                    if (order4ItemsArr[i].installationNo == checkRow) {
                        continue;
                    } else {
                        checkRow = order4ItemsArr[i].installationNo;
                        order4Items.push(order4ItemsArr[i]);
                    }
                }
            }

            var partnetKey, partnerShortname,contacterId;
            var flag = false;
            var numIndex = 0, partnerIndex = 0;
            $.each(order4Items, function (index, element) {
                //判断是否同一用户
                if (numIndex == 0) {
                    partnetKey = element.partnerKey;
                    contacterId = element.contactId;
                    partnerShortname = element.partnerShortname;
                } else if (partnetKey != element.partnerKey) {
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户").delay(3000).fadeOut(250).appendTo('body');
                    flag = true;
                    return false;
                }
                numIndex++;
            });
//        只能勾选同一类型的订单生成对账单
//        如订单号旁标识“协”，则说明此单为好友订单

            if (flag) {
                return false;
            }
            var totalPrice = 0, depositRequested = 0,payablePrice=0, receivePrice = 0;
            var installationNo = new Array();
            $.each(order4Items, function (index, element) {
                installationNo.push(element.installationNo);
                    totalPrice = totalPrice + element.installationPrice;
                payablePrice = payablePrice + element.payablePrice;
                depositRequested = depositRequested + element.prepayPrice;
            });
            if (installationNo.length == 0) {
                $("<div class='tips_contants'>").fadeIn(250).html("请选择需要对账的订单").delay(3000).fadeOut(250).appendTo('body');
            } else {
                $("#depositRequestedHid").val(depositRequested);
                $("#totalPriceHid").val(totalPrice);

                    $.ajax({
                        url: "/system/partner/partnerInfo",
                        dataType: "json",
                        data:{"partnerKey":partnetKey,"contacterId":contacterId},
                        success: function (data) {
                            if(data.tel1==""){
                                $(".telNumberShow").text("未填写");
                            }else{
                                $(".telNumberShow").text(data.tel1);
                            }

                            $(".telSelMesWin").show();
                        },
                        error: function () {
                        }
                    });


                    $("#orderMake").text("生成安装对账单").attr("disabled", false).unbind().bind("click",function () {
                        installPageFun.batchGenerateBill(this);
                    });
                    $("#orderdescWin").text("通过对账单和安装供应商做确认，确认无误后结算费用");
                    $("#orderTitWin").text("生成安装对账单");

                //depositRequested 没有返回
                receivePrice = Number(payablePrice);
                totalPrice = accounting.formatNumber(totalPrice, 2);
                depositRequested = accounting.formatNumber(depositRequested, 2);
                $("#receivePriceHid").val(receivePrice);

                receivePrice = accounting.formatNumber(receivePrice, 2);


                $("#totalPrice").text(totalPrice);//销售价格
                $("#numIndex").text(numIndex);//订单笔数
                $("#partnerShortname").text(partnerShortname);//客户简称
                $("#depositRequested").text(depositRequested);//预收金额

                //需要变换的值
                $("#taxRateView").val(0);//税率赋值0
                $("#totalPriceWithTax").text(totalPrice);//默认价格
                $("#taxPrice").text(0.00);//默认税额
                $("#receivePrice").text(receivePrice);//应收金额
                $(".window-mask").show();
                $("#taxPointWin").css({display: 'block'});
            }
        },
            batchGenerateBill:  function (btn) {
            $(btn).attr("disabled", true);
            var order4ItemsArr = $('#order').datagrid('getChecked');
            var order4Items = [];
            var checkRow = "";
            for (var i = 0; i < order4ItemsArr.length; i++) {
                if (i == 0) {
                    checkRow = order4ItemsArr[i].installationNo;
                    order4Items.push(order4ItemsArr[i]);
                } else {
                    if (order4ItemsArr[i].installationNo == checkRow) {
                        continue;
                    } else {
                        checkRow = order4ItemsArr[i].installationNo;
                        order4Items.push(order4ItemsArr[i]);
                    }
                }
            }
//            var installationNo ="";
            var installationNo = new Array();
            var partnetKey;
            var flag = false;
            var numIndex = 0;
            $.each(order4Items, function (index, element) {
                installationNo.push(element.installationNo);
//                installationNo.push(element.installationNo);
                //判断是否同一用户
                if (numIndex == 0) {
                    partnetKey = element.partnerKey;
                } else if (partnetKey != element.partnerKey) {
                    $(btn).attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("请选择相同客户").delay(3000).fadeOut(250).appendTo('body');
                    flag = true;
                    return false;
                }
                numIndex++;

            });
            if (flag) {
                return false;
            }

            var parse = {};
            parse.installationNoIns =installationNo.join(",");
            parse.payablePrice =accounting.formatNumber($("#receivePriceHid").val(), 2,"");
            parse.isSms = $("#telSelMes").prop("checked")?"1":"0";//是否发送短信
            $.ajax({
                type: "POST",
                url:pageInstallUrl,
                data: jQuery.param(parse),
                async: "false",
                dataType: "json",
                success: function (callback) {
                    if (callback.code == "1") {
                        installPageFun.closeTaxPoint();
                        $(btn).attr("disabled", false);
                        $("<div class='tips_contants'  style='line-height: 40px'>").fadeIn(250).html("已成功生成对账单</br>请到【安装结算】查看").delay(3000).fadeOut(250).appendTo('body');
                        setTimeout(function () {
                        $("#order").datagrid('reload');
//                            $(".max-hidden", window.parent.document).find("li[data-url='/openPage?pageName=assignment_installation-settlement-list']").click().addClass("active");
                        }, 2000);

                    } else {
                        installPageFun.closeTaxPoint();
                        $(btn).attr("disabled", false);
                        $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(3000).fadeOut(250).appendTo('body');
                    }
                },
                error: function () {
                    $(btn).attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("生成对账单失败").delay(3000).fadeOut(250).appendTo('body');
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
                arrclo.push({
                    field: 'orderDate',
                    title: '工单概要',
                    width: 140,
                    align: 'left',
                    sortable: true,
                    formatter: function (value, row) {
                        var r = row.caseDesc == "" ? "无概要" : row.caseDesc;
                        return '<a data-id=' + row.installationNo + ' data-did=' + row.industryId + ' href=\'##\' onclick=installPageFun.openDt(this)>' + row.orderDate + '</a>' + '<div class="namebd"><span class="namebdsml">' + r + '</span></div>';
                    }
                });
                arrclo.push({field: 'partnerShortname', align: 'center', width: 200, title: '供应商'});
                arrclo.push({field: 'priceWay', width: 100,align: 'center',  title: '计价方式', formatter: function (value, row) {
                    for(var i=0;i<priceWayAll.length;i++){
                        if(priceWayAll[i].priceWay==value){
                            return priceWayAll[i].priceWayDesc;
                            break;
                        }
                    }
                }
                });

                arrclo.push({field: 'businessDesc', width: 200, title: '业务内容'});

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
                    field: 'installationPrice', width: 100, align: 'right', formatter: function (value, row) {
                        return accounting.formatNumber(value, 2);
                    }, title: '安装费用'
                });

                arrclo.push({field: 'createTime', sortable: true, width: 140, align: 'center', title: '制单时间'});
                arrclo.push({
                    field: 'installationNo', width: 160, align: 'center', title: '安装工单号', formatter: function (value, row) {
                        return value;
                    }
                });
                return arrclo;
            },
            onLoadSuccess: function (data) {
                if (data.rows.length > 0) {
                    installPageFun.mergeCellsByField("order", 'ck,orderDate,installationPrice,installationNo,partnerShortname,createTime');
                } else {
                    $("<div class='tips_contants'>").fadeIn(250).html("没有查询到数据").delay(1000).fadeOut(250).appendTo('body');
                }
            },
            msg: function (content) {
                $("#msgwindow").html(content).addClass("activ");
            },

            mergeCellsByField: function (tableID, colList) {
            var ColArray = colList.split(",");
            var tTable = $("#" + tableID);
            var TableRowCnts = tTable.datagrid("getRows").length;
            var tmpA;
            var tmpB;
            var PerTxt = "";
            var CurTxt = "";
            var alertStr = "";
            for (j = ColArray.length - 1; j >= 0; j--) {
                PerTxt = "";
                tmpA = 1;
                tmpB = 0;

                for (i = 0; i <= TableRowCnts; i++) {
                    if (i == TableRowCnts) {
                        CurTxt = "";
                    }
                    else {
                        CurTxt = tTable.datagrid("getRows")[i][ColArray[j]] + tTable.datagrid("getRows")[i]["installationNo"];
                    }
                    if (PerTxt == CurTxt) {
                        tmpA += 1;
                    }
                    else {
                        tmpB += tmpA;

                        tTable.datagrid("mergeCells", {
                            index: i - tmpA,
                            field: ColArray[j],//合并字段
                            rowspan: tmpA,
                            colspan: null
                        });
                        tmpA = 1;
                    }
                    PerTxt = CurTxt;
                }
            }
        },
            createOrder: function () {

                var modifyRow = new Array();
                var flag = false;
                var order4ItemsArr = $('#order').datagrid('getChecked');
                console.log(order4ItemsArr);
                var cols = [];
                var checkRow = "";
                for (var i = 0; i < order4ItemsArr.length; i++) {
                    if (i == 0) {
                        checkRow = order4ItemsArr[i].salesNo;
                        cols.push(order4ItemsArr[i]);
                    } else {
                        if (order4ItemsArr[i].salesNo == checkRow) {
                            continue;
                        } else {
                            checkRow = order4ItemsArr[i].salesNo;
                            cols.push(order4ItemsArr[i]);
                        }
                    }
                }
                $.each(cols, function (index, item) {

                    modifyRow.push(item);
                });

                /*      if (flag) {
                 $("<div class='tips_contants'>").fadeIn(250).html("好友协同单已经被收货，不可修改。").delay(4000).fadeOut(250).appendTo('body');
                 return false;
                 }*/


                if (modifyRow.length == 1) {
                    //查询订单状态
                    var saleOrderNo = modifyRow[0].salesNo;
                    $.post("/ydz/salesorder/saleOrderOne", {salesNo: saleOrderNo}, function (data) {
                        var callback = eval("(" + data + ")");
                        var status = callback.status;
                        if (status != modifyRow[0].status) {
                            $("<div class='tips_contants'>").fadeIn(250).html("订单状态已过期，请刷新").delay(4000).fadeOut(250).appendTo('body');
                            return false;
                        } else {
                            var App = window.parent.App;
                            var config = {
                                closeable: "true",
                                icon: "icon dashboard",
                                label: "修改销售订单",
                                path: "/ydz/salesorder/updatePage?salesNo=" + modifyRow[0].salesNo,
                                type: "subWindow"
                            };
                            App.open(config.path, config);
                        }

                    });
                    //调转修改页面

                } else {
                    if ($(".tips_contants").length > 0) {
                        $(".tips_contants").remove();
                        $("<div class='tips_contants'>").fadeIn(250).html("只可修改单笔订单").delay(3000).fadeOut(250).appendTo('body');
                    } else {
                        $("<div class='tips_contants'>").fadeIn(250).html("只可修改单笔订单").delay(3000).fadeOut(250).appendTo('body');
                    }
                }


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

               var url="/order/installation/forward-installation-list-detail?installationNo="+$(obj).attr("data-id");
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
                installPageFun.openTaxPoint();
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
            url = pageUrl;
            pageSize = 30;
            pageList = [30, 40];
                if(status=="CC" || status=="05"){
                    $(".createInstaller").addClass("hide");
                }else{
                    $(".createInstaller").removeClass("hide");
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
                        "status": status,
                        "partnerKey": $('#customerDat').val(),
                        "endTime": $('#datetimepickere').val(),
                        "searchKey": $('#searchK').val(),
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
<input type="hidden" name="receivePriceHid" id="receivePriceHid">
<div id="msgwindow" style="border:none;"></div>
<%--遮罩--%>
<div class="window-mask"
     style=" position: absolute;left: 0;top: 0;display:none; background:#fff; z-index:999;width: 100%;height: 100%;filter: alpha(opacity=20);opacity: 0.90;font-size: 1px;overflow: hidden;"></div>

<div id="taxPointWin"
     style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-239px;position:absolute; width: 660px;height:478px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;" id="orderTitWin">
    </p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="installPageFun.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;" id="orderdescWin">
        </p>
        <span class="customerjc"
              style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
              data-title="客户简称" id="partnerShortname"></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单总数(笔)：<em
                    style="font-family:Arial;font-weight: 100;    font-style: normal; font-size: 22px;"
                    id="numIndex"></em></span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;">订单总金额：<em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;"
                    id="totalPrice"></em></span>
        </div>

        <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>
        <div style="      width: 400px; margin: 0 auto; padding: 30px 20px 0; position: relative;">
            <p style="text-align: right;  height: 30px;  color: #666;font-size: 14px;font-weight: 700;"><span
                    style="float:left;">预付总金额：</span><em
                    style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100">-</em>
                <em style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100"
                    id="depositRequested"></em></p>
            <p style="text-align: right; height: 30px;   margin-top:15px; color: #666;font-size: 14px;font-weight: 700;">
                <span style="float:left;">应付总金额：</span><em
                    style="font-weight:100;font-family: Arial; font-style:normal;font-size: 22px;color:#ff0000;"
                    id="receivePrice"></em></p>
        </div>
        <div style="    position: absolute;
    bottom: 70px;
    right: 80px;" class="telSelMesWin  prettyck"><input id="telSelMes" checked type="checkbox" name="ck" value=""><label for="telSelMes" style="vertical-align:middle;font-weight: normal;">给安装供应商发送账单链接短信【手机号：<i class="telNumberShow telColor"></i>】</label></div>

        <div style="clear: both; position:absolute;bottom:25px;right:80px;">
            <button type="button" class="btn " onclick="installPageFun.closeTaxPoint()" style="width:100px;">取消</button>
            <button type="button" class="btn btn-primary" style="margin-left:15px;font-size:12px;"
                    id="orderMake">
            </button>
        </div>
    </div>
</div>


<div data-options="region:'north'" style="border:none !important;padding:10px;overflow: hidden;">

    <ul class="nav nav-tabs" id="navCondition">
        <li style="position:relative;" data-s="04" class="smcolor order2"><a href="#">待对账</a></li>
        <li style="position:relative;" data-s="05" class="order"><a href="#">已对账</a></li>
        <li style="position:relative;" data-s="CC" class="order"><a href="#">已作废</a></li>
        <li class="block"></li>
    </ul>


    <div class="h10"></div>
    <div style="    padding: 10px;
    border: 1px solid #ebebeb;">
        <form role="form">
            <div class="row" style="margin:0;">
                <div class="col-xs-2" style="width:200px;padding:0 5px 0 0">
                    <%--<input type="text" class="form-control" placeholder="选择客户">--%>
                    <select class="form-control input-xs" id="customerDat" placeholder="选择供应商">
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
                               id="searchK" placeholder="搜索业务内容、工单概要" style="      width: 192px;
    border-radius: 30px;
    color: #b3b3b3;
    font-size: 12px;
    padding-right: 30px;">

                    </div>
                </div>
                <button type="button" id="searchBtn" class="btn btn-primary "
                        style="font-size:12px;height:30px;line-height:1;">搜索
                </button>

                <button type="button" class="btn btn-primary pull-right createInstaller "
                        style="font-size:12px;height:30px">生成对账单
                </button>
                <div style="     color: #ff9900;
    float: right;
    margin-right: 20px;" id="caozuoTip" data-toggle="popover" data-container="body" data-trigger="hover" data-placement="bottom"
                     data-html="true" data-content="将需要一起安装的工单批量勾选，生成一张安装对账单" data-original-title="" title="">
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