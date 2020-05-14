<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>销售订单明细</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
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
            top: 4px;
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
            color: #666;
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
        .cover:hover{
            color: #3385ff!important;
        }
        .coverage{
            font-size: 12px;
            float: right;
            color: #eb6877;
            cursor: pointer;
        }
        .coverage span{
            color:#4284D9; 
        }
        label{
           font-weight: normal;
           color: #000;
        }
        .coveres {
            display: none;
            position: fixed;
            top: 0;
            width: 100%;
            height: 100%;
            background: #000;
            opacity: 0.7;
            z-index: 1000;
        }
     .alart_one {
            display: none;
            position: fixed;
            top: 50%;
            z-index: 2000;
            width: 1100px;
            margin-top: -270px;
            left: 60%;
            margin-left: -550px;
        }
    .callback {
            font-size: 45px;
            right: 180px;
            top: -20px;
            position: absolute;
            color: #fff;
            cursor: pointer;
        }
     .received{
         float: right;
         color: #01a09a;
         font-size: 12px;
         margin-right: 24px;
         line-height: 55px;
         display: none;
     }
        .fixheader {
            background: #fff;
            height: 55px;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            border-bottom: 1px solid #dddddd;
            padding: 8px 20px 0 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 99;
            overflow: hidden;
        }
        #tableContainer{
            padding-top:80px !important;
            /*border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);*/
        }
    </style>
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/bootstrap/jquery.webui-popover.min.js?v=4f80ef33c0"></script>
    <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
    <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
</head>
<body style="padding:0 2%;overflow:visible; background: url('/images/backlogo.png') repeat; z-index: 1000;">
<div class="coveres"></div>
<div class="alart_one">
    <div class="callback iconfont_new">&#xe6a0;</div>
    <img src="../../images/print.png" alt="">
</div>
<div id="cancelWin"
     style="padding-top:5px;top:100px;left:50%;margin-left:-330px; position:absolute; width: 660px;height:428px;">
    <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
        订单作废</p>
    <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
          onclick="order_detail.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>
    <div style="text-align: center;margin: 0 auto;">
        <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: #999; background: #f5f5f5;line-height: 30px;height: 30px;">
            请谨慎操作,被作废的订单将不能再进行任何操作</p>
        <span class="customerjc partnerShortnameCls"
              style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
        ></span>
        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单金额：</span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;"><em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;"
                    id="totalPrice"></em></span>
        </div>

        <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>

        <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 预收金额：</span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;"><em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;color:#ff0000;"
                    class="depositRequestedCls"></em></span>
        </div>

        <div style="clear: both;margin: 20px 0 20px 280px; padding-bottom: 20px; position:absolute;bottom:10px;right:80px;">
            <button type="button" onclick="order_detail.closeTaxPoint()" class="btn "
                    style="font-size:12px;height:30px;width:92px;margin-right: 5px;">取消
            </button>
            <button type="button" class="btn btn-primary"
                    style="margin-left:15px;font-size:12px;width:92px;" onclick="order_detail.cancelOrderLast(this)">作废
            </button>


        </div>
    </div>
</div>

<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

<div class="fixheader">
<button type="button" onclick="order_detail.closeRightWin()" class="btn "
        style="font-size:12px;height:30px;width:88px;margin:12px 0px 9px 0px;line-height:1;">关闭页面
</button>
<button type="button" onclick="order_detail.updateOrder()" class="btn hide updateOrder cover"
        style="font-size:14px;height:30px;width:58px;margin:0px 8px 5px 21px;line-height:1;background:#fff;color:#7e92ab;padding:0;"><i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e6;</i> 修改
</button>
<button type="button"  id="print" class="btn cover"
        style="font-size:14px;height:30px;width:58px;margin:0px 8px 5px 10px;line-height:1;background:#fff;color:#7e92ab;padding:0;"><i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e8;</i> 打印
</button>
<button type="button" id="qrCodeData" data-toggle="popover" data-container="body" data-trigger="hover"
        data-placement="bottom"
        data-html="true" class="btn cover"
        style="font-size:14px;height:30px;width:112px;line-height:1;margin:0px 8px 5px 10px;background:#fff;color:#7e92ab;padding:0;"><i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e9;</i> 微信/QQ转发
</button>

<button type="button" class="btn cover" onclick="order_detail.toCreatePurchaseOrder()"
        style="font-size:14px;height:30px;width:98px;line-height:1;margin:0px 8px 5px 10px;background:#fff;color:#7e92ab;padding:0;"><i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe698;</i> 生成采购单
</button>

<button type="button" onclick="order_detail.cancelOrder()" class="btn hide cancelOrder cover"
         style="font-size:14px;height:30px;width:58px;margin:0px 8px 5px 10px;line-height:1;background:#fff;color:#7e92ab;padding:0;"><i class="iconfont_new" style="font-size:26px;position:relative;top:4px;margin-right:3px;">&#xe6c4;</i>作废
</button>
<div title="点击查看如何另存为PDF" class="coverage"><i class="iconfont_new" style="font-size:30px;position:relative;top:7px;">&#xe6ed;</i> 友情提示：你可以在打印页将订单另存为PDF文件 <span>查看<i class="iconfont_new" style="font-weight:900;font-size:14px;position:relative;top:1px;">&#xe68b;</i></span></div>
<div class="received">已收货&#x3000;<span></span></div>

</div>




<div class="hide qrCodeDataCls" style="padding: 0;margin-right: 5px;width: 280px;height: 260px;"><p
        style="margin-top: 20px;text-align: center">扫一扫，转发给客户做确认</p>
    <div style="margin-top: 30px ;text-align: center;" class="qrCodeDataMid"></div>
</div>

<div style="height: 1px ;background: #ccc;"></div>


<div id="tableContainer" class="hide"
     style="padding: 20px;">
</div>


<script id="tpl-detail" type="text/html">

    <div class="ui form" style="position:relative;">
        <div class="order" style="color:#13c19f;font-weight:900;">
            <p>销售单号 : <span id="orderNum">{{saleOrder.salesNo}}</span></p>
            <p class="cai">采购单号 : <span>{{saleOrder.purchaseNo}}</span></p>
        </div>
        <div class="inline fields" style="text-align: center; display: block;">
            <div class="field" style="margin-left: 20px;display: inline-block;font-size: 18px;">
                <label>${sessionScope.sessionUser.comName}</label>
                <label>销售单</label>
                <label>( {{saleOrder.orderDate}} )</label>
                <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
            </div>
        </div>

        <div class="fieldsec" style="font-size:14px;color:#666;margin-bottom:15px;">
            客户 : <span>{{saleOrder.partnerShortname}}</span>
            税号 : <span>{{saleOrder.taxNo}}</span>
            <span>{{saleOrder.contactName}} ({{saleOrder.contactTel}})</span>
            地址 : <span class="address{{saleOrder.salesNo}}">{{bottomComInfo.partnerAddress}}</span>
        </div>
    </div>
    
    <div class="ui form">

        <table class="tbWk" style="width:100%;">
            <col width="32%"/>
            <col width="18%"/>
            <col width="10%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="6%"/>
            <col width="10%"/>
            <thead>
            <th>业务内容</th>
            <th>制作物料</th>
            <th>规格(m)</th>
            <th>面积(㎡)</th>
            <th>数量</th>
            <th>单位</th>
            <th>单价</th>
            <th>行小计</th>
            <th>备注</th>
            </thead>
            <tbody>
            {{each orders as item i}}
            <tr>
                <td>{{item.businessDesc}}</td>
                <td>{{item.requirements}}</td>
                <td style="text-align:center;">{{item.specification}}</td>
                <td style="text-align:center;">{{item.totalArea}}</td>
                <td style="text-align:center;">{{item.quantity}}</td>
                <td style="text-align:center;">{{item.unit}}</td>
                <td class="talRight">{{item.unitPrice | formatNumber}}</td>
                <td class="talRight">{{item.totalPrice | formatNumber}}</td>
                <td>{{item.remarks}}</td>
            </tr>
            {{/each}}
            </tbody>

        </table>

        <div class="total-drive">
            <div>
                <div class="total-left">
                    <div>备注：<span id="shifouweikong">{{saleOrder.remarks}}</span></div>
                </div>
                <ul class="total_right">
                    <li>合&#x3000;&#x3000;计 :<span>{{saleOrder.price | formatNumber}}</span></li>
                    <li class="zhe">折&#x3000;&#x3000;扣 :<span> - <i
                    >{{saleOrder.discount | formatNumber}}</i> </span></li>
                    <li class="jian">减&#x3000;&#x3000;免 :<span> - <i
                    >{{saleOrder.preferential | formatNumber}}</i> </span></li>
                    <div class="ui divider"></div>
                </ul>
                <div style="clear:both;"></div>
            </div>
            <div style="position:relative;">
                <ul class="total_right">
                    <li style="margin-bottom:8px;">订单金额<span style="color:#eb6877;font-weight:900;"
                    >{{saleOrder.totalPrice | formatNumber}}</span></li>
                    <li>预&#x3000;&#x3000;收 :<span> - <i>{{saleOrder.depositRequested | formatNumber}}</i> </span>
                    </li>
                </ul>
                <div style="clear:both;"></div>
            </div>
        </div>
    </div>
    <div class="ui divider"></div>
    <div class="Customer-address">
        电话 : <span>{{bottomComInfo.comTel}}</span>
        QQ : <span>{{bottomComInfo.comQQ}}</span>
        <span class="relation">联系人 : <span style="margin:0;">{{bottomComInfo.realName}} ({{bottomComInfo.userId}})</span></span>
        <span class="addr">
        地址 : <span>
                    <b>{{bottomComInfo.comAddress}}</b>
                </span></span>
        <span style="float:right;margin:0;">
            制单人 ：<span>{{saleOrder.creatorName}} ({{saleOrder.createTime}})</span>
    </div>

</script>

<script type="text/javascript">
    var industryId = '${param.industryId}';
    var salesNo = '${param.salesNo}';
    var pageDelOrder = "/ydz/salesorder/deleteSalesOrder";// 删除订单请求url
    var pageCancelOrder = "/ydz/salesorder/cancelSalesOrder";// 作废订单请求url
    var pageshareUrl = "/ydz/salesorder/shareUrl?orderNo=${param.salesNo}";
    $(function () {
        try {

            //打印
            $("#print").click(function () {
                window.parent.parent.open("/print/sales-order-detail-print.html?salesNo=${param.salesNo}" + "&industryId=${param.industryId}");
            });

        } catch (e) {

        }
        order_detail.initTbData(salesNo, industryId);

        $(".coverage").click(function(){
            $(".coveres").show();
            $(".alart_one").show();
        });
        $(".callback").click(function(){
            $(".coveres").hide();
            $(".alart_one").hide();
        });
    })

    //    页面方法的主体
    var order_detail = {
        initTbData: function (salesNo, industryId) {
            $.ajax({
                url: "/ydz/salesorder/salesOrderDetailData?salesNo=" + salesNo + "&industryId=" + industryId,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (bothData) {

                    console.log(bothData.bottomComInfo);
                    console.log(bothData.orders);
                    console.log(bothData.saleOrder);
                    // 二维码展示

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

                    $(".partnerShortnameCls").text(bothData.saleOrder.partnerShortname);
                    $(".depositRequestedCls").text(bothData.saleOrder.depositRequested);
                    if ((bothData.saleOrder.orderStatus == '04' || bothData.saleOrder.orderStatus == '01' )) {
                        $(".updateOrder").removeClass("hide");
                        $(".cancelOrder").removeClass("hide");
                    }

                    $("#totalPrice").text(accounting.formatNumber(bothData.saleOrder.totalPrice, 2));

                    template.defaults.imports.formatNumber = function (value) {
                        return accounting.formatNumber(value, 2);
                    };
                    var html = template('tpl-detail', bothData);
                    document.getElementById("tableContainer").innerHTML += html;
                    $("#tableContainer").removeClass("hide");
                    if(bothData.saleOrder.isReceived=="1"){
                        $(".received").show();
                        $(".received span").text(bothData.saleOrder.receivedTime);
                    }
                    if(bothData.bottomComInfo.realName=="-"&&bothData.bottomComInfo.userId=="-"){
                        $(".relation").hide()
                    }
                    if(bothData.bottomComInfo.comAddress=="-"){
                         $(".addr").hide()
                    }
                    if (bothData.saleOrder.purchaseNo == "" || bothData.saleOrder.purchaseNo == null) {
                        $(".cai").addClass("hide");
                    }
                    if (bothData.saleOrder.discount == "" || bothData.saleOrder.discount == "0") {
                        $(".zhe").hide();
                    }
                    if (bothData.saleOrder.preferential == "" || bothData.saleOrder.preferential == "0") {
                        $(".jian").hide();
                    }
                    //客户地址
                    if (bothData.bottomComInfo.partnerProvince != "" || bothData.bottomComInfo.partnerCity != "" || bothData.bottomComInfo.partnerCountry != "" || bothData.bottomComInfo.partnerAddress != "") {


                        order_detail.pccJson(salesNo, bothData.bottomComInfo.partnerProvince, bothData.bottomComInfo.partnerCity, bothData.bottomComInfo.partnerCountry);

                    } 
                    order_detail.initData(salesNo, bothData.bottomComInfo.comProvince, bothData.bottomComInfo.comCity, bothData.bottomComInfo.comCountry);
                }
            })

        },

        pccJson: function (salesNo, province, city, country) {
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == province) {
                    $(".province" + salesNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == province && val.cityId == city) {
                    $(".city" + salesNo).html(val.cityName);
                    return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == city && val.countryId == country) {
                    $(".country" + salesNo).html(val.countryName);
                    return false;
                }
            });

        },

        initData: function (salesNo, sheng, shi, xian) {
            //通讯地址
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == sheng) {
                    $("#sheng1" + salesNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == sheng && val.cityId == shi) {
                    $("#shi1" + salesNo).html(val.cityName);
                    return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == shi && val.countryId == xian) {
                    $("#xian2" + salesNo).html(val.countryName);
                    return false;
                }
            });
        },


        closeRightWin: function () {
            parent.hideMsg();
        },
        deleteOrder: function () {
            $('#taxPointWin').show();
        },
        cancelOrder: function () {
            $('#cancelWin').show();
        },
        toCreatePurchaseOrder: function () {
//            var App = window.parent.parent.App;
//            var config = {
//                path: "/ydz/salesorder/toCreatePurchaseOrder?salesNo=" + salesNo,
//            };
//            App.open(config.path, config);
//            parent.parent.purchaseOrderAdd("/ydz/salesorder/toCreatePurchaseOrder?salesNo=" + salesNo);
//            parent.parent.purchaseOrderAdd("/openPage?pageName=advert_purchase-order-update-wx");

            parent.parent.purchaseOrderAdd("/ydz/purchaseorder/forward-addOrderBySupplier?salesNo="+salesNo);
        },
        closeTaxPoint: function () {
            $(".window-mask").hide();
            $("#taxPointWin,#cancelWin").css({display: 'none'});
        },

        updateOrder: function () {
            window.parent.openDtParent($("#orderNum").text());
            return;
            var App = window.parent.parent.App;
            var config = {
                path: "/ydz/salesorder/updatePage?salesNo=" + $("#orderNum").text(),
            };
            App.open(config.path, config);
        },
        cancelOrderLast: function (sel) {
            var self = $(sel);
            self.attr("disabled", true);
            $.ajax({
                type: "POST",
                url: pageCancelOrder,
                data: {salesNo: $("#orderNum").text()},
                dataType: "json",
                success: function (dt) {
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(2000).fadeOut(250).appendTo('body');

                    setTimeout(function () {
                        parent.hideMsg();
                        window.parent.reload();
                    }, 2000);
                },
                error: function () {
                    self.attr("disabled", false);
                    $("<div class='tips_contants'>").fadeIn(250).html("作废失败").delay(2000).fadeOut(250).appendTo('body');

                }
            })
        }
    };


</script>
</body>
</html>
