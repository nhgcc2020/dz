<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>设计派工提成结算详情</title>

        <link rel="stylesheet" type="text/css" href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
        <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">
        <style>

            *, *:before, *:after {
                box-sizing: border-box;
            }

            .ui.divider {
                margin: 1rem 0;
                border-top: 1px solid rgba(34, 36, 38, 0.15);
            }

            .ui.form {
                max-width: 100%;
                font-size: 12px
            }

            .ui.items-view.widget-table {
                margin-top: 15px
            }

            @media only screen and (max-width: 1050px) {
                #tableContainer table {
                    width: 1050px;
                    overflow: scroll;
                    margin-bottom: 10px
                }
            }

            @media only screen and (min-width: 1051px) {
                #tableContainer table {
                    width: 100%;
                    overflow: scroll;
                    margin-bottom: 10px
                }
            }

            .business-desc {
                color: #337AB7;
                padding: 0 .4em
            }

            .order {
                position: absolute;
                right: 10px;
                top: 30px;
            }

            #taxPointWin {
                border: none;
                z-index: 9999;
                width: 700px;
                box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
                /*min-height:290px;*/
                background: #fff;
                transition: all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
                display: none;
            }

            .total-preson .show_address span {
                margin-right: 0px;
            }

            .show_address {
                margin-bottom: 8px;
            }

            .Customer-address {
                height: auto;
                line-height: normal;
            }

            #cancelWin {
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

            .tbWk td {
                border: 1px solid #e4e4e4 !important;
                padding: 10px;
            }

            .tbWk {
                border: 1px solid #e4e4e4;
                color: #000;
            }

            .tbWk th {
                text-align: center;
                border: 1px solid #e4e4e4;
                background: #eff1f3;
                font-size: 14px;
                height: 40px;
                font-weight: normal;
                color: #666;
                line-height: 40px;
                cursor: default;
            }
            .talRight{
                text-align: right;
            }
            #receivablesBar {
                border: none;
                z-index: 10;
                width: 700px;
                box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);
                min-height: 290px;
                background: #fff;
                transition: all 0.2s 0s linear;
                -webkit-transition: all 0.2s 0s linear;
                position: absolute;
                display: none;
            }
            .ui.button {
                cursor: pointer;
                display: inline-block;
                min-height: 1em;
                outline: none;
                border: none;
                vertical-align: baseline;
                background: #E0E1E2 none;
                color: rgba(0, 0, 0, 0.6);
                font-family: Arial, "Microsoft YaHei", '宋体';
                margin: 0em 0.25em 0em 0em;
                font-size: 12px !important;
                height: 30px;
                line-height: 30px;
                padding:0px 30px;
                text-transform: none;
                text-shadow: none;
                font-weight: bold;
                font-style: normal;
                text-align: center;
                text-decoration: none;
                border-radius: 0.28571429rem;
                box-shadow: 0px 0px 0px 1px transparent inset, 0px 0em 0px 0px rgba(34, 36, 38, 0.15) inset;
                -webkit-user-select: none;
                -moz-user-select: none;
                -ms-user-select: none;
                user-select: none;
                -webkit-transition: opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease;
                transition: opacity 0.1s ease, background-color 0.1s ease, color 0.1s ease, box-shadow 0.1s ease, background 0.1s ease;
                will-change: '';
                -webkit-tap-highlight-color: transparent;
            }
            @media only screen and (max-width: 1050px) {
                #tableContainer table {
                    width: 1050px;
                    overflow: scroll;
                    margin-bottom: 10px
                }
            }

            @media only screen and (min-width: 1051px) {
                #tableContainer table {
                    width: 100%;
                    overflow: scroll;
                    margin-bottom: 10px
                }
            }

            .business-desc {
                color: #337AB7;
                padding: 0 .4em
            }

            .saledetailList {
                height: 36px;
                line-height: 36px;
                background: #f3f3f3;
                overflow: hidden;
                border: 1px solid #e4e4e4;
                border-bottom: none
            }

            .saledetailList li {
                float: left;
                width: 25%;
                padding-left: 15px;
                box-sizing: border-box;
                height: 36px;
                overflow: hidden;
                white-space: nowrap;
                text-overflow: ellipsis
            }

            .saledetailList li b {
                font-weight: 100;
                margin-left: 10px
            }

            .segment-line {
                height: 25px;
                border-top: 1px grey;
                border-style: dashed;
                margin-top: 15px
            }

            .ui.items-view table tbody tr:nth-child(even) {
                background: none !important;
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

            .Customer-address {
                height: 10px;
                line-height: normal;
            }
            .colde{
                font-weight: 900;
                color: #eb6877;
            }
        </style>
        <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
        <script src="/resources/bootstrap/jquery.webui-popover.min.js?v=4f80ef33c0"></script>
        <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
        <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
        <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
        <script src="/resources/business/base_new.js?v=9ac481258d"></script>
    </head>
<body style="padding:2%;background: url('/images/backlogo.png') repeat;">
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<button type="button" onclick="salesCheckingFun.closeRightWin()" class="btn "
        style="font-size:12px;height:30px;width:92px;margin-right: 5px;line-height:1;">关闭
</button>
<button type="button"  id="print" class="btn "
        style="font-size:12px;height:30px;width:92px;margin-right: 5px;line-height:1;">打印
</button>
<button type="button" id="qrCodeData" data-toggle="popover" data-container="body" data-trigger="hover"
        data-placement="bottom"
        data-html="true" class="btn btn-primary "
        style="font-size:12px;height:30px;line-height:1;margin-right: 5px;">微信/QQ转发
</button>
<%--<button type="button"  id="export" class="btn "--%>
<%--style="font-size:12px;height:30px;width:92px;margin-right: 5px;line-height:1;">导出--%>
<%--</button>--%>


<%--<button type="button" onclick="salesCheckingFun.resetCheckOrder('07')" class="btn hide updateOrder "--%>
<%--style="font-size:12px;width:92px;margin-right: 8px;height:30px;line-height:1;">撤销对账单--%>
<%--</button>--%>

<%--<button type="button" onclick="salesCheckingFun.resetCheckOrder('08')" class="btn hide cancelOrder "--%>
<%--style="font-size:12px;width:92px;margin-right: 5px;height:30px;line-height:1;">撤销收款--%>
<%--</button>--%>
<div class="hide qrCodeDataCls" style="padding: 0;margin-right: 5px;width: 280px;height: 260px;"><p
        style="margin-top: 20px;text-align: center">扫一扫，转发给客户做确认</p>
    <div style="margin-top: 30px ;text-align: center;" class="qrCodeDataMid"></div>
</div>
<div style="height: 1px ;background: #fff;"></div>
<div id="tableContainer" class="hide"
     style="padding: 20px;border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);">
</div>

<script id="tpl-detail" type="text/html">

    <div class="ui form" style="position:relative;">
        <div style="position: absolute;top:10px;right: 20px;font-size:12px !important;color:#13c19f;font-weight:900;">
            <input type="hidden" value="{{order.salesNo}}"  id="saleNumCc">
            <p class="hide salescheckingNoCls" >结算单号：<span id="salesCheck"
            >{{order.commissionsCheckingNo}}</span></p>

        </div>
        <div class="inline fields" style="text-align: center; display: block;">
            <div class="field" style="margin-left: 20px;display: inline-block;font-size: 20px;">
                <label>{{order.taskUserName}}</label>
                <label>提成结算单</label>
                <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
            </div>
        </div>

        <div style="text-align:center;font-size:14px;color:#666;margin-bottom:20px;">
            <div style="display: inline-block">
                设计师 : <span style="font-weight:400" >
                {{order.taskUserName}}</span></div>
            &#x3000;
            <div style="display: inline-block">手机 : <span style="font-weight:400" >{{order.taskUserTel}}</span>
            </div>
            &#x3000;
            {{if payment}}
            <div style="display: inline-block">结算账户 : <span style="font-weight:400"
            >{{payment.accountPayee}}</span></div>
            {{/if}}
        </div>
        <div class="ui form" style="position:relative;">

            <table class="tbWk" style="width:100%;">
                <col width="6%"/>
                <col width="14%"/>
                <col width="6%"/>
                <col width="6%"/>
                <col width="10%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="14%"/>
                <thead>
                <th>订单号</th>
                <th>订单概要</th>
                <th>客户</th>
                <th>联系人</th>
                <th>任务说明</th>
                <th>订单金额</th>
                <th>提成金额</th>
                <th>制单时间</th>
                </thead>
                <tbody>
                {{each details as item i}}
                <tr>
                    <td align="center">{{item.salesNo}}</td>
                    <td>{{item.caseDesc}}</td>
                    <td align="center">{{item.partnerShortname}}</td>
                    <td align="center">{{item.contactName}}</td>
                    <td>{{item.taskDesc}}</td>
                    <td class="talRight">{{item.totalPrice | formatNumber}}</td>
                    <td class="talRight">{{item.commissionsMoney | formatNumber}}</td>
                    <td>{{item.createTime}}</td>
                </tr>
                {{/each}}
                </tbody>

            </table>

            <div class="total-drive">
                <div>
                    <ul class="total_right">
                        <li style="margin-bottom:8px;">订单总金额：<span
                        >{{order.totalPrice | formatNumber}}</span></li>
                        <%--<li class="zhe">实&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收：<span> - <i--%>
                        <%-->{{order.paidUp | formatNumber}}</i> </span></li>--%>

                        <div class="ui divider"></div>
                    </ul>
                    <div style="clear:both;"></div>
                </div>
                <div style="position:relative;">
                    <ul class="total_right total_only">
                        <li style="margin-bottom:8px;" class=" paidUpCls">提成总金额：<span
                        >{{order.commissionsMoney | formatNumber}}</span></li>
                        <li style="margin-bottom:8px;">结算总金额：<span
                        >{{order.settlementMoney | formatNumber}}</span></li>
                    </ul>



                    <div style="clear:both;"></div>
                </div>
            </div>
        </div>
        <div class="ui divider"></div>
        <div class="Customer-address">
            <div style="float:left;">
                电话 : <span >{{bottomComInfo.comTel}}</span>
                QQ : <span >{{bottomComInfo.comQQ}}</span>
                联系人 : <span >{{bottomComInfo.realName}} ({{bottomComInfo.userId}})</span>
                地址 : <span>
                            <b c-bind="bottomComInfo.comAddress">{{bottomComInfo.comAddress}}</b>
                        </span></div>
            <span style="float:right;margin:0;">制单人 ：<span style="margin:0;">{{order.creatorName}} ({{order.createTime}})</span></span>
        </div>
    </div>
</script>
<script type="text/javascript">
    Date.prototype.Format = function (fmt) {
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    };


    var pageshareUrl = "/ydz/commission/design/shareUrl?orderNo=${commissionsCheckingNo}";
    var salesCheckingFun={
        initTbData: function (orderNo, industryId) {
            $.ajax({
                url:  "/ydz/commission/commissionCheckingOrderAndDetail?commissionsCheckingNo=" + orderNo,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (bothData) {
                    $("[data-toggle='popover']").webuiPopover({
                        content: $(".qrCodeDataCls")[0].innerHTML,
                        width: '250',
                        height: '260',
                        onShow: function () {
                            if($('.qrCodeDataMid').html()==""){
                                $('.qrCodeDataMid').html("正在生成二维码...");
                                $.ajax({
                                    url:pageshareUrl,
                                    dataType: "json",
                                    success:function(dt){
                                        if(dt.code=="1"){
                                            $('.qrCodeDataMid').empty();
                                            $('.qrCodeDataMid').qrcode({width: 160, height: 160, text:dt.shareUrl});
                                        }
                                    }
                                })
                            }
                        },
                        onHide: function ($element) {
                        },
                        trigger: 'hover'
                    });
                    template.defaults.imports.formatNumber = function (value) {
                        return accounting.formatNumber(value, 2);
                    };



                    var html = template('tpl-detail', bothData);
                    document.getElementById("tableContainer").innerHTML += html;
                    $("#tableContainer").removeClass("hide");
                    if(bothData.payment==""||bothData.payment==null){
                        $(".total_only li").eq(0).children().addClass("colde").siblings().removeClass("colde");
                    }else{
                        $(".total_only li").eq(1).children().addClass("colde").siblings().removeClass("colde");
                    }
                    if (bothData.order.orderStatus == '07') {
                        var htmlCancel = template('tpl-taxPointWin', bothData);
                        $("body").append(htmlCancel);
                        $(".updateOrder").removeClass("hide");
                        $(".receivablesMoneyCls").removeClass("hide");
                    }
                    if (bothData.order.orderStatus == '08') {
                        var htmlCancel2 = template('tpl-receivable', bothData);
                        $("body").append(htmlCancel2);
                        $(".cancelOrder").removeClass("hide");
                        $(".paidUpCls").removeClass("hide");
                    }
                    if(bothData.order.purchasecheckingNo!=''){
                        $(".purchasecheckingNoCls").removeClass("hide");
                    }
                    if(bothData.order.salescheckingNo!=''){
                        $(".salescheckingNoCls").removeClass("hide");
                    }
                    salesCheckingCity();
                }
            })

        },

        resetOrder2: function () {
            $.ajax({
                type: "POST",
                url: "/ydz/salescheck/cancelreceivable",
                data: {checkingNo: $("#salesCheck").text()},
                dataType: "json",
                success: function (callback) {
                    $("<div class='tips_contants'>").fadeIn(250).html(callback.msg).delay(2000).fadeOut(250).appendTo('body');
                    setTimeout(function () {
                        window.parent.location.reload();
                    }, 2000);

                },
                error: function () {
                    $("<div class='tips_contants'>").fadeIn(250).html("撤销收款失败").delay(2000).fadeOut(250).appendTo('body');

                }
            })
        },
        resetOrder:function () {
            $.ajax({
                type: "POST",
                url: "/ydz/salescheck/cancelDelorder",
                data: {checkingNo: $("#salesCheck").text()},
                dataType: "json",
                success: function (callback) {
                    $("<div class='tips_contants'>").fadeIn(250).html("撤销并删除成功").delay(2000).fadeOut(250).appendTo('body');
                    setTimeout(function () {
                        window.parent.location.reload();

                    }, 2000);
                },
                error: function () {
                    $("<div class='tips_contants'>").fadeIn(250).html("撤销并删除失败").delay(2000).fadeOut(250).appendTo('body');

                }
            })
        },
        closeTaxPoint:function () {
            $(".window-mask").hide();
            $("#taxPointWin,#receivablesBar").css({display: 'none'});
        },
        closeRightWin: function () {
            parent.hideMsg();
        },
        resetCheckOrder: function (bt) {
            if(bt=="07"){
                $("#taxPointWin").css({display: 'block'});
            }else if(bt=="08"){
                if($("#receivablesBarTextArea").val()!=""){
                    $("body").append($("#receivablesBarTextArea").val());
                    $("#receivablesBarTextArea").val("");
                }
                $.ajax({
                    type: "POST",
                    url: "/ydz/salescheck/getReceivableInfo",
                    data: {checkingNo: $("#salesCheck").text()},
                    dataType: "json",
                    success: function (callback) {
                        $("#recpayName").val(callback.recpayName);
                        $("#recpayAccount").val(callback.accountPayee);
                        $("#recpayDate").val(new Date(callback.recpayDate).Format("yyyy-MM-dd"));
                        $("#remarks").val(callback.remarks);
                    }
                })
                $("#receivablesBar").show();
            }
        }
    };
    function salesCheckingCity(){
        var a = $(".zhe i").text();
        var b = $(".jian i").text();
        if (a == "0.00") {
            $(".zhe").hide();
        }
        if (b == "0.00") {
            $(".jian").hide();
        }
        var sheng = $("#sheng").val();
        var shi = $("#shi").val();
        var xian = $("#xian").val();

        $.each(ProvinceJson, function (key, val) {
            if (val.provinceId == sheng) {
                $("#sheng1").html(val.provinceName);
                return false ;
            }
        });

        $.each(CityJson, function (key, val) {
            if (val.provinceId == sheng && val.cityId == shi) {
                $("#shi1").html(val.cityName);return false;
            }
        });

        $.each(CountryJson, function (key, val) {
            if (val.cityId == shi && val.countryId == xian) {
                $("#xian2").html(val.countryName);return false;
            }
        });
    }
    ;(function ($) {
        $.fn.extend({
            //表格合并单元格，colIdx要合并的列序号，从0开始
            "rowspan": function (colIdx) {
                return this.each(function () {
                    var that;
                    $('tr', this).each(function (row) {
                        $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {
                            if (that != null && $(this).text() == $(that).text()) {

                                rowspan = $(that).attr("rowSpan");
                                if (rowspan == undefined) {
                                    $(that).attr("rowSpan", 1);
                                    rowspan = $(that).attr("rowSpan");
                                }
                                rowspan = Number(rowspan) + 1;
                                $(that).attr("rowSpan", rowspan);
                                $(this).hide();

                            } else {
                                that = this;
                            }
                        });
                    });
                });
            },
            "rowspan2": function (colIdx) {
                return this.each(function () {
                    var that;
                    var thatVal;
                    var valT2;
                    $('tr', this).each(function (row) {


                        $(this).attr("data-id","1");
                        var $tdVal=$('td:eq(1)',this).text();
                        $('td:eq(' + colIdx + ')', this).filter(':visible').each(function (col) {

                            var valT1=$(this).text()+$tdVal;

                            var valT2=$(that).text()+thatVal;
                            if (that != null && valT1 == valT2) {
                                rowspan = $(that).attr("rowSpan");
                                if (rowspan == undefined) {
                                    $(that).attr("rowSpan", 1);
                                    rowspan = $(that).attr("rowSpan");
                                }
                                rowspan = Number(rowspan) + 1;
                                $(that).attr("rowSpan", rowspan);
//                                $(this).remove();
                                $(this).hide();
//                                $(this).html("");

                            } else {
                                that = this;
                                thatVal=$tdVal;
                            }
                        });
                    });
                });
            }

        });

    })(jQuery);
    $(function () {
        salesCheckingFun.initTbData('${commissionsCheckingNo}');
        if ($("#saleNumCc").val()) {
            var num = $("#saleNumCc").val().split(",").length;
            $("#numIndex").text(num);
        }
        $("#print").click(function () {
            window.parent.parent.open("/print/design-commission-checking-list-detail-print.html?commissionsCheckingNo=${commissionsCheckingNo}");
        });

    })
</script>
</body>
</html>