<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>安装单明细</title>
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
        .fixheader button{
            margin:12px 0px 9px 0px !important;
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
    <script src="/resources/pageConfig.js?v=d1935279f7"></script>
</head>
<body style="padding:2%;overflow:visible; background: url('/images/backlogo.png') repeat; z-index: 1000;">
<div id="cancelWin"
     style="padding-top:5px;top:50%;left:50%;margin-left:-330px; margin-top:-214px;position:absolute; width: 660px;height:428px;">
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
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 预付金额：</span>
            <span style=" color: #666;font-size: 14px;font-weight: 700;"><em
                    style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;color:#ff0000;"
                    class="depositRequestedCls"></em></span>
        </div>

        <div style="clear: both;margin: 20px 0 20px 280px; padding-bottom: 20px; position:absolute;bottom:10px;right:80px;">
            <button type="button" onclick="order_detail.closeTaxPoint()" class="btn "
                    style="font-size:12px;height:30px;width:92px;margin-right: 5px;">取消
            </button>
            <button type="button" class="btn btn-primary "
                    style="margin-left:15px;font-size:12px;width:92px;" onclick="order_detail.cancelOrderLast(this)">作废
            </button>


        </div>
    </div>
</div>
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>

<div class="fixheader">
<button type="button" onclick="order_detail.closeRightWin()" class="btn "
        style="font-size:12px;height:30px;width:92px;margin-right: 5px;line-height:1;">关闭
</button>
<button type="button" id="print" class="btn "
        style="font-size:12px;height:30px;width:92px;margin-right: 5px;line-height:1;">打印
</button>
<button type="button" id="qrCodeData" data-toggle="popover" data-container="body" data-trigger="hover"
        data-placement="bottom"
        data-html="true" class="btn btn-primary "
        style="font-size:12px;height:30px;line-height:1;margin-right: 5px;">微信/QQ转发
</button>
<button type="button" onclick="order_detail.updateOrder()" class="btn updateOrder hide"
        style="font-size:12px;width:92px;margin-right: 8px;height:30px;line-height:1;">修改
</button>
<button type="button" onclick="order_detail.cancelOrder()" class="btn cancelOrder  hide"
        style="font-size:12px;width:92px;margin-right: 5px;height:30px;line-height:1;">作废
</button>
</div>
<div class="hide qrCodeDataCls" style="padding: 0;margin-right: 5px;width: 280px;height: 260px;"><p
        style="margin-top: 20px;text-align: center">扫一扫，转发给客户做确认</p>
    <div style="margin-top: 30px ;text-align: center;" class="qrCodeDataMid"></div>
</div>
<div style="height: 1px ;background: #fff;"></div>
<div id="tableContainer" class="hide"
     style="">
</div>
<script id="tpl-detail" type="text/html">

    <div class="ui form" style="position:relative;">
        <div class="order">
            <p>安装单号 : <span id="orderNum">{{order.installationNo}}</span></p>
        </div>
        <div class="inline fields" style="text-align: center; display: block;">
            <div class="field" style="margin-left: 20px;display: inline-block;font-size: 20px;">
                <label>${sessionScope.sessionUser.comName}</label>
                <label>安装单</label>
                <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
            </div>
        </div>

        <div class="fieldsec">
            供应商 : <span>{{order.partnerShortname}}</span>
            联系人 : <span>{{order.contactName}}</span>
            订单日期 : <span>{{order.orderDate}}</span>
            手机 : <span>{{order.contactTel}}</span>
        </div>
    </div>
    <div class="ui divider"></div>
    <div class="ui form">

        <table class="tbWk" style="width:100%;">
            <col width="45%"/>
            <col width="10%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="7%"/>
            <col width="8%"/>
            <col width="15%"/>
            <thead>
            <th>业务内容</th>
            <th>规格(m)</th>
            <th>计价方式</th>
            <th>面积(㎡)</th>
            <th>数量</th>
            <th>单位</th>
            <th>费用单价</th>
            <th>行小计</th>
            </thead>
            <tbody>
            {{each details as item i}}
            <tr>
                <td>{{item.businessDesc}}</td>
                <td align="center">{{item.specification}}</td>
                <td align="center">{{item.priceWay | formatPrcWay}}</td>
                <td align="center">{{item.totalArea}}</td>
                <td class="talRight">{{item.quantity}}</td>
                <td align="center">{{item.unit}}</td>
                <td class="talRight">{{item.unitPrice | formatNumber}}</td>
                <td class="talRight">{{item.totalPrice | formatNumber}}</td>
            </tr>
            {{/each}}
            </tbody>

        </table>

        <div class="total-drive">
            <div>
                <div class="total-left">
                    <div>备注：<span id="shifouweikong">{{order.remarks}}</span></div>
                </div>
                <ul class="total_right">
                    <li>合&#x3000;&#x3000;计 :<span>{{order.totalPrice | formatNumber}}</span></li>
                    <li class="zhe">折&#x3000;&#x3000;扣 :<span> - <i
                    >{{order.discount | formatNumber}}</i> </span></li>
                    <li class="jian">减&#x3000;&#x3000;免 :<span> - <i
                    >{{order.preferential | formatNumber}}</i> </span></li>
                    <div class="ui divider"></div>
                </ul>
                <div style="clear:both;"></div>
            </div>
            <div style="position:relative;">
                <ul class="total_right">
                    <li style="margin-bottom:8px;">安装金额<span
                    >{{order.installationPrice | formatNumber}}</span></li>
                    <li>预&#x3000;&#x3000;付 :<span> - <i>{{order.prepayPrice | formatNumber}}</i> </span>
                    <li>应&#x3000;&#x3000;付 :<span>  <i>{{order.payablePrice | formatNumber}}</i> </span>
                    </li>
                </ul>
                <div style="position:absolute;left:0;bottom:0;">
                    <p class="show_address">客户地址 ：<span class="province{{order.installationNo}}">{{bottomComInfo.partnerProvince}}</span>
                        <span class="city{{order.installationNo}}">{{bottomComInfo.partnerCity}}</span> <span
                                class="country{{order.installationNo}}"
                        >{{bottomComInfo.partnerCountry}}</span>
                        <span class="address{{order.installationNo}}">{{bottomComInfo.partnerAddress}}</span></p>
                    <p>制单人 ：<span>{{order.creatorName}}</span>&#x3000;&#x3000;制单时间 ：<span
                    >{{order.createTime}}</span></p>
                </div>
                <div style="clear:both;"></div>
            </div>
        </div>
    </div>
    <div class="ui divider"></div>
    <div class="Customer-address">
        公司电话 : <span>{{bottomComInfo.comTel}}</span>
        公司QQ : <span>{{bottomComInfo.comQQ}}</span>
        联系人 : <span>{{bottomComInfo.realName}}</span>
        手机 : <span>{{bottomComInfo.userId}}</span>
        通讯地址 : <span>
                    <input type="hidden" id="sheng" value="{{bottomComInfo.comProvince}}">
                    <input type="hidden" id="shi" value="{{bottomComInfo.comCity}}">
                    <input type="hidden" id="xian" value="{{bottomComInfo.comCountry}}">
                    <b id="sheng1{{order.installationNo}}"></b>
                    <b id="shi1{{order.installationNo}}"></b>
                    <b id="xian2{{order.installationNo}}"></b>
                    <b value="{{bottomComInfo.comAddress}}"></b>
                </span>
    </div>

</script>
<script type="text/javascript">
    var pageUpdateOrder = "/order/installation/forward-updatePage?installationNo=";// 修改订单请求url
    var pageCancelOrder = "/order/installation/cancel";// 作废订单请求url
    var installationNo = '${param.installationNo}';
    var pageshareUrl = "/order/installation/shareUrl?orderNo=${param.installationNo}";
    $(function () {
        try {
            //打印
            $("#print").click(function () {
                window.parent.parent.open("/print/installation-list-detail-print.html?installationNo="+installationNo );
            });
        } catch (e) {
        }
        order_detail.initTbData(installationNo);

    })

    //    页面方法的主体
    var order_detail = {
        initTbData: function (installationNo) {
            $.ajax({
                url: "/order/installation/orderAndDetails?installationNo=" + installationNo,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (bothData) {

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
                        trigger: 'hover'
                    });
                    $(".partnerShortnameCls").text(bothData.order.partnerShortname);
                    $(".depositRequestedCls").text("- "+accounting.formatNumber(bothData.order.prepayPrice, 2));
                    if (bothData.order.status == '04') {
                        $(".updateOrder").removeClass("hide");
                        $(".cancelOrder").removeClass("hide");
                    }

                    $("#totalPrice").text(accounting.formatNumber(bothData.order.installationPrice, 2));

                    template.defaults.imports.formatNumber = function (value) {
                        return accounting.formatNumber(value, 2);
                    };
                    template.defaults.imports.formatPrcWay = function (value) {
                        for(var i=0;i<priceWayAll.length;i++){
                            if(priceWayAll[i].priceWay==value){
                                return priceWayAll[i].priceWayDesc;
                                break;
                            }
                        }
                    };
                    var html = template('tpl-detail', bothData);
                    document.getElementById("tableContainer").innerHTML += html;
                    $("#tableContainer").removeClass("hide");

                    if (bothData.order.purchaseNo == "" || bothData.order.purchaseNo == null) {
                        $(".cai").addClass("hide");
                    }
                    if (bothData.order.discount == "" || bothData.order.discount == "0") {
                        $(".zhe").hide();
                    }
                    if (bothData.order.preferential == "" || bothData.order.preferential == "0") {
                        $(".jian").hide();
                    }
                    //客户地址
                    if (bothData.bottomComInfo.partnerProvince != "" || bothData.bottomComInfo.partnerCity != "" || bothData.bottomComInfo.partnerCountry != "" || bothData.bottomComInfo.partnerAddress != "") {


                        order_detail.pccJson(installationNo, bothData.bottomComInfo.partnerProvince, bothData.bottomComInfo.partnerCity, bothData.bottomComInfo.partnerCountry);

                    } else {
                        $(".show_address").hide()
                    }
                    order_detail.initData(installationNo, bothData.bottomComInfo.comProvince, bothData.bottomComInfo.comCity, bothData.bottomComInfo.comCountry);
                }
            })

        },

        pccJson: function (installationNo, province, city, country) {
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == province) {
                    $(".province" + installationNo).html(val.provinceName);return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == province && val.cityId == city) {
                    $(".city" + installationNo).html(val.cityName);return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == city && val.countryId == country) {
                    $(".country" + installationNo).html(val.countryName);return false;
                }
            });

        },

        initData: function (installationNo, sheng, shi, xian) {
            //通讯地址
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == sheng) {
                    $("#sheng1" + installationNo).html(val.provinceName);return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == sheng && val.cityId == shi) {
                    $("#shi1" + installationNo).html(val.cityName);return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == shi && val.countryId == xian) {
                    $("#xian2" + installationNo).html(val.countryName);return false;
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

        closeTaxPoint: function () {
            $(".window-mask").hide();
            $("#taxPointWin,#cancelWin").css({display: 'none'});
        },

        updateOrder: function () {
            var App = window.parent.parent.App;
            var config = {
                path: pageUpdateOrder + $("#orderNum").text(),
            };
            App.open(config.path, config);
        },
        cancelOrderLast: function (sel) {
            var self = $(sel);
            self.attr("disabled", true);
            $.ajax({
                type: "POST",
                url: pageCancelOrder,
                data: {installationNo: $("#orderNum").text()},
                dataType: "json",
                success: function (dt) {
                    $("<div class='tips_contants'>").fadeIn(250).html(dt.msg).delay(2000).fadeOut(250).appendTo('body');
                    setTimeout(function () {
                        parent.hideMsg();
                        window.parent.location.reload();
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
