<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/semantic.css?v=6d8f0baa07">
    <link rel="stylesheet" type="text/css" href="/resources/cola-ui/cola.css?v=347492ea8b">
    <script src="/resources/jquery/jquery-2.1.3.min.js?v=a03e4bc153"></script>
    <script src="/resources/cola-ui/3rd.js?v=c0452c9026"></script>
    <script src="/resources/cola-ui/semantic.js?v=4d50164349"></script>
    <script src="/resources/cola-ui/cola.js?v=bd5fd42985"></script>
    <script type="text/javascript">
        cola(function (model) {
            model.widgetConfig({
                operations: {
                    $type: "button",
                    click: function(self, arg) {
                        var ops = cola.tag("op")
                        for(var i = 0; i < ops.length; i++) {
                            var op = ops[i]
                            op.get$Dom().removeClass("active blue")
                        }

                        self.get$Dom().addClass("active blue")
                    }

                },
                operations2: {
                    $type: "button",
                    click: function(self, arg) {
                        var ops = cola.tag("op2")
                        for(var i = 0; i < ops.length; i++) {
                            var op = ops[i]
                            op.get$Dom().removeClass("active blue")
                        }

                        self.get$Dom().addClass("active blue")
                    }

                },
                operations3: {
                    $type: "button",
                    click: function(self, arg) {
                        var ops = cola.tag("op3")
                        for(var i = 0; i < ops.length; i++) {
                            var op = ops[i]
                            op.get$Dom().removeClass("active blue")
                        }

                        self.get$Dom().addClass("active blue")
                    }

                },
                checkbox: {
                    $type: "checkbox",
                    change: function(self, arg) {
                        if (arg.value) {
                            self.get$Dom().parent("td").next().text( self.get$Dom().parent("td").prev().text());
                        } else {
                            self.get$Dom().parent("td").next().text("");
                        }
                    }
                }
            });
            model.action({
                pay: function() {
                    $("#payDialog").modal("show");
                }

            });
        });
    </script>
</head>
<body style="padding: 20px;overflow-x: auto">

<div class="field">
    <div c-widget="ButtonGroup">
        <div c-widget="#operations; caption:充值支付; class:active blue;tag:op"></div>
        <div c-widget="#operations; caption:充值记录;tag:op"></div>
        <div c-widget="#operations; caption:发票记录;tag:op"></div>
        <div c-widget="#operations; caption:充值说明;tag:op"></div>
    </div>
</div>

<div class="ui divider"></div>

<div class="ui form">
    <div class="ui fields">
        <div class="ui field">
            <h4>当前系统许可到期时间：    <span style="color: red;margin-left: 30px">2016-07-08</span></h4>
            <div class="ui divider"></div>
        </div>
        <div class="ui field">
            <h4 style="margin-left: 30px">请勾选您需要的配置：（勾选后才会在页面显示并使用该功能，当前的已默认勾选）</h4>
        </div>
    </div>
</div>

<h4>
    管理功能选择组合
</h4>

<table class="ui celled structured table">
    <thead>
    <tr>
        <th style="color: #2E94E1">业务分类/描述（一级菜单）</th>
        <th style="color: #2E94E1">功能分类/功能描述（二级菜单）</th>
        <th class="center aligned" width="100px">月单价</th>
        <th class="center aligned" width="100px">请勾选</th>
        <th class="center aligned" width="100px">单项费用</th>
    </tr>
    </thead>
    <tbody>

    <tr>
        <td rowspan="2" style="color: #2E94E1">协同接单<br/>--接收好友供应商发来的订单</td>
        <td>订单处理<span style="margin-left: 40px">--处理订单/对账/付款等业务</span></td>
        <td class="center aligned">0</td>
        <td class="center aligned"><i class="red check circle icon large"></i></td>
        <td class="center aligned" style="color: #00B5AD">0</td>
    </tr>
    <tr>
        <td>统计分析<span style="margin-left: 40px">--订单/供应商/付款记录等的统计与分析</span></td>
        <td class="center aligned">20</td>
        <td class="center aligned"><div c-widget="#checkbox"></div></td>
        <td class="center aligned" style="color: #00B5AD"></td>
    </tr>

    <tr>
        <td rowspan="2" style="color: #2E94E1">销售业务管理<br/>--处理所有销售订单及账务</td>
        <td>订单处理<span style="margin-left: 40px">--处理订单/对账/付款等业务</span></td>
        <td class="center aligned">60</td>
        <td class="center aligned"><div c-widget="#checkbox"></div></td>
        <td class="center aligned" style="color: #00B5AD"></td>
    </tr>
    <tr>
        <td>统计分析<span style="margin-left: 40px">--订单/客户/收款/绩效/提成等的统计与分析</span></td>
        <td class="center aligned">30</td>
        <td class="center aligned"><div c-widget="#checkbox"></div></td>
        <td class="center aligned" style="color: #00B5AD"></td>
    </tr>


    <tr>
        <td rowspan="3" style="color: #2E94E1">采购业务管理<br/>--记录向非好友供应商的采购</td>
        <td>外协加工<span style="margin-left: 40px">--处理外协加工的订单/对账/支付</span></td>
        <td class="center aligned">30</td>
        <td class="center aligned"><div c-widget="#checkbox"></div></td>
        <td class="center aligned" style="color: #00B5AD"></td>
    </tr>
    <tr>
        <td>商品采购<span style="margin-left: 40px">--处理商品采购的订单/对账/支付</span></td>
        <td class="center aligned">30</td>
        <td class="center aligned"><div c-widget="#checkbox"></div></td>
        <td class="center aligned" style="color: #00B5AD"></td>
    </tr>
    <tr>
        <td>统计分析<span style="margin-left: 40px">--订单/供应商/付款记录等的统计与分析</span></td>
        <td class="center aligned">20</td>
        <td class="center aligned"><div c-widget="#checkbox"></div></td>
        <td class="center aligned" style="color: #00B5AD"></td>
    </tr>
    </tbody>
</table>

<div style="float:right;font-weight: bolder">
    <table>
        <tr>
            <td style="width: 90px;text-align: right">小计/每月</td>
            <td style="width: 120px;text-align: right">¥90.00</td>
        </tr>
    </table>
    <div class="ui divider"></div>
</div>


<h4 style="margin-top: 60px">
    管理功能选择组合
</h4>

<table class="ui table">
    <tbody>

    <tr>
        <td style="color: #2E94E1">可添加的客户数</td>
        <td>
            <div c-widget="ButtonGroup; size:tiny">
                <div c-widget="#operations2; caption:≤50客户; class:active blue; tag:op2"></div>
                <div c-widget="#operations2; caption:≤200客户; tag:op2"></div>
                <div c-widget="#operations2; caption:≤500客户; tag:op2"></div>
                <div c-widget="#operations2; caption:≤1000客户; tag:op2"></div>
                <div c-widget="#operations2; caption:>1000客户; tag:op2"></div>
            </div>
        </td>
        <td class="center aligned" style="color: #2E94E1">月单价</td>
        <td class="center aligned"><i class="red check circle icon large"></i></td>
        <td class="center aligned" style="color: #00B5AD">0</td>
    </tr>
    <tr>
        <td style="color: #2E94E1">可使用系统的客户数</td>
        <td>
            <div c-widget="ButtonGroup; size:tiny">
                <div c-widget="#operations3; caption:≤5人; tag:op3"></div>
                <div c-widget="#operations3; caption:≤20人; tag:op3"></div>
                <div c-widget="#operations3; caption:≤50人; class:active blue; tag:op3"></div>
                <div c-widget="#operations3; caption:≤100人; tag:op3"></div>
                <div c-widget="#operations3; caption:>100人; tag:op3"></div>
            </div>
        </td>
        <td class="center aligned" style="color: #2E94E1">月单价</td>
        <td class="center aligned"><i class="red check circle icon large"></i></td>
        <td class="center aligned" style="color: #00B5AD">50</td>
    </tr>
    </tbody>
</table>

<div style="float:right;font-weight: bolder">
    <table>
        <tr>
            <td style="width: 90px;text-align: right">小计/每月</td>
            <td style="width: 120px;text-align: right">¥50.00</td>
        </tr>
    </table>
    <div class="ui divider"></div>
    <table style="font-weight: bolder">
        <tr>
            <td style="width: 90px;text-align: right">两项合计/每月</td>
            <td style="width: 120px;text-align: right">¥140.00</td>
        </tr>
    </table>
    <div class="ui divider"></div>
    <div c-widget="button; caption:确定配置，去支付; class:orange right floated fluid; click:pay"></div>
</div>

<!--支付对话框-->
<div id="payDialog" class="ui test long scrolling medium modal">
    <div class="header">
        费用支付
    </div>
    <div class="content" style="height: 580px">
        <div class="ui form">
            <div class="field">
                <label>您刚才选择的功能合计<span style="color:#ff9812; font-size: 1.1em">每月120元</span></label>
            </div>
            <div class="field">
                <label>选择以下一种进行支付</label>
                <div c-widget="button;class:basic;caption:600元/半年;width:200px"></div>
                <div c-widget="button;class:basic;caption:1040元/年（省160元）;width:200px"></div>
                <div c-widget="button;class:basic;caption:2160元/2年（省240元）;width:200px"></div>
                <div c-widget="button;class:basic;caption:3060元/3年（省540元）;width:200px"></div>

            </div>
            <div class="field">
                <label>使用代金券 0 张可用</label>
               <div c-widget="dropdown; placeholder: 暂不使用代金券;width:200px"></div>
            </div>
            <div class="field">
                <label>费用总计</label>
                <div style="width:220px; border: 1px solid #CEA489; padding: 10px; background-color: #FBE6E6">
                    <table>
                        <tr>
                            <td style="width: 76px">付费套餐</td>
                            <td style="width: 120px;text-align: right">¥1024.00</td>
                        </tr>
                        <tr>
                            <td style="width: 76px">代金券抵扣</td>
                            <td style="width: 120px;text-align: right">¥200.00</td>
                        </tr>
                    </table>
                    <div class="ui divider"></div>
                    <table>
                        <tr>
                            <td style="width: 76px">还需支付</td>
                            <td style="width: 120px;text-align: right;color:#ff9812; font-size: 1.1em">¥840</td>
                        </tr>
                    </table>
                </div>

            </div>
            <div class="field">
                <label>发票申请</label>
                <p>请在“企业账户中心”相关处申请发票</p>
            </div>
            <div class="field">
                <label>选择支付方式</label>
                <div c-widget="button;class:green basic;caption:支付宝(建议);width:150px"></div>
                <div c-widget="button;class:green basic;caption:微信;width:150px"></div>
            </div>


        </div>
    </div>

</div>



</body>
</html>