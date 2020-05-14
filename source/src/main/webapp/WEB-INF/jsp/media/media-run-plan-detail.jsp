<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>投放计划详情</title>
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

        .talRight {
            text-align: right;
        }

        .cover:hover {
            color: #3385ff !important;
        }

        .coverage {
            font-size: 12px;
            float: right;
            color: #eb6877;
            cursor: pointer;
        }

        .coverage span {
            color: #4284D9;
        }

        label {
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

        .received {
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

        #tableContainer {
            padding-top: 80px !important;
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
    <button type="button" onclick="order_detail.updateOrder()" class="btn  updateOrder cover"
            style="font-size:14px;height:30px;width:58px;margin:0px 8px 5px 21px;line-height:1;background:#fff;color:#7e92ab;padding:0;">
        <i class="iconfont_new" style="font-size:26px;position:relative;top:4px;">&#xe6e6;</i> 修改
    </button>

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
            <%--<p>销售单号 : <span id="orderNum">{{saleOrder.salesNo}}</span></p>--%>
            <%--<p class="cai">采购单号 : <span>{{saleOrder.purchaseNo}}</span></p>--%>
        </div>
        <div class="inline fields" style="text-align: center; display: block;">
            <div class="field" style="margin-left: 20px;display: inline-block;font-size: 18px;">
                <label>${sessionScope.sessionUser.comName}</label>
                <label>投放计划</label>
                <%--<label>( {{order.orderDate}} )</label>--%>
                <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
            </div>
        </div>

        <div class="fieldsec" style="font-size:14px;color:#666;margin-bottom:15px;">
            广告名称 : <span>{{order.adName}}</span>
            客户 : <span>{{order.partnerName}}</span>
            排期状态 : <span>{{order.planStatus |formatStatus}}</span>
        </div>
    </div>

    <div class="ui form">

        <table class="tbWk" style="width:100%;">
            <col width="5%"/>
            <col width="25%"/>
            <%--<col width="18%"/>--%>
            <col width="10%"/>
            <col width="10%"/>
            <col width="6%"/>
            <%--<col width="6%"/>--%>
            <col width="10%"/>

            <thead>
            <th>序号</th>
            <th>投放点位</th>
            <%--<th>点位位置</th>--%>
            <th>投放开始日期</th>
            <th>投放结束日期</th>
            <th>投放天数</th>
            <%--<th>点位排期</th>--%>
            <th>备注</th>
            </thead>
            <tbody>
            {{each details as item i}}
            <tr>
                <td style="text-align:center;">{{i+1}}</td>
                <td>{{item.pointName}}</td>
                <%--<td>{{item.XXXX}}</td>--%>
                <td style="text-align:center;">{{item.startDate}}</td>
                <td style="text-align:center;">{{item.endDate}}</td>
                <td style="text-align:center;">{{item.days}}</td>
                <%--<td style="text-align:center;">查看</td>--%>
                <td>{{item.remarks}}</td>
            </tr>
            {{/each}}
            </tbody>

        </table>

        <div class="total-drive">
            <div>
                <div style="clear:both;"></div>
            </div>

        </div>
    </div>
    <div class="ui divider"></div>
    <div class="Customer-address">
        电话 : <span>{{bottomComInfo.comTel}}</span>
        QQ : <span>{{bottomComInfo.comQQ}}</span>
        <span class="relation">联系人 : <span
                style="margin:0;">{{bottomComInfo.realName}} ({{bottomComInfo.userId}})</span></span>

        <span style="float:right;margin:0;">
        制单人 ：<span>{{order.viewCreatorName}} ({{order.createTime}})</span></span>
    </div>

</script>

<script type="text/javascript">
    var planNo = '${param.planNo}';
    $(function () {
        try {
            order_detail.initTbData(planNo);
        } catch (e) {

        }


        $(".coverage").click(function () {
            $(".coveres").show();
            $(".alart_one").show();
        });
        $(".callback").click(function () {
            $(".coveres").hide();
            $(".alart_one").hide();
        });
    })

    //    页面方法的主体
    var order_detail = {
        initTbData: function (planNo) {
            $.ajax({
                url: "/ydz/mediaresource/getMediaRunPlansAndDetail?planNo=" + planNo,
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                dataType: "json",
                success: function (bothData) {
//                    console.log(bothData.bottomComInfo);
                    console.log(bothData.details);
                    console.log(bothData.order);
                    // 二维码展示
                    template.defaults.imports.formatNumber = function (value) {
                        return accounting.formatNumber(value, 2);
                    };
                    template.defaults.imports.formatStatus = function (value) {
                        if (value == "1L") {
                            return "锁定";
                        } else if (value == "2S") {
                            return "售出"
                        } else {
                            return "空闲"
                        }
                    };
                    var html = template('tpl-detail', bothData);
                    document.getElementById("tableContainer").innerHTML += html;
                    $("#tableContainer").removeClass("hide");
                }
            })

        },

        pccJson: function (planNo, province, city, country) {
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == province) {
                    $(".province" + planNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == province && val.cityId == city) {
                    $(".city" + planNo).html(val.cityName);
                    return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == city && val.countryId == country) {
                    $(".country" + planNo).html(val.countryName);
                    return false;
                }
            });

        },

        initData: function (planNo, sheng, shi, xian) {
            //通讯地址
            $.each(ProvinceJson, function (key, val) {
                if (val.provinceId == sheng) {
                    $("#sheng1" + planNo).html(val.provinceName);
                    return false;
                }
            });
            $.each(CityJson, function (key, val) {
                if (val.provinceId == sheng && val.cityId == shi) {
                    $("#shi1" + planNo).html(val.cityName);
                    return false;
                }
            });
            $.each(CountryJson, function (key, val) {
                if (val.cityId == shi && val.countryId == xian) {
                    $("#xian2" + planNo).html(val.countryName);
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
            parent.parent.purchaseOrderAdd("/ydz/purchaseorder/forward-addOrderBySupplier?planNo=" + planNo);
        },
        closeTaxPoint: function () {
            $(".window-mask").hide();
            $("#taxPointWin,#cancelWin").css({display: 'none'});
        },

        updateOrder: function () {
            window.parent.modifyPlan(planNo);
        },
    };


</script>
</body>
</html>
