<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>销售单关联采购单详情</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css"  href="/resources/bootstrap/css/bootstrap.min.css?v=4121062a56">
    <link rel="stylesheet" type="text/css"  href="/resources/new/base_new.css?v=da63245499">
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
            margin-bottom: 10px;
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

        .talRight {
            text-align: right;
        }

        label {
            font-weight: normal;
        }
    </style>
    <script src="/resources/cola-ui/jquery-2.2.3.min.js?v=33cabfa15c"></script>
    <script src="/resources/cola-ui/china_city.js?v=bef170068c"></script>
    <script src="/resources/easyui/pace.min.js?v=cdbdd88ddf"></script>
    <script src="/resources/business/base_new.js?v=9ac481258d"></script>
</head>
<body
        style="padding: 2%; overflow: visible; background: url('/images/backlogo.png') repeat; z-index: 1000;">
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg"
     style="display: block; left: 50%">
    <span></span>
</div>

<p style="font-size: 16px;">查看关联订单</p>
<button type="button" onclick="order_detail.closeRightWin()"
        class="btn "
        style="font-size: 12px; height: 30px; width: 92px; margin-right: 5px; line-height: 1;">关闭
</button>
<p style="text-align: right; margin-bottom: 20px; font-size: 14px;">
    <label style="font-weight: normal;">销售总额：</label><span style="margin-right: 100px;">${totalPriceSales}</span>
    <label>采购总额：</label><span style="margin-right: 100px;">${totalPricePurchase}</span>
    <label>毛利润：</label><span>${profitPrice}</span>
</p>

<div style="height: 1px; background: #fff;"></div>

<div class="salesdetail"></div>

<script id="tpl-detail" type="text/html">
    <div class=""
         style="padding: 20px;margin-bottom: 10px;border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);">
        <div class="ui form" style="position:relative;">
            <div class="order">
                <p class="">采购单号 : <span>{{purchaseOrder.purchaseNo}}</span></p>
            </div>
            <div class="inline fields" style="text-align: center; display: block;">
                <div class="field" style="margin-left: 20px;display: inline-block;font-size: 20px;">
                    <label>${sessionScope.sessionUser.comName}</label>
                    <label>采购单</label>
                    <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
                </div>
            </div>

            <div class="fieldsec">
                供应商 : <span>{{purchaseOrder.partnerShortname}}</span>
                联系人 : <span>{{purchaseOrder.contactName}}</span>
                订单日期 : <span>{{purchaseOrder.orderDate}}</span>
                项目名称 : <span>{{purchaseOrder.caseDesc}}</span>
            </div>
        </div>
        <div class="ui divider"></div>
        <div class="ui form">

            <table class="tbWk" style="width:100%;">
                <col width="15%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <thead>
                <th>业务内容</th>
                <th>物料/制作/说明</th>
                <th>制作进度</th>
                <th>规格(m)</th>
                <th>面积(㎡)</th>
                <th>数量</th>
                <th>单位</th>
                <th>单价</th>
                <th>行小计</th>
                </thead>
                <tbody>
                {{each orders as item i}}
                <tr>
                    <td>{{item.businessDesc}}</td>
                    <td>{{item.requirements}}</td>
                    <td>{{item.workingStatus}}</td>
                    <td>{{item.length}}</td>
                    <td>{{item.totalArea}}</td>
                    <td class="talRight">{{item.quantity}}</td>
                    <td>{{item.unit}}</td>
                    <td class="talRight">{{item.unitPrice | formatNumber}}</td>
                    <td class="talRight">{{item.totalPrice | formatNumber}}</td>
                </tr>
                {{/each}}
                </tbody>

            </table>

            <div class="total-drive">
                <div>
                    <div class="total-left">
                        <div>备注：<span id="shifouweikong">{{purchaseOrder.remarks}}</span></div>
                    </div>
                    <ul class="total_right">
                        <li>合&#x3000;&#x3000;计 :<span>{{purchaseOrder.price | formatNumber}}</span></li>
                        <li class="zhe{{purchaseOrder.purchaseNo}}">折&#x3000;&#x3000;扣 :<span> - <i
                        >{{purchaseOrder.discount | formatNumber}}</i> </span></li>
                        <li class="jian{{purchaseOrder.purchaseNo}}">减&#x3000;&#x3000;免 :<span> - <i
                        >{{purchaseOrder.preferential | formatNumber}}</i> </span></li>
                        <div class="ui divider"></div>
                    </ul>
                    <div style="clear:both;"></div>
                </div>
                <div style="position:relative;">
                    <ul class="total_right">
                        <li style="margin-bottom:8px;">订单金额<span
                        >{{purchaseOrder.totalPrice | formatNumber}}</span></li>
                        <li>预&#x3000;&#x3000;付 :<span>  <i>{{purchaseOrder.depositRequested | formatNumber}}</i> </span>
                        </li>
                    </ul>
                    <div style="position:absolute;left:0;bottom:0;">

                        <p>制单人 ：<span>{{purchaseOrder.creatorName}}</span>&#x3000;&#x3000;制单时间 ：<span
                        >{{purchaseOrder.createTime}}</span></p>
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
                    <input type="hidden" id="" value="{{bottomComInfo.comProvince}}">
                    <input type="hidden" id="" value="{{bottomComInfo.comCity}}">
                    <input type="hidden" id="" value="{{bottomComInfo.comCountry}}">
                    <b id="sheng1{{purchaseOrder.purchaseNo}}"></b>
                    <b id="shi1{{purchaseOrder.purchaseNo}}"></b>
                    <b id="xian2{{purchaseOrder.purchaseNo}}"></b>
                    <b value="{{bottomComInfo.comAddress}}"></b>
                </span>
        </div>

    </div>
</script>
<script id="tpl-salesdetail" type="text/html">
    <div class=""
         style="padding: 20px;margin-bottom: 10px;border: 1px rgb(204, 204, 204) solid;box-shadow: 3px 3px 5px rgba(0, 0, 0, 0.3);">
        <div class="ui form" style="position:relative;">
            <div class="order">
                <p>销售单号 : <span id="">{{saleOrder.salesNo}}</span></p>
                <p class="cai">采购单号 : <span>{{saleOrder.purchaseNo}}</span></p>
            </div>
            <div class="inline fields" style="text-align: center; display: block;">
                <div class="field" style="margin-left: 20px;display: inline-block;font-size: 20px;">
                    <label>${sessionScope.sessionUser.comName}</label>
                    <label>销售单</label>
                    <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
                </div>
            </div>

            <div class="fieldsec">
                客户 : <span>{{saleOrder.partnerShortname}}</span>
                联系人 : <span>{{saleOrder.contactName}}</span>
                订单日期 : <span>{{saleOrder.orderDate}}</span>
                项目名称 : <span>{{saleOrder.caseDesc}}</span>
            </div>
        </div>
        <div class="ui divider"></div>
        <div class="ui form">

            <table class="tbWk" style="width:100%;">
                <col width="15%"/>
                <col width="15%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <col width="10%"/>
                <thead>
                <th>业务内容</th>
                <th>物料/制作/说明</th>
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
                    <td>{{item.length}}</td>
                    <td>{{item.totalArea}}</td>
                    <td class="talRight">{{item.quantity}}</td>
                    <td>{{item.unit}}</td>
                    <td class="talRight">{{item.unitPrice | formatNumber}}</td>
                    <td class="talRight">{{item.totalPrice | formatNumber}}</td>
                    <td>{{item.remarks}}</td>
                </tr>
                </tbody>
                {{/each}}
            </table>

            <div class="total-drive">
                <div>
                    <div class="total-left">
                        <div>备注：<span id="">{{saleOrder.remarks}}</span></div>
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
                        <li style="margin-bottom:8px;">订单金额<span
                        >{{saleOrder.totalPrice | formatNumber}}</span></li>
                        <li>预&#x3000;&#x3000;收 :<span>  <i>{{saleOrder.depositRequested | formatNumber}}</i> </span>
                        </li>
                    </ul>
                    <div style="position:absolute;left:0;bottom:0;">
                        <p class="show_address">客户地址 ：<span class="province{{saleOrder.salesNo}}">{{bottomComInfo.partnerProvince}}</span>
                            <span class="city{{saleOrder.salesNo}}">{{bottomComInfo.partnerCity}}</span> <span
                                    class="country{{saleOrder.salesNo}}"
                            >{{bottomComInfo.partnerCountry}}</span>
                            <span class="address{{saleOrder.salesNo}}">{{bottomComInfo.partnerAddress}}</span></p>
                        <p>制单人 ：<span>{{saleOrder.creatorName}}</span>&#x3000;&#x3000;制单时间 ：<span
                        >{{saleOrder.createTime}}</span></p>
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
                    <b id="sheng1{{saleOrder.salesNo}}"></b>
                    <b id="shi1{{saleOrder.salesNo}}"></b>
                    <b id="xian2{{saleOrder.salesNo}}"></b>
                    <b value="{{bottomComInfo.comAddress}}"></b>
                </span>
        </div>
    </div>

</script>

<script type="text/javascript">
    var industryId = '${param.industryId}';
    var purchaseNo = '${purchaseNo}';
    var salesNo = '${param.salesNo}';
    $(function () {
        try {
            if (purchaseNo != "") {
                var p = purchaseNo.split(",");
                for (var i = 0; i < p.length; i++) {
                    setTimeout(order_detail.initTbData(p[i], industryId), 100);
                }
            }


        } catch (e) {

        }
        try {
            order_detail.initTbDataSale(salesNo, industryId);
        } catch (e) {

        }


    })

    //    页面方法的主体
    var order_detail = {

        initTbDataSale: function (salesNo, industryId) {
            $.ajax({
                url: "/ydz/salesorder/salesOrderDetailData?salesNo=" + salesNo + "&industryId=" + industryId,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (bothData) {

                    // 二维码展示


                    $(".partnerShortnameCls").text(bothData.saleOrder.partnerShortname);
                    $(".depositRequestedCls").text(bothData.saleOrder.depositRequested);
                    if (!(bothData.saleOrder.orderStatus == '04' || bothData.saleOrder.orderStatus == '01')) {
                        $(".updateOrder").removeClass("hide");
                        $(".cancelOrder").removeClass("hide");
                    }

                    $("#totalPrice").text(accounting.formatNumber(bothData.saleOrder.totalPrice, 2));

                    template.defaults.imports.formatNumber = function (value) {
                        return accounting.formatNumber(value, 2);
                    };
                    var html = template('tpl-salesdetail', bothData);
                    $(".salesdetail").html(html);
                    $("#tableContainer").removeClass("hide");

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


                        order_detail.pccJsonSale(salesNo, bothData.bottomComInfo.partnerProvince, bothData.bottomComInfo.partnerCity, bothData.bottomComInfo.partnerCountry);

                    } else {
                        $(".show_address").hide()
                    }
                    order_detail.initDataSale(salesNo, bothData.bottomComInfo.comProvince, bothData.bottomComInfo.comCity, bothData.bottomComInfo.comCountry);
                }
            })

        },

        pccJsonSale: function (salesNo, province, city, country) {
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == province) {
                    $(".province" + salesNo).html(val.provinceName);return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == province && val.cityId == city) {
                    $(".city" + salesNo).html(val.cityName);return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == city && val.countryId == country) {
                    $(".country" + salesNo).html(val.countryName);return false;
                }
            });

        },

        initDataSale: function (salesNo, sheng, shi, xian) {
            //通讯地址
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == sheng) {
                    $("#sheng1" + salesNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == sheng && val.cityId == shi) {
                    $("#shi1" + salesNo).html(val.cityName);return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == shi && val.countryId == xian) {
                    $("#xian2" + salesNo).html(val.countryName);return false;
                }
            });
        },


        initTbData: function (purchaseNo, industryId) {
            $.ajax({
                url: "/ydz/purchaseorder/orderDetailData?orderNo=" + purchaseNo + "&industryId=" + industryId,
                type: 'post',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (bothData) {

                    // 二维码展示


                    $(".partnerShortnameCls").text(bothData.purchaseOrder.partnerShortname);
                    $(".depositRequestedCls").text(bothData.purchaseOrder.depositRequested);
                    if (!(bothData.purchaseOrder.orderStatus == '04' || bothData.purchaseOrder.orderStatus == '01')) {
                        $(".updateOrder").removeClass("hide");
                        $(".cancelOrder").removeClass("hide");
                    }

                    $("#totalPrice").text(accounting.formatNumber(bothData.purchaseOrder.totalPrice, 2));

                    template.defaults.imports.formatNumber = function (value) {
                        return accounting.formatNumber(value, 2);
                    };
                    var html = template('tpl-detail', bothData);
                    $(html).appendTo("body");
                    $("#tableContainer").removeClass("hide");


                    if (bothData.purchaseOrder.discount == "" || bothData.purchaseOrder.discount == "0") {
                        $(".zhe" + bothData.purchaseOrder.purchaseNo).hide();
                    }
                    if (bothData.purchaseOrder.preferential == "" || bothData.purchaseOrder.preferential == "0") {
                        $(".jian" + bothData.purchaseOrder.purchaseNo).hide();
                    }
                    //客户地址
                    if (bothData.bottomComInfo.partnerProvince != "" || bothData.bottomComInfo.partnerCity != "" || bothData.bottomComInfo.partnerCountry != "" || bothData.bottomComInfo.partnerAddress != "") {


                        order_detail.pccJson(purchaseNo, bothData.bottomComInfo.partnerProvince, bothData.bottomComInfo.partnerCity, bothData.bottomComInfo.partnerCountry);

                    } else {
                        $(".show_address").hide()
                    }
                    order_detail.initData(purchaseNo, bothData.bottomComInfo.comProvince, bothData.bottomComInfo.comCity, bothData.bottomComInfo.comCountry);
                }
            })

        },

        pccJson: function (purchaseNo, province, city, country) {
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == province) {
                    $(".province" + purchaseNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == province && val.cityId == city) {
                    $(".city" + purchaseNo).html(val.cityName);
                    return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == city && val.countryId == country) {
                    $(".country" + purchaseNo).html(val.countryName);
                    return false;
                }
            });

        },

        initData: function (purchaseNo, sheng, shi, xian) {
            //通讯地址
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == sheng) {
                    $("#sheng1" + purchaseNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == sheng && val.cityId == shi) {
                    $("#shi1" + purchaseNo).html(val.cityName);
                    return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == shi && val.countryId == xian) {
                    $("#xian2" + purchaseNo).html(val.countryName);
                    return false;
                }
            });
        },
        closeRightWin: function () {
            parent.hideMsg();
        }

    };


</script>
</body>
</html>
