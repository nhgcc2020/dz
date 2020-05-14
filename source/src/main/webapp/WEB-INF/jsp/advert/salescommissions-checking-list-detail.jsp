<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>销售提成结算单明细</title>

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
    </head>
<body style="padding:2%;background: url('/images/backlogo.png') repeat;">
<div id="datagrid-mask-msg" class="frame_box datagrid-mask-msg" style="display:block;left:50%"><span></span></div>
<div class="fixheader">
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
</div>
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
     style="">
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
                <label>${sessionScope.sessionUser.comName}</label>
                <label>提成结算单</label>
                <div style="margin-left:-40px;margin-right:-40px;" class="ui divider"></div>
            </div>
        </div>

        <div style="text-align:center;font-size:14px;color:#666;margin-bottom:20px;">
            <div style="display: inline-block">
                销售代表 : <span style="font-weight:400" >
                {{order.salesName}}</span></div>
            &#x3000;
            <div style="display: inline-block">手机 : <span style="font-weight:400" >{{order.salesTel}}</span>
            </div>
            &#x3000;
            {{if payment}}
            <div style="display: inline-block">结算账户 : <span style="font-weight:400"
            >{{payment.accountPayee}}</span></div>
            {{/if}}
        </div>
        <div class="ui form" style="position:relative;">

            <table class="tbWk" style="width:100%;">
                <col width="10%"/>
                <col width="10%"/>
                <col width="14%"/>
                <col width="8%"/>
                <col width="18%"/>
                <col width="8%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="7%"/>
                <col width="11%"/>
                <thead>
                <th>收款日期</th>
                <th>结算单号</th>
                <th>订单周期</th>
                <th>客户</th>
                <th>项目名称</th>
                <th>订单（明细）</th>
                <th>预收金额</th>
                <th>实收金额</th>
                <th>提成金额</th>
                <th>制单时间</th>
                </thead>
                <tbody>
                {{each details as item i}}
                <tr>
                    <td>{{item.recpayDate}}</td>
                    <td>{{item.commissionsCheckingNo}}</td>
                    <td>{{item.orderCycle}}</td>
                    <td>{{item.partnerShortname}}</td>
                    <td >{{item.caseDesc}}</td>
                    <td>{{item.salesOrderNum}}({{item.detailNum}})</td>
                    <td class="talRight">{{item.depositRequested | formatNumber}}</td>
                    <td class="talRight">{{item.paidUp | formatNumber}}</td>
                    <td class="talRight">{{item.commissionsMoney | formatNumber}}</td>
                    <td>{{item.createTime}}</td>
                </tr>
                {{/each}}
                </tbody>

            </table>

            <div class="total-drive">
                <div>
                  <ul class="total_right">
                        <li style="margin-bottom:8px;">预&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收：<span
                        > - <i>{{order.depositRequested | formatNumber}}</i></span></li>
                        <li class="zhe">实&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;收：<span><i
                                >{{order.paidUp | formatNumber}}</i> </span></li>
                       
                        <div class="ui divider"></div>
                    </ul>
                    <div style="clear:both;"></div>
                </div>
                <div style="position:relative;">
                    <ul class="total_right total_only">
                        <li style="margin-bottom:8px;" class=" paidUpCls">提&#x3000;&#x3000;&#x3000;成：<span
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
<script  id="tpl-receivable" type="text/html">
    <div id="receivablesBar" style="left: 50%;margin-left: -420px;margin-top: -320px;position: absolute;width: 760px;height: 640px;display: none;">
        <span style="position: absolute;top: 12px;left:20px;display: block;font-size: 16px;height:30px;color:#333;">收款</span>
        <p style="position:relative;font-weight: 100;text-align: center;height: 50px;font-size: 14px;color: #999;margin: 0px auto;padding: 10px 20px;border-bottom: 1px solid #e4e4e4;line-height: 30px;" id="orderTitWin"><label style="
    font-weight: normal;
    ">账单周期：</label>&nbsp;
            <span class="orderCycleCls" c-bind="">{{order.orderCycle}}</span>
        </p>
        <span style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;" onclick="salesCheckingFun.closeTaxPoint()"><img src="../../images/close_user.png" alt="点击关闭"></span>




        <div style="width: 560px;margin: 0 auto;position: relative">
            <div style="display: inline-block;vertical-align: middle;width: 184px;">
                <img class="comImgTran" style="margin: 38px auto 38px;float:left;width: 50px;height: 50px;border-radius: 40px;border:1px solid #ccc;padding:3px;" src="/images/share.png"><em c-bind="" class="partnerShortnameCls" style="font-style: normal;margin-top: 45px;margin-left: 10px;display: inline-block;width: 110px;overflow: hidden;font-weight: 700;text-overflow: ellipsis;height: 20px;word-wrap: break-word;font-size: 14px;">{{order.partnerShortname}}</em><br><span class="contactNameCls" c-bind="" style="
    margin-left: 10px;
    color: #999;
    ">{{order.contactName}}</span>
            </div>

            <div style="display: inline-block;text-align: center;">
                <label style="
    display: inline-block;
    font-weight: normal;
    color: #999;
    font-size: 14px;
    ">订单笔数：</label>&nbsp;<span c-bind="" class="detailNumCls" style="
    font-size: 20px;
    width: 50px;
    display: inline-block;
    vertical-align: middle;
    overflow: hidden;
    text-align: left;
    margin-top:-5px;
    ">{{order.salesOrderNum}}</span>
            </div>

            <div style="display: inline-block;">
                <label style="
    display: inline-block;
    font-weight: normal;
    color: #999;
    font-size: 14px;
    ">账单金额：</label>&nbsp;<span c-bind="" class="totalPriceCls" style="
    font-size: 20px;
    display: inline-block;
    text-align: left;
    vertical-align: middle;
    overflow: hidden;
    margin-top:-5px;
    ">{{order.totalPrice}}</span>
            </div>
            <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

            <div style="margin:24px auto;width: 270px;">
                <p style="text-align: right;height: 40px;line-height: 40px;">
                    <label style="float: left;font-weight: normal;color: #999;font-size: 14px;">预收金额：</label>
                    <span c-bind="" class="depositRequestedCls" style="
    font-size: 20px;
    color: #666;
    ">{{order.depositRequested |formatNumber}}</span>
                </p>
                <p style="text-align: right;clear: both;height: 40px;line-height: 40px;">
                    <label style="float: left;font-weight: normal;color: #999;font-size: 14px;">应收金额：</label>
                    <span c-bind="" class="receivablesMoneyShow" style="
    color: #ff5505;
    font-size: 20px;
    ">{{order.receivablesMoney |formatNumber}}</span>
                </p>
            </div>

            <div style="margin:-1px auto;width:500px;border-top: 1px solid #f2f2f2;"></div>

            <div style="width:552px;margin:35px auto;">
                <div style="width:215px;display: inline-block;position:relative;margin-right: 117px;text-align: right;margin-bottom: 20px;height: 34px;line-height: 34px;"><label style="float: left;font-size: 14px;color: #333;font-weight: normal;">实收金额：</label>
                    <input readonly c-bind="" type="text" name="recpayMoney"  value="{{order.paidUp |formatNumber}}"  style="width:120px;    text-align: right;line-height: 18px;
    padding: 5px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;" placeholder="0.00">
                    <%--<span c-bind="formatNumber(order.paidUp,'#,##0.00')" class="recpayDiscount bigCls hide" style="position: absolute;top:30px;right:0;font-size: 12px;"></span>--%>
                </div>

                <div style="width: 215px;display: inline-block;text-align: right;height: 34px;line-height: 34px;margin-bottom: 22px;">

                    <label style="float: left;float: left;font-size: 14px;color: #333;width: 70px;font-weight: normal;">收款人：</label>
                    <input readonly  type="text" id="recpayName" name="recpayName" style="padding: 5px;width: 120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                </div>
                <div style="width:215px;display: inline-block;text-align: right;height: 34px;margin-right: 117px;line-height: 34px;margin-bottom: 22px;/* margin-right:82px; */"> <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">收款账户：</label>
                    <input readonly  type="text" id="recpayAccount" name="recpayAccount" style="padding: 5px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                    <%--<div class="ydz_select ">--%>
                    <%--<div class="">--%>
                    <%--<span  class="ydz_select_txt ">选择收款账户</span>--%>
                    <%--<input type="hidden" value="" name="recpayAccount">--%>
                    <%--<a class="ydz_select_a" href="javascript:;"></a>--%>
                    <%--</div>--%>
                    <%--<ul class="ydz_select_menu recpayAccountList">--%>

                    <%--</ul>--%>
                    <%--</div>--%>

                </div>
                <div style="width: 215px;display: inline-block;height: 34px;position:relative;line-height: 34px;margin-bottom: 22px;text-align: right;">
                    <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">收款日期：</label>
                    <input readonly  id="recpayDate" name="recpayDate" type="text" style="padding: 5px 5px 5px 10px;width:120px;height: 34px;border: 1px solid #f2f2f2;border-radius: 3px;">
                    <%--<span onclick="$('#recpayDate').datetimepicker('show');" class="" style="--%>
                    <%--position: absolute;--%>
                    <%--right: 10px;--%>
                    <%--"><i class="iconfont_new" style="font-size: 18px;">&#xe6a6;</i></span>--%>
                </div>
                <div style="text-align: right;height: 34px;line-height: 34px;">
                    <label style="float: left;float: left;font-size: 14px;color: #333;font-weight: normal;">附加说明：</label>
                    <textarea readonly  rows="2" id="remarks" name="remarks" style="resize: none;padding: 5px;border: 1px solid #f2f2f2;border-radius: 3px;width: 455px;height:68px;"></textarea>
                </div>
            </div>




        </div>
        <div style="clear: both;position:absolute;bottom:30px;right: 105px;">

            <button type="button"  class="btn " onclick="salesCheckingFun.closeTaxPoint()"
                    style="font-size:12px;height:30px;width:100px;margin-right: 5px;line-height:1;">取消
            </button>
            <button type="button"  class="btn btn-primary" onclick="salesCheckingFun.resetOrder2(this)"
                    style="margin-left:15px;font-size:12px;height:30px;width:100px;margin-right: 5px;line-height:1;">撤销收款
            </button>
        </div>
    </div>
</script>
<script  id="tpl-taxPointWin" type="text/html">
    <div id="taxPointWin" class=" animated flipInY"
         style="padding-top:5px;top:100px;left:50%;margin-left:-330px; position:absolute; width: 660px;height:468px;">
        <p style="position:relative;font-weight: 100; text-align: left; font-size: 22px; margin: 0px auto; padding: 10px 20px;border-bottom: 1px solid #ccc;">
            撤销对账单</p>
        <span id="closetranform"
              style="  position: absolute; top:15px;right:1px;display: block;height:30px;width: 30px; cursor: pointer;"
              onclick="salesCheckingFun.closeTaxPoint()"><i
                style="background: url('/images/close_user.png');width:14px;height: 14px;display: block"
                alt="点击关闭"></i></span>
        <div style="text-align: center;margin: 0 auto;">
            <p style="  width: 500px;margin: 20px auto;font-size: 12px;position: relative;text-align: center;color: red; background: #f5f5f5;line-height: 30px;height: 30px;">
                被撤销的对账单会被删除以避免重复，相关订单恢复到待对账状态，可重新生成对账单。</p>
            <span class="customerjc"
                  style="position:relative;text-align:center;margin: 0 auto;font-size:22px;font-weight:normal;color:#44ae80;height: 30px;line-height: 30px;"
                  data-title="客户简称" c-bind="" id="partnerShortname">{{order.partnerShortname}}</span>
            <div style="    width: 360px;margin: 20px auto 25px;height: 30px;line-height: 30px;position: relative;text-align: right;">
            <span style="color: #666;font-size: 14px;font-weight: 700;float: left;"> 订单笔数：<em
                    style="font-family:Arial;font-weight: 100;    font-style: normal; font-size: 22px;"
                    id="numIndex"></em></span>
                <span style=" color: #666;font-size: 14px;font-weight: 700;">对账单金额：<em
                        style="font-family: Arial;font-style: normal      ;font-weight: 100; font-size: 22px;"
                        c-bind="">{{order.totalPrice |formatNumber}}</em></span>

            </div>
            <div style="margin:-1px auto;width:400px;border-top:1px solid #ccc"></div>
            <div style="      width: 400px; margin: 0 auto; padding: 30px 20px 0; position: relative;">
                <p style="text-align: right;  height: 30px;  color: #666;font-size: 14px;font-weight: 700;"><span
                        style="float:left;">预收金额：</span><em
                        style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100">-</em>
                    <em style="font-family: Arial;font-style:normal;font-size: 22px;font-weight: 100"
                        c-bind="">{{order.depositRequested |formatNumber}}</em></p>
                <p style="text-align: right; height: 30px;   margin-top:15px; color: #666;font-size: 14px;font-weight: 700;">
                    <span style="float:left;">应收金额：</span><em
                        style="font-weight:100;font-family: Arial; font-style:normal;font-size: 22px;color:#ff0000;"
                        c-bind="">{{order.receivablesMoney |formatNumber}}</em></p>



            </div>

            <div style="clear: both;margin: 20px 0 20px 280px; padding-bottom: 20px; position:absolute;bottom:10px;right:80px;">
                <button type="button"  class="btn " onclick="salesCheckingFun.closeTaxPoint()"
                        style="font-size:12px;height:30px;width:100px;margin-right: 5px;line-height:1;">取消
                </button>
                <button type="button"  class="btn btn-primary" onclick="salesCheckingFun.resetOrder(this)"
                        style="margin-left:15px;font-size:12px;height:30px;width:100px;margin-right: 5px;line-height:1;">撤销对账单
                </button>

            </div>
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


    var pageshareUrl = "/ydz/commission/shareUrl?orderNo=${commissionsCheckingNo}";
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
                    $(".tbWk tbody").rowspan(1);
                    $(".tbWk tbody").rowspan2(0);
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
        // console.log(${commissionsCheckingNo})
        if ($("#saleNumCc").val()) {
            var num = $("#saleNumCc").val().split(",").length;
            $("#numIndex").text(num);
        }
        $("#print").click(function () {
            window.parent.parent.open("/print/sales-commission-checking-list-detail-print.html?commissionsCheckingNo=${commissionsCheckingNo}");
        });

    })
</script>
</body>
</html>