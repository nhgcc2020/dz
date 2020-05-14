<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
 <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
 <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
 <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
 <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
 <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
<link rel="stylesheet" type="text/css" href="/resources/business/order-table.css?v=7367cb39d5">
<link rel="stylesheet" type="text/css" href="/resources/cola-ui/base.css?v=529b4c3d67">         <%--//全局图标样式--%>
<script src="/resources/pingpp/pingpp.js?v=510543a282"></script>
<script src="/resources/util/jquery.qrcode.min.js?v=05f0b1d7d4"></script>
    <style>
        /*.ui.buttons.tiny{
            border:1px solid #e4e4e4;
            border-radius: 3px;
        }
        .ui.button{
            background: none !important;
            font-size:12px;
            font-weight:normal;
            border-left:1px solid #e4e4e4;
        }
        .ui.blue.active.button{
            background: #2e8ae6 !important;
        }
        .ui.button:hover{
            color: #2e8ae6 !important;
        }*/
        .ui.menu:not(.vertical) .item {
            height: inherit;
            line-height: inherit;

        }
    </style>
    <script type="text/javascript">

        cola(function (model) {
            model.set("duration",12);
            model.set("shouldPay", "￥0.00");
            model.set("discount", "￥0.00");
            model.set("actualPay", "￥0.00");
            var current_version = "${result.rentalVersion}";
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

            var menuItems = {
                "02":[
                    {
                        caption: "高级版",
                        userData:"03",
                        icon:"arrow circle up"
                    }],
                "01":[
                    {
                        caption: "专业版",
                        userData:"02",
                        icon:"arrow circle up"
                    }, {
                        caption: "高级版",
                        userData:"03",
                        icon:"arrow circle up"
                    }]
            };
            model.widgetConfig({

                //升级按钮
                upgradeMenu: {
                    $type:"MenuButton",
                    caption:"升级高版本",
                    menuItems: menuItems[current_version],
                    menuItemClick:function(self,arg){
                        self.set("disabled",true);
                        self.set("state","loading");
                        var new_version = arg.item.get("userData");
                        if(Number(new_version) <= Number(current_version)){
                            $("<div class='tips_contants'>").fadeIn(250).html("操作失败，只可升级更高版本").delay(3000).fadeOut(250).appendTo('body');
                            self.set("disabled",false);
                            self.set("state","");
                            return false;
                        }else{
                            $.post("<c:url value='/payment/changeVersion'/>",{newVersion:new_version},function(data){
                                var callback = eval("("+data+")");
                                if(callback.state == "1"){
                                    $("<div class='tips_contants'>").fadeIn(250).html("升级成功，请重新登录获取新版本。").delay(2000).fadeOut(250).appendTo('body');
                                    setTimeout(function(){
                                        window.location.href="<c:url value="/login/logout"/>";
                                    },2000);
                                }else{
                                    $("<div class='tips_contants'>").fadeIn(250).html("升级失败").delay(2000).fadeOut(250).appendTo('body');
                                }
                            })
                            //进行版本升级操作
                        }
                    }
                },
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
                        model.set("duration",userData.month);
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
                    })
                    cola.widget("flipLayer2").hide({
                        animation: "horizontal flip"
                    })
                    cola.widget("flipLayer3").hide({
                        animation: "horizontal flip"
                    })
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
                    btn.set("disabled", false);
                    btn.set("state", "");
                    $.post("/payment/aliPay", {
                                "duration": duration,
                                "rentalVersion": rentalVersion,
                                "voucherNo": value,
                                "rentalMoney": discountNum,
                                "actualPayNum": actualPayNum,
                                "rentalKey": rentalKey,
                                "tradeType": tradeType,
                                "discount": discount},
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
                                window.open("/alipay.jsp?aaa="+escape(charge));
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
                                "discount": discount
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
                                    var queryAndMod = setInterval(function () {
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
                    //半年
                    halfYear = totalNum * 0.5 + 244;
                    //1年费用
                    oneYear = totalNum;
                    //2年费用
                    twoYear = totalNum * 2 * 0.9;
                    //3年费用
                    threeYear = totalNum * 3 * 0.85;

                    var dbgl = $("#diaBtnGroup");
                    dbgl.text("");
                    var lable = $("<label style='margin-bottom: 10px'>选择以下一种进行支付</label>");
                    dbgl.append(lable);
                    var buttongroup = $(cola.xRender("<div c-widget='ButtonGroup;'>"));
                    lable.append(buttongroup);
                    dbgl.append(buttongroup);

                    //#operations4
                    var fragment1 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:" + halfYear.toFixed(2) + "元/半年;userData:{money:" + halfYear + ",month:6};width:200px;tag:op4;'>"));
                    var fragment2 = $(cola.xRender("<div c-widget='#operations4;class:active;color:blue;caption:" + oneYear.toFixed(2) + "元/1年;userData:{money:" + oneYear + ",month:12};width:200px;tag:op4'>"));
                    var fragment3 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:" + twoYear.toFixed(2) + "元/2年（9折）;userData:{money:" + twoYear + ",month:24};width:200px;tag:op4'>"));
                    var fragment4 = $(cola.xRender("<div c-widget='#operations4;class:basic;color:blue;caption:" + threeYear.toFixed(2) + "元/3年（85折）;userData:{money:" + threeYear + ",month:36};width:200px;tag:op4'>"));
                    model.set("shouldPay", "￥" + oneYear.toFixed(2));
                    model.set("actualPay", "￥" + oneYear.toFixed(2));
                    buttongroup.append(fragment1);
                    buttongroup.append(fragment2);
                    buttongroup.append(fragment3);
                    buttongroup.append(fragment4);

                    /*var voucherList = $("#voucherList");
                    var voucherLable = $("");
                    voucherList.append(voucherLable);

                    var sltMenu = $(".ui.dropdown").find(".menu");
                    sltMenu.empty(); //先清除原有的div元素
                    model.get("countries", function (vouchers) {
                        voucherList.find("label").find("span").text(vouchers.entityCount);
                        vouchers.each(function (vou, i) {
                            var mDiv = $('<div class="item" data-value="' + vou.get("value") + '">' + vou.get("text") + '</div>');
                            sltMenu.append(mDiv);
                        })
                    });*/
                    model.flush("vouchers",function (data) {
                        if(data == undefined){
                            model.set("vouchersEntityCount",0);
                        }else{
                            model.set("vouchersEntityCount",data.length);
                        }
                    });
                    $("#payDialog").modal("show");
                },
                close_btn: function () {
                    cola.widget("payDialog").hide();
                }
            });
        });
    </script>
<title>综合型广告公司</title>
</head>
<body style="padding: 10px;overflow-x: auto">
<div style=" border-bottom: 1px solid #e4e4e4;">
    <div class="all-pay" style="display: inline-block;">
        您现在处于: <span>${result.statusValue}</span>
        许可到期时间: <span>${result.endDate}</span>
        当前版本: <span>${result.rentalVersionValue}</span>
    </div>
    <c:if test="${result.status eq '1' and (result.rentalVersion eq '01' or result.rentalVersion eq '02')}">
        <div id="upgradeMenu"></div>
        <div style="display: inline-block;font-size: 12px;vertical-align: middle;margin-left: 2rem;">
            <span style="color: red">注</span>：升级新版本后将重新计算到期时间。<br>
            新版本到期时间=升级日当天+(当前版本的剩余金额÷新版本日单价)
        </div>
    </c:if>
</div>

<div class="payList">
    <table border="1">
        <tr>
            <th style="width:10%;">版本</th>
            <th style="width:22.5%;">免费版</th>
            <th style="width:22.5%;">基础版</th>
            <th style="width:22.5%;">专业版 <i></i> </th>
            <th style="width:22.5%;">高级版</th>
        </tr>
        <tr>
            <td>价格</td>
            <td><span>0</span>元/年</td>
            <td><span>${result.version01}</span>元/年
                <c:choose>
                    <c:when test="${result.status ne '1'}">
                        <button c-tag="btn01"  c-onclick="payDailog(${result.version01},'01')">立即购买</button>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${'01' eq result.rentalVersion}">
                                <button c-tag="btn01"  c-onclick="payDailog(${result.version01},'01')">续费</button>
                            </c:when>
                            <c:otherwise>
                                <button c-tag="btn01" disabled style="background-color: #8aa1b8" >立即购买</button>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
                <%--<button class="color_blue" c-onclick="payDailog(${result.version01},'01')">立即购买</button>--%>
            </td>
            <td><span>${result.version02}</span>元/年
                <c:choose>
                    <c:when test="${result.status ne '1'}">
                        <button c-onclick="payDailog(${result.version02},'02')">立即购买</button>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${'02' eq result.rentalVersion}">
                                <button c-onclick="payDailog(${result.version02},'02')">续费</button>
                            </c:when>
                            <c:otherwise>
                                <button disabled style="background-color: #bfa28f" >立即购买</button>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
                <%--<button class="color_blue" c-onclick="payDailog(${result.version02},'02')">立即购买</button>--%>
            </td>
            <td><span>${result.version03}</span>元/年
                <c:choose>
                    <c:when test="${result.status ne '1' }">
                        <button c-onclick="payDailog(${result.version03},'03')">立即购买</button>
                    </c:when>
                    <c:otherwise>
                        <c:choose>
                            <c:when test="${'03' eq result.rentalVersion}">
                                <button c-onclick="payDailog(${result.version03},'03')">续费</button>
                            </c:when>
                            <c:otherwise>
                                <button disabled style="background-color: #b88a8e" >立即购买</button>
                            </c:otherwise>
                        </c:choose>
                    </c:otherwise>
                </c:choose>
                <%--<button class="color_blue" c-onclick="payDailog(${result.version03},'03')">立即购买</button>--%>
            </td>
        </tr>
        <tr>
            <td>协同接单</td>
            <td>
                <p>协同订单管理</p>
                <p>协同对账结算</p>
                <p>协同统计分析</p>
            </td>
            <td>
                <p>协同订单管理</p>
                <p>协同对账结算</p>
                <p>协同统计分析</p>
            </td>
            <td>
                <p>协同订单管理</p>
                <p>协同对账结算</p>
                <p>协同统计分析</p>
            </td>
            <td>
                <p>协同订单管理</p>
                <p>协同对账结算</p>
                <p>协同统计分析</p>
            </td>
        </tr>
        <tr>
            <td>外协管理</td>
            <td></td>
            <td>
                <p>外协订单管理</p>
                <p>外协对账管理</p>
                <p>外协统计分析</p>
            </td>
            <td>
                <p>外协订单管理</p>
                <p>外协对账管理</p>
                <p>外协统计分析</p>
            </td>
            <td>
                <p>外协订单管理</p>
                <p>外协对账管理</p>
                <p>外协统计分析</p>
            </td>
        </tr>
        <tr>
            <td>散单销售</td>
            <td></td>
            <td>
                <p>销售订单管理</p>
                <p>销售对账结算</p>
                <p>销售提成管理</p>
                <p>销售发票管理</p>
                <p>销售统计分析</p>
            </td>
            <td>
                <p>销售订单管理</p>
                <p>销售对账结算</p>
                <p>销售提成管理</p>
                <p>销售发票管理</p>
                <p>销售统计分析</p>
            </td>
            <td>
                <p>销售订单管理</p>
                <p>销售对账结算</p>
                <p>销售提成管理</p>
                <p>销售发票管理</p>
                <p>销售统计分析</p>
            </td>
        </tr>
        <tr>
            <td>项目销售</td>
            <td></td>
            <td>
                <p>项目合同管理</p>
                <p>项目对账结算</p>
                <p>项目提成管理</p>
                <p>销售发票管理</p>
                <p>项目统计分析</p>
            </td>
            <td>
                <p>项目合同管理</p>
                <p>项目对账结算</p>
                <p>项目提成管理</p>
                <p>销售发票管理</p>
                <p>项目统计分析</p>
            </td>
            <td>
                <p>项目合同管理</p>
                <p>项目对账结算</p>
                <p>项目提成管理</p>
                <p>销售发票管理</p>
                <p>项目统计分析</p>
            </td>
        </tr>
        <tr>
            <td>派工绩效</td>
            <td></td>
            <td>
                <p>任务派工管理</p>
                <p>任务执行管理</p>
                <p>绩效提成管理</p>
                <p>派工绩效分析</p>
            </td>
            <td>
                <p>任务派工管理</p>
                <p>任务执行管理</p>
                <p>绩效提成管理</p>
                <p>派工绩效分析</p>
            </td>
            <td>
                <p>任务派工管理</p>
                <p>任务执行管理</p>
                <p>绩效提成管理</p>
                <p>派工绩效分析</p>
            </td>
        </tr>
        <tr>
            <td>CRM</td>
            <td></td>
            <td></td>
            <td>
                <p>销售机会管理</p>
                <p>销售报价管理</p>
                <p>销售目标管理</p>
            </td>
            <td>
                <p>销售机会管理</p>
                <p>销售报价管理</p>
                <p>销售目标管理</p>
            </td>
        </tr>
        <tr>
            <td>媒体代理发布</td>
            <td></td>
            <td></td>
            <td></td>
            <td>
                <p>广告资源管理</p>
                <p>广告档期管理</p>
                <p>广告分类管理</p>
                <p>广告资源分析</p>
            </td>
        </tr>
        <tr>
            <td>系统用户</td>
            <td class="fontSize14">≤5人</td>
            <td class="fontSize14">≤5人</td>
            <td class="fontSize14">≤10人</td>
            <td class="fontSize14">不限</td>
        </tr>
    </table>
</div>
<div id="payDialog" class="ui test long scrolling medium modal">
    <!--搜索 start-->
    <%--
     class="content"
     --%>
    <div style="height: 580px;">
        <span class="close_btn" c-onclick="close_btn()"></span>
        <div id="flipLayer" c-widget="Layer;" style="display: block;visibility: visible;padding: 30px;">
            <div class="header" style="margin-bottom: 20px;font-size: 20px;">
                费用支付
            </div>
            <div class="ui form">
                <%-- <div class="field">
                     <label>您刚才选择的功能合计<span style="color:#ff9812; font-size: 1.1em" id="diaTotalSum">每月120元</span></label>
                 </div>--%>
                <div id="diaBtnGroup" class="field">

                </div>
                <div id="voucherList" class="field" style="margin-top: 20px;">
                    <label>使用代金券 <span c-bind="vouchersEntityCount">0</span>张可用</label>
                    <div id="voucherDp"></div>
                </div>
                <div class="field" style="margin-top: 20px; overflow: hidden;">
                    <label>费用总计</label>
                    <div style="width:220px; border: 1px solid #CEA489; padding: 10px; background-color: #FBE6E6;margin-top: 10px;">
                        <table>
                            <tr>
                                <td style="width: 76px">应付费用</td>
                                <td style="width: 120px;text-align: right" c-bind="shouldPay"></td>
                            </tr>
                            <tr>
                                <td style="width: 76px">代金券抵扣</td>
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
                    <label>发票申请</label>
                    <p style="margin-top: 10px;">可在【企业账户中心】--【会员支付中心】--【发票中心】申请开具增值税普通发票。</p>
                </div>
                <div class="field" style="margin-top: 20px; overflow: hidden;">
                    <label style="margin-bottom: 10px;">选择支付方式</label>
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
                    <a style="cursor: pointer;font-size: 20px;display: inline-block;margin-top: 30px;" c-onclick="backToPay()">返&nbsp;&nbsp;回</a>
                </div>
                <%-- --%>

            </div>

            <div>

            </div>
        </div>
    </div>
</div>

</body>
</html>