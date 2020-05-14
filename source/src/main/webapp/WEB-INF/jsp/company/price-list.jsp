<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>产品订购</title>
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
 <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
 <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
 <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
 <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
 <%--<link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">--%>
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
 <link rel="stylesheet" type="text/css" href="/resources/new/base_new.css?v=da63245499">         <%--//全局图标样式--%>
 <script src="/resources/pingpp/pingpp.js?v=510543a282"></script>
 <script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>

 <style>
       .ui.menu:not(.vertical) .item {
           height: inherit;
           line-height: inherit;

       }
       p{
        margin: 1rem 0rem ;
       }
       .all-pay span{
           margin-right: 10px;
           color: #333;
           margin-left: 10px;
       }
       .taxPointWin{
           border: none;

           /*box-shadow: 1px 3px 10px 2px rgba(0, 0, 0, 0.2);*/

           border:1px solid #ccc;
           background: #fff;
           transition:all 0.2s 0s linear;
           -webkit-transition: all 0.2s 0s linear;
           position: absolute;
           left:50%;
           /*display: none;*/
       }
     .taxPointWin p{
         margin:10px 0;
     }
       .all-pay span{
           font-size: 14px;
       }
 </style>
 <script type="text/javascript">
//     alert(new Date());
        cola(function (model) {
            model.set("duration",36);
            model.set("shouldPay", "￥0.00");
            model.set("discount", "￥0.00");
            model.set("actualPay", "￥0.00");
            var current_version = "${result.rentalVersion}";
            var queryAndMod=null;
            function openPostWindow(url, data, name) {
                var tempForm = document.createElement("form");
                tempForm.id = "tempForm1";
                tempForm.method = "post";
                tempForm.action = url;
                tempForm.target = name;

                var hideInput = document.createElement("input");
                hideInput.type = "hidden";
                hideInput.name = "content";
                hideInput.value = data;
                tempForm.appendChild(hideInput);
                $(tempForm).on("onsubmit", function () {
                    openWindow(name);
                });
                document.body.appendChild(tempForm);

                //tempForm.fireEvent("onsubmit");
                $(tempForm).submit();
                document.body.removeChild(tempForm);
            }

            function openWindow(name) {
                window.open('about:blank', name, 'height=400, width=400, top=0, left=0, toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes,location=yes, status=yes');
            }


            model.describe("vouchers", {
                provider: "<c:url value="/payment/effectiveVouchers"/>"
            });

            model.widgetConfig({
                //代金券下拉菜单
                voucherDp:{
                    $type: "dropdown",
                    items: "{{item in vouchers}}",
                    openMode: "drop",
                    /*valueProperty: "text",*/
                    textProperty: "text",
                    icon:"dropdown icon iconfont",
                    width:"300px",
                    change:function(self,arg){
                        var discount = arg.value.get("value");
                        var voucherNoStr = arg.value.get("text");
                        var voucherNo = voucherNoStr.substr(0, voucherNoStr.indexOf("，"));
                        model.set("voucherNo",voucherNo);
                        model.set("discount", "￥" + discount);
                        var shouldPay = model.get("shouldPay");
                        var discountNum = shouldPay.substr(1, shouldPay.length);
                        model.set("actualPay", "￥" + (discountNum - discount).toFixed(2));
                    }
                },
                operations4: {
                    $type: "button",
                    click: function(self, arg) {
                        var ops = cola.tag("op4")
                        for(var i = 0; i < ops.length; i++) {
                            var op = ops[i]
                            op.get$Dom().removeClass("active");
                            op.get$Dom().addClass("basic");

                        }

                        var userData = eval("("+self._userData+")");
                        //duration = userData.month;
                        model.set("duration", userData.month);
                        var count = parseFloat(userData.money).toFixed(2);

                        model.set("shouldPay","￥"+count);
                        //去掉￥
                        var discount = model.get("discount");
                        var discountNum = discount.substr(1,discount.length);
                        model.set("actualPay","￥"+(count - discountNum).toFixed(2));

                        self.get$Dom().removeClass("basic");
                        self.get$Dom().addClass("active");
                    }
                }
            });
            model.action({
                checkPay: function () {
                    var aliOrderNo = model.get("aliOrderNo");
                    if(aliOrderNo != undefined && aliOrderNo != "" ){
                        $.post("<c:url value="/payment/queryAndMod"/>", {orderNo: aliOrderNo}, function (callback) {
                            if (callback == 1) {
                                var n = 5;
                                var timer = setInterval(function () {
                                    $("#tigMsg").html("正在初始化,"+ n + "秒后重新登录");
                                    n--;
                                    if (n == 0) {
                                        clearInterval(timer); //停止计时器
                                        window.location = "/login/logout";
                                    }
                                }, 1000);
                            }else{
                                alert("当前订单为待支付状态");
                            }
                        })
                    }
                },

                backToPay: function () {
                    cola.widget("flipLayer").show({
                        animation: "horizontal flip"
                    });
                    cola.widget("flipLayer2").hide({
                        animation: "horizontal flip"
                    });
                    cola.widget("flipLayer3").hide({
                        animation: "horizontal flip"
                    });
                    clearInterval(queryAndMod);
                },
                pay: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    var duration = model.get("duration");
                    var rentalVersion = model.get("rentalVersion");
                    //model.set("actualPay","￥"+(discountNum - discount).toFixed(2));
                    var shouldPay = model.get("shouldPay");
                    var discountNum = shouldPay.substr(1, shouldPay.length);
                    var actualPayStr = model.get("actualPay");
                    var actualPayNum = actualPayStr.substr(1, actualPayStr.length);
                    var rentalKey = "${result.rentalKey}";
                    var status = "${result.status}";
                    var tradeType;
                    var oldRentalVersion = "${result.rentalVersion}";
                    var value = model.get("voucherNo");
                    if (value == undefined) {
                        value = "";
                    }
                    if (status == "T") {
                        tradeType = "1";
                    } else if (rentalVersion == oldRentalVersion) {
                        tradeType = "2";
                    } else {
                        tradeType = "3";
                    }
                    if(status == "1" && oldRentalVersion == "0T"){
                        tradeType = "1";
                    }

                    var discount;

                    if (duration == 6) {
                        discount = 1;
                    } else if (duration == 12) {
                        discount = 1;
                    } else if (duration == 24) {
                        discount = 0.9;
                    } else {
                        discount = 0.85;
                    }
                    //openPostWindow("/alipay.jsp", "qqq", "aaa");

                    $.post("/payment/aliPay", {
                                "duration": duration,
                                "rentalVersion": rentalVersion,
                                "voucherNo": value,
                                "rentalMoney": discountNum,
                                "actualPayNum": actualPayNum,
                                "rentalKey": rentalKey,
                                "tradeType": tradeType,
                                "discount": discount,
                                "oldRentalVersion": oldRentalVersion
                                },
                            function (charge) {
                                var chargeObj = eval("("+charge+")");
                                model.set("aliOrderNo",chargeObj.orderNo);
                                cola.widget("flipLayer").hide({
                                    animation: "horizontal flip"
                                });
                                cola.widget("flipLayer2").show({
                                    animation: "horizontal flip"
                                });
                                cola.widget("flipLayer3").hide({
                                    animation: "horizontal flip"
                                });
                                btn.set("disabled", false);
                                btn.set("state", "");
                                var alipayurl = "/alipay.jsp?aaa="+escape(charge);
                                newWin(alipayurl,"alipay");
                            })
                },
                payWx: function (btn) {
                    btn.set("disabled", true);
                    btn.set("state", "loading");
                    var duration = model.get("duration");
                    var rentalVersion = model.get("rentalVersion");
                    //model.set("actualPay","￥"+(discountNum - discount).toFixed(2));
                    var shouldPay = model.get("shouldPay");
                    var discountNum = shouldPay.substr(1, shouldPay.length);
                    var actualPayStr = model.get("actualPay");
                    var actualPayNum = actualPayStr.substr(1, actualPayStr.length);
                    var rentalKey = "${result.rentalKey}";
                    var status = "${result.status}";
                    var tradeType;
                    var oldRentalVersion = "${result.rentalVersion}";
                    var value = model.get("voucherNo");
                    if (value == undefined) {
                        value = "";
                    }
                    if (status == "T") {
                        tradeType = "1";
                    } else if (rentalVersion == oldRentalVersion) {
                        tradeType = "2";
                    } else {
                        tradeType = "3";
                    }
                    if(status == "1" && oldRentalVersion == "0T"){
                        tradeType = "1";
                    }
                    var discount;

                    if (duration == 6) {
                        discount = 1;
                    } else if (duration == 12) {
                        discount = 1;
                    } else if (duration == 24) {
                        discount = 0.9;
                    } else {
                        discount = 0.85;
                    }

                    $.post("<c:url value="/payment/wxPay"/>",
                            {
                                "duration": duration,
                                "rentalVersion": rentalVersion,
                                "voucherNo": value,
                                "rentalMoney": discountNum,
                                "actualPayNum": actualPayNum,
                                "rentalKey": rentalKey,
                                "tradeType": tradeType,
                                "discount": discount,
                                "oldRentalVersion": oldRentalVersion
                            },
                            function (charge) {
                                if (charge != "0") {
                                    var data = eval("(" + charge + ")")
                                    $('#wechat_code').qrcode({width: 200, height: 200, text: data.url});

                                    cola.widget("flipLayer").hide({
                                        animation: "horizontal flip"
                                    })
                                    cola.widget("flipLayer2").hide({
                                        animation: "horizontal flip"
                                    })
                                    cola.widget("flipLayer3").show({
                                        animation: "horizontal flip"
                                    })
                                    btn.set("disabled", false);
                                    btn.set("state", "");
                                     queryAndMod = setInterval(function () {
                                        //查询该订单状态
                                        $.post("<c:url value="/payment/queryAndMod"/>", {orderNo: data.orderNo}, function (callback) {
                                            if (callback == 1) {
                                                $("#wechatPaytips").children().remove();
                                                $("#wechatPaytips").append('<img src="/images/success.jpg" width="41px" alt=""><span>支付成功</span><div class="cutdowntips">5秒后自动返回</div>');
                                                clearInterval(queryAndMod);
                                                $(function () {
                                                    var n = 5;
                                                    var timer = setInterval(function () {
                                                        $(".cutdowntips").html("正在初始化,"+ n + "秒后重新登录");
                                                        n--;
                                                        if (n == 0) {
                                                            clearInterval(timer); //停止计时器
                                                            window.location = "/login/logout";
                                                        }
                                                    }, 1000);
                                                })

                                            }
                                        })

                                    }, 3000)
                                } else {
                                    btn.set("disabled", false);
                                    btn.set("state", "");
                                }

                            })
                },
                payDailog: function (totalNum, rentalVersion) {
                    model.set("rentalVersion", rentalVersion);
                    //获取每月的总计
                    //totalNum
                    //半年
                    halfYear = totalNum * 0.5 + 244;
                    //1年费用
                    oneYear = totalNum;
                    //2年费用
                    twoYear = totalNum * 2 * 0.9;
                    //3年费用
                    threeYear = totalNum * 3 * 0.85;
                    //$("#diaTotalSum").text("每月"+totalNum+"元");
                    var dbgl = $("#diaBtnGroup");
                    dbgl.text("");
                    var lable = $("<label style='margin-bottom: 10px'>选择以下一种进行支付</label>");
                    dbgl.append(lable);
                    //console.info(dbgl);
                    var buttongroup = $(cola.xRender("<div c-widget='ButtonGroup;'>"));
                    lable.append(buttongroup);
                    //console.info(buttongroup);
                    dbgl.append(buttongroup);

                    //#operations4
                    var fragment1 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:" + halfYear.toFixed(2) + "元/半年;userData:{money:" + halfYear + ",month:6};width:200px;tag:op4;'>"));
                    var fragment2 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:" + oneYear.toFixed(2) + "元/1年;userData:{money:" + oneYear + ",month:12};width:200px;tag:op4'>"));
                    var fragment3 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:" + twoYear.toFixed(2) + "元/2年（9折）;userData:{money:" + twoYear + ",month:24};width:200px;tag:op4'>"));
                    var fragment4 = $(cola.xRender("<div c-widget='#operations4;class:active;color:blue;caption:" + threeYear.toFixed(2) + "元/3年（85折）;userData:{money:" + threeYear + ",month:36};width:200px;tag:op4'>"));
                    model.set("shouldPay", "￥" + threeYear.toFixed(2));
                    model.set("actualPay", "￥" + threeYear.toFixed(2));
                    buttongroup.append(fragment1);
                    buttongroup.append(fragment2);
                    buttongroup.append(fragment3);
                    buttongroup.append(fragment4);

                    model.flush("vouchers",function (data) {
//                        console.log(data);
                        if(data == undefined || data.length==0){
                            model.set("vouchersEntityCount",0);
                          $("#discountShow,#voucherList").hide();
                        }else{
                            model.set("vouchersEntityCount",data.length);
                        }
                    });

                    cola.widget("payDialog").show();
                    //$("#payDialog").modal("show");

                },

                close_btn: function () {
                    cola.widget("payDialog").hide();
                }

            });
        });
        
        function newWin(url, id) {
            var a = document.createElement('a');
            a.setAttribute('href', url);
            a.setAttribute('target', '_blank');
            a.setAttribute('id', id);
            //防止反复添加
            if(!document.getElementById(id)) {                     
                document.body.appendChild(a);
            }
            a.click();
}


    </script>
</head>

<body style="padding: 32px;overflow-x: auto">



<div style=" border-bottom: 1px solid #f2f2f2;">

    <div>
        <img src="/images/login/logo.png" style="width:30px;height:30px">
        <span style="font-size: 16px;color:#333;">产品订购</span>
    </div>
<div class="all-pay" style="margin: 20px 0 0;">
    <label style="font-size: 14px;color:#999;">当前企业：</label>
    <span style="font-size: 14px;color:#333;">${result.currentCom}</span>
    <span style="    font-size: 14px;
    padding: 0 5px;
    margin-right: 0;
    color: #fff;
    background: #4fc3c3;">企业版</span>
    <span style="    font-size: 14px;
    margin: 0;
    color: #fff;
    padding: 0 5px;
    background: #f8b559;">${result.industryDesc}</span>
</div>
    <div class="all-pay" style="display: inline-block;line-height: normal;margin-bottom:20px;">
        <label style="font-size: 14px;color:#999;">现在处于：</label><span style="width: 150px;
    display: inline-block;">${result.statusValue}</span>
        <label style="font-size: 14px;color:#999;">到期时间：</label><span style="width: 150px;
    display: inline-block;">${result.endDate}</span>
        <label style="font-size: 14px;color:#999;">当前版本：</label><span>${result.rentalVersionValue}</span>
    </div>
</div>

<div>
    <p style="font-size: 14px;position: relative;color:#fd3a3a;height:70px;line-height: 70px;">
        <%--<i class="iconfont_new" style="font-size: 30px;--%>
    <%--vertical-align: middle;">&#xe6d4;</i>--%>
        <span>订购说明：易对账大部分功能都可免费使用，当销售订单达到50笔时才需缴纳年费（提前购买有优惠～）</span>
        <%--<span style="position: absolute;right:0;color:#999" >优惠咨询QQ：<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=3568013299&site=qq&menu=yes" style="font-style: normal;color:#333">3568013299</a></span>--%>
    </p>
</div>

<div  class=" taxPointWin "  style="    height: 480px;
    width: 900px;
    border-radius: 3px;
    margin-left: -450px;
    padding-top: 5px;
    /* left: 50%; */
    /* margin-top: 100px; */
    position: absolute; ">


    <div style="text-align: center;margin: 0 auto;">
        <p class="comImgTran" style="font-size:18px;color:#333;margin:32px auto 48px;">订购易对账</p>
        <div style="height: 1px;background: #999;width:200px;text-align: center;margin:0 auto;"></div>
        <p style="    font-size: 14px;
    color: #333;
    margin-top: -10px;
    width: 70px;
    background: #fff;
    margin: -10px auto 0;">功能模块</p>
        <p style="font-size: 14px;color:#333;">销售开单，采购记账</p>
        <p style="font-size: 14px;color:#333;">记录生意伙伴信息</p>
        <p style="font-size: 14px;color:#333;">服务报价单</p>
        <p style="font-size: 14px;color:#333;">设计派工</p>

        <p style="font-size: 14px;color:#333;">制作派工<span style="color:#ccc;font-size: 12px;">(仅广告加工企业类型拥有)</span></p>
        <p style="font-size: 14px;color:#333;">销售报表</p>
        <p style="font-size: 14px;color:#333;">员工权限</p>

        <p style="font-size: 28px;color:#ff4545;margin:16px auto 30px;">${result.version01}<em style="    font-size: 12px;
    color: #333;
    margin-left: 5px;
    vertical-align: top;">元/年</em></p>
        <div>
            <button c-tag="btn01"  c-onclick="payDailog(${result.version01},'01')" type="button"  class="btnEnter" style="background:#ff4545;color:#fff;margin-bottom:20px;cursor:pointer;border:none;border-radius:3px;outline:none;width:110px;height:36px;font-size:14px;" >立即购买</button>
        </div>

    </div>
</div>

<div id="payDialog" c-widget="Dialog; width:900px;closeable:false">
    <div style="height: 580px;">
        <span class="close_btn" style="cursor: pointer;z-index: 9999;" c-onclick="close_btn()"></span>
        <div id="flipLayer" c-widget="Layer;" style="display: block;visibility: visible;padding: 30px;">
            <div class="header" style="margin-bottom: 20px;font-size: 20px;">
                费用支付
            </div>
            <div class="ui form">

                <div id="diaBtnGroup" class="field">

                </div>
                <div id="voucherList" class="field" style="margin-top: 20px;">
                    <label>使用代金券 <span c-bind="vouchersEntityCount">0</span>张可用</label>
                    <div id="voucherDp"></div>
                </div>
                <div class="field" style="margin-top: 20px; overflow: hidden;">
                    <label>费用总计</label>
                    <div style="width:220px; border: 1px solid #CEA489; padding: 10px; background-color: #FBE6E6; margin-top: 10px;">
                        <table>
                            <tr>
                                <td style="width: 76px">应付费用</td>
                                <td style="width: 120px;text-align: right" c-bind="shouldPay"></td>
                            </tr>
                            <tr id="discountShow">
                                <td  style="width: 76px">代金券抵扣</td>
                                <td style="width: 120px;text-align: right" c-bind="discount"></td>
                            </tr>
                        </table>
                        <div class="ui divider"></div>
                        <table>
                            <tr>
                                <td style="width: 76px">还需支付</td>
                                <td style="width: 120px;text-align: right;color:#ff9812; font-size: 1.1em"
                                    c-bind="actualPay"></td>
                            </tr>
                        </table>
                    </div>

                </div>
                <div class="field" style="margin-top: 20px; overflow: hidden;">
                    <label></label>
                    <p style="margin-top: 10px"></p>
                </div>
                <div class="field" style="margin-top: 20px; overflow: hidden;">
                    <label style="margin-bottom: 10px">选择支付方式</label>
                    <div c-widget="button;class:green basic;caption:支付宝;width:150px;click:pay"></div>
                    <div c-widget="button;class:green basic;caption:微信(建议);width:150px;click:payWx"></div>
                </div>

            </div>
        </div>
        <!--flipLayer2-->
        <div id="flipLayer2" c-widget="Layer;" style="padding: 30px;">
            <%--<div class="wechat_tips wechat_tips_3">--%>
            <div style="margin-top: 100px">
                <div>
                    <div class="wechatPayLeft"><img width="60px" src="/images/tip.jpg" alt=""></div>
                    <div class="wechatPayRight">支付完成前，请不要关闭此支付验证窗口。</br>支付完成后，请根据您支付的情况点击下面按钮。</div>
                </div>
                <div class="wechatBtn">
                    <button c-onclick="backToPay()">支付遇到问题</button>
                    <button c-onclick="checkPay()">支付完成</button>
                </div>
                <div id="tigMsg" class="wechatBtn"></div>
            </div>
            <%--</div>--%>
        </div>
        <!---flipLayer3-->
        <div id="flipLayer3" c-widget="Layer;" style="padding: 30px;">
            <div>
                <div id="wechat_code" class="wechat_code"></div>
                <div id="wechatPaytips" class="wechatPaytips">
                    <p>打开微信，立即扫码支付</p>
                    <a style="cursor: pointer;font-size: 20px" c-onclick="backToPay()">返回</a>
                </div>
            </div>
            <div></div>
        </div>
    </div>
</div>
</body>
</html>